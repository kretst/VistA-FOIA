LRMINEW2 ;SLC/CJS/BA - NEW DATA TO BE REVIEWED/VERIFIED ;2/19/91  10:49 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
Q2 F I=0:0 W !,"Do you want to queue the data to print and review/approve it later" S %=1 D YN^DICN Q:%  W !,"Or you could look at it now!"
 Q:%=-1
 I %=1 S %ZIS="MQ",%ZIS("B")="",IOP="Q"
 W ! S ZTRTN="DQ^LRMINEW2" D IO^LRWU
 Q
DQ S:$D(ZTQUEUED) ZTREQ="@" U IO K ^TMP($J) S LREND=0,LRONETST="",LRONESPC=""
 S LRAN=0 F I=0:0 S LRAN=+$O(^LRO(68,LRAA,1,LRAD,"AC",LRSB,LRAN)) Q:LRAN<1!($G(LREND))  D:+^(LRAN)=LRDXZ!(LRDXZ=0) SORT
 S LRLOCA="" F I=0:0 S LRLOCA=$O(^TMP($J,LRLOCA)) Q:LRLOCA=""!($G(LREND))  S LRLTR=$E(LRLOCA,1,4) W @IOF D ^LRLTR:$E(IOST,1,2)'="C-" S LRAN=0 F I=0:0 S LRAN=+$O(^TMP($J,LRLOCA,LRAN)) Q:LRAN<1!($G(LREND))  D SENDUP Q:LREND
 K ^TMP($J),LRWRDVEW
 Q
SORT Q:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0))  S LRLOCA=$P(^(0),U,7) Q:LRLOCA=""
 S ^TMP($J,LRLOCA,LRAN)=""
 Q
SENDUP Q:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,3))!($G(LREND))  S LRIDT=9999999-^(3),LRDFN=+^(0),LRLLT=^LR(LRDFN,"MI",LRIDT,0),LRACC=$P(LRLLT,U,6),LRCMNT=$S($D(^(99)):^(99),1:""),LRPG=0 D EN^LRMIPSZ1 Q:LREND
 Q
