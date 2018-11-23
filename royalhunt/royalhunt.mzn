int: n; % number of court members
set of int: COURT = 1..n;
int: emperor = 1;
array[COURT] of int: rank;
array[COURT] of int: ability;

int: m; % number of horses
set of int: HORSE = 1..m;
array[HORSE] of int: beauty;
array[HORSE] of int: speed;


array[COURT,HORSE] of int: enjoy;


array[COURT] of var 0..m: horse;

% The emperor must enjoy the day more than anyone else.
constraint horse[emperor] = arg_max(enjoy[emperor,..]);

% All court members must ride unless there is no horse left available
include "globals.mzn";
constraint global_cardinality_low_up_closed(
  horse, 
  [0] ++ [i | i in 1..n],
  [0 | i in 1..n+1],
  [max(n-m, 0)] ++ [1 | i in 1..n]
);




var int: obj;
constraint obj = sum(c in horse where c != 0)(enjoy[c, horse[c]]);
solve maximize obj;

% output [
%   show(horse) ++ "\n",
%   show(arg_max(enjoy[emperor,..])) ++ "\n",
%   show([0 | i in 1..n+1]) ++ "\n",
%   show([max(n-m, 0)] ++ [1 | i in 1..n]) ++ "\n",
% ];