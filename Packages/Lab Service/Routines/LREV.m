LREV ;SLC/CJS - REVIEW OF LRTEST DESCRIPTIONS ;2/19/91  13:06 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
R2 S U="^",DIC="^LAB(60,",DIC(0)="AEOQZ" D ^DIC G END:Y<1 S LRTEST=+Y,LRDAN=0
R4 S LRDAN=$O(^LAB(60,LRTEST,1,LRDAN)) G R5:LRDAN<1
 S DIC="^LAB(60,"_LRTEST_",1,",DA=LRDAN,DR=0 D EN^DIQ G R4
R5 IF $D(^LAB(60,LRTEST,3,0)) S LRCS=$P(^(0),U,4),DIC="^LAB(60,"_LRTEST_",3,",DR="0:2" F LRJJ=1:1:LRCS S DA=LRJJ D EN^DIQ
 G R2
END K LRTEST,LRDAN,LRJJ,LRCS
 Q
