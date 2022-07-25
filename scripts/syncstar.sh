#!/bin/env bash

set -e

GITHUB_TOKEN="${PRIV_GITHUB_TOKEN}" gh repo sync vanhtuan0409/stargazer -b master
