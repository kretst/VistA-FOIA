RMPRPRE ;PHX/JLT-PRE INIT ROUTINE FOR PROSTHETICS ;8/29/1994 [ 08/31/94  2:18 PM ]
 ;;3.0;PROSTHETICS;;Feb 09, 1996
 I $D(DUZ),$D(DUZ(0)),DUZ(0)'="@" W !!,?5,$C(7),"YOUR DUZ(0) MUST BE SET TO '@' BEFORE YOU CAN INSTALL THIS PACKAGE",! K DIFQ Q
 I '$D(DUZ) W !!,?5,$C(7),"YOUR DUZ MUST BE DEFINED BEFORE YOU CAN INSTALL THIS PACKAGE",! K DIFQ Q
 I $D(DUZ),'$D(DUZ(0)) W !!,?5,$C(7),"YOUR DUZ(0) MUST BE DEFINED BEFORE YOU CAN INSTALL PACKAGE",! K DIFQ Q
 S RMPRP=$S($D(^DIC(9.4,"B","IFCAP")):$O(^DIC(9.4,"B","IFCAP",0)),1:$O(^DIC(9.4,"B","IFCAP PACKAGE",0))) I RMPRP'>0 W !!,$C(7),"IFCAP HAS NOT BEEN INSTALLED ON YOUR SYSTEM.  PLEASE SEE YOUR SITE MANAGER",! K DIFQ Q
 I $D(^DIC(9.4,RMPRP,"VERSION")),^DIC(9.4,RMPRP,"VERSION")<3.6 W !!,$C(7),"YOU NEED IFCAP VERSION 3.6 OR GREATER TO RUN PROSTHETICS.  PLEASE SEE YOUR SITE MANAGER",! K DIFQ Q
 S RMPRP=$O(^DIC(9.4,"B","REGISTRATION",0)) I RMPRP'>0 W !!,$C(7),"MAS HAS NOT BEEN INSTALLED ON YOUR SYSTEM.  PLEASE SEE YOUR SITE MANAGER",! K DIFQ Q
 I $D(^DIC(9.4,RMPRP,"VERSION")),^DIC(9.4,RMPRP,"VERSION")<5.2 W !!,$C(7),"YOU NEED MAS 5.2 OR GREATER TO RUN PROSTHETICS.  PLEASE SEE YOUR SITE MANAGER",! K DIFQ Q
 S RMPRP=$O(^DIC(9.4,"B","INTEGRATED BILLING",0)) I RMPRP'>0 W !!,$C(7),"INTEGRATED BILLING HAS NOT BEEN INSTALLED ON YOUR SYSTEM.  PLEASE SEE YOUR SITE MANAGER",! K DIFQ Q
 I $D(^DIC(9.4,RMPRP,"VERSION")),^DIC(9.4,RMPRP,"VERSION")<1.5 W !!,$C(7),"YOU NEED INTEGRATED BILLING 1.5 OR GREATER TO RUN PROSTHETICS.  PLEASE SEE YOUR SITE MANAGER",! K DIFQ Q
 S RMPRP=$O(^DIC(9.4,"B","ORDER ENTRY/RESULTS REPORTING",0)) I RMPRP'>0 W !!,"ORDER ENTRY RESULTS REPORTING HAS NOT BEEN INSTALLED ON YOUR SYSTEM.  PLEASE SEE YOUR SITE MANAGER",! K DIFQ Q
 I $D(^DIC(9.4,RMPRP,"VERSION")),^DIC(9.4,RMPRP,"VERSION")<1.96 W !!,$C(7),"YOU NEED OE/RR VERSION 1.96 OR GREATER TO RUN PROSTHETICS",! K DIFQ Q
 D NOW^%DTC S Y=% D DD^%DT S RMPRST=Y Q
