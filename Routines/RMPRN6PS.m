RMPRN6PS ;Hines OIFO/HNC - POST INIT ;9/16/02  10:29
 ;;3.0;PROSTHETICS;**70**;Feb 09, 1996
 Q
 ;
EN ;main entry point
 ;rmpry is ien to 661.1 from list
 ;line is NPPD New Line
 ;
 S ERR=""
 S RMPRX=""
 F RMPRX=1:1:211 S RMPRY=$P($T(LST+RMPRX),";",3) Q:ERR=1  D
 .S LINE=$P($T(LST+RMPRX),";",4)
 .S DIE="^RMPR(661.1,",DA=RMPRY,DR="6///^S X=LINE"
 .L +^RMPR(661.1,RMPRY):1 I '$T W !,"ERROR, STOPPING!" S ERR=1 Q
 .D ^DIE L -^RMPR(661.1,RMPRY)
 ;
 S RMPRX=""
 F RMPRX=1:1:17 S RMPRY=$P($T(REP+RMPRX),";",3) Q:ERR=1  D
 .S LINE=$P($T(REP+RMPRX),";",4)
 .S DIE="^RMPR(661.1,",DA=RMPRY,DR="5///^S X=LINE"
 .L +^RMPR(661.1,RMPRY):1 I '$T W !,"ERROR, STOPPING!" S ERR=1 Q
 .D ^DIE L -^RMPR(661.1,RMPRY)
EXIT ;main exit point
 K RMPRY,LINE,RMPRX,DR,DA,DIE,ERR
 Q
