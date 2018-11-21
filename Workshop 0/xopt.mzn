var 1..10: x;
var 1..10: i;
constraint x = i*4;
% constraint x mod 4 == 0;
solve minimize pow((x-7),2);

output [show(x)]