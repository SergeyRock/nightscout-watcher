echo off
set TARGET_DIR=r:\Дом\Здоровье\NightscoutWatcher\
echo on
copy /Y .\lib\x86_64-win64\NightscoutWatcher.exe %TARGET_DIR%
rem copy /Y .\lib\x86_64-win64\Options.ini %TARGET_DIR%

pause