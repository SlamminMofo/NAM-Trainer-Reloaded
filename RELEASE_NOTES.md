# NAM Trainer Reloaded v1.0.0

![NAM Trainer Reloaded GUI](https://raw.githubusercontent.com/SlamminMofo/NAM-Trainer-Reloaded/main/docs/images/NAM_TRAINER_RELOADED_GUI.jpg)

NAM Trainer Reloaded is a compact desktop trainer package based on Neural Amp Modeler training code, with A2 architectures, paired-checkpoint resume support, additional WaveNet architectures, scheduler tools, and current TTS input-clip recognition updates.

## Highlights

- Local desktop GUI for NAM training.
- A2 architecture support, including current packed A2 variants.
- Resume-from-checkpoint support, including A2 checkpoint pairs.
- Custom architecture list including RevYLo, Nano variants, Double/xDouble/yDouble, and A2 hybrids.
- Windows local install/run scripts.
- macOS install/run shell scripts and `.command` launchers.

## Installation Summary

Windows:

1. Download and extract the release zip.
2. Run `INSTALL_WINDOWS.bat`.
3. Run `run_trainer.bat`.

Windows CPU-only:

```bat
INSTALL_WINDOWS.bat -CPU
```

macOS:

1. Download and extract the release zip.
2. Run `INSTALL_MACOS.command`.
3. Run `run_trainer.command`.

If macOS blocks the `.command` files after download, run:

```sh
chmod +x INSTALL_MACOS.command run_trainer.command INSTALL_MACOS.sh run_trainer.sh scripts/install_unix.sh
```

Then double-click the `.command` files again.

See `INSTALL.md` for full CPU/GPU dependency details.
