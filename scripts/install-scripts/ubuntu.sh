#!/bin/sh

INSTALL_PATH="/usr/bin/multipftest"

echo "Copying files..."

rm -rf ${INSTALL_PATH}
cp -R ./publish/. ${INSTALL_PATH}

echo "Adding to path..."

echo "PATH=\"${INSTALL_PATH}:\${PATH}\"" >> ~/.profile

echo "DONE! ☕"