@echo off

REM Проверка наличия winget
winget --version >nul 2>&1
if %errorlevel% equ 0 (
    echo "Winget уже установлен."
) else (
    echo "Устанавливаем winget..."
    REM Скачиваем только winget MSI через PowerShell
    powershell -Command "Invoke-WebRequest -Uri 'https://github.com/microsoft/winget-cli/releases/download/v1.9.25180/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' -OutFile '%TEMP%\AppInstaller.msixbundle'"
    msiexec /i "%TEMP%\AppInstaller.msixbundle" /quiet /norestart
)

REM Проверка, установился ли winget успешно
winget --version >nul 2>&1
if %errorlevel% neq 0 (
    echo "Не удалось установить winget."
    pause
    exit /b 1
)

REM Устанавливаем Python через winget
call winget install Python.Python.3 --silent

REM Проверка успешной установки Python
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo "Не удалось установить Python."
    pause
    exit /b 1
)

REM Создаем виртуальное окружение и устанавливаем зависимости
python -m venv venv
call .\venv\Scripts\activate.bat
pip install -r requirements.txt

pause
