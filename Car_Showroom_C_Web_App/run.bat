@echo off
if not exist showroom.exe (echo Run build.bat first.& pause & exit /b 1)
showroom.exe
pause
