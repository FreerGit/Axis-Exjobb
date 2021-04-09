int add(int a, int b) {
  return a + b;
}

int mul(int a, int b) {
  return a * b;
}

int factorial(int a) {
    if (a <= 1) return 1;
    return a * factorial (a-1);
}
