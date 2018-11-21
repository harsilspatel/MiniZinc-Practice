% workshop 2
% select a set of trade negotiation party
enum NEGOTIATOR;
NEGOTIATOR: dummy; 

int: l; % minimum party size
int: u; % maximum party size
int: m; % minimum joint ability

array[NEGOTIATOR] of int: honor;
array[NEGOTIATOR,NEGOTIATOR] of int: joint;

% array[NEGOTIATOR] of var bool: party;
% var int: total_strength = sum(i in NEGOTIATOR, j in NEGOTIATOR where i != j /\ party[i] /\ party[j])(joint[i,j]) div 2;

% var int: n = sum(party);

% % constraint total_strength >= m;
% constraint l < n /\ n < u;

% output [show(n), show(party)];

var set of NEGOTIATOR: party;
var int: total_strength = sum(i in party, j in party where i != j) (
  joint[i,j]
) div 2;

var int: n = card(party);
constraint total_strength >= m;
constraint l <= n /\ n <= u;

solve satisfy;
output [show(party) ++ " " ++ show(total_strength)];
