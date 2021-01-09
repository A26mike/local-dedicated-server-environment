@echo off
:: start up perams only change the port  
SET PORT=2302
SET TIME_OUT=2

:: Do Not change unless you know what you are doing 
SET START_NAME=arma3_dedicated
SET ARMA_EXE=arma3server_x64.exe
SET FPS=1000
SET SERVER_CFG=server.cfg
SET BASIC_CFG=basic.cfg
SET PROFILE=profiles
SET BANDWIDTH=2
SET TOKENS= "Tokens=* Delims="
SET BEPATH = C:\A3\%PORT%\battleye
:: use for battle eye    -bepath=%BEPATH%

::######### Title #######################
Title %PORT% 
color 1f 

::#############################

:: delete mod lists because how  for loop works 
echo Deleting Mod lists
del /s Mods_required.txt
del /s server_Mod.txt
timeout %TIME_OUT% /nobreak

::Make both mod lists 
echo Creating required mods mod list
for /d %%M in (Mods_required\*@*) do (echo %%M>> Mods_required.txt)
echo Required mods mod list Complete


echo Creating server only mods list 
for /d %%S in (Mods_server\*@*) do (echo %%S>> Mods_server.txt)
echo server only  mod list complete
timeout %TIME_OUT% /nobreak


SETLOCAL EnableDelayedExpansion
echo Starting %PORT%
for /f %TOKENS% %%M in (Mods_required.txt) do set Mod=!Mod!%%M;
for /f %TOKENS% %%S in (Mods_server.txt) do set Smod=!Smod!%%S;

start "%START_NAME%+%PORT%" /HIGH %ARMA_EXE% -port=%PORT% -bandwidthAlg=%BANDWIDTH% -limitFPS=%FPS% -config=%SERVER_CFG% -cfg=%BASIC_CFG% -profiles=%PROFILE% -filePatching "-servermod=%Smod%" "-mod=%Mod%" 
timeout %TIME_OUT% /nobreak