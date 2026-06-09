@echo off
setlocal
cd /d "%~dp0"

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\install_windows.ps1" %*
set "EXIT_CODE=%ERRORLEVEL%"
if "%EXIT_CODE%"=="0" (
    echo.
    echo Installation completed. Run run_trainer.bat to start NAM Trainer Reloaded.
    pause
    exit /b 0
)

echo.
echo Installation failed with error code %EXIT_CODE%.
pause
exit /b %EXIT_CODE%
