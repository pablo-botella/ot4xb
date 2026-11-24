@echo off
rem Rebuild the documentation database of ot4xb from its sources.
rem The .doc-tool says what to collect and how the documentation is organized;
rem the .doc-tool.user, personal and never tracked, says where the database
rem lands - today the ot4xb-site repository.
rem compile stores books, index and kinds inside the database, so the site
rem generates from the .db alone: gen-html.bat needs no .doc-tool.

cd /d "%~dp0"
set TOOL=C:\HD\F\__pbnprj\xbwin\ot4xb-tool\ot4xb-tool.exe
set DOCTOOL=%~dp0ot4xb.doc-tool

if not exist "%TOOL%" goto :notool

echo === compile ===
"%TOOL%" doc compile -doctool "%DOCTOOL%"
if errorlevel 1 goto :failed

echo === resolve ===
"%TOOL%" doc resolve -doctool "%DOCTOOL%"
if errorlevel 1 goto :failed

echo.
echo Database rebuilt. Run gen-html.bat in the site repository.
pause
exit /b 0

:notool
echo ERROR: %TOOL% not found - build it with "go build ." in the ot4xb-tool repository.
pause
exit /b 1

:failed
echo.
echo FAILED - the database was not rebuilt.
pause
exit /b 1
