import datetime
import sys
import subprocess
import os
def timeCall(fcall):
  timerstart = datetime.datetime.now().timestamp() * 1000
  subprocess.call(fcall, shell=True)
  timerstop = datetime.datetime.now().timestamp() * 1000
  timerobj = timerstop - timerstart
  return timerobj

def writeTime(runtime, filename, timeObj):
  with open(f"./results/{runtime}/{filename}.txt","a+") as f:
    f.write(str(timeObj)+'\n')

def main():
    runargs=sys.argv[1]
    osarg=sys.argv[2]
    
    cmds={
      "wasmerslow": "wasmer run ",
      "wasmerllvm": "wasmer run --llvm ",
      "wasmtime": "wasmtime run ",
      "runall": "run-all"
    }
    cmd = cmds[runargs]
    passes = 1
    
    if cmd == "run-all":
      passes = int(input("How many passes? "))

    ostype={
        "osx": "m",
        "linux": "l",
    }

    ost = ostype[osarg]
        
    if not os.path.exists('./wasm-binaries') or not os.path.exists('./c-binaries'):
        subprocess.call("./compile-all.sh -" + ost, shell=True)

    if len(os.listdir('./wasm-binaries')) == 0 or len(os.listdir('./c-binaries')) == 0:
        rc = subprocess.call("./compile-all.sh -" + ost, shell=True)

    if len(os.listdir('./results')) < 2:
        subprocess.call("mkdir ./results/c",shell=True )
        subprocess.call("mkdir ./results/wasmerslow", shell=True)
        subprocess.call("mkdir ./results/wasmerllvm", shell=True)
        subprocess.call("mkdir ./results/wasmtime", shell=True)
        subprocess.call("mkdir ./results/docker ", shell=True)

    cntr = 1
    seperator="-"*30
    while cntr <= passes:
      cntr += 1
      if cmd == "run-all":
          for benchmark in os.listdir('./wasm-binaries'):
            print(seperator)
            filename=subprocess.check_output(f'basename {benchmark} .wasm', shell=True).decode('UTF-8').rstrip("\n")
            print(f'running benchmark for {filename}')
            
            calltime = timeCall(f"wasmer run ./wasm-binaries/{benchmark}")
            writeTime("wasmerslow", filename, calltime)

            calltime = timeCall(f"wasmer run --llvm ./wasm-binaries/{benchmark}")
            writeTime("wasmerllvm", filename, calltime)

            calltime = timeCall(f"wasmtime run ./wasm-binaries/{benchmark}")
            writeTime("wasmtime", filename, calltime)

            calltime = timeCall(f"./c-binaries/{filename}")
            writeTime("c", filename, calltime)

            calltime = timeCall(f"docker run --rm --name=benchmark alpine ping -c 1 8.8.8.8")
            writeTime("docker", filename, calltime)
      else:
        pass
      print(seperator)

if __name__ == "__main__":
  main()