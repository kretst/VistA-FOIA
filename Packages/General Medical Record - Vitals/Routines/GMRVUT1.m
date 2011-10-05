GMRVUT1 ;HIRMFO/YH-VITAL SIGNS INFORMATION ;2/5/99
 ;;4.0;Vitals/Measurements;**6,7,11**;Apr 25, 1997
T ;HELP INFORMATION FOR TEMPERATURE
 S GMRVITY="T",GMRVIT=$O(^GMRD(120.51,"C",GMRVITY,0)) Q:GMRVIT'>0  S GMRVIT(1)=$P($G(^GMRD(120.51,GMRVIT,0)),"^")
 W !,"** Temperature:  a number + a location qualifier(optional), e.g., 99.6A",!,?3,"or 99.6AX (F AXILLARY) or 37R (C RECTAL)." S GLVL="" D LISTQ^GMRVQUAL S GLINE=$G(GLINE)+4 D CHECK Q
P ;HELP INFORMATION FOR PULSE
 S GMRVITY="P",GMRVIT=$O(^GMRD(120.51,"C",GMRVITY,0)) Q:GMRVIT'>0  S GMRVIT(1)=$P($G(^GMRD(120.51,GMRVIT,0)),"^")
 W !,"** Pulse:  a number + a location qualifier(optional), e.g., 70A or 70AP",!,?3,"(70 APICAL).  " S GLVL="" D LISTQ^GMRVQUAL S GLINE=$G(GLINE)+5 D CHECK Q
R ;HELP INFORMATION FOR RESPIRATORY
 S GMRVITY="R",GMRVIT=$O(^GMRD(120.51,"C",GMRVITY,0)) Q:GMRVIT'>0  S GMRVIT(1)=$P($G(^GMRD(120.51,GMRVIT,0)),"^")
 W !,"** Respiration:  a number(0-99 with no decimal places) + method qualifier" S GLINE=$G(GLINE)+1 D CHECK W !,?3,"(optional) e.g., 40C or 40c." S GLVL="" D LISTQ^GMRVQUAL S GLINE=$G(GLINE)+1 D CHECK Q
BP ;HELP INFORMATION FOR BLOOD PRESSURE
 W !,"** B/P:  systolic/intermediate/diastolic" S GLINE=$G(GLINE)+1 D CHECK W !,?3,"intermediate pressure is optional, e.g., 98/64 or 120/100/80"
 S GLINE=$G(GLINE)+1 D CHECK W !,?3,"Null diastolic only be allowed for taken either by Doppler or Palpated." S GLINE=$G(GLINE)+1 D CHECK
 W !,?3,"The Default method is Palpated if no diastolic is entered."
 S GLINE=$G(GLINE)+1 D CHECK
 W !,?3,"Otherwise, enter D for Doppler, (e.g., 120/ or 120/D or 120/P)."
 S GLINE=$G(GLINE)+1 D CHECK Q
HT ;HELP INFORMATION FOR HEIGHT
 W !,"** Height:  a number + ',' (optional) + qualifier (2 decimals allowed)" S GLINE=$G(GLINE)+1 D CHECK
 S GMRVITY="HT",GMRVIT=$O(^GMRD(120.51,"C",GMRVITY,0)) Q:GMRVIT'>0  S GMRVIT(1)=$P($G(^GMRD(120.51,GMRVIT,0)),"^")
 W !,?3,"72I (inches)   147C (centimeters)" S GLINE=$G(GLINE)+1 D CHECK W !,?3,"5F10IE or 5'10""E (for 5 feet 10 inches ESTIMATED)" S GLINE=$G(GLINE)+1 D CHECK
 S GLVL="" D LISTQ^GMRVQUAL S GLINE=$G(GLINE)+2 D CHECK Q
CG ;HELP INFORMATION FOR CIRCUMFERENCE/GIRTH
 D CG^GMRVUTL1  S GLINE=$G(GLINE)+3 D CHECK Q
CVP ;
 D CVP^GMRVUTL1 Q
