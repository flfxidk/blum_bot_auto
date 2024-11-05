call winget install Python.Python.3

REM Проверка успешной установки Python
python --version || (
    echo "Python installation failed."
    pause
    exit /b 1
)

python -m venv venv

call .\\venv\Scripts\activate.bat

pip install -r requirements.txt

pause
