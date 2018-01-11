#!/bin/sh

# Copyright (c) 2017 Akira Kido
# https://github.com/akiraKido

# Permission is hereby granted, free of charge, to any person obtaining a 
# copy of this software and associated documentation files (the 
# "Software"), to deal in the Software without restriction, including 
# without limitation the rights to use, copy, modify, merge, publish, 
# distribute, sublicense, and/or sell copies of the Software, and to 
# permit persons to whom the Software is furnished to do so, subject to 
# the following conditions:

# The above copyright notice and this permission notice shall be 
# included in all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE 
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION 
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION 
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

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