#!/usr/bin/env sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
VENV="$ROOT/.venv"
REQUIREMENTS="$ROOT/requirements.txt"
PYTHON_CMD=""
SKIP_TORCH=0
TORCH_INDEX_URL=""

while [ "$#" -gt 0 ]; do
    case "$1" in
        --python)
            shift
            PYTHON_CMD="${1:-}"
            ;;
        --skip-torch)
            SKIP_TORCH=1
            ;;
        --torch-index-url)
            shift
            TORCH_INDEX_URL="${1:-}"
            ;;
        --help|-h)
            echo "Usage: sh INSTALL_MACOS.sh [--python /path/to/python] [--skip-torch] [--torch-index-url URL]"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            exit 2
            ;;
    esac
    shift
done

find_python() {
    if [ -n "$PYTHON_CMD" ]; then
        printf '%s\n' "$PYTHON_CMD"
        return
    fi
    if command -v python3.13 >/dev/null 2>&1; then
        command -v python3.13
        return
    fi
    if command -v python3 >/dev/null 2>&1; then
        command -v python3
        return
    fi
    if command -v python >/dev/null 2>&1; then
        command -v python
        return
    fi
    return 1
}

echo "NAM Trainer Reloaded installer"
echo "Root: $ROOT"

BASE_PYTHON=$(find_python) || {
    echo "Python was not found. Install Python 3.13 or Miniforge/Miniconda, then rerun this installer."
    exit 1
}

if [ ! -d "$VENV" ]; then
    echo "Creating local virtual environment..."
    "$BASE_PYTHON" -m venv "$VENV"
fi

PYTHON="$VENV/bin/python"
if [ ! -x "$PYTHON" ]; then
    echo "Python executable was not created: $PYTHON"
    exit 1
fi

echo "Using Python: $PYTHON"
"$PYTHON" -m pip install --upgrade pip setuptools wheel

if [ "$SKIP_TORCH" -eq 0 ]; then
    if [ -n "$TORCH_INDEX_URL" ]; then
        echo "Installing PyTorch from $TORCH_INDEX_URL ..."
        "$PYTHON" -m pip install torch --index-url "$TORCH_INDEX_URL"
    else
        echo "Installing PyTorch from PyPI ..."
        "$PYTHON" -m pip install torch
    fi
fi

"$PYTHON" -m pip install -r "$REQUIREMENTS"
"$PYTHON" -m pip install --no-deps -e "$ROOT"

"$PYTHON" -c "from nam.train.gui import run; print('NAM Trainer Reloaded import check passed')"

echo
echo "Installation complete."
echo "Start the trainer with: sh $ROOT/run_trainer.sh"