LST ;List of changes, new NPPD Line only
 ;;907;200 I;
 ;;908;200 I;
 ;;909;200 I;
 ;;910;200 I;
 ;;911;200 I;
 ;;912;200 I;
 ;;913;200 I;
 ;;914;200 I;
 ;;915;200 I;
 ;;916;200 I;
 ;;917;200 I;
 ;;918;200 I;
 ;;919;200 I;
 ;;920;200 I;
 ;;921;200 I;
 ;;922;200 I;
 ;;923;200 I;
 ;;924;200 I;
 ;;925;200 I;
 ;;926;200 I;
 ;;927;200 I;
 ;;928;200 I;
 ;;929;200 I;
 ;;930;200 I;
 ;;931;200 I;
 ;;932;200 I;
 ;;933;200 I;
 ;;934;200 I;
 ;;935;200 I;
 ;;936;200 I;
 ;;937;200 I;
 ;;938;200 I;
 ;;939;200 I;
 ;;940;200 I;
 ;;941;200 I;
 ;;942;200 I;
 ;;943;200 I;
 ;;944;200 I;
 ;;945;200 I;
 ;;946;200 I;
 ;;947;200 I;
 ;;948;200 I;
 ;;949;200 I;
 ;;950;200 I;
 ;;951;200 I;
 ;;952;200 I;
 ;;953;200 I;
 ;;954;200 I;
 ;;955;200 I;
 ;;956;200 I;
 ;;957;200 I;
 ;;958;200 I;
 ;;959;200 I;
 ;;960;200 I;
 ;;961;200 I;
 ;;962;200 I;
 ;;963;200 I;
 ;;964;200 I;
 ;;965;200 I;
 ;;966;200 I;
 ;;967;200 I;
 ;;968;200 I;
 ;;969;200 I;
 ;;970;200 I;
 ;;971;200 I;
 ;;972;200 I;
 ;;974;200 I;
 ;;975;200 I;
 ;;976;200 I;
 ;;977;200 I;
 ;;978;200 I;
 ;;979;200 I;
 ;;980;200 I;
 ;;981;200 I;
 ;;982;200 I;
 ;;983;200 I;
 ;;984;200 I;
 ;;985;200 I;
 ;;986;200 I;
 ;;987;200 I;
 ;;988;200 I;
 ;;989;200 I;
 ;;990;200 I;
 ;;991;200 I;
 ;;992;200 I;
 ;;993;200 I;
 ;;994;200 I;
 ;;995;200 I;
 ;;996;200 I;
 ;;997;200 I;
 ;;998;200 I;
 ;;999;200 I;
 ;;1000;200 I;
 ;;1001;200 I;
 ;;1002;200 I;
 ;;1003;200 I;
 ;;1004;200 I;
 ;;1005;200 I;
 ;;1006;200 I;
 ;;1007;200 I;
 ;;1008;200 I;
 ;;1009;200 I;
 ;;1010;200 I;
 ;;1011;200 I;
 ;;1012;200 I;
 ;;1013;200 I;
 ;;1014;200 I;
 ;;1015;200 I;
 ;;1016;200 I;
 ;;1017;200 I;
 ;;1018;200 I;
 ;;1019;200 I;
 ;;1020;200 I;
 ;;1021;200 I;
 ;;1022;200 I;
 ;;1023;200 I;
 ;;1024;200 I;
 ;;1025;200 I;
 ;;1026;200 I;
 ;;1176;200 I;
 ;;1177;200 I;
 ;;2225;200 I;
 ;;2241;200 I;
 ;;2242;200 I;
 ;;2243;200 I;
 ;;2244;200 I;
 ;;2245;200 I;
 ;;2246;200 I;
 ;;2247;200 I;
 ;;2252;200 I;
 ;;2255;200 I;
 ;;2560;200 I;
 ;;2561;200 I;
 ;;2562;200 I;
 ;;2563;200 I;
 ;;2564;200 I;
 ;;2585;200 I;
 ;;3609;200 I;
 ;;3611;200 I;
 ;;3614;200 I;
 ;;3616;200 I;
 ;;1062;300 D;
 ;;1063;300 D;
 ;;1064;300 D;
 ;;1065;300 D;
 ;;1066;300 D;
 ;;1067;300 D;
 ;;1068;300 D;
 ;;1069;300 D;
 ;;1070;300 D;
 ;;1071;300 D;
 ;;1072;300 D;
 ;;1073;300 D;
 ;;1074;300 D;
 ;;1075;300 D;
 ;;1076;300 D;
 ;;1077;300 D;
 ;;1078;300 D;
 ;;1079;300 D;
 ;;1080;300 D;
 ;;1081;300 D;
 ;;1082;300 D;
 ;;1083;300 D;
 ;;1084;300 D;
 ;;1085;300 D;
 ;;1086;300 D;
 ;;1087;300 D;
 ;;1088;300 D;
 ;;1089;300 D;
 ;;1090;300 D;
 ;;1091;300 D;
 ;;1092;300 D;
 ;;1094;300 D;
 ;;1095;300 D;
 ;;1096;300 D;
 ;;1097;300 D;
 ;;1160;300 D;
 ;;1161;300 D;
 ;;1162;300 D;
 ;;1163;300 D;
 ;;1164;300 D;
 ;;1165;300 D;
 ;;1166;300 D;
 ;;1167;300 D;
 ;;1168;300 D;
 ;;1169;300 D;
 ;;1170;300 D;
 ;;1172;300 D;
 ;;1173;300 D;
 ;;1174;300 D;
 ;;2239;300 D;
 ;;2566;300 D;
 ;;3618;300 D;
 ;;3621;300 D;
 ;;20;910 A;
 ;;29;910 A;
 ;;268;910 A;
 ;;420;910 A;
 ;;421;910 A;
 ;;422;910 A;
 ;;423;910 A;
 ;;424;910 A;
 ;;425;910 A;
 ;;2058;800 A;
 ;;2059;800 A;
 ;;2060;800 A;
 ;;2061;800 A;
 ;;2062;800 A;
 ;;2094;900 K;
 ;;2448;910 A;
 ;;2803;910 A;
 Q
REP ;;repair
 ;;20;@;
 ;;29;@;
 ;;268;@;
 ;;420;@;
 ;;421;@;
 ;;422;@;
 ;;423;@;
 ;;424;@;
 ;;425;@;
 ;;2058;R91 C;
 ;;2059;R91 C;
 ;;2060;R91 C;
 ;;2061;R91 C;
 ;;2062;R91 C;
 ;;2094;R91 C;
 ;;2448;@;
 ;;2803;@;
 Q
 ;END