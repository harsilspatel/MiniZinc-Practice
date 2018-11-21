int: n;
array[1..n] of var 0..3: x;

constraint x[1] == 0;
constraint x[n] == 3;

constraint forall(i in 1..n) (
  (i mod 3) != 0 \/ x[i] >= 2
);

constraint forall(i in 1..n-1) (
  x[i] + x[i+1] <= 3
);

solve maximize sum(x);

output [show(x)];