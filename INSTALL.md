# NAM Trainer Reloaded Installation

NAM Trainer Reloaded installs locally from this repository or from the release zip. It creates its own local Python environment inside the project folder and does not require an existing NAM installation.

## What Gets Installed

The installers create one local environment:

- Windows with conda available: `.conda-env`
- Windows without conda: `.venv`
- macOS: `.venv`

The Python package is installed in editable mode from this folder. User settings, saved presets, paths, output captures, checkpoints, and logs are created locally after you run the app and are ignored by git.

## Required External Programs

All systems:

- Internet access during installation.
- Python package installer access to PyPI.
- Git only if you clone the repository instead of downloading a release zip.

Windows:

- Windows 10 or Windows 11.
- Miniconda/Anaconda is recommended.
- If conda is not installed, install Python 3.13 from python.org and make sure the `py` launcher or `python` command is available.

macOS:

- macOS with Python 3.13 preferred. The installer also tries `python3` if `python3.13` is not available.
- Homebrew is optional, but useful if the audio backend needs PortAudio:

```sh
brew install portaudio
```

## Python Packages

The install scripts install:

- `torch`
- `pytorch-lightning`
- `numpy`
- `scipy`
- `librosa`
- `matplotlib`
- `soundfile`
- `sounddevice`
- `pydantic`
- `tensorboard`
- `rich`
- `requests`
- `transformers`
- `tqdm`
- `wavio`

The vendored `nam._dependencies.auraloss` code is included in the repository.

## Windows GPU Training

For NVIDIA GPU training on Windows:

1. Install or update the NVIDIA driver.
2. Run:

```bat
INSTALL_WINDOWS.bat
```

By default, the installer tries the CUDA PyTorch wheel index configured in `scripts/install_windows.ps1`. If that CUDA wheel is not compatible with your system, choose a PyTorch index manually:

```bat
INSTALL_WINDOWS.bat -TorchIndexUrl https://download.pytorch.org/whl/cu128
```

or:

```bat
INSTALL_WINDOWS.bat -TorchIndexUrl https://download.pytorch.org/whl/cu130
```

You do not need to install the full CUDA Toolkit for normal PyTorch wheel usage; the NVIDIA driver is the important system requirement.

## Windows CPU Training

For CPU-only training:

```bat
INSTALL_WINDOWS.bat -CPU
```

CPU training is much slower, especially for larger WaveNet architectures, but it avoids NVIDIA/CUDA requirements.

## Windows Run

After installation:

```bat
run_trainer.bat
```

You can also double-click `run_trainer.bat`.

## macOS Training

macOS does not support NVIDIA CUDA. PyTorch may use Apple MPS acceleration on supported Apple Silicon systems, depending on your Python/PyTorch/macOS combination. Otherwise, training runs on CPU.

Install:

```sh
sh INSTALL_MACOS.sh
```

Run:

```sh
sh run_trainer.sh
```

Double-click friendly files are also included:

- `INSTALL_MACOS.command`
- `run_trainer.command`

If macOS refuses to open them after downloading a zip, run this once in Terminal from the project folder:

```sh
chmod +x INSTALL_MACOS.command run_trainer.command INSTALL_MACOS.sh run_trainer.sh scripts/install_unix.sh
```

Then double-click `INSTALL_MACOS.command`, and afterward double-click `run_trainer.command`.

## macOS Options

Choose a specific Python:

```sh
sh INSTALL_MACOS.sh --python /path/to/python3.13
```

Skip PyTorch installation if it already exists in the local environment:

```sh
sh INSTALL_MACOS.sh --skip-torch
```

Use a custom PyTorch package index:

```sh
sh INSTALL_MACOS.sh --torch-index-url https://download.pytorch.org/whl/cpu
```

## Runtime Notes

- The runners set `KMP_DUPLICATE_LIB_OK=TRUE`, matching common NAM Trainer Windows runtime practice.
- The runners disable `NAM_TRAINER_DEVICE_STATS` by default to avoid Lightning device-stat logging stalls during training.
- The trainer may create `nam/train/gui/_resources/settings.json` after launch. That file stores local paths, GUI settings, and any presets the user creates later. It is intentionally ignored and not shipped in this release.
- This repository does not include user presets, input clips, output clips, checkpoints, NAM exports, Lightning logs, tests, or cache files.
- The small `nam/models/_resources/loudness_input.wav` file is included because NAM export/loudness code references it at runtime.
