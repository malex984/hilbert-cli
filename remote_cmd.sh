#!/bin/sh

SELFDIR=`dirname "$0"`
SELFDIR=`cd "$SELFDIR" && pwd`

## set -e

if [ -z "$CFG_DIR" ]; then
    export CFG_DIR="$PWD" 
    # HOME/.config/dockapp"
fi

cd $CFG_DIR

# ACTION="$1"
### start, stop, 
# shift

CMD=$(basename "$0" '.sh')
CMD="~/.config/dockapp/$CMD.sh"

TARGET_HOST_NAME="$1"
shift
### station id
ARGS=$@


DM=${DM:-}
SSH=${SSH:-${DM} ssh}

# "$CFG_DIR/deploy.sh" "${TARGET_HOST_NAME}"

   $SSH "${TARGET_HOST_NAME}" "test -x $CMD && exit 0 || exit 1"
   if [ $? -ne 0 ]; then
      echo "ERROR: no executable shell script '$CMD' on station '${TARGET_HOST_NAME}'!"
      exit 1
   fi

D="$CMD $ARGS"

echo "Running custom management command: '$D' to run on station '${TARGET_HOST_NAME}': "
$SSH "${TARGET_HOST_NAME}" "$D"
