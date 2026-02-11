@echo off
chcp 65001 >nul
setlocal enableextensions
cd /d "%~dp0"

openfiles >nul 2>&1
if %errorlevel% neq 0 (
    echo ---------- for
    echo ---------- manager ONLY
    pause
    exit /b
)

echo ---------- (1) %date% %time%
echo ---------- mkdir 00-wind
mkdir 00-wind
echo ---------- (2) %date% %time%
echo ---------- pscp.exe -r -P 22 pi@pi:archive/myusb/00-wind/* 00-wind/
pscp.exe -r -P 5822 proenpi@pi:archive/myusb/00-wind/* 00-wind/
echo ---------- (3) %date% %time%
echo ---------- (4-1) cd 00-wind/ttf-fonts-dir
cd 00-wind/ttf-fonts-dir
for %%f in (*.ttf *.otf) do (
    echo ---------- copy /y "%%f"
    copy /y "%%f" "%SystemRoot%\Fonts\" >nul
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /v "%%~nf (TrueType)" /t REG_SZ /d "%%f" /f >nul
)
echo ---------- (4-2) cd ..
cd ..

echo ----------
echo ---------- (5) %date% %time%
echo ---------- pscp.exe -P 5822 proenpi@pi:archive/keepass/keepassproen.kdbx .
pscp.exe -P 5822 proenpi@pi:archive/keepass/keepassproen.kdbx .

echo ----------
echo ---------- (6) %date% %time%
echo ---------- Git-2.52.0-64-bit.exe
Git-2.52.0-64-bit.exe
echo ---------- (7) %date% %time%
echo ---------- xcopy /e /s usr "c:\Program Files\Git\usr"
xcopy /e /s usr "c:\Program Files\Git\usr"

echo ----------
echo ---------- (8) %date% %time%
echo ---------- ChromeSetup.exe
echo ========== start "" "ChromeSetup.exe"
start "" "ChromeSetup.exe"
echo ---------- (9) %date% %time%
echo ---------- BraveBrowserSetup-BRV002.exe
echo ========== start "" "BraveBrowserSetup-BRV002.exe"
start "" "BraveBrowserSetup-BRV002.exe"

echo ----------
echo ---------- (10) %date% %time%
echo ---------- VC_redist.x64.exe
VC_redist.x64.exe
echo ---------- (11) %date% %time%
echo ========== start "" "KeePassXC-2.7.11-Win64\KeePassXC.exe"
start "" "KeePassXC-2.7.11-Win64\KeePassXC.exe""
echo ---------- (12) %date% %time%
echo ---------- putty-64bit-0.83-installer.msi
putty-64bit-0.83-installer.msi
echo ---------- (13) %date% %time%
echo ---------- regedit-HK_CU_USER-Soft-SimonTatham-PuTTY.reg
regedit-HK_CU_USER-Soft-SimonTatham-PuTTY.reg

echo ----------
echo ---------- (14) %date% %time%
echo ========== node-v24.12.0-x64.msi
node-v24.12.0-x64.msi
echo ---------- (15) %date% %time%
echo ========== python-3.14.2-amd64.exe
python-3.14.2-amd64.exe

echo ----------
echo ---------- (16) %date% %time%
echo ----------
echo cp 00-wind/DOTbashrc-4windows ~/.bashrc; source ~/.bashrc #-- for Git-Bash
echo ----------
echo //////////
