enum Color = {a, b, c, d};

var Color: Liang;
var Color: You;
var Color: Bing;
var Color: Ji;
var Color: Qing;
var Color: Yong;
var Color: Si;
var Color: Yan;
var Color: Yu;
var Color: Xu;
var Color: Yi;
var Color: Jing;
var Color: Yang;
var Color: Jiao;

constraint Liang != Yong;
constraint You != Bing;
constraint You != Ji;
constraint Ji != Bing;
constraint Bing != Si;
constraint Ji != Yan;
constraint Ji != Qing;
constraint Si != Yong;
constraint Si != Jing;
constraint Si != Yu;
constraint Yan != Qing;
constraint Yan != Xu;
constraint Yong != Yi;
constraint Yong != Jing;
constraint Jing != Yang;
constraint Yi != Jiao;
constraint Jiao != Jing;
constraint Jiao != Yang;

solve satisfy;