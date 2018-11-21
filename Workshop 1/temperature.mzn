array[int] of int: readings;
int: start;
int: n = length(readings);
set of int: HOUR = 1..n;
set of int: HOUR0 = 0..n;

array[HOUR0] of var int: temp;

constraint temp[0] = start;

constraint forall(h in HOUR)
                 (temp[h] = (temp[h-1] + readings[h]) div 2);

enum CHOICE = {heat, strongly_heat, cool, strongly_cool, do_nothing};

array[CHOICE] of int: costs = [1,5,3,9,0];
array[CHOICE] of int: result = [1,4,-2,-5,0];

array[0..n] of var CHOICE: choice;

constraint forall(i in 0..n) (
  25 <= (result[choice[i]] + temp[i]) /\ (result[choice[i]] + temp[i]) <= 30
);

var int: cost = sum(i in choice)(costs[i]);

solve minimize cost;
output ["temp = \(temp);\nchoice = \(choice)\ncost = \(cost)"];

                 

