PSDUTL3 ;BIR/JPW-Utility FM and X-Refs (cont'd) ; 18 Jan 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
SAC ;sets 'AC' x-ref on field 10 in file 58.86
 S PSDDRU=+$P(^PSD(58.86,DA,0),"^",2),PSDNL=+$P(^(0),"^",7) I 'PSDDRU!('PSDNL) K PSDDDU,PSDNL Q
 S ^PSD(58.86,"AC",X,PSDNL,PSDDRU,DA)="" K PSDDRU,PSDNL
 Q
KAC ;kills 'AC' x-ref on field 10 in file 58.86
 S PSDDRU=+$P(^PSD(58.86,DA,0),"^",2),PSDNL=+$P(^(0),"^",7) I 'PSDDRU!('PSDNL) K PSDDRU,PSDNL Q
 K ^PSD(58.86,"AC",X,PSDNL,PSDDRU,DA),PSDDRU,PSDNL
 Q
SAC1 ;sets 'AC' x-ref on field 1 in file 58.86
 S PSDDAT=+$P(^PSD(58.86,DA,0),"^",11),PSDNL=+$P(^(0),"^",7) I 'PSDDAT!('PSDNL) K PSDDAT,PSDNL Q
 S ^PSD(58.86,"AC",PSDDAT,PSDNL,X,DA)="" K PSDDAT,PSDNL
 Q
KAC1 ;kills 'AC' x-ref on field 1 in file 58.86
 S PSDDAT=+$P(^PSD(58.86,DA,0),"^",11),PSDNL=+$P(^(0),"^",7) I 'PSDDAT!('PSDNL) K PSDDAT,PSDNL Q
 K ^PSD(58.86,"AC",PSDDAT,PSDNL,X,DA),PSDDAT,PSDNL
 Q
SAC2 ;sets 'AC' x-ref on field 6 in file 58.86
 S PSDDRU=$P(^PSD(58.86,DA,0),"^",2),PSDDAT=$P(^(0),"^",11) I 'PSDDRU!('PSDDAT) K PSDDRU,PSDDAT Q
 S ^PSD(58.86,"AC",PSDDAT,X,PSDDRU,DA)="" K PSDDAT,PSDDRU
 Q
KAC2 ;kills 'AC' x-ref on field 6 in file 58.86
 S PSDDRU=$P(^PSD(58.86,DA,0),"^",2),PSDDAT=$P(^(0),"^",11) I 'PSDDRU!('PSDDAT) K PSDDRU,PSDDAT Q
 K ^PSD(58.86,"AC",PSDDAT,X,PSDDRU,DA),PSDDAT,PSDDRU
 Q
SAD ;sets 'AD' x-ref on field 10 in file 58.86
 S PSDDRU=$P($G(^PSD(58.86,DA,1)),"^"),PSDNL=+$P(^(0),"^",7) I PSDDRU']""!('PSDNL) K PSDDRU,PSDNL Q
 S ^PSD(58.86,"AD",X,PSDNL,PSDDRU,DA)="" K PSDDRU,PSDNL
 Q
KAD ;kills 'AD' x-ref on field 10 in file 58.86
 S PSDDRU=$P($G(^PSD(58.86,DA,1)),"^"),PSDNL=+$P(^(0),"^",7) I PSDDRU']""!('PSDNL) K PSDDRU,PSDNL Q
 K ^PSD(58.86,"AD",X,PSDNL,PSDDRU,DA),PSDDRU,PSDNL
 Q
SAD1 ;sets 'AD' x-ref on field 13 in file 58.86
 S PSDDAT=+$P(^PSD(58.86,DA,0),"^",11),PSDNL=+$P(^(0),"^",7) I 'PSDDAT!('PSDNL) K PSDDAT,PSDNL Q
 S ^PSD(58.86,"AD",PSDDAT,PSDNL,X,DA)="" K PSDDAT,PSDNL
 Q
KAD1 ;kills 'AD' x-ref on field 13 in file 58.86
 S PSDDAT=+$P(^PSD(58.86,DA,0),"^",11),PSDNL=+$P(^(0),"^",7) I 'PSDDAT!('PSDNL) K PSDDAT,PSDNL Q
 K ^PSD(58.86,"AD",PSDDAT,PSDNL,X,DA),PSDDAT,PSDNL
 Q
SAD2 ;sets 'AD' x-ref on field 6 in file 58.86
 S PSDDRU=$P($G(^PSD(58.86,DA,1)),"^"),PSDDAT=$P(^(0),"^",11) I PSDDRU']""!('PSDDAT) K PSDDRU,PSDDAT Q
 S ^PSD(58.86,"AD",PSDDAT,X,PSDDRU,DA)="" K PSDDAT,PSDDRU
 Q
KAD2 ;kills 'AD' x-ref on field 6 in file 58.86
 S PSDDRU=$P($G(^PSD(58.86,DA,1)),"^"),PSDDAT=$P(^(0),"^",11) I PSDDRU']""!('PSDDAT) K PSDDRU,PSDDAT Q
 K ^PSD(58.86,"AD",PSDDAT,X,PSDDRU,DA),PSDDAT,PSDDRU
 Q
SACT7 ;set 'ACT' x-ref on field 37 in 58.81
 S PSDNL=$P(^PSD(58.81,DA,0),"^",3),PSDDRU=$P(^(0),"^",5),PSDTYPE=4
 I ('PSDNL)!('PSDDRU)!('PSDTYPE) K PSDNL,PSDDRU,PSDTYPE Q
 S ^PSD(58.81,"ACT",X,PSDNL,PSDDRU,PSDTYPE,DA)="" K PSDNL,PSDDRU,PSDTYPE
 Q
KACT7 ;kill 'ACT' x-ref on field 37 in 58.81
 S PSDNL=$P(^PSD(58.81,DA,0),"^",3),PSDDRU=$P(^(0),"^",5),PSDTYPE=4
 I ('PSDNL)!('PSDDRU)!('PSDTYPE) K PSDNL,PSDDRU,PSDTYPE Q
 K ^PSD(58.81,"ACT",X,PSDNL,PSDDRU,PSDTYPE,DA),PSDNL,PSDDRU,PSDTYPE
 Q
