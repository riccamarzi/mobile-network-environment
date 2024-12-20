#!/bin/bash
# 
# $Id: add-imscore-user_newdb.sh 626 2009-03-05 16:31:09Z vingarzan $
# 
# add-imscore-user_newdb.sh
# Version: 0.5
# Released: 02/06/07
# Author: Sven Bornemann -at- materna de
#
# History:
#   0.51 (04/08/08)
#     * added tel-URI support incl. implicit-set
#   0.4 (06/21/07)
#     * upgraded to the new db structures	
#   0.3 (03/09/07):
#     * sip2ims transactions are commented out.
#   0.2 (02/06/07): 
#     * Changed parameter handling (getopt).
#     * Allow direct mysql import.
#     * Remove temporary password file after usage.
#   0.1 (02/02/07): 
#     * Initial version
#
# Script for generating two SQL scripts for creating/deleting IMS Core users 
# in the HSS and the SIP2IMS gateway tables.
#
# Usage for add-imscore-user.sh: See Usage() procedure below
#
# Example for creating user 'brooke' with password 'brooke' for realm 
# 'ims.mnc001.mcc001.3gppnetwork.org':
#
# # ./add-imscore-user.sh -u brooke -a
# Successfully wrote add-user-brooke.sql
# Successfully wrote delete-user-brooke.sql
# Apply add-user-brooke.sql...
# Enter password:
# Successfully applied add-user-brooke.sql
# 
# After applying the add script, you should be able to register with IMS Core 
# with SIP clients (e.g. as 'brooke') via SIP2IMS. Use delete script or -d 
# option for removing the user from IMS Core database tables.
# 
# Known limits:
# * IMS Core installation in /opt/OpenIMSCore required.
# * Password is limited to 16 characters.
# 


Usage()
{
    echo "ERROR: Invalid parameters"
    echo "add-imscore-user.sh -u <user> [-t <tel-URI>] [-r <realm> -p <password>] [-a|-d]"
    echo "  -u <user>: The username (e.g. 'brooke')"
    echo "  -t <tel-URI>: The tel-URI (e.g. 'tel:+49123456789'). If used with -a, -d requires"
    echo "     this parameter too!"
    echo "  -r <realm>: The realm. Default is 'ims.mnc001.mcc001.3gppnetwork.org'"
    echo "  -i <impi>: The Private Identity (e.g. 'brooke@ims.mnc001.mcc001.3gppnetwork.org'). The -u option overrides this."
    echo "  -b <impu>: The Public Identity (e.g. 'sip:brooke@ims.mnc001.mcc001.3gppnetwork.org') The -u option overrides this."
    echo "  -p <password>: The password. Default is value of -u option"
    echo "  -a: Automatically apply created add script"
    echo "  -d: Automatically apply created delete script"
    echo "  -c: Delete the scripts afterwards (by default they are not deleted)"
    exit -1
}

OPTION_ADD=0
OPTION_DELETE=0
OPTION_CLEANUP=0
SCRIPT=
EXIT_CODE=0
DBUSER=root

while getopts u:r:i:b:p:o:c?:adt:? option;
do
    case $option in
        u) IMSUSER=$OPTARG;;
        r) REALM=$OPTARG;;
        i) IMPI=$OPTARG;;
        b) IMPU=$OPTARG;;        
        t) TELURI=$OPTARG;;        
        p) PASSWORD=$OPTARG;;
        a) OPTION_ADD=1;;
        d) OPTION_DELETE=1;;
        c) OPTION_CLEANUP=1;;
    esac
done

[ -z "$REALM" ] && REALM=ims.mnc001.mcc001.3gppnetwork.org
if [ -z "$IMSUSER" ]; 
then
	IMSUSER=${IMPI%%@*}
else
	IMPI="$IMSUSER@$REALM"
	IMPU="sip:$IMSUSER@$REALM"
fi
[ -z "$PASSWORD" ] && PASSWORD=$IMSUSER
[ -z "$IMSUSER" ] && Usage

# Some checks
[ $OPTION_ADD -eq 1 ] && [ $OPTION_DELETE -eq 1 ] && Usage;


#KEY=`/opt/OpenIMSCore/ser_ims/utils/gen_ha1/gen_ha1 $IMSUSER@$REALM $REALM $PASSWORD`

CREATE_SCRIPT="add-user-$IMSUSER.sql"
DELETE_SCRIPT="delete-user-$IMSUSER.sql"
SED_SCRIPT="s/<USER>/$IMSUSER/g"
PASSWORD_FILE=~temp~password~

echo -n $PASSWORD > $PASSWORD_FILE
ENCODED_PASSWORD=`hexdump -C < $PASSWORD_FILE|cut -b 10-60|sed 's/ //g'|cut -b 1-32`00000000000000000000000000000000
ENCODED_PASSWORD=`echo $ENCODED_PASSWORD|cut -b 1-32`
rm $PASSWORD_FILE

CREATE_SCRIPT_TEMPLATE="insert into hss_db.imsu(name) values ('<USER>_imsu');

insert into hss_db.impi(
        identity,
        id_imsu,
        k,
        auth_scheme,
        default_auth_scheme,
        amf,
        op,
	opc)
values( '$IMPI',
        (select id from hss_db.imsu where hss_db.imsu.name='<USER>_imsu'),
        '$PASSWORD',
        127,
        1,
        '\0\0',
        '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
	'');

