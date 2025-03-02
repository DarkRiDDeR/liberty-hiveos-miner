#!/usr/bin/env bash
. /hive/miners/custom/$CUSTOM_MINER/h-manifest.conf

get_miner_uptime(){
    local log_time=$(stat --format='%Y' "$CUSTOM_LOG_BASENAME")
    local conf_time=$(stat --format='%Y' "$CUSTOM_CONFIG_FILENAME")
	echo $(($log_time-$conf_time))
}

hs=0
hs_units='H/s'
ac=0
rj=0
uptime=$(get_miner_uptime)

# [⠇] Hashrate: 604.49 H/s | Accepts: 49 | Rejects: 0
# [⠋] Hashrate: 751.29 H/s | Accepts: 1 | Rejects: 02025/03/02 07:04:52 ✅ Worker 16: Block solution found! Sending to node...
line=`cat $CUSTOM_LOG_BASENAME | tail -n 10 | sed -En '$s/.*Hashrate:(.*?)((\d\d\d\d\/\d\d\/\d\d)|$)/\1/p'`
#| tail -n 1 | rev | cut -d "-" -f1 | rev`
if [ ! -z "${line}" ] ; then
    hs=`echo $line | cut -d " " -f1 | cut -d "." -f1`
    hs_units=`echo $line | cut -d " " -f2`
    ac=`echo $line | cut -d " " -f5`
    rj=`echo $line | cut -d " " -f8`
fi

temp=`cpu-temp`
khs=$hs
stats=$(jq -nc \
        --arg hs_units "$hs_units" \
        --arg hs "$hs" \
        --arg temp "$temp" \
        --arg ver "$CUSTOM_VERSION" \
        --arg algo "liberty-cpu" \
        --arg ac "$ac" --arg rj "$rj" \
        --arg uptime "$uptime" \
        '{hs: [$hs], $hs_units, temp: [$temp], fan: [0], $uptime, $ver, ar: [$ac, $rj], $algo, bus_numbers: ["0"]}')

echo hs:   $khs
echo stats: $stats
echo ----------
