% Beauty Trap
% Perform the most seductive dance
include "globals.mzn";

enum LEGS = {spin, leap, waltz, curtsey, prep, stand};
enum ARMS = {beckon, out, up, wrapped, neutral};
enum FACE = {smile, wink, batt, think, glow, blank};

int: maxlen;
set of int: STEP = 1..maxlen;
array[LEGS] of int: maxlegs;
array[ARMS] of int: maxarms;
array[FACE] of int: maxface;
constraint assert(maxlegs[stand] >= maxlen, "maxlegs[stand] smaller than maxlen");
constraint assert(maxarms[neutral] >= maxlen, "maxarms[neutral] smaller than maxlen");
constraint assert(maxface[blank] >= maxlen, "maxface[blank] smaller than maxlen");
array[LEGS,ARMS] of int: dance_value;
array[ARMS,FACE] of int: entice_value;
constraint assert(dance_value[stand,neutral] = 0, "incorrect dance_value array");
constraint assert(entice_value[neutral,blank] = 0, "incorrect entice_value array");
int: boredom; % how bored each step make the viewer

var STEP: len;
array[STEP] of var LEGS: legs;
array[STEP] of var ARMS: arms;
array[STEP] of var FACE: face;

constraint global_cardinality_low_up_closed(
  legs,
  [i | i in LEGS],
  [0 | i in LEGS],
  [m | m in maxlegs]
);

constraint global_cardinality_low_up_closed(
  arms,
  [i | i in ARMS],
  [0 | i in ARMS],
  [m | m in maxarms]
);

constraint global_cardinality_low_up_closed(
  face,
  [i | i in FACE],
  [0 | i in FACE],
  [m | m in maxface]
);

% legs
constraint regular(legs, card(LEGS)+1, card(LEGS), dLegs, 1, {7});
array[1..7, LEGS] of 0..7: dLegs = 
     [| 2,0,4,5,6,7      % start
      | 0,0,0,5,6,7      % spin
      | 2,0,4,0,0,7      % leap
      | 2,0,4,0,6,7      % waltz
      | 2,0,4,5,0,7      % curtsey
      | 2,3,4,5,6,7      % prep
      | 2,0,4,5,6,7 |];  % stand

% constraint forall(i in 1..len-2) (
%   ((legs[i] = waltz) /\ (legs[i+2] = curtsey)) -> (legs[i+1] = stand)
% );

constraint forall(c in 1..len-1) (
  legs[c] = waltz -> 
    forall(c1 in c+1..len) (
      legs[c1] = curtsey -> 
        exists(c2 in c+1..c1-1)(legs[c2] = stand)
    )
);

constraint forall(i in 1..len-3) (
  ((legs[i] = waltz) /\ (legs[i+1] = waltz) /\ (legs[i+2] = waltz)) -> (not (legs[i+3] = waltz))
);

% arms
constraint regular(arms, card(ARMS)+1, card(ARMS), dArms, 1, {6});
array[1..6, ARMS] of 0..6: dArms = 
     [| 0,3,4,5,6      % start
      | 0,3,4,5,6      % backon
      | 2,0,4,0,6      % out
      | 2,3,0,0,6      % up
      | 0,3,4,0,6      % wrapped
      | 0,3,4,5,6 |];  % neutral

% face
constraint regular(face, card(FACE)+1, card(FACE), dFace, 1, {7});
array[1..7, FACE] of 0..7: dFace = 
     [| 2,3,4,5,6,7      % start
      | 0,3,4,0,6,7      % smile
      | 2,0,4,5,6,7      % wink
      | 2,3,0,0,6,7      % batt
      | 2,3,4,0,6,7      % think
      | 2,3,4,5,0,7      % glow
      | 2,3,4,5,6,7 |];  % blank

var int: obj;
constraint forall(i in 1..len) (
  (dance_value[legs[i], arms[i]] >= 0) /\
  (entice_value[arms[i], face[i]] >= 0)
);

constraint obj = (- boredom*len) + sum(i in 1..len)(
  dance_value[legs[i], arms[i]] + entice_value[arms[i], face[i]]
);

constraint forall (i in len+1..maxlen) (
  face[i] = blank /\
  arms[i] = neutral /\
  legs[i] = stand
);

solve maximize obj;