insert into hss_db.impu(identity,id_sp) values ('$IMPU', (select id from hss_db.sp order by id limit 1));
update hss_db.impu set id_implicit_set=id where hss_db.impu.identity='$IMPU';

insert into hss_db.impi_impu(id_impi,id_impu) values ((select id from hss_db.impi where hss_db.impi.identity='$IMPI'), (select id from hss_db.impu where hss_db.impu.identity='$IMPU'));

insert into hss_db.impu_visited_network(id_impu, id_visited_network) values((select id from hss_db.impu where hss_db.impu.identity='$IMPU'), (select id from hss_db.visited_network where hss_db.visited_network.identity='$REALM'));
"

CREATE_TELURI_IMPU_TEMPLATE="
insert into hss_db.impu(identity,id_sp) values ('$TELURI', (select id from hss_db.sp order by id limit 1));
select @id:=id from hss_db.impu where hss_db.impu.identity='$IMPU';
update hss_db.impu set id_implicit_set=@id where hss_db.impu.identity='$TELURI';

insert into hss_db.impi_impu(id_impi,id_impu) values ((select id from hss_db.impi where hss_db.impi.identity='$IMPI'), (select id from hss_db.impu where hss_db.impu.identity='$TELURI'));

insert into hss_db.impu_visited_network(id_impu, id_visited_network) values((select id from hss_db.impu where hss_db.impu.identity='$TELURI'), (select id from hss_db.visited_network where hss_db.visited_network.identity='$REALM'));
"

DELETE_SCRIPT_TEMPLATE=" 
delete from hss_db.impu_visited_network where id_impu = (select id from hss_db.impu where hss_db.impu.identity='$IMPU');
delete from hss_db.impi_impu where id_impi = (select id from hss_db.impi where hss_db.impi.identity='$IMPI');
delete from hss_db.impu where identity = '$IMPU';
delete from hss_db.imsu where name = '<USER>_imsu';
"

DELETE_TELURI_IMPU_TEMPLATE=" 
delete from hss_db.impu_visited_network where id_impu = (select id from hss_db.impu where hss_db.impu.identity='$TELURI');
delete from hss_db.impi_impu where id_impi = (select id from hss_db.impi where hss_db.impi.identity='$IMPI');
delete from hss_db.impu where identity = '$TELURI';
"

DELETE_IMPI_TEMPLATE="
delete from hss_db.impi where identity = '$IMPI';
"

# Create SQL add script
echo "$CREATE_SCRIPT_TEMPLATE" | sed $SED_SCRIPT > $CREATE_SCRIPT 
if [ $? -ne 0 ]; then
    echo "Failed to write $CREATE_SCRIPT"
    exit -1
fi
if [ ! -z $TELURI ]; then
    echo "$CREATE_TELURI_IMPU_TEMPLATE" | sed $SED_SCRIPT >> $CREATE_SCRIPT 
    if [ $? -ne 0 ]; then
        echo "Failed to write $CREATE_SCRIPT"
        exit -1
    fi
fi    
echo "Successfully wrote $CREATE_SCRIPT"

# Create SQL delete script
echo "$DELETE_SCRIPT_TEMPLATE" | sed $SED_SCRIPT > $DELETE_SCRIPT
if [ $? -ne 0 ]; then
    echo "Failed to write $DELETE_SCRIPT"
    exit -1
fi
if [ ! -z $TELURI ]; then
    echo "$DELETE_TELURI_IMPU_TEMPLATE" | sed $SED_SCRIPT >> $DELETE_SCRIPT
    if [ $? -ne 0 ]; then
        echo "Failed to write $DELETE_SCRIPT"
        exit -1
    fi
fi
echo "$DELETE_IMPI_TEMPLATE" | sed $SED_SCRIPT >> $DELETE_SCRIPT
echo "Successfully wrote $DELETE_SCRIPT"

# Apply scripts directly?
if [ $OPTION_ADD -eq 1 ]; then
    echo Apply $CREATE_SCRIPT as user $DBUSER...
    mysql -u $DBUSER -p$OPENIMS_MYSQL_PWD -h $OPENIMS_MYSQL_IP < $CREATE_SCRIPT > /dev/null
    EXIT_CODE=$?
    SCRIPT=$CREATE_SCRIPT
elif [ $OPTION_DELETE -eq 1 ]; then
    echo Apply $DELETE_SCRIPT as user $DBUSER...
    mysql -u $DBUSER -p$OPENIMS_MYSQL_PWD -h $OPENIMS_MYSQL_IP < $DELETE_SCRIPT
    EXIT_CODE=$?
    SCRIPT=$DELETE_SCRIPT
fi

# Evaluate exit code
if [ ! -z "$SCRIPT" ]; then
    if [ $EXIT_CODE -ne 0 ]; then
        echo "ERROR: Failed to apply $SCRIPT"
    else    
        echo "Successfully applied $SCRIPT"
    fi
fi

# Clean-up?
if [ $OPTION_CLEANUP -eq 1 ]; then
	rm $CREATE_SCRIPT $DELETE_SCRIPT
	echo "Deleted $CREATE_SCRIPT $DELETE_SCRIPT"
fi
	

exit $EXIT_CODE

