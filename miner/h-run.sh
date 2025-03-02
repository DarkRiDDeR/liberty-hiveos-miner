cd `dirname $0`

. h-manifest.conf
CONF=`cat config.conf`

CUSTOM_LOG_BASEDIR=`dirname "$CUSTOM_LOG_BASENAME"`
[[ ! -d $CUSTOM_LOG_BASEDIR ]] && mkdir -p $CUSTOM_LOG_BASEDIR

./liberty-linux-amd64 $CONF 2>&1 | tee $CUSTOM_LOG_BASENAME