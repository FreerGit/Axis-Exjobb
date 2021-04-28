// The entry file of your WebAssembly module.
import 'wasi';
import { Console } from 'as-wasi';

export function gcd(a: i32, b: i32): i32 {
  if (b == 0) {
    return a;
  } else {
    return gcd(b, a % b);
  }
}

Console.log('gcd(48, 18) = ' + gcd(48, 18).toString());