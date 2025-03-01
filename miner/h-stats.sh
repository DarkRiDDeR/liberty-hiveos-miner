. /hive/miners/custom/$CUSTOM_MINER/h-manifest.conf

get_miner_uptime(){
    local log_time=$(stat --format='%Y' "$CUSTOM_LOG_BASENAME")
    local conf_time=$(stat --format='%Y' "$CUSTOM_CONFIG_FILENAME")
	echo $(log_time-conf_time)
}

hs=0
hs_units='H/s'
ac=0
rj=0
uptime=1

# [⠇] Hashrate: 604.49 H/s | Accepts: 49 | Rejects: 0
line=`cat $CUSTOM_LOG_BASENAME | tail -n 10 | grep "Hashrate:"
#| tail -n 1 | rev | cut -d "-" -f1 | rev`
if [ ! -z "${data}" ] ; then
    IFS=' ' read -r -a arr <<< "$line"
    hs=`echo ${arr[2]}`
    hs_units=`echo ${arr[3]}`
    ac=`echo ${arr[6]}`
    rj=`echo ${arr[9]}`
fi


#--argjson temp "`echo ${temp[@]} | tr " " "\n" | jq -cs '.'`" \
#--argjson fan "`echo ${fan[@]} | tr " " "\n" | jq -cs '.'`" \
#--arg uptime "$uptime" \
#--arg ac "$ac" --arg rj "$rj" \
temp=`cpu-temp`
stats=$(jq -nc \
        --arg hs_units "$hs_units" \
        --arg hs "$hs" \
        --arg temp "$temp" \
        --arg ver "$CUSTOM_VERSION" \
        --arg algo "liberty-cpu" \
        --arg ac "$ac" --arg rj "$rj" \
        --arg uptime "$uptime" \
        '{$hs, $hs_units, temp: [$temp], fan: [0], $uptime, $ver, ar: [$ac, $rj], $algo, bus_numbers: [0]}')

echo khs:   $hs
echo stats: $stats
echo ----------
