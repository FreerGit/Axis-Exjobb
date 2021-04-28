// The entry file of your WebAssembly module.

export function add(a: i32, b: i32): i32 {
  return a + b;
}

export function fib(n: u64, cache: Map<u64, u64> = new Map<u64, u64>()): u64 {
	if (n < 3) {
		cache.set(n, 1)
		return cache.get(n);
	}
	else if (cache.has(n)) {
		return cache.get(n);
	}
	cache.set(n, (fib(n - 1, cache) + fib(n - 2, cache)));
	return cache.get(n);
}