PRCHS ;SF-ISC/RSD/RHD-PLACES BOCS & AMOUNTS INTO PO FILE ;12/6/93  09:05
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;REQUIRES FOLLOWING VARIABLES: DA
 Q:$P(^PRC(442,DA,7),U,1)=45  L +^PRC(442,DA):1 I '$T W !," P.O. is being edited by another person !",$C(7) Q
 S U="^",X=^PRC(442,DA,0),PRCHS("EST")=+$P(X,U,13),PRCHS("CP")=+$P(X,U,3),PRCHS("SITE")=+X I $D(^PRC(420,PRCHS("SITE"),1,PRCHS("CP"),0)),$P(^(0),U,12) S PRCHS("SP")=$P(^(0),U,12) G SP
 S I=0 F  S I=$O(^PRC(442,DA,2,I)) Q:I=""!(I'>0)  S PRCHS=I,PRCHS("N")=^(PRCHS,0),PRCHS("N2")=$S($D(^(2)):^(2),1:""),PRCHS("NS")=$S($P(PRCHS("N"),U,4)]"":+$P(PRCHS("N"),U,4),1:"**") D L
 D LI1 G:'$D(PRCHS("AMT")) NOSUB S CNT=0,I=0 F  S I=$O(PRCHS("AMT",I)) Q:I=""!(I<0)!(CNT>1)  S PRCHS=0 D LI2 I $O(PRCHS("AMT",I,PRCHS)) D LI2
 S:PRCHS("EST") PRCHS("EST")=PRCHS("EST")/CNT S (PRCHS,CNT)=0
 F I=0:0 S PRCHS=$O(PRCHS("A",PRCHS)) Q:PRCHS=""  S J=CNT#2+1,PRCHS(J)=$P(PRCHS(J),U,1)_U_($P(PRCHS(J),U,2)+PRCHS("A",PRCHS))_U_$P(PRCHS(J),U,3)_$P(PRCHS("A",PRCHS),U,2),CNT=CNT+1
 F I=1:1:2 S:$D(PRCHS(I)) X=$P(PRCHS(I),U,2),$P(PRCHS(I),U,2)=(X+PRCHS("EST")*100+.5\1/100),PRCHS(I)=$S($P(PRCHS(I),U,2)'>0:"",1:PRCHS(I)) S:'$D(PRCHS(I)) PRCHS(I)=""
 S PRCHS("TOT")=$P(PRCHS(1),U,2)+$P(PRCHS(2),U,2)
 D TM F I=1:1:2 Q:'$P(PRCHS(I),U,2)  S X=$P(PRCHS(I),U,2)-PRCHS("EST"),$P(PRCHS(I),U,2)=(X-$J(X*PRCHS("T"),0,2)+PRCHS("EST"))
 I PRCHS(2)>0,PRCHS(2)<PRCHS(1) S X=PRCHS(1),PRCHS(1)=PRCHS(2),PRCHS(2)=X
 I '$D(PRCSUM)&($P($G(^PRC(442,DA,12)),"^",2)]"") S PRCSUM=$$SUM^PRCUESIG(DA_"^"_$$STRING^PRCHES5(^PRC(442,DA,0),^PRC(442,DA,1),^PRC(442,DA,12)))
 S $P(^PRC(442,DA,0),U,6,9)=$P(PRCHS(1),U,1)_U_$P(PRCHS(1),U,2)_U_$P(PRCHS(2),U,1)_U_$P(PRCHS(2),U,2),$P(^(0),U,15,16)=PRCHS("TOT")_U_($P(PRCHS(1),U,2)+$P(PRCHS(2),U,2))
 I $P($G(^PRC(442,DA,12)),"^",2)]"" S PRCSIG="",X=0 D
 . N PRCHMOP S PRCHMOP=$P($G(^PRC(442,DA,0)),"^",2)
 . I PRCHMOP=7 D REMOVE^PRCHES5(DA),ENCODE^PRCHES5(DA,DUZ,.PRCSIG) I PRCSIG<1 W !!,"ESIG PROBLEM: ",PRCSIG H 2
 . I PRCHMOP'=7 D RECODE^PRCHES5(DA,PRCSUM,.PRCSIG)
 . K PRCSUM,PRCSIG
 . QUIT
 F I=1:1:2 S X=$P(PRCHS(I),U,3) I X]"" S X=$E(X,1,$L(X)-1) D:X[":" COL X "F J="_X_" D IT"
Q L -^PRC(442,DA) K PRCHS,I,J,CNT Q
IT I $D(^PRC(442,DA,2,J,2)) S $P(^(2),U,7)=+$P(PRCHS(I),U,1)
 Q
L G:'$D(PRCHS("A",PRCHS("NS"))) LI S PRCHS("L0")=$P(PRCHS("A",PRCHS("NS")),U,2) F J=1:1 S PRCHS("L1")=$E(PRCHS("L0"),$L(PRCHS("L0"))-J) Q:PRCHS("L1")'=+PRCHS("L1")
 S PRCHS("L2")=$E(PRCHS("L0"),$L(PRCHS("L0"))-J+1,$L(PRCHS("L0"))-1)+1 I PRCHS("L2")'=PRCHS S PRCHS=PRCHS("L0")_PRCHS G LI
 I PRCHS("L1")=":" S PRCHS=$E(PRCHS("L0"),1,$L(PRCHS("L0"))-J)_PRCHS
 E  S PRCHS=$E(PRCHS("L0"),1,$L(PRCHS("L0"))-1)_":"_PRCHS
LI S:'$D(PRCHS("A",PRCHS("NS"))) PRCHS("A",PRCHS("NS"))="" S PRCHS("A",PRCHS("NS"))=PRCHS("A",PRCHS("NS"))+PRCHS("N2")-$P(PRCHS("N2"),U,6)_U_PRCHS_"," Q
LI1 S PRCHS=0 F I=0:0 S PRCHS=$O(PRCHS("A",PRCHS)) Q:PRCHS=""  S:PRCHS'="**" PRCHS("AMT",(1000000000-PRCHS("A",PRCHS)),PRCHS)=""
 Q
LI2 S CNT=CNT+1,PRCHS=$O(PRCHS("AMT",I,PRCHS)) Q:PRCHS=""  S PRCHS(CNT)=PRCHS_U_PRCHS("A",PRCHS) K PRCHS("A",PRCHS) Q
TM S PRCHS("T")=0 K I F I=0:0 S I=$O(^PRC(442,DA,5,I)) Q:'I  S X=^(I,0) I +X>0 S I(100-X)=+X
 S:$O(I(0)) PRCHS("T")=I($O(I(0))),PRCHS("T")=PRCHS("T")/100 K I Q
 Q
COL F J=0:0 S J=$F(X,":",J) Q:'J  S X=$E(X,1,J-1)_"1:"_$E(X,J,999),J=J+2
 Q
SP S:PRCHS("SP")>1 $P(^PRC(442,DA,0),"^",5)="" S PRCHS("A","**")=""
 F I=0:0 S I=$O(^PRC(442,DA,2,I)) Q:'I  S $P(^(I,0),U,4)="",$P(^(2),U,7)="",PRCHS("N2")=^(2),PRCHS("A","**")=PRCHS("A","**")+PRCHS("N2")-$P(PRCHS("N2"),U,6)
NOSUB G:$O(PRCHS("A",0))'="**" Q S (PRCHS("NET"),PRCHS("TOT"))=(+$P(PRCHS("A","**"),U,1)*100+.5\1/100),PRCHS("TOT")=PRCHS("TOT")+PRCHS("EST") D TM
 I $D(PRCHS("SP")),PRCHS("SP")=2 G ENDNO
 I PRCHS("T") S PRCHS("NET")=PRCHS("NET")-$J(PRCHS("NET")*PRCHS("T"),0,2)
ENDNO S PRCHS("NET")=PRCHS("NET")+PRCHS("EST"),$P(^PRC(442,DA,0),U,6,9)="^^^",$P(^(0),U,15,16)=PRCHS("TOT")_"^"_PRCHS("NET") G Q