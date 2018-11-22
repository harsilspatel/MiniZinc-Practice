include "globals.mzn";

int: n;
array[1..n] of var 1..n: order;
array[1..n-1] of var 1..n-1: diffs;
array[1..n] of var 1..n: posn;
array[1..n-1] of var 1..n-1: dposn;

constraint diffs = [abs(order[i]-order[i+1]) | i in 1..n-1];

constraint inverse(order, posn);
constraint inverse(diffs, dposn);

constraint abs(posn[1]-posn[n]) = 1;
constraint min(posn[1],posn[n]) = dposn[n-1];

solve satisfy;
