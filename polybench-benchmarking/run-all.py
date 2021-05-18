import sys
import datetime
import subprocess
import os

def timeCall(fcall):
  timerstart = datetime.datetime.now()
  subprocess.call(fcall, shell=True)
  timerstop = datetime.datetime.now()
  timerobj = timerstop - timerstart
  return timerobj

def writeTime(runtime, filename, timeObj):
  
  with open(f"./results/time/{runtime}/{filename}.txt","a+") as f:
    f.write(str(timeObj.total_seconds())+'\n')

def main():
  # Check for correct numbers of args in argv
  if len(sys.argv) != 2:
    print(f"Wrong number of arguments provided, 1 needed, {len(sys.argv)} provided")
    exit();
  #  Either l for linux or m for macos, aarhc not needed for startup
  osarg=sys.argv[1]

  # Get number of passes to run in while-loop
  passes = int(input("How many passes? "))

  # If either binary-folder doesn't exist, create it and populate it
  if not os.path.exists('./wasm-binaries') or not os.path.exists('./c-binaries'):
    subprocess.call("./compile-all.sh -" + osarg, shell=True)

  # If either binary-folder is empty, populate it
  if len(os.listdir('./wasm-binaries')) == 0 or len(os.listdir('./c-binaries')) == 0:
    subprocess.call("./compile-all.sh -" + osarg, shell=True)

  # If the results folder doesn't have all folders, create them
  if len(os.listdir('./results')) < 2:
    subprocess.call("mkdir ./results/wasmerslow", shell=True)
    subprocess.call("mkdir ./results/wasmerfast", shell=True)
    subprocess.call("mkdir ./results/wasmtime", shell=True)
    subprocess.call("mkdir ./results/docker", shell=True)

  cntr = 1
  seperator="-"*30
  # Main game-loop
  while cntr <= passes:
    cntr += 1
    for benchmark in os.listdir('./wasm-binaries'):
      print(seperator)
      filename=subprocess.check_output(f'basename {benchmark} .wasm', shell=True).decode('UTF-8').rstrip("\n")
      if osarg == "l":
        gtime="/usr/bin/time -f '%M' -ao results/memory/"
      elif osarg == "m":
        gtime="gtime -f '%M' -ao results/memory/"

      print(f'running benchmark for {filename}')
      
      #wasmerslow
      calltime = timeCall(f"{gtime}wasmerslow/{filename}.txt wasmer run ./wasm-binaries/{benchmark}")
      writeTime("wasmerslow", filename, calltime)

      #wasmerllvm
      calltime = timeCall(f"{gtime}wasmerllvm/{filename}.txt wasmer run --llvm ./wasm-binaries/{benchmark}")
      writeTime("wasmerllvm", filename, calltime)

      #wasmtime
      calltime = timeCall(f"{gtime}wasmtime/{filename}.txt wasmtime run ./wasm-binaries/{benchmark}")
      writeTime("wasmtime", filename, calltime)

      #docker hot start
      pwd = os.getcwd()
      copyFile = f"-v {pwd}/c-binaries/{filename}:/exec/{filename}"
      chmodAndRun = f"chmod +x /exec/{filename}; ./exec/{filename}"
      calltime = timeCall(f"{gtime}c/{filename}.txt docker run --rm {copyFile} debian /bin/bash -c \"{chmodAndRun}\"")
      writeTime("c", filename, calltime)
    print(seperator)
        
if __name__ == "__main__":
  main()