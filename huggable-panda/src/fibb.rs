fn fibb(n: usize) -> usize {
  fn fib_memo(n: usize, memo: &mut [usize; 2]) -> usize{
    let [a, b] = *memo;
    let c = a + b;
    if n == 0 {
      c
    } else {
      *memo = [b, c];
      fib_memo(n-1, memo)
    }
  }

  if n < 2 {
    1
  } else {
    fib_memo(n-2, &mut[1, 1])
  }
}

fn main() {
  println!("{}", fibb(46));
}