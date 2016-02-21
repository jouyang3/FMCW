allegro -s CustomShapes.scr
pad_designer -s 2016-01-25_01-56-38_pads.scr
CALL :checkfile "RX11p81Y31p69D0T.pad"
CALL :checkfile "RX110p24Y110p24D0T.pad"
allegro -s 2016-01-25_01-56-38_brd.scr
CALL :checkfile "HCP_24_3.psm"

exit

:checkfile
@echo off
dir %1 1>nul 2>nul
if errorlevel 1 goto checkfile_err
goto end
:checkfile_err
echo Expected file %1 not found
pause > nul
exit
:end
@echo on
