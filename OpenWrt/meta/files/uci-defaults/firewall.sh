#!/bin/sh

. "$IPKG_INSTROOT/etc/meta/scripts/include.sh"

uci -q batch <<-EOF > /dev/null
	del firewall.meta
	set firewall.meta=include
	set firewall.meta.type=script
	set firewall.meta.path=$FIREWALL_INCLUDE_SH
	set firewall.meta.fw4_compatible=1
	commit firewall
EOF
