@echo off
setlocal EnableDelayedExpansion

echo ================================================
echo    oh-pi-superpowers - Installer
echo ================================================
echo.

:: 색상 코드 (Windows 10+)
set "GREEN=[92m"
set "YELLOW=[93m"
set "RED=[91m"
set "RESET=[0m"

:: 설치 디렉토리 설정
set "INSTALL_DIR=%USERPROFILE%\.pi"
set "SKILLS_DIR=%INSTALL_DIR%\agent\skills"
set "EXTENSIONS_DIR=%INSTALL_DIR%\agent\extensions"
set "SETTINGS_FILE=%INSTALL_DIR%\settings.json"

:: pi-superpowers 경로 (이 스크립트의 위치)
set "SCRIPT_DIR=%~dp0"
set "SOURCE_SKILLS=%SCRIPT_DIR%skills"
set "SOURCE_EXTENSIONS=%SCRIPT_DIR%.pi\extensions"
set "SOURCE_SETTINGS=%SCRIPT_DIR%.pi\settings.json"

echo Installing Superpowers to %INSTALL_DIR%
echo.

:: 설치 디렉토리 생성
echo Creating directories...
if not exist "%SKILLS_DIR%" mkdir "%SKILLS_DIR%"
if not exist "%EXTENSIONS_DIR%" mkdir "%EXTENSIONS_DIR%"
echo.

:: Skills 복사
echo Copying skills...
xcopy /E /I /Y "%SOURCE_SKILLS%" "%SKILLS_DIR%\superpowers\" >nul 2>&1
if errorlevel 1 (
    echo [%RED%ERROR%RESET%] Failed to copy skills
    exit /b 1
)
echo   - Skills copied to %SKILLS_DIR%\superpowers\
echo.

:: Extensions 복사
echo Copying extension...
xcopy /E /I /Y "%SOURCE_EXTENSIONS%" "%EXTENSIONS_DIR%\" >nul 2>&1
echo   - Extension copied to %EXTENSIONS_DIR%\
echo.

:: settings.json 업데이트
echo Updating settings.json...
if exist "%SETTINGS_FILE%" (
    :: 기존 settings.json 백업
    copy "%SETTINGS_FILE%" "%SETTINGS_FILE%.backup" >nul 2>&1
    echo   - Backed up existing settings to settings.json.backup
    
    :: PowerShell로 settings.json 병합 (간단한 구현)
    powershell -Command "
        $settings = Get-Content '%SETTINGS_FILE%' -Raw | ConvertFrom-Json
        if (-not $settings.skills) { $settings | Add-Member -NotePropertyName 'skills' -NotePropertyValue @() }
        $settings.skills += @(
            '%SKILLS_DIR%\superpowers'
        )
        $settings | ConvertTo-Json -Depth 10 | Set-Content '%SETTINGS_FILE%'
    "
    echo   - Updated existing settings.json
) else (
    copy "%SOURCE_SETTINGS%" "%SETTINGS_FILE%" >nul 2>&1
    echo   - Created new settings.json
)
echo.

echo ================================================
echo [%GREEN%SUCCESS%RESET%] Superpowers installed!
echo ================================================
echo.
echo Usage:
echo   Restart pi and it will load Superpowers skills
echo   Use /skill:brainstorming to start a design session
echo.
echo Installed skills:
dir /B "%SKILLS_DIR%\superpowers\skills" 2>nul | findstr /V /R "^$"
echo.

pause