#!/usr/bin/env sh
echo "Removing old 7z files"
if [ -e "grubfm*.7z" ]
then
    rm grubfm*.7z
fi

i=0
for lang in en_US
do
    echo "Processing language: ${lang}"
    echo "Starting build with value: ${i}"
    sudo ./build.sh
    echo "Copying files"
    cp grubfm.iso loadfm samples/
    cp grubfm*.efi g2fm*.efi samples/
    echo "Creating 7z file"
    cd samples
    7z a ../g2fm-${lang}.7z *
    cd ..
done

