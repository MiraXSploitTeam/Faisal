@echo off
echo Installing WebView2 Runtime...
set WEBVIEW2_INSTALLER="https://aka.ms/webview2installer"
set WEBVIEW2_INSTALLER_PATH="%TEMP%\WebView2Installer.exe"
powershell -Command "Invoke-WebRequest -Uri %WEBVIEW2_INSTALLER% -OutFile %WEBVIEW2_INSTALLER_PATH%"
start /wait %WEBVIEW2_INSTALLER_PATH% /silent /install
del %WEBVIEW2_INSTALLER_PATH%

echo WebView2 Runtime installed.

echo Checking for .NET Framework 4.8...
reg query "HKLM\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" /v Version
if %errorlevel% neq 0 (
    echo .NET Framework 4.8 not found. Installing .NET Framework 4.8...
    set DOTNET_INSTALLER="https://aka.ms/vs/16/release/dotnetfx48.exe"
    set DOTNET_INSTALLER_PATH="%TEMP%\dotnetfx48.exe"
    powershell -Command "Invoke-WebRequest -Uri %DOTNET_INSTALLER% -OutFile %DOTNET_INSTALLER_PATH%"
    start /wait %DOTNET_INSTALLER_PATH% /q /norestart
    del %DOTNET_INSTALLER_PATH%
    echo .NET Framework 4.8 installed.
) else (
    echo .NET Framework 4.8 is already installed.
)

echo Installing Visual C++ Redistributable...
set VCRUNTIME_INSTALLER="https://aka.ms/vs/16/release/vc_redist.x64.exe"
set VCRUNTIME_INSTALLER_PATH="%TEMP%\vc_redist.x64.exe"
powershell -Command "Invoke-WebRequest -Uri %VCRUNTIME_INSTALLER% -OutFile %VCRUNTIME_INSTALLER_PATH%"
start /wait %VCRUNTIME_INSTALLER_PATH% /quiet /norestart
del %VCRUNTIME_INSTALLER_PATH%

echo Visual C++ Redistributable installed.

echo All dependencies installed successfully
pause