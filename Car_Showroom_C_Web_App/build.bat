@echo off
gcc server.c -o showroom.exe -lws2_32 -std=c11
if errorlevel 1 pause
