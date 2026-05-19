@echo off
setlocal EnableDelayedExpansion

echo ================================================
echo    oh-pi-superpowers - Installer
echo ================================================
echo.

set "GREEN=[92m"
set "YELLOW=[93m"
set "RED=[91m"
set "RESET=[0m"

set "INSTALL_DIR=%USERPROFILE%\.pi"
set "SKILLS_DIR=%INSTALL_DIR%\agent\skills"
set "EXTENSIONS_DIR=%INSTALL_DIR%\agent\extensions"
set "SETTINGS_FILE=%INSTALL_DIR%\settings.json"

set "SCRIPT_DIR=%~dp0"
set "SOURCE_SKILLS=%SCRIPT_DIR%skills"
set "SOURCE_EXTENSIONS=%SCRIPT_DIR%.pi\extensions"
set "SOURCE_SETTINGS=%SCRIPT_DIR%.pi\settings.json"

echo Installing Superpowers to %INSTALL_DIR%
echo.

echo Creating directories...
if not exist "%SKILLS_DIR%" mkdir "%SKILLS_DIR%"
if not exist "%EXTENSIONS_DIR%" mkdir "%EXTENSIONS_DIR%"
echo.

echo Copying skills...
xcopy /E /I /Y "%SOURCE_SKILLS%" "%SKILLS_DIR%\superpowers\" >nul 2>&1
if errorlevel 1 (
    echo [%RED%ERROR%RESET%] Failed to copy skills
    exit /b 1
)
echo   - Skills copied to %SKILLS_DIR%\superpowers\
echo.

echo Copying extension...
xcopy /E /I /Y "%SOURCE_EXTENSIONS%" "%EXTENSIONS_DIR%\" >nul 2>&1
echo   - Extension copied to %EXTENSIONS_DIR%\
echo.

echo Updating settings.json...
if exist "%SETTINGS_FILE%" (
    findstr /C:"superpowers" "%SETTINGS_FILE%" >nul 2>&1
    if !errorlevel! equ 0 (
        echo   - Superpowers already configured in settings.json
    ) else (
        copy "%SETTINGS_FILE%" "%SETTINGS_FILE%.backup" >nul 2>&1
        echo   - Backed up existing settings
        powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_DIR%update-settings.ps1" "%SETTINGS_FILE%" "%SKILLS_DIR%\superpowers"
        echo   - Updated existing settings.json
    )
) else (
    copy "%SOURCE_SETTINGS%" "%SETTINGS_FILE%" >nul 2>&1
    echo   - Created new settings.json
)
echo.

echo ================================================
echo [%GREEN%SUCCESS%RESET%] Superpowers installed!
echo ================================================
echo.
echo Restart pi to load Superpowers skills
echo.

pause