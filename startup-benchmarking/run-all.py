import datetime
import sys
import subprocess
import os

# Calls fcall and times it in 8 significant digits
def timeCall(fcall):
  timerstart = datetime.datetime.now().timestamp() * 1000
  subprocess.call(fcall, shell=True)
  timerstop = datetime.datetime.now().timestamp() * 1000
  timerobj = timerstop - timerstart
  return timerobj

# Writes the time to filename
def writeTime(runtime, filename, timeObj):
  with open(f"./results/{runtime}/{filename}.txt","a+") as f:
    f.write(str(timeObj)+'\n')

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
      filename=subprocess.check_output(f'basename {benchmark} .wasm', shell=True).decode('UTF-8').rstrip("\n")
      if osarg == "l":
        gtime=f"/usr/bin/time -f '%M' -ao results/"
      elif osarg == "m":
        gtime=f"gtime -f '%M' -ao results/"

      print(seperator)
      print(f'running benchmark for {benchmark}')

      calltime = timeCall(f"{gtime}wasmerslow/memory.txt wasmer run ./wasm-binaries/{benchmark}")
      writeTime("wasmerslow", filename, calltime)

      calltime = timeCall(f"{gtime}wasmerllvm/memory.txt wasmer run --llvm ./wasm-binaries/{benchmark}")
      writeTime("wasmerllvm", filename, calltime)

      calltime = timeCall(f"{gtime}wasmtime/memory.txt wasmtime run ./wasm-binaries/{benchmark}")
      writeTime("wasmtime", filename, calltime)

      pwd = os.getcwd()
      copyFile = f"-v {pwd}/c-binaries/{filename}:/exec/{filename}"
      chmodAndRun = f"chmod +x /exec/{filename}; ./exec/{filename}"
      calltime = timeCall(f"{gtime}docker/{filename}.txt docker run --rm {copyFile} debian /bin/bash -c \"{chmodAndRun}\"")
      writeTime("docker", filename, calltime)

      calltime = timeCall(f"{gtime}docker/memory.txt docker run --rm --name=benchmark alpine ping -c 1 8.8.8.8")
      writeTime("docker", filename, calltime)
    print(seperator)

if __name__ == "__main__":
  main()