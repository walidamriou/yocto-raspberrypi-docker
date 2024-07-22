#!/bin/bash

# Create and navigate to the Yocto directory
mkdir -p ~/Yocto
cd ~/Yocto

# Clone the Yocto project repository
git clone git://git.yoctoproject.org/poky -b dunfell

# Clone the meta-raspberrypi repository
git clone git://git.yoctoproject.org/meta-raspberrypi -b dunfell

# Clone the meta-openembedded repository
git clone https://git.openembedded.org/meta-openembedded -b dunfell

# Source the build environment
source poky/oe-init-build-env

# Add layers to the build configuration
bitbake-layers add-layer ../meta-openembedded/meta-oe
bitbake-layers add-layer ../meta-openembedded/meta-python
bitbake-layers add-layer ../meta-openembedded/meta-multimedia
bitbake-layers add-layer ../meta-openembedded/meta-networking
bitbake-layers add-layer ../meta-raspberrypi

# Execute the bash shell to keep the container running
exec /bin/bash
