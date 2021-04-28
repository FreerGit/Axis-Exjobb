// The entry file of your WebAssembly module.

export function gcd(a: i32, b: i32): i32 {
  if (b == 0) {
    return a;
  } else {
    return gcd(b, a % b);
  }
}
