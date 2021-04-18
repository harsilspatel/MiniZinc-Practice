int: budget = 10000;
var 0..1000: feng;
var 0..400: liu;
var 0..500: zhao;
var 0..150: jian;

constraint 13*feng + 21*liu + 17*zhao + 100*jian <= budget;

var int: strength;
constraint strength = 6*feng + 10*liu + 8*zhao + 40*jian; 
solve maximize strength;

% output [show(feng+liu+zhao+jian)]