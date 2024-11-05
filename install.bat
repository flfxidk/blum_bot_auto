@echo off

REM Проверка наличия winget
winget --version >nul 2>&1
if %errorlevel% equ 0 (
    echo "Winget уже установлен."
) else (
    echo "Устанавливаем winget..."
    REM Скачиваем и устанавливаем winget через PowerShell
    powershell -Command "Invoke-WebRequest -Uri 'https://aka.ms/getwinget' -OutFile '%TEMP%\AppInstaller.msi'"
    msiexec /i "%TEMP%\AppInstaller.msi" /quiet /norestart
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
