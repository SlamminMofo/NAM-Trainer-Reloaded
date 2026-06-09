# NAM Trainer Reloaded

NAM Trainer Reloaded is a compact desktop trainer package based on Neural Amp Modeler training code, with A2 architectures, paired-checkpoint resume support, extra WaveNet architectures, scheduler tools, and current TTS input-clip recognition updates.

![NAM Trainer Reloaded GUI](docs/images/NAM_TRAINER_RELOADED_GUI.jpg)

Use the included installers to create a local training environment, then launch the desktop trainer with the platform-specific runner.

## Highlights

- Local desktop GUI for NAM training.
- A2 Full+Lite, A2 Complex+Lite, A2 Complex+RevYLo, A2 Complex+Nano, Double/xDouble, and other custom architectures.
- Queue/scheduler workflow for multiple training runs.
- Analyze Lightning folders to review previous training runs, saved metrics, ESR values, and timing data.
- Core and refinement dual-stage training with separate epoch, learning-rate, decay, scheduler, and refinement-focus controls.
- Resume training from checkpoint, including A2 checkpoint-pair handling.
- Clean Windows and macOS local installers/runners.

## Included

- `nam/` runtime source package.
- A2 packed model resource JSON files.
- The internal `nam/models/_resources/loudness_input.wav` file required by NAM export/loudness code.
- Windows installer and runner:
  - `INSTALL_WINDOWS.bat`
  - `run_trainer.bat`
- macOS installer and runner:
  - `INSTALL_MACOS.sh`
  - `INSTALL_MACOS.command`
  - `run_trainer.sh`
  - `run_trainer.command`
- Python dependency manifests:
  - `requirements-windows.txt`
  - `requirements.txt`
- `pyproject.toml`, `MANIFEST.in`, `LICENSE`, and GitHub publishing notes.

## Quick Start: Windows

1. Extract the release folder.
2. Double-click `INSTALL_WINDOWS.bat`.
3. Double-click `run_trainer.bat`.

The installer creates a local `.conda-env` when conda is available, otherwise a local `.venv`.

## Quick Start: macOS

Option A, double-click friendly:

1. Extract the release folder.
2. Double-click `INSTALL_MACOS.command`.
3. Double-click `run_trainer.command`.

Option B, Terminal:

```sh
sh INSTALL_MACOS.sh
sh run_trainer.sh
```

If you prefer executable scripts:

```sh
chmod +x INSTALL_MACOS.sh run_trainer.sh scripts/install_unix.sh
./INSTALL_MACOS.sh
./run_trainer.sh
```

## More Detail

- Installation details: `INSTALL.md`
- GitHub/fork publishing steps: `GITHUB_READY.md`
- Release checklist: `RELEASE.md`

The package keeps the Python package name `nam` for compatibility with existing NAM model and training imports. The distributable project name in `pyproject.toml` is `nam-trainer-reloaded`.
