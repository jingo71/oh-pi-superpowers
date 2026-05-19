@echo off
setlocal EnableDelayedExpansion

echo ================================================
echo    oh-pi-superpowers - Updater
echo ================================================
echo.

set "GREEN=[92m"
set "YELLOW=[93m"
set "RED=[91m"
set "RESET=[0m"

set "INSTALL_DIR=%USERPROFILE%\.pi"
set "SKILLS_DIR=%INSTALL_DIR%\agent\skills"
set "EXTENSIONS_DIR=%INSTALL_DIR%\agent\extensions"

:: 이 스크립트의 위치
set "SCRIPT_DIR=%~dp0"
set "SOURCE_SKILLS=%SCRIPT_DIR%skills"
set "SOURCE_EXTENSIONS=%SCRIPT_DIR%.pi\extensions"

echo Fetching latest from GitHub...
echo.

:: GitHub에서 최신 버전 가져오기
cd /d "%SCRIPT_DIR%"
git pull origin main 2>nul
if errorlevel 1 (
    echo [%YELLOW%WARNING%RESET%] Not a git repo or fetch failed
    echo   Run setup.bat to reinstall
)

echo.
echo Updating skills...
if exist "%SKILLS_DIR%\superpowers" rmdir /S /Q "%SKILLS_DIR%\superpowers"
xcopy /E /I /Y "%SOURCE_SKILLS%" "%SKILLS_DIR%\superpowers\" >nul 2>&1
echo   - Skills updated

echo.
echo Updating extension...
if exist "%EXTENSIONS_DIR%\superpowers-intro.ts" del /Q "%EXTENSIONS_DIR%\superpowers-intro.ts"
xcopy /E /I /Y "%SOURCE_EXTENSIONS%" "%EXTENSIONS_DIR%\" >nul 2>&1
echo   - Extension updated

echo.
echo ================================================
echo [%GREEN%SUCCESS%RESET%] oh-pi-superpowers updated!
echo ================================================
echo.
echo Restart pi to use the latest version

pause