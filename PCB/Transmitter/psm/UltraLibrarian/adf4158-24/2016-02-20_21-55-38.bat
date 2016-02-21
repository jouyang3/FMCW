allegro -s CustomShapes.scr
pad_designer -s 2016-02-20_21-55-38_pads.scr
CALL :checkfile "RX12Y32D0TSM2.pad"
CALL :checkfile "RX104Y104D0T.pad"
allegro -s 2016-02-20_21-55-38_brd.scr
CALL :checkfile "CP_24_7.psm"

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
