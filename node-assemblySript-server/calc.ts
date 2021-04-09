export function factorial(a: i32): i32 {
    if (a <= 1) return 1;
    else return a * factorial(a - 1)
}