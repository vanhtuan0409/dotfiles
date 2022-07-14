#!/bin/env bash

set -e

tmp_file=$(mktemp)
vim_path=$(which nvim)
$vim_path --startuptime $tmp_file -c "qall!" --headless
cat $tmp_file
rm -rf $tmp_file
