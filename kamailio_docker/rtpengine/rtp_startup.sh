#!/bin/bash

set -x
RUNTIME=${1:-rtpengine}

if lsmod | grep xt_RTPENGINE || modprobe xt_RTPENGINE; then
	echo "rtpengine kernel module already loaded."
else
	modprobe xt_RTPENGINE
fi

# Populate options of the rtpengine cli command
[ -z "$INTERFACE" ] && INTERFACE="$(awk 'END{print $1}' /etc/hosts)"
[ -z "$TABLE" ] && TABLE="0"
[ -z "$LISTEN_NG" ] && LISTEN_NG="$(awk 'END{print $1}' /etc/hosts):2223"
[ -z "$PORT_MIN" ] && PORT_MIN="30000"
[ -z "$PORT_MAX" ] && PORT_MAX="40000"
[ -z "$TOS" ] && TOS="184"
[ -z "$PIDFILE" ] && PIDFILE="/run/ngcp-rtpengine-daemon.pid"

LISTEN_CLI="$(awk 'END{print $1}' /etc/hosts):9901"

OPTIONS=""
OPTIONS="$OPTIONS --interface=$INTERFACE --listen-ng=$LISTEN_NG --listen-cli=$LISTEN_CLI --pidfile=$PIDFILE --port-min=$PORT_MIN --port-max=$PORT_MAX "
OPTIONS="$OPTIONS --table=$TABLE  --tos=$TOS --foreground"

if test "$NO_FALLBACK" = "yes" ; then
	OPTIONS="$OPTIONS --no-fallback"
fi

# Sync docker time
#ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

set +e
if [ -e /proc/rtpengine/control ]; then
	echo "del $TABLE" > /proc/rtpengine/control 2>/dev/null
fi
# Freshly add the iptables rules to forward the udp packets to the iptables-extension "RTPEngine":
# Remember iptables table = chains, rules stored in the chains
# -N (create a new chain with the name rtpengine)
iptables -N rtpengine 2> /dev/null

# -D: Delete the rule for the target "rtpengine" if exists. -j (target): chain name or extension name 
# from the table "filter" (the default -without the option '-t') 
iptables -D INPUT -j rtpengine 2> /dev/null
# Add the rule again so the packets will go to rtpengine chain after the (filter-INPUT) hook point.
iptables -I INPUT -j rtpengine
# Delete and Insert a rule in the rtpengine chain to forward the UDP traffic    
iptables -D rtpengine -p udp -j RTPENGINE --id "$TABLE" 2>/dev/null
iptables -I rtpengine -p udp -j RTPENGINE --id "$TABLE"
iptables-save > /etc/iptables.rules

# The same for IPv6
ip6tables -N rtpengine 2> /dev/null
ip6tables -D INPUT -j rtpengine 2> /dev/null
ip6tables -I INPUT -j rtpengine
ip6tables -D rtpengine -p udp -j RTPENGINE --id "$TABLE" 2>/dev/null
ip6tables -I rtpengine -p udp -j RTPENGINE --id "$TABLE"
ip6tables-save > /etc/ip6tables.rules

ip r add 10.46.0.0/16 via 10.1.1.18

set -x

exec $RUNTIME $OPTIONS
