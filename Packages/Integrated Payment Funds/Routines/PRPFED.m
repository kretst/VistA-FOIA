PRPFED ;ALTOONA/CTB  EDIT ROUTINE FOR PATIENT FUNDS PACKAGE ;2/24/97  5:09 PM
V ;;3.0;PATIENT FUNDS;**6**;JUNE 1, 1989
DEAD I $D(^DPT(DFN,.35)),$P(^(.35),"^")]"" W !,*7,"PATIENT HAS DIED!" Q
 Q
GETPAT K DFN S %PRPF=0,DIC(0)="IAEZMQ",DIC=470,DLAYGO=470 D ^DIC K DIC("A"),DLAYGO Q:Y<0  S DFN=+Y,DFN(0)=Y(0),DFN(0,0)=Y(0,0) I $D(^DPT(DFN,.31)) W:$P(^(.31),"^",3)]"" ?($X+5),"Claim #: ",$P(^(.31),"^",3)
 I $D(^PRPF(470,DFN,9)) S X=^(9) W !!,*7,"This File is being edited",$S($P(X,"^",2)>0:" by "_$P(^VA(200,$P(X,"^",2),0),"^"),1:" ")," on Device ",$P(X,"^",3)_".",!,"  Please try later." R X:3 W ! G GETPAT
 S ^PRPF(470,DFN,9)="1^"_DUZ_"^"_$S($D(ION):ION,1:""),%PRPF=1 Q
 ;
GETTRANS ;GET TEMP TRANS NUMBER FROM TEMP TRANSACTION FILE
 S (DLAYGO,DIC)=470.5,DIC(0)="XOLM",X="T"_^%ZOSF("VOL")_$J,%PRPF=0
 S:'$D(COUNT) COUNT=0 D ^DIC Q:Y<0  I $P(Y,"^",3)="" S COUNT=COUNT+1 Q:COUNT>3  S DIK=DIC,DA=+Y D ^DIK K DIK G GETTRANS
 S (TRDA,DA)=+Y,%PRPF=1 Q
 ;
POST ;POST TRANSACTION
 D GETPAT G:'%PRPF OUT D EN1^PRPFBAL D DEAD S %=1,%A="Do you wish to continue with this transaction",%B="" D ^PRPFYN I %'=1 G OUT
 D GETTRANS G:'%PRPF OUT S TRDA=+Y,DIE=DIC,%=1
EDIT S $P(^PRPFT(470.5,DA,0),"^",4)="",DR="[PRPF TEMP TRANS POST]",DIE("NO^")="OUTOK" D ^DIE I $D(Y)'=0!($D(PRPF("KILL"))) K PRPF("KILL") S DIK=DIC D ^DIK K DIK S X="  < Option Terminated >*" D MSG^PRPFU1 R X:3 G OUT
 S Y=DFN,Y(0)=DFN(0) D ^PRPFPOST G:%=3 EDIT G:%=1 CL
 K ^PRPF(470,DFN,9) G POST
CL K ^PRPF(470,DFN,9) D EN1^PRPFBAL,ENCON^PRPFQ,OUT G POST
 ;
DEF ;EDIT DEFERRAL
 D GETPAT G:'%PRPF OUT
 I $S('$D(^PRPF(470,DFN,4,0)):1,$P(^(0),"^",4)=0:1,1:0) S X="No Deferrals recorded for this account.*" D MSG^PRPFU1,ENCON^PRPFQ,OUT G DEF
 S DA=DFN,DIC="^PRPF(470,"_DA_",4,",DIC(0)="AEMN" D ^DIC G:Y<0 OUT S DIE=DIC,DR=1,DA=+Y D ^DIE,OUT G DEF Q
CKINACT ;CHECK BALANCE DURING INPUT TRANSFORM FOR ACCOUNT STATUS
 Q:$E(X,1)="A"
 I $D(^PRPF(470,DA,1)),+$P(^(1),"^",4)'=0 W "   BALANCE IS $",$J($P(^(1),"^",4),0,2),*7,!,"  You may not Inactivate an Account unless the Balance is zero" K X Q
 Q
CLEAR ;CLEAR LOCK ON ACCOUNT
 S DIC=470,DIC(0)="AEMN" D ^DIC G:Y<0 OUTC S DFN=+Y I '$D(^PRPF(470,DFN,9)) W !,"Account is already clear.  No action is required.",! R X:3 G OUTC
 S X=^PRPF(470,DFN,9),%A="The lock indicates that the file is being edited"_$S($P(X,"^",2)>0:" by "_$P(^VA(200,$P(X,"^",2),0),"^"),1:" "),%A(1)="Are you sure you want to clear the lock",%B="",%=2 D ^PRPFYN
 I %'=1 G CLEAR
 K ^PRPF(470,DFN,9) W *7,"---CLEARED---",! R X:3 D OUTC Q
SUSPENSE ;ADD/EDIT SUSPENSE ITEM
 S DIC=470,DIC(0)="AEMNQ" D ^DIC G OUT:Y<0 S DIE=DIC,DA=+Y,DR="[PRPF SUSPENSE ENTER EDIT]" D ^DIE G SUSPENSE
FORM ;ADD/EDIT PATIENT FUNDS FORM
 S (DLAYGO,DIC)=470.2,DIC(0)="AEMZLQ" D ^DIC K DIC,DLAYGO G:Y<0 OUT S DIE="^PRPF(470.2,",DA=+Y,DR="[PRPF FORMS EDIT]" D ^DIE S DIC("A")="Select Next PATIENT FUNDS FORM: " G FORM
OUT I $D(DFN)#2,DFN]"" K ^PRPF(470,DFN,9)
 I $D(TRDA),TRDA>0 S DIK="^PRPFT(470.5,",DA=TRDA D ^DIK
 W:$D(IOF) @IOF
OUTC K %,%DT,%H,%I,%PRPF,%W,%X,%Y,C,COUNT,D,D0,D1,DA,DEFDATE,DEP,DFN,DG1,DGA1,DGT,DGX,DI,DIC,DIE,DIK,DIPGM,DIW,DIWT,DIYS,DLAYGO,DN,DQ,DR,DUOUT,DWLW
 K FORM,I,J,K,N,P,PFHI,PFLO,PFNORM,POP,PRBAL,PRPF,Q3,RES,S,SOURCE,TMP,TRDA,TYPE,X,X1,X2,Y,Z Q
