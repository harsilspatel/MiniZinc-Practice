var 0..496: i; % 496 from previous solution
constraint i mod 5 == 2;
constraint i mod 7 == 2;
constraint i mod 12 == 1;

solve satisfy;