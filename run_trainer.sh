#!/usr/bin/env sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
PYTHON="$ROOT/.venv/bin/python"

if [ ! -x "$PYTHON" ]; then
    if command -v python3 >/dev/null 2>&1; then
        PYTHON=$(command -v python3)
    elif command -v python >/dev/null 2>&1; then
        PYTHON=$(command -v python)
    else
        echo "Could not find Python."
        echo "Run INSTALL_MACOS.sh first, then run this file again."
        exit 1
    fi
fi

export KMP_DUPLICATE_LIB_OK=TRUE
export FOR_DISABLE_CONSOLE_CTRL_HANDLER=1
unset NAM_TRAINER_DEVICE_STATS

if [ -n "${PYTHONPATH:-}" ]; then
    export PYTHONPATH="$ROOT:$PYTHONPATH"
else
    export PYTHONPATH="$ROOT"
fi

echo "Starting NAM Trainer Reloaded from:"
echo "  $ROOT"
echo "Using Python:"
echo "  $PYTHON"
echo
exec "$PYTHON" -c "from nam.train.gui import run; run()"
