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
    runargs=sys.argv[1]
    osarg=sys.argv[2]
    
    cmds={
      "wasmerslow": "wasmer run ",
      "wasmerllvm": "wasmer run --llvm ",
      "wasmtime": "wasmtime run ",
      "runall": "run-all"
    }
    cmd = cmds[runargs]
    passes = 0
    
    if cmd == "run-all":
      passes = int(input("How many passes? "))

    ostype={
        "osx": "m",
        "linux": "l",
    }

    ost = ostype[osarg]
    makeSubDirectories=False
        
    if not os.path.exists('./wasm-binaries') or not os.path.exists('./c-binaries'):
        subprocess.call("./compile-wasm.sh -" + ost, shell=True)

    if len(os.listdir('./wasm-binaries')) == 0 or len(os.listdir('./c-binaries')) == 0:
        rc = subprocess.call("./compile-wasm.sh -" + ost, shell=True)

    if len(os.listdir('./results')) == 1:
        subprocess.call("mkdir ./results/time && mkdir ./results/memory", shell=True)
        subprocess.call("mkdir ./results/time/c && mkdir ./results/memory/c",shell=True )
        subprocess.call("mkdir ./results/time/wasmerslow && mkdir ./results/memory/wasmerslow", shell=True)
        subprocess.call("mkdir ./results/time/wasmerllvm && mkdir ./results/memory/wasmerllvm", shell=True)
        subprocess.call("mkdir ./results/time/wasmtime && mkdir ./results/memory/wasmtime", shell=True)

    cntr = 0
    seperator="-"*30
    while cntr <= passes:
      cntr += 1
      if cmd == "run-all":
          for benchmark in os.listdir('./wasm-binaries'):
            print(seperator)
            filename=subprocess.check_output(f'basename {benchmark} .wasm', shell=True).decode('UTF-8').rstrip("\n")
            gtime="gtime -f '%M' -ao results/memory/"
            print(f'running benchmark for {filename}')
            
            #calltime = timeCall(f"{gtime}wasmerslow/{filename}.txt wasmer run ./wasm-binaries/{benchmark}")
            #writeTime("wasmerslow", filename, calltime)

            #calltime = timeCall(f"{gtime}wasmerllvm/{filename}.txt wasmer run --llvm ./wasm-binaries/{benchmark}")
            #writeTime("wasmerllvm", filename, calltime)

            #calltime = timeCall(f"{gtime}wasmtime/{filename}.txt wasmtime run ./wasm-binaries/{benchmark}")
            #writeTime("wasmtime", filename, calltime)

            calltime = timeCall(f"{gtime}c/{filename}.txt ./c-binaries/{filename}")
            writeTime("c", filename, calltime)
      else:
        pass
      print(seperator)
        
if __name__ == "__main__":
  main()