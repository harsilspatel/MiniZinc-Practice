int: n;
array[1..n] of var 1..n: order;

include "alldifferent.mzn";
constraint alldifferent(order);
constraint alldifferent([abs(order[i]-order[i+1]) | i in 1..n-1]);

solve satisfy;