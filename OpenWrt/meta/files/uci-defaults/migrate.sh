#!/bin/sh

. "$IPKG_INSTROOT/etc/meta/scripts/include.sh"

# since v1.18.0

mixin_rule=$(uci -q get meta.mixin.rule); [ -z "$mixin_rule" ] && uci set meta.mixin.rule=0

mixin_rule_provider=$(uci -q get meta.mixin.rule_provider); [ -z "$mixin_rule_provider" ] && uci set meta.mixin.rule_provider=0

# commit
uci commit meta

# exit with 0
exit 0
