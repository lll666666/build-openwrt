#!/bin/bash
#========================================================================================================================
# https://github.com/ophub/amlogic-s9xxx-openwrt
# Description: Automatically Build OpenWrt
# Function: Diy script (Before Update feeds, Modify the default IP, hostname, theme, add/remove software packages, etc.)
# Source code repository: https://github.com/openwrt/openwrt / Branch: main
#========================================================================================================================

# Add a feed source
# sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default
> feeds.conf.default
echo 'src-git-full packages https://github.com/jjm2473/packages.git^b26cfeee1' >>feeds.conf.default
echo 'src-git-full luci https://github.com/jjm2473/luci.git^5b482a70ba' >>feeds.conf.default
echo 'src-git-full routing https://git.openwrt.org/feed/routing.git^777c115' >>feeds.conf.default
echo 'src-git-full telephony https://git.openwrt.org/feed/telephony.git^8143d9d' >>feeds.conf.default
echo 'src-git store https://github.com/linkease/istore.git^4c5098f' >>feeds.conf.default
echo 'src-git third https://github.com/jjm2473/openwrt-third.git^4a0f27e' >>feeds.conf.default
echo 'src-git third_party https://github.com/linkease/istore-packages.git^3874e89
echo 'src-git diskman https://github.com/jjm2473/luci-app-diskman.git^113509f' >>feeds.conf.default
echo 'src-git oaf https://github.com/jjm2473/OpenAppFilter.git^d8663f9' >>feeds.conf.default
echo 'src-git linkease_nas https://github.com/linkease/nas-packages.git^87bf6e6' >>feeds.conf.default
echo 'src-git linkease_nas_luci https://github.com/linkease/nas-packages-luci.git^f9869e2' >>feeds.conf.default
echo 'src-git jjm2473_apps https://github.com/jjm2473/openwrt-apps.git^fae9cde' >>feeds.conf.default

# other
# rm -rf package/utils/{ucode,fbtest}

