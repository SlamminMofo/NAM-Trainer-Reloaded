@echo off
setlocal
cd /d "%~dp0"

set KMP_DUPLICATE_LIB_OK=TRUE
set FOR_DISABLE_CONSOLE_CTRL_HANDLER=1
set NAM_TRAINER_DEVICE_STATS=

set "NAM_RELOADED_ROOT=%~dp0"
set "NAM_RELOADED_CONDA_PYTHON=%NAM_RELOADED_ROOT%.conda-env\python.exe"
set "NAM_RELOADED_VENV_PYTHON=%NAM_RELOADED_ROOT%.venv\Scripts\python.exe"

if defined PYTHONPATH (
    set "PYTHONPATH=%NAM_RELOADED_ROOT%;%PYTHONPATH%"
) else (
    set "PYTHONPATH=%NAM_RELOADED_ROOT%"
)

if exist "%NAM_RELOADED_CONDA_PYTHON%" (
    set "NAM_RELOADED_PYTHON=%NAM_RELOADED_CONDA_PYTHON%"
    goto :run
)

if exist "%NAM_RELOADED_VENV_PYTHON%" (
    set "NAM_RELOADED_PYTHON=%NAM_RELOADED_VENV_PYTHON%"
    goto :run
)

where python >nul 2>nul
if "%ERRORLEVEL%"=="0" (
    set "NAM_RELOADED_PYTHON=python"
    goto :run
)

echo Could not find a Python environment.
echo Run INSTALL_WINDOWS.bat first, then run this file again.
pause
exit /b 1

:run
echo Starting NAM Trainer Reloaded from:
echo   %NAM_RELOADED_ROOT%
echo Using Python:
echo   %NAM_RELOADED_PYTHON%
echo.
"%NAM_RELOADED_PYTHON%" -c "from nam.train.gui import run; run()"
set "EXIT_CODE=%ERRORLEVEL%"
if "%EXIT_CODE%"=="0" exit /b 0
echo.
echo NAM Trainer Reloaded exited with error code %EXIT_CODE%.
pause
exit /b %EXIT_CODE%