PO2 ;
 D PO2^GMRVUTL1 S GLINE=$G(GLINE)+2 D CHECK Q
PN ;HELP INFORMATION
 D PAIN^GMRVUTL1 S GLINE=$G(GLINE)+4 D CHECK Q
WT ;HELP INFORMATION FOR WEIGHT
 S GMRVITY="WT",GMRVIT=$O(^GMRD(120.51,"C",GMRVITY,0)) Q:GMRVIT'>0  S GMRVIT(1)=$P($G(^GMRD(120.51,GMRVIT,0)),"^")
 W !,"** Weight: a number+L(l) or a number+K(k) + 2nd quality (optional) 2 decimals" S GLINE=$G(GLINE)+1 D CHECK W !,?3,"allowed, e.g., 120.25L or 120l (pounds),   45.25K or 45k (kilograms)." S GLINE=$G(GLINE)+1
 D CHECK W !,?3,"120L, 120LA, or 120K for actual weight." S GLVL="" D LISTQ^GMRVQUAL S GLINE=$G(GLINE)+2 D CHECK Q
WTYPE ;ENTRY POIT FOR TYPE OF WEIGHT - ACTUAL/ESTIMATED/DRY
 K GMRW S (GMRVDFLT,GMRW)="",GLVL=9 D LISTQ^GMRVQUAL Q:'$D(GMRW)
 S GMRSITE=$P(X,+X,2) I $L(GMRSITE)=1,"LlKk"[GMRSITE S GMRSITE(GMRVITY)=$G(GMRVDFLT(1)) W ! G OTHERQ
 I $L(GMRSITE)=1,"LlKk"'[GMRSITE Q
 S:$L(GMRSITE)>1 GMRSITE=$$UP^XLFSTR($E(GMRSITE,2,30))
ASK3 K GMRV S GMRV=0 D SETSITE^GMRVUT3 I GMRV>0!GMROUT G OTHERQ
 G ASK
 ;
TPSITE ;SITE FOR TEMP., PULSE, B/P, RESPIRATION AND HEIGHT
 K GMRW S (GMRVDFLT,GMRW)="",GLVL=9 D LISTQ^GMRVQUAL Q:'$D(GMRW)
ASK2 ;
 I GMRVITY="T"!(GMRVITY="R")!(GMRVITY="P"),GMRSITE="" S GMRSITE(GMRVITY)=$G(GMRVDFLT(1)) G OTHERQ
 I GMRVITY="HT",GMRSITE="" S GMRSITE(GMRVITY)="" G OTHERQ
ASK1 K GMRV S GMRV=0 D SETSITE^GMRVUT3 I GMROUT!(GMRV>0) G OTHERQ
 ;
ASK W !!,"Select one of the following qualifiers for "_GMRVIT(1)_" or <RET> for default" D LIST W !!,"Please enter "_$S(GMRVITY="T"!(GMRVITY="BP")!(GMRVITY="P"):"location: ",GMRVITY="R":"method: ",GMRVITY="WT":"quality: ",1:"")
 W $P($G(GMRVDFLT(1)),"^")_"// "
 S GMRSITE="" R GMRSITE:DTIME S:'$T!(GMRSITE["^") GMROUT=1 I GMROUT W ! G OTHERQ
 S GMRSITE=$$UP^XLFSTR(GMRSITE) I GMRSITE="" S (GMRSITE,GMRSITE(GMRVITY))=$G(GMRVDFLT(1)) G OTHERQ
 G ASK3:GMRVITY="WT",ASK1
OTHERQ ;
 Q:GMROUT!(GMRENTY<5)  D OTHERQ^GMRVQUAL
 Q
CHECK ;
 I GLINE>14 D
 . W !,"<Ret> to continue " S J="" R J:DTIME S GLINE=0
 Q
LIST ;LIST SITES FOR THE SELECTED VM TYPE
 Q:'$D(GMRW)  S GMRZ="" F  S GMRZ=$O(GMRW(GMRZ)) Q:GMRZ=""  W !,?4,GMRZ
 Q