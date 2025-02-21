#!/bin/sh

# meta's installer

# check env
if [[ ! -x "/bin/opkg" && ! -x "/usr/bin/apk" || ! -x "/sbin/fw4" ]]; then
	echo "only supports OpenWrt build with firewall4!"
	exit 1
fi

# include openwrt_release
. /etc/openwrt_release

# get branch/arch
arch="$DISTRIB_ARCH"
branch=
case "$DISTRIB_RELEASE" in
	*"23.05"*)
		branch="openwrt-23.05"
		;;
	*"24.10"*)
		branch="openwrt-24.10"
		;;
	"SNAPSHOT")
		branch="SNAPSHOT"
		;;
	*)
		echo "unsupported release: $DISTRIB_RELEASE"
		exit 1
		;;
esac

# feed url
repository_url="https://metameta.pages.dev"
feed_url="$repository_url/$branch/$arch/meta"

if [ -x "/bin/opkg" ]; then
	# download ipks
	eval $(curl -s -L $feed_url/index.json | jsonfilter -e 'version=@["packages"]["meta"]' -e 'app_version=@["packages"]["luci-app-meta"]' -e 'i18n_version=@["packages"]["luci-i18n-meta-zh-cn"]')
	curl -s -L -J -O $feed_url/meta_${version}_${arch}.ipk
	curl -s -L -J -O $feed_url/luci-app-meta_${app_version}_all.ipk
	curl -s -L -J -O $feed_url/luci-i18n-meta-zh-cn_${i18n_version}_all.ipk
	# update feeds
	echo "update feeds"
	opkg update
	# install ipks
	echo "install ipks"
	opkg install meta_*.ipk luci-app-meta_*.ipk luci-i18n-meta-zh-cn_*.ipk
	rm -f -- *meta*.ipk
elif [ -x "/usr/bin/apk" ]; then
	# install apks from remote repository
	echo "install apks from remote repository"
	apk add --allow-untrusted --repository $feed_url/packages.adb meta luci-app-meta luci-i18n-meta-zh-cn
fi

echo "success"
