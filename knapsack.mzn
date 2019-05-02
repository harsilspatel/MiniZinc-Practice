int: budget = 10000;
var 0..1000: bowAndArrow;
var 0..400: sword;
var 0..150: canon;

% constraint bowAndArrow mod 10 == 0;
constraint 13*bowAndArrow + 21*sword + 100*canon <= budget;

var int: strength;
constraint strength = 6*bowAndArrow + 10*sword + 40*canon; 
solve maximize strength;

% output [show(bowAndArrow+sword+canon)]