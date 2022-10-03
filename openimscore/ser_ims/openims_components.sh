case $OPENIMS_COMPONENT in
	pcscf)
		cp /opt/OpenIMSCore/ser_ims/cfg/pcscf.* /opt/OpenIMSCore
		/opt/OpenIMSCore/pcscf.sh
		;;
esac
