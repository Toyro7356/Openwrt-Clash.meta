#!/bin/sh

# uninstall
if [ -x "/bin/opkg" ]; then
	opkg remove luci-i18n-meta-zh-cn
	opkg remove luci-app-meta
	opkg remove meta
elif [ -x "/usr/bin/apk" ]; then
	apk del luci-i18n-meta-zh-cn
	apk del luci-app-meta
	apk del meta
fi
# remove config
rm -f /etc/config/meta
# remove files
rm -rf /etc/meta
