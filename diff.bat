@echo off
fc /b %1 %2 > nul
if errorlevel 1 (
	REM Files are different.
    echo |set /p=%1
) else (
	echo |set /p=same
)