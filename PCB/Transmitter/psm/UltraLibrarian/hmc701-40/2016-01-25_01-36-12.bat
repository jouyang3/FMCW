allegro -s CustomShapes.scr
pad_designer -s 2016-01-25_01-36-12_pads.scr
CALL :checkfile "RX12Y23p81D0T.pad"
CALL :checkfile "RX185p04Y185p04D0T.pad"
allegro -s 2016-01-25_01-36-12_brd.scr
CALL :checkfile "HCP_40_1.psm"

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
