#!/bin/bash
#========================================================================================================================
# https://github.com/ophub/amlogic-s9xxx-openwrt
# Description: Automatically Build OpenWrt
# Function: Diy script (After Update feeds, Modify the default IP, hostname, theme, add/remove software packages, etc.)
# Source code repository: https://github.com/openwrt/openwrt / Branch: main
#========================================================================================================================

# ------------------------------- Main source started -------------------------------
#
# Add the default password for the 'root' user（Change the empty password to 'password'）
sed -i 's/root:::0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.::0:99999:7:::/g' package/base-files/files/etc/shadow

# Set etc/openwrt_release
sed -i "s|DISTRIB_REVISION='.*'|DISTRIB_REVISION='R$(date +%Y.%m.%d)'|g" package/base-files/files/etc/openwrt_release
echo "DISTRIB_SOURCECODE='official'" >>package/base-files/files/etc/openwrt_release

# Modify default IP（FROM 192.168.1.1 CHANGE TO 192.168.31.4）
sed -i 's/192.168.1.1/192.168.31.2/g' package/base-files/files/bin/config_generate
#
# ------------------------------- Main source ends -------------------------------

# ------------------------------- Other started -------------------------------
#
# Add luci-app-amlogic
# svn co https://github.com/ophub/luci-app-amlogic/trunk/luci-app-amlogic package/luci-app-amlogic
# echo 'src-git istore https://github.com/linkease/istore' >>feeds.conf.default
# > feeds.conf.default
# echo 'src-git-full packages https://github.com/jjm2473/packages.git^b26cfeee1' >>feeds.conf.default
# echo 'src-git-full luci https://github.com/jjm2473/luci.git^5b482a70ba' >>feeds.conf.default
# echo 'src-git-full routing https://git.openwrt.org/feed/routing.git^777c115' >>feeds.conf.default
# echo 'src-git-full telephony https://git.openwrt.org/feed/telephony.git^8143d9d' >>feeds.conf.default
# echo 'src-git store https://github.com/linkease/istore.git^4c5098f' >>feeds.conf.default
# echo 'src-git third https://github.com/jjm2473/openwrt-third.git^4a0f27e' >>feeds.conf.default
# echo 'src-git third_party https://github.com/linkease/istore-packages.git^3874e89' >>feeds.conf.default
# echo 'src-git diskman https://github.com/jjm2473/luci-app-diskman.git^113509f' >>feeds.conf.default
# echo 'src-git oaf https://github.com/jjm2473/OpenAppFilter.git^d8663f9' >>feeds.conf.default
# echo 'src-git linkease_nas https://github.com/linkease/nas-packages.git^87bf6e6' >>feeds.conf.default
# echo 'src-git linkease_nas_luci https://github.com/linkease/nas-packages-luci.git^f9869e2' >>feeds.conf.default
# echo 'src-git jjm2473_apps https://github.com/jjm2473/openwrt-apps.git^fae9cde' >>feeds.conf.default

# echo 'src-git packages https://github.com/jjm2473/packages.git' >>feeds.conf.default
# echo 'src-git luci https://github.com/jjm2473/luci.git' >>feeds.conf.default
# echo 'src-git routing https://git.openwrt.org/feed/routing.git' >>feeds.conf.default
# echo 'src-git telephony https://git.openwrt.org/feed/telephony.git' >>feeds.conf.default
# echo 'src-git store https://github.com/linkease/istore.git' >>feeds.conf.default
# echo 'src-git third https://github.com/jjm2473/openwrt-third.git' >>feeds.conf.default
# echo 'src-git third_party https://github.com/linkease/istore-packages.git' >>feeds.conf.default
# echo 'src-git diskman https://github.com/jjm2473/luci-app-diskman.git' >>feeds.conf.default
# echo 'src-git oaf https://github.com/jjm2473/OpenAppFilter.git' >>feeds.conf.default
# echo 'src-git linkease_nas https://github.com/linkease/nas-packages.git' >>feeds.conf.default
# echo 'src-git linkease_nas_luci https://github.com/linkease/nas-packages-luci.git' >>feeds.conf.default
# echo 'src-git jjm2473_apps https://github.com/jjm2473/openwrt-apps.git' >>feeds.conf.default
git clone https://github.com/1877574385/luci-app-openclash package/luci-app-openclash

# 修改 Makefile
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/..\/..\/luci.mk/$(TOPDIR)\/feeds\/luci\/luci.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/..\/..\/lang\/golang\/golang-package.mk/$(TOPDIR)\/feeds\/packages\/lang\/golang\/golang-package.mk/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=@GHREPO/PKG_SOURCE_URL:=https:\/\/github.com/g' {}
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/PKG_SOURCE_URL:=@GHCODELOAD/PKG_SOURCE_URL:=https:\/\/codeload.github.com/g' {}
# coolsnowwolf default software package replaced with Lienol related software package
# rm -rf feeds/packages/utils/{containerd,libnetwork,runc,tini}
# svn co https://github.com/Lienol/openwrt-packages/trunk/utils/{containerd,libnetwork,runc,tini} feeds/packages/utils

# Add third-party software packages (The entire repository)
# git clone https://github.com/libremesh/lime-packages.git package/lime-packages
# Add third-party software packages (Specify the package)
# svn co https://github.com/libremesh/lime-packages/trunk/packages/{shared-state-pirania,pirania-app,pirania} package/lime-packages/packages
# Add to compile options (Add related dependencies according to the requirements of the third-party software package Makefile)
# sed -i "/DEFAULT_PACKAGES/ s/$/ pirania-app pirania ip6tables-mod-nat ipset shared-state-pirania uhttpd-mod-lua/" target/linux/armvirt/Makefile

# Apply patch
# git apply ../config/patches/{0001*,0002*}.patch --directory=feeds/luci
#
# ------------------------------- Other ends -------------------------------
