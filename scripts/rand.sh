#!/usr/bin/env bash
len=${1:-10}
head /dev/urandom | tr -dc A-Za-z0-9 | head -c $len; echo ''
