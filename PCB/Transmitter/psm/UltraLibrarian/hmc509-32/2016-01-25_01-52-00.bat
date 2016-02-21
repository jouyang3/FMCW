allegro -s CustomShapes.scr
pad_designer -s 2016-01-25_01-52-00_pads.scr
CALL :checkfile "RX11p81Y27p75D0T.pad"
CALL :checkfile "RX147p64Y147p64D0T.pad"
allegro -s 2016-01-25_01-52-00_brd.scr
CALL :checkfile "HCP_32_1.psm"

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
