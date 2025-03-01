#!/usr/bin/env bash
# This code is included in /hive/bin/custom function

. colors
. /hive/miners/custom/$CUSTOM_MINER/h-manifest.conf

# for replacing rhminer 2.3
# MINER_LATEST_VER=2.3
function miner_ver() {
    echo "2.3"
}
function miner_config_echo() {
    echo "config"
}
function miner_config_gen() {
    echo "gen"
}

#DWAL="dummy"
#WORKER_NAME=test
#CUSTOM_TEMPLATE=HaloGenius.%WORKER_NAME%
#CUSTOM_URL=stratum.nrg.minecrypto.pro:9999
#CUSTOM_PASS=""
#CUSTOM_CONFIG_FILENAME="config.conf"
#CUSTOM_USER_CONFIG="--wallet YouWallet --threads YouTreads"

[[ -z $CUSTOM_TEMPLATE ]] && echo -e "${YELLOW}CUSTOM_TEMPLATE is empty${NOCOLOR}" && return 1
[[ -z $CUSTOM_URL ]] && echo -e "${YELLOW}CUSTOM_URL is empty${NOCOLOR}" && return 1
[[ -z $CUSTOM_USER_CONFIG ]] && echo -e "${YELLOW}CUSTOM_USER_CONFIG is empty${NOCOLOR}" && return 1

conf="${CUSTOM_URL} ${CUSTOM_TEMPLATE} ${CUSTOM_USER_CONFIG}"
echo "$conf" > $CUSTOM_CONFIG_FILENAME





