# --------------------------------------------
# aka.jiang 20150228
# for clone project

# --------------------------------------------
BASE_PROJECT=k15ta_a
NEW_PROJECT=k15tb_a
PLATFORM=mt6797
COMPANY=nb
SHARED_LIB=yes

ROOT_PATH=`pwd`

echo "----------------------------------------------"
echo "BASE_PROJECT = $BASE_PROJECT"
echo "NEW_PROJECT  = $NEW_PROJECT"
echo "PLATFORM     = $PLATFORM"
echo "COMPANY      = $COMPANY"
echo "SHARED_LIB   = $SHARED_LIB"
echo "ROOT_PATH    = $ROOT_PATH"
echo "----------------------------------------------"

# --------------------------------------------
# preloader
echo "clone preloader begin ..."

cd vendor/mediatek/proprietary/bootable/bootloader/preloader/custom
cp -r  ${BASE_PROJECT}   ${NEW_PROJECT}
mv ${NEW_PROJECT}/${BASE_PROJECT}.mk   ${NEW_PROJECT}/${NEW_PROJECT}.mk
sed -i  s/${BASE_PROJECT}/${NEW_PROJECT}/g  ${NEW_PROJECT}/${NEW_PROJECT}.mk
sed -i  s/${BASE_PROJECT}/${NEW_PROJECT}/g  ${NEW_PROJECT}/dct/dct/codegen.dws

echo "clone preloader end"
# --------------------------------------------
# lk
echo "clone lk begin ..."

cd $ROOT_PATH
cd vendor/mediatek/proprietary/bootable/bootloader/lk

cp project/${BASE_PROJECT}.mk  project/${NEW_PROJECT}.mk
cp -r target/${BASE_PROJECT}  target/${NEW_PROJECT}
sed -i s/${BASE_PROJECT}/${NEW_PROJECT}/g  target/${NEW_PROJECT}/dct/dct/codegen.dws
sed -i s/${BASE_PROJECT}/${NEW_PROJECT}/g  project/${NEW_PROJECT}.mk
#sed -i s/${BASE_PROJECT}/${NEW_PROJECT}/g  target/${NEW_PROJECT}/include/target/cust_usb.h

echo "clone lk end"
# --------------------------------------------
# kernel
echo "clone kernel begin ..."

cd $ROOT_PATH
cd kernel-3.18

cp -r drivers/misc/mediatek/mach/${PLATFORM}/${BASE_PROJECT}  drivers/misc/mediatek/mach/${PLATFORM}/${NEW_PROJECT}
cd drivers/misc/mediatek/mach/${PLATFORM}/${NEW_PROJECT}/dct/dct/
sed -i s/${BASE_PROJECT}/${NEW_PROJECT}/g  codegen.dws
cd -
cp arch/arm64/configs/${BASE_PROJECT}_defconfig   arch/arm64/configs/${NEW_PROJECT}_defconfig
cp arch/arm64/configs/${BASE_PROJECT}_debug_defconfig   arch/arm64/configs/${NEW_PROJECT}_debug_defconfig

cd $ROOT_PATH
cd kernel-3.18/arch/arm64/

sed -i s/${BASE_PROJECT}/${NEW_PROJECT}/g   configs/${NEW_PROJECT}_defconfig
sed -i s/${BASE_PROJECT}/${NEW_PROJECT}/g   configs/${NEW_PROJECT}_debug_defconfig
cp boot/dts/${BASE_PROJECT}.dts  boot/dts/${NEW_PROJECT}.dts

echo "clone kernel end"
# --------------------------------------------
# android
echo "clone android begin ..."

cd $ROOT_PATH

cp -r device/${COMPANY}/${BASE_PROJECT} device/${COMPANY}/${NEW_PROJECT}
mv device/${COMPANY}/${NEW_PROJECT}/full_${BASE_PROJECT}.mk device/${COMPANY}/${NEW_PROJECT}/full_${NEW_PROJECT}.mk

cp -r vendor/mediatek/proprietary/custom/${BASE_PROJECT} vendor/mediatek/proprietary/custom/${NEW_PROJECT}
cp vendor/mediatek/proprietary/trustzone/custom/build/project/${BASE_PROJECT}.mk vendor/mediatek/proprietary/trustzone/custom/build/project/${NEW_PROJECT}.mk
cp -r vendor/mediatek/proprietary/tinysys/freertos/source/project/CM4_A/mt6797/${BASE_PROJECT} vendor/mediatek/proprietary/tinysys/freertos/source/project/CM4_A/mt6797/${NEW_PROJECT}
# cp md32/md32/project/${BASE_PROJECT}.mk md32/md32/project/${NEW_PROJECT}.mk

sed -i s/${BASE_PROJECT}/${NEW_PROJECT}/g  device/${COMPANY}/${NEW_PROJECT}/AndroidProducts.mk
sed -i s/${BASE_PROJECT}/${NEW_PROJECT}/g  device/${COMPANY}/${NEW_PROJECT}/BoardConfig.mk
sed -i s/${BASE_PROJECT}/${NEW_PROJECT}/g  device/${COMPANY}/${NEW_PROJECT}/device.mk
sed -i s/${BASE_PROJECT}/${NEW_PROJECT}/g  device/${COMPANY}/${NEW_PROJECT}/full_${NEW_PROJECT}.mk
sed -i s/${BASE_PROJECT}/${NEW_PROJECT}/g  device/${COMPANY}/${NEW_PROJECT}/vendorsetup.sh
sed -i s/${BASE_PROJECT}/${NEW_PROJECT}/g  vendor/mediatek/proprietary/custom/${NEW_PROJECT}/Android.mk

# if [ "$SHARED_LIB" == "yes" ] || [ "$SHARED_LIB" == "YES" ]; then
#    echo "using shared lib with ${BASE_PROJECT}"
#    sed -i s#vendor/${COMPANY}/libs/${NEW_PROJECT}#vendor/${COMPANY}/libs/${BASE_PROJECT}#g device/${COMPANY}/${NEW_PROJECT}/device.mk
# else
#    echo "cp lib from ${BASE_PROJECT}"
#    cp -r vendor/${COMPANY}/libs/${BASE_PROJECT}  vendor/${COMPANY}/libs/${NEW_PROJECT}
#fi
cd $ROOT_PATH/vendor/${COMPANY}/libs/
ln -s ${BASE_PROJECT} ${NEW_PROJECT}
#cd $ROOT_PATH
#cp vendor/google/products/${BASE_PROJECT}/ vendor/google/products/${NEW_PROJECT}/ -rf

#only k15tb_a modem
#cd vendor/mediatek/proprietary/modem/
#ln -s nb6797_5M_OM_lwctg_k15ta_a/ nb6797_5M_OM_lwctg_k15tb_a

echo "clone android end"
# --------------------------------------------
