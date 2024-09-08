#!/usr/bin/env sh

# Download the latest grub2 release
if ! wget https://github.com/TCFFan123/grub2/releases/download/latest/grub2-latest.tar.gz -O grub2-latest.tar.gz; then
  echo "Failed to download grub2-latest.tar.gz - "
  exit 1
fi

# Extract the files
echo "Extracting files... (this may take a while)"
if ! tar --overwrite -xf grub2-latest.tar.gz; then
  echo "Failed to extract grub2-latest.tar.gz"
  rm -f grub2-latest.tar.gz
  exit 1
fi