#!/bin/sh

####################################################################
# The install path will be added by build.ps1
# INSTALL_PATH="..."
####################################################################

if [ -d "${INSTALL_PATH}" ]; then

    read -p "Program already exists. Would you like to overwrite? [y]" CONFIRM
    if [ "${CONFIRM}" != "y" ]; then
        echo "Aborting install."
        exit
    fi

    echo "Removing existing directory..."
    sudo rm -rf ${INSTALL_PATH}
fi

echo "Copying files to ${INSTALL_PATH}..."

sudo cp -R ./publish/. ${INSTALL_PATH}
sudo chmod -R 777 ${INSTALL_PATH} 

grep "${INSTALL_PATH}" ~/.profile

if [ $? -eq 1 ]; then
echo "Adding to path..."
echo "PATH=\"${INSTALL_PATH}:\${PATH}\"" >> ~/.profile
fi

echo "DONE! ☕"

echo "Execute 'source ~/.profile' to apply the changes immediately."