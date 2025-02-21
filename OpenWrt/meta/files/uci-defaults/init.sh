#!/bin/sh

. "$IPKG_INSTROOT/etc/meta/scripts/include.sh"

# check meta.config.init
init=$(uci -q get meta.config.init); [ -z "$init" ] && return

# generate random string for api secret and authentication password
random=$(awk 'BEGIN{srand(); print int(rand() * 1000000)}')

# set meta.mixin.api_secret
uci set meta.mixin.api_secret="$random"

# set meta.@authentication[0].password
uci set meta.@authentication[0].password="$random"

# remove meta.config.init
uci del meta.config.init

# commit
uci commit meta

# exit with 0
exit 0
