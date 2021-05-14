from math import sqrt

def sieve_through(lim: int) -> int:
  fools_gold: list[int] = []
  for nugg in range(2, lim+1):
    if nugg not in fools_gold:
      for gravel in range(nugg*nugg, lim+1, nugg):
        if gravel not in fools_gold:
          fools_gold.append(gravel)
  return 0
  # return sifted