#!/bin/bash

# Thanks for xiaoxindada

set -e

DEVICE=$1
MAKEWHAT=$2

device_manufacturer=$(cat out/target/product/$DEVICE/recovery/root/default.prop | grep "ro.product.system.manufacture" | head -n 1 | cut -d "=" -f 2)
android_version=$(cat out/target/product/$DEVICE/recovery/root/default.prop | grep "ro.build.version.release" | head -n 1 | cut -d "=" -f 2)
device_product=$(cat out/target/product/$DEVICE/recovery/root/default.prop | grep "ro.build.product=" | head -n 1 | cut -d "=" -f 2)
andriod_spl=$(cat out/target/product/$DEVICE/recovery/root/default.prop | grep "ro.build.version.security_patch" | head -n 1 | cut -d "=" -f 2)
device_model=$(cat out/target/product/$DEVICE/recovery/root/default.prop | grep "ro.product.system.model" | head -n 1 | cut -d "=" -f 2)
android_image_size=$(echo `(du -sm out/target/product/$DEVICE/$MAKEWHAT.img | awk '{print $1}' | sed 's/$/&MB/')`)
build_date=$(TZ=Asia/Shanghai date "+%Y-%m-%d %H:%M")
ofox=$(cat out/target/product/$DEVICE/recovery/root/default.prop | grep "ro.product.system.name" | head -n 1 | cut -d "=" -f 2)
twrp=$(cat out/target/product/$DEVICE/recovery/root/default.prop | grep "ro.product.system.name" | head -n 1 | cut -d "=" -f 2)

if [ $ofox = fox_$DEVICE ] ;then
recoveryiswhat=Ofox
elif [ $twrp = twrp_$DEVICE  ] ;then
recoveryiswhat=Twrp
else
recoveryiswhat=Unknown
fi

echo "
Recovery: $recoveryiswhat
Manufacturer Name: $device_manufacturer
Android Version: $android_version
Product Name: $device_product
Security Patch Level: $andriod_spl
Device Model: $device_model
$MAKEWHAT.img Size: $android_image_size
Build Date: $build_date
" > info.txt

echo "RECOVERYISWHAT=$recoveryiswhat" >> $GITHUB_ENV
