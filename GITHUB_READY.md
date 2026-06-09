# GitHub Readiness

This repository is prepared as a clean source release named **NAM Trainer Reloaded**.

The intended GitHub repository slug is:

```text
NAM-Trainer-Reloaded
```

The upstream project is:

```text
https://github.com/sdatkinson/neural-amp-modeler
```

## Clean Release Contents

Included:

- Python source needed by the trainer.
- Required model/resource JSON files.
- Required internal loudness calibration WAV.
- Windows and macOS install/run scripts.
- macOS `.command` launchers for double-click use.
- Dependency files and packaging metadata.
- GUI screenshot in `docs/images/NAM_TRAINER_RELOADED_GUI.jpg`.

Excluded:

- Saved GUI state.
- Saved advanced-option presets.
- User paths.
- Input clips.
- Output clips.
- Checkpoints.
- NAM exports.
- Lightning logs.
- Python caches.
- Test data and large documentation assets.

## Suggested First Commit

```bat
git init
git add .
git update-index --chmod=+x INSTALL_MACOS.sh run_trainer.sh INSTALL_MACOS.command run_trainer.command scripts/install_unix.sh
git commit -m "Initial NAM Trainer Reloaded release"
```

## Publishing To The Fork

Create or use a fork of `sdatkinson/neural-amp-modeler` named `NAM-Trainer-Reloaded`, then push this repository content to it:

```bat
git remote add origin https://github.com/SlamminMofo/NAM-Trainer-Reloaded.git
git branch -M main
git push -u origin main
```

## Suggested Release Tag

```bat
git tag v1.0.0
git push origin v1.0.0
```

## Authentication

Do not share your GitHub password. Use GitHub CLI, GitHub Desktop, or Git Credential Manager. For GitHub CLI:

```bat
gh auth login
gh auth status
```
