#!/bin/bash
function git_sparse_clone() {
  branch=$1 repourl=$2 && shift 2
  TMPFILE=$(mktemp -d tmp.XXXX) || exit 1
  git clone -b $branch --depth=1 --filter=blob:none --sparse $repourl $TMPFILE
  cd $TMPFILE
  git sparse-checkout init --cone
  git sparse-checkout set $@
  mv -n $@ ../
  cd ..
  rm -rf $TMPFILE
}

function mvdir() {
  mv -n $(find $1/* -maxdepth 0 -type d) ./
  REPODIR=$(echo $1 | cut -d/ -f1)
  rm -rf $REPODIR
}

#全能推送
git clone --depth=1 https://github.com/zzsj0928/luci-app-pushbot
#主题
#git clone --depth=1 -b master https://github.com/jerrykuku/luci-theme-argon
#git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config
#git clone --depth=1 https://github.com/sirpdboy/luci-app-advanced
#git clone --depth=1 https://github.com/Jason6111/luci-app-netdata
git clone --depth=1 https://github.com/esirplayground/luci-app-poweroff
git clone --depth=1 https://github.com/rufengsuixing/luci-app-adguardhome

git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall passwall && mvdir passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall2 && mvdir openwrt-passwall2
git clone --depth=1 -b main https://github.com/fw876/helloworld && mv helloworld/luci-app-ssr-plus ./

#git clone --depth=1 https://github.com/destan19/OpenAppFilter && mvdir OpenAppFilter
#git clone --depth=1 https://github.com/sbwml/luci-app-alist package/luci-app-alist
#git_sparse_clone master https://github.com/lisaac/luci-app-dockerman applications/luci-app-dockerman
#git_sparse_clone master https://github.com/immortalwrt/packages net/adguardhome


git clone --depth=1 https://github.com/linkease/istore-ui && mvdir istore-ui
git clone --depth=1 https://github.com/linkease/istore && mvdir istore/luci


git_sparse_clone master https://github.com/kenzok8/openwrt-packages luci-app-aliddns
git_sparse_clone master https://github.com/kiddin9/openwrt-packages luci-app-linkease linkease linkmount ffmpeg-remux


git_sparse_clone main https://github.com/haiibo/packages luci-app-wrtbwmon wrtbwmon luci-app-onliner

rm -rf ./*/.git* ./*/LICENSE
find ./*/ -type f -name '*.md' -print -exec rm -rf {} \;

exit 0
