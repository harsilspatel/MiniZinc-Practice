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

%
array[COURT] of var 0..m: court2horse;
array[HORSE] of var 0..n: horse2court;

% The emperor must enjoy the day more than anyone else.
constraint court2horse[emperor] = arg_max(enjoy[emperor,..]);

% All court members must ride unless there is no horse left available
include "globals.mzn";

% constraint forall(c in COURT where court2horse[c] != 0)(
%   horse2court[court2horse[c]] = c
% );

% constraint forall(h in HORSE where horse2court[h] != 0) (
%   court2horse[horse2court[h]] = h
% );

constraint forall(c in COURT, h in HORSE)(
  court2horse[c] = h <-> horse2court[h] = c
);

% constraint global_cardinality_low_up_closed(
%   court2horse, 
%   [0] ++ [i | i in 1..n],
%   [0 | i in 1..n+1],
%   [min(n-m, 0)] ++ [1 | i in 1..n]
% );

constraint sum(c in COURT)(court2horse[c] > 0) = min(m,n);

constraint forall(i, j in 1..n where ((i < j) /\ (court2horse[i] != 0) /\ court2horse[j] != 0)) (
  court2horse[i] != court2horse[j]
);

% If a court member holds a higher rank than another, then either (a) the beauty of their horse can be no less than that assigned to the other, (b) the lower rank member does not ride, or (c) both court members do not ride.
var 0..n: penalties;
constraint penalties = sum(i,j in COURT where rank[i] > rank[j]) (
  not (
    (beauty[court2horse[i]] >= beauty[court2horse[j]])
    \/ (court2horse[j] = 0)
    \/ (court2horse[i] = 0 /\ court2horse[j] = 0)
  )
);

% constraint forall(i,j in COURT where rank[i] > rank[j]) (
%   (beauty[court2horse[i]] >= beauty[court2horse[j]])
%   \/ (court2horse[j] = 0)
%   \/ (court2horse[i] = 0 /\ court2horse[j] = 0)
% );

% If a horse is faster than another then either (a) the rider of the faster horse has no less riding ability than that of the slower horse, (b) the faster horse has no rider, or (c) both horses have no rider.
constraint forall(i,j in HORSE where speed[i] > speed[j]) (
  (ability[horse2court[i]] >= ability[horse2court[j]])
  \/ (horse2court[i] = 0)
  \/ ((horse2court[i] = 0) /\ (horse2court[j] = 0))
);

% constraint global_cardinality_low_up(
%   court2horse,
%   [0],
%   [0],
%   [max(n-m, 0)]
% );

var int: obj;
constraint obj = sum(c in COURT where court2horse[c] != 0)(enjoy[c, court2horse[c]]) - (100*penalties);
solve maximize obj;

output [
  "horse = \(court2horse);\nobj = \(obj);",
];