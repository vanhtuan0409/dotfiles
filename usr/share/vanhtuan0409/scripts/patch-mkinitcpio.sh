#!/bin/env bash

set -e

sed -i "s/PRESETS=('default' 'fallback')/PRESETS=('default')/g" /bin/gen-mkinitcpio-preset

sed -i "/KIM_NO_FALLBACK/d" /etc/kernel-install-mkinitcpio.conf
echo 'KIM_NO_FALLBACK=true' >> /etc/kernel-install-mkinitcpio.conf
