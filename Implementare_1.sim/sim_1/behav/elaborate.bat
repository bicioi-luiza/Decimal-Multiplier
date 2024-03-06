@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xelab  -wto 32f33a6734414476b775f222d8129a54 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot Metoda2_TB_behav xil_defaultlib.Metoda2_TB -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
