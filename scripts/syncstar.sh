#!/bin/env bash

set -e

export GITHUB_TOKEN=$(op item get $OP_GITHUB_PRIV_ID --fields label=token --reveal)
gh repo sync vanhtuan0409/stargazer -b master
