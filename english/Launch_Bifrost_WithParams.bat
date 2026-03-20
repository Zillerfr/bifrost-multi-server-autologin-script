@echo off
powershell.exe -ExecutionPolicy Bypass -File "%~dp0Choose_Bifrost_Server.ps1" -ConfigName "%~1"