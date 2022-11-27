#!/bin/bash
cp /mnt/hibernate.properties /opt/OpenIMSCore/FHoSS/deploy
cp /mnt/DiameterPeerHSS.xml /opt/OpenIMSCore/FHoSS/deploy
cp /mnt/configurator.sh /opt/OpenIMSCore/FHoSS/deploy
cp /mnt/configurator.sh /opt/OpenIMSCore/FHoSS/scripts
cp /mnt/configurator.sh /opt/OpenIMSCore/FHoSS/config
sed -i "s/OPENIMS_MYSQL_IP/$OPENIMS_MYSQL_IP/g" /opt/OpenIMSCore/FHoSS/deploy/hibernate.properties
sed -i "s/IMS_DOMAIN/$OPENIMS_IMS_DOMAIN/g" /opt/OpenIMSCore/FHoSS/deploy/DiameterPeerHSS.xml
sed -i "s/IMS_DOMAIN/$OPENIMS_IMS_DOMAIN/g" /mnt/userdata.sql
sed -i "s/OPENIMS_FHOSS_IP/$OPENIMS_FHOSS_IP/g" /opt/OpenIMSCore/FHoSS/deploy/DiameterPeerHSS.xml
cd /opt/OpenIMSCore/FHoSS/deploy
./configurator.sh $OPENIMS_IMS_DOMAIN $OPENIMS_FHOSS_IP
cd ../scripts
./configurator.sh $OPENIMS_IMS_DOMAIN $OPENIMS_FHOSS_IP
cd ../config 
./configurator.sh $OPENIMS_IMS_DOMAIN $OPENIMS_FHOSS_IP
sed -i "s/open-ims.test/$OPENIMS_IMS_DOMAIN/g" /opt/OpenIMSCore/FHoSS/src-web/WEB-INF/web.xml
mysql -u root -p$OPENIMS_MYSQL_PWD -h $OPENIMS_MYSQL_IP < /mnt/drop_and_create_db.sql 
cd ../scripts
mysql -u root -p$OPENIMS_MYSQL_PWD -h $OPENIMS_MYSQL_IP < /mnt/hss_db.sql
mysql -u root -p$OPENIMS_MYSQL_PWD -h $OPENIMS_MYSQL_IP hss_db < /mnt/userdata.sql
cp /mnt/hss.sh /opt/OpenIMSCore/FHoSS/deploy
chmod +x /opt/OpenIMSCore/FHoSS/deploy/hss.sh
/opt/OpenIMSCore/FHoSS/deploy/hss.sh
bash
