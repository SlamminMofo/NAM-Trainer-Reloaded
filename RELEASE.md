# Release Checklist

Use this checklist before publishing NAM Trainer Reloaded.

## Verify The Package

Windows:

```bat
INSTALL_WINDOWS.bat
run_trainer.bat
```

macOS:

```sh
sh INSTALL_MACOS.sh
sh run_trainer.sh
```

## Confirm Exclusions

Before committing, confirm the repository does not contain:

- `settings.json`
- saved advanced-option preset data
- `.ckpt` files
- `.nam` files
- output WAV clips
- input WAV clips, except the required internal `nam/models/_resources/loudness_input.wav`
- `lightning_logs`
- `__pycache__`
- `.conda-env` or `.venv`

## Suggested Release Notes

NAM Trainer Reloaded v1.0.0

![NAM Trainer Reloaded GUI](docs/images/NAM_TRAINER_RELOADED_GUI.jpg)

Highlights:

- Local desktop trainer based on Neural Amp Modeler training code.
- A2 architecture support, including current packed A2 variants.
- Resume-from-checkpoint support, including A2 checkpoint pairs.
- Analyze Lightning folders for reviewing previous training runs and saved metrics.
- Core and refinement dual-stage training with separate training controls for each stage.
- Current custom architecture list.
- TTS input v11 short registered as a known v3-compatible input clip.
- Windows local install/run scripts.
- macOS install/run shell scripts and `.command` launchers.

Installation:

- Windows: run `INSTALL_WINDOWS.bat`, then `run_trainer.bat`.
- Windows CPU only: run `INSTALL_WINDOWS.bat -CPU`.
- macOS: run or double-click `INSTALL_MACOS.command`, then `run_trainer.command`.

See `INSTALL.md` for detailed CPU/GPU dependency notes.
