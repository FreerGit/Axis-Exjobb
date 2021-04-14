// The entry file of your WebAssembly module.

export function add(a: i32, b: i32): i32 {
	return a + b;
}

export function concatString(x: string, y: string): string {
	return x + y;
}