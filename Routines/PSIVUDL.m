PSIVUDL ;BIR/PR,MLM-IV ORDER INFORMATION FOR UNIT DOSE LABEL ;25 Nov 98 / 9:12 AM
 ;;5.0; INPATIENT MEDICATIONS ;**21,58,110**;16 DEC 97
 ;
 ; References to ^PS(52.6 supported by DBIA #1231
 ; References to ^PS(52.7 supported by DBIA #2173
 ; References to ^PS(55 supported by DBIA #2191
 ;
 ;Needs DFN and PSJORD
EN(DFN,ON,PSJLWD,PSJLRB) ; Entry to print MAR label for all types of IV orders.
 N PSJLABEL,VAIN,VADM S (PSJACNWP,PSJLABEL)=1 D ENIV^PSJAC
 S PSJTM=$S(PSJLRB]"":$P($G(^PS(57.7,+PSJLWD,1,+$O(^PS(57.7,"AWRT",+PSJLWD,PSJLRB,0)),0)),U),1:""),PSJWGN=$P($G(^PS(57.5,+$O(^PS(57.5,"AB",+PSJLWD,0)),0)),U)
 K PSJLAT,ON55 D @$S(ON["V":"GT55^PSIVORFB",1:"GT531^PSIVORFA(DFN,ON)") S (MSG,PSJRPH,PSJLDT,PSJLR)="" S:ON["V" X=$G(^PS(55,DFN,"IV",+ON,7)),PSJLDT=+X,PSJLR=$P(X,U,2)
 I ON["P",(P("OPI")=""),$O(^PS(53.1,+ON,12,0)) F X=0:0 S X=$O(^PS(53.1,+ON,12,X)) Q:'X!($L(P("OPI"))>180)  S P("OPI")=P("OPI")_" "_$G(^(X,0))
 S PSJLAT=P(11),PSGLST=$$ONE^PSJBCMA(DFN,ON,P(9),P(2),P(3)) I PSGLST'="O" S PSGLST=$S(P(9)["PRN":"P",1:"C")
 S:ON["P" PSGLST=""
 F X="LOG",2,3 S:P(X) P(X)=$$ENDTC1^PSGMI(P(X))
 D RPHINIT^PSGMIV(.PSJRPH)
 S X=P(17),(PSJLAT(1),PSJLAT(2),PSJLAT(4),PSJLAT(5))=$S(X="D"!(X="E"):"****",1:""),PSJLAT(3)=$S(X="D":"DC'D",X="E":"EX'D",1:""),PSJLAT(0)=$S(X="D":0,X="E":0,1:$L(PSJLAT,"-"))
 I PSJLAT(0) D
 .F X=1:1:5 S PSJLAT(X)=""
 .I PSJLAT(0)=1 S PSJLAT(3)=$P(PSJLAT,"-") Q
 .I PSJLAT(0)=2 S PSJLAT(1)=$P(PSJLAT,"-"),PSJLAT(5)=$P(PSJLAT,"-",2) Q
 .I PSJLAT(0)=3 S PSJLAT(1)=$P(PSJLAT,"-"),PSJLAT(3)=$P(PSJLAT,"-",2),PSJLAT(5)=$P(PSJLAT,"-",3) Q
 .F X=1:1:PSJLAT(0) S PSJLAT(X)=$P(PSJLAT,"-",X)
 ;
ENP ; Print MAR label for IV order.
 S PSGLRN=$S(ON["P":$G(^PS(53.1,+ON,4)),1:$G(^PS(55,DFN,"IV",+ON,4)))
 I $G(DFN),$G(ON) N PSGLREN S PSGLREN=+$$LASTREN^PSJLMPRI(DFN,ON)
 N PSGLRNDT S PSGLRNDT=$P(PSGLRN,"^",2),PSGLRN=+PSGLRN I PSGLRNDT,$G(PSGLREN) I $G(PSGLREN)>PSGLRNDT S PSGLRN=0
 I ON["P",P(2)="",+PSGLRN S X="P E N D I N G"
 E  S X=$S(P(2)]"":$E(P(2),1,5)_$E(P(2),9,14),1:"           ")_" |"_P(3)
 W $C(13),?1,$E(P("LOG"),1,5)," |",X,?36,"(",$E(VADM(1),1),$E(VADM(2),6,9),")",?42,"|",$G(PSJLAT(1)),?52,VADM(1),?88,$J($S(PSJLRB]"":PSJLRB,1:"*NF*"),12)
 S:'+PSGLRN PSGLRN="_____"
 I +PSGLRN,$D(^VA(200,+PSGLRN,0))#2 S X=^(0),X=$S($P(X,"^",2)]"":$P(X,"^",2),1:$P(X,"^")),PSGLRN=$S(X'[",":X,1:$E(X,$F(X,","))_$E(X))
 S PSJCNT=2,X=0,MSG="",PSJCONT="See next label for continuation"
 NEW NAME
 W ! F X=0:0 S X=$O(DRG("AD",X)) Q:'X  D NAME^PSIVUTL(DRG("AD",X),47,.NAME,1) F Y=0:0 S Y=$O(NAME(Y)) Q:'Y  W ?1,NAME(Y) D NXTLNE(1) S:$P($G(^PS(52.6,+DRG("AD",+X),0)),U,9)]"" MSG=MSG_$P($G(^(0)),U,9)_" "
 ;*W:$G(DRG("SOL",0)) ?1,"in " F X=0:0 S X=$O(DRG("SOL",X)) Q:'X  D NAME^PSIVUTL(DRG("SOL",X),47,.NAME,1) F Y=0:0 S Y=$O(NAME(Y)) Q:'Y  W ?4,NAME(Y) D NXTLNE(1)
 NEW PSJPRT2
 W:$G(DRG("SOL",0)) ?1,"in " F X=0:0 S X=$O(DRG("SOL",X)) Q:'X  D NAME^PSIVUTL(DRG("SOL",X),47,.NAME,1) F Y=0:0 S Y=$O(NAME(Y)) Q:'Y  D
 . W ?4,NAME(Y) D NXTLNE(1)
 . S PSJPRT2=$P(^PS(52.7,+DRG("SOL",X),0),U,4) I PSJPRT2]"" W !?7,PSJPRT2 D NXTLNE(1)
 I MSG]"" S P("OPI")=MSG_P("OPI") S:$L($P(P("OPI"),"^"))>180 $P(P("OPI"),"^")=$E($P(P("OPI"),"^"),1,177)_"..."
 W ?1,$P(P("MR"),U,2)," ",P(9)," ",P(8) I P("OPI")]""!$D(PSJLAT(PSJCNT+1))!(P(4)="C") D NXTLNE($S($L($P(P("OPI"),"^"))>22:1,P(4)'="C":0,1:$L($P(P("OPI"),"^"))))
 I P(4)="C" W "*CAUTION-CHEMOTHERAPY*" D:$L($P(P("OPI"),"^")) NXTLNE($L($P(P("OPI"),"^"))>22)
 I P("OPI")]"" W ?1,"" F Y=1:1:$L($P(P("OPI"),"^")," ") D
 .S Y1=$P($P(P("OPI"),"^")," ",Y) I $X+$L(Y1)>42 D NXTLNE($L($P($P(P("OPI"),"^")," ",Y))>23) W ?1
 .W Y1," "
 D:$X>24 NXTLNE(1)
 I $D(PSJLAT(PSJCNT+1)) F  Q:'$D(PSJLAT(PSJCNT+1))  D
 .I PSJCNT#5=0 W ?1,PSJCONT D NXTLNE(2) W ?1 Q
 .D NXTLNE($D(PSJLAT(PSJCNT+2)))
 I PSJCNT#5>0 F  Q:PSJCNT#5=0  D NXTLNE(0)
 W ?24,"RPH:",PSJRPH,?33," RN:",PSGLRN D NXTLNE($D(PSJLAT(PSJCNT+1))) W !
 ;* W ?24,"RPH:",$S(PSJRPH]"":PSJRPH,1:"_____"),?33," RN:_____" D NXTLNE($D(PSJLAT(PSJCNT+1))) W !
DONE ;
 K DRG,MSG,NL,ON55,PSJTM,P,PSJLAT,PSJRPH,PSJACNWP,PSJCNT,PSJLDT,PSJLR,PSJTM,PSJWGN,X,Y,Y1
 Q
NXTLNE(NL) ; Print info to right of drug (x=line number,NL=new label)
 N Y
 W:PSJCNT=2 ?42,PSGLST W ?43,"|",$G(PSJLAT(PSJCNT)) I PSJCNT=2 W ?52,$P(VADM(2),U,2),?70,$E($$ENDTC^PSGMI(+VADM(3)),1,8),"  (",VADM(4),")",?85,$J($S(PSJTM]"":PSJTM,1:"NOT FOUND"),15)
 I PSJCNT=3 W ?52,$S(VADM(5)]"":$P(VADM(5),U,2),1:"____"),?65,"DX: ",VAIN(9)
 I PSJCNT=4,PSJLDT S Y=PSJLR D
 .W ?52,$$ENDTC^PSGMI(PSJLDT)
 .W ?77,$S(Y="N":"NEW ",Y="R":"RENEWAL ",1:""),"ORDER ",$S(Y="AD":"AUTO-DC'ED",Y="N":"",Y="E":"EDITED",Y="DE":"DC'ED (EDIT)",Y["D":"DISCONTINUED",Y="H1":"ON HOLD",Y="H0":"OFF OF HOLD",Y="ARI":"AUTO-REINSTATED",Y="RI":"REINSTATED",1:"")
 I PSJCNT=5 W ?52,$S(PSJWGN]"":$E(PSJWGN,1,21),1:"NOT FOUND"),?79,$J($S($P(PSJLWD,U,2)]"":$P(PSJLWD,U,2),1:"NOT FOUND"),21)
 W !,?1 S PSJCNT=PSJCNT+1 I NL=2 W !,?1 S NL=0
 I PSJCNT#5=0,NL W ?1,PSJCONT D NXTLNE(2)
 Q