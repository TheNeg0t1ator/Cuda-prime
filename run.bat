@echo off
REM Compile the CUDA program
nvcc prime.cu -o program

REM Run the compiled program
program.exe
