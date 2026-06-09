param(
    [switch]$CPU,
    [switch]$SkipTorch,
    [string]$PythonVersion = "3.13",
    [string]$TorchIndexUrl = "https://download.pytorch.org/whl/cu130"
)

$ErrorActionPreference = "Stop"
$Root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$CondaEnv = Join-Path $Root ".conda-env"
$Venv = Join-Path $Root ".venv"
$Requirements = Join-Path $Root "requirements-windows.txt"

function Get-CondaExe {
    if ($env:CONDA_EXE -and (Test-Path -LiteralPath $env:CONDA_EXE)) {
        return $env:CONDA_EXE
    }
    $command = Get-Command conda -ErrorAction SilentlyContinue
    if ($command) {
        return $command.Source
    }
    return $null
}

function Invoke-Pip {
    param(
        [string]$Python,
        [string[]]$Arguments
    )
    & $Python -m pip @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "pip failed: $($Arguments -join ' ')"
    }
}

Write-Host "NAM Trainer Reloaded installer"
Write-Host "Root: $Root"

$Python = $null
$Conda = Get-CondaExe
if ($Conda) {
    if (-not (Test-Path -LiteralPath $CondaEnv)) {
        Write-Host "Creating local conda environment..."
        & $Conda create -y -p $CondaEnv "python=$PythonVersion" pip
        if ($LASTEXITCODE -ne 0) {
            throw "conda environment creation failed"
        }
    }
    $Python = Join-Path $CondaEnv "python.exe"
} else {
    if (-not (Test-Path -LiteralPath $Venv)) {
        Write-Host "Conda was not found; creating local venv..."
        $pyLauncher = Get-Command py -ErrorAction SilentlyContinue
        if ($pyLauncher) {
            & py "-$PythonVersion" -m venv $Venv
        } else {
            & python -m venv $Venv
        }
        if ($LASTEXITCODE -ne 0) {
            throw "venv creation failed. Install Miniconda or Python $PythonVersion, then rerun this installer."
        }
    }
    $Python = Join-Path $Venv "Scripts\python.exe"
}

if (-not (Test-Path -LiteralPath $Python)) {
    throw "Python executable was not created: $Python"
}

Write-Host "Using Python: $Python"
Invoke-Pip $Python @("install", "--upgrade", "pip", "setuptools", "wheel")

if (-not $SkipTorch) {
    if ($CPU) {
        Write-Host "Installing CPU PyTorch..."
        Invoke-Pip $Python @("install", "torch", "--index-url", "https://download.pytorch.org/whl/cpu")
    } else {
        Write-Host "Installing CUDA PyTorch from $TorchIndexUrl ..."
        try {
            Invoke-Pip $Python @("install", "torch", "--index-url", $TorchIndexUrl)
        } catch {
            Write-Warning "CUDA PyTorch install failed. Falling back to the default PyPI torch package."
            Invoke-Pip $Python @("install", "torch")
        }
    }
}

Invoke-Pip $Python @("install", "-r", $Requirements)
Invoke-Pip $Python @("install", "--no-deps", "-e", $Root)

& $Python -c "from nam.train.gui import run; print('NAM Trainer Reloaded import check passed')"
if ($LASTEXITCODE -ne 0) {
    throw "Import check failed"
}

Write-Host ""
Write-Host "Installation complete."
Write-Host "Start the trainer with: $Root\run_trainer.bat"
