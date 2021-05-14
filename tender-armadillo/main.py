import wasmtime.loader
from wasmer import engine, Store, Module, Instance
from wasmer_compiler_cranelift import Compiler
import slow_sieve
import sieve
from datetime import datetime

upto = 3000

timerstart = datetime.now()
print(f'{slow_sieve.sieve_through(upto)}')
timerstop = datetime.now()
timerobj = timerstop - timerstart
print(f'Python took {timerobj.total_seconds()*1000}ms to run')

timerstart = datetime.now()
print(f'{sieve.sieve_through(upto)}')
timerstop = datetime.now()
timerobj = timerstop - timerstart
print(f'WasmTime took {timerobj.total_seconds()*1000}ms to run')

store = Store(engine.JIT(Compiler))
module = Module(store, open('sieve.wasm', 'rb').read())
instance = Instance(module)
timerstart = datetime.now()
print(f'{instance.exports.sieve_through(upto)}')
timerstop = datetime.now()
timerobj = timerstop - timerstart
print(f'Wasmer took {timerobj.total_seconds()*1000}ms to run')
# sieve.sieve(15)