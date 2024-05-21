#!/bin/env bash

set -e

MACHINEID=c8dcec4f25ed470cbf11f3f7af97c7fb

find /efi/$MACHINEID -type f | grep initrd-fallback | xargs rm -rf
find /efi/loader/entries -type f | grep fallback | xargs rm -rf
