ABSVU1 ;VAMC ALTOONA/CTB - MISC UTILITY PROGRAMS ;2/10/00  2:31 PM
V ;;4.0;VOLUNTARY TIMEKEEPING;**7,10,15,18**;JULY 6, 1994
GET(A,B,C,D) ;function to insert variables C and D into phrase A in language B.
 N X,ONE,TWO
 S B=$S($G(B)>0:B,1:1),ONE="|1|",TWO="|2|"
 S X=$$PHRASE(A,B)
 I $D(C),X[ONE S X=$P(X,ONE,1)_C_$P(X,ONE,2,99)
 I $D(D),X[TWO S X=$P(X,TWO,1)_D_$P(X,TWO,2,99)
 QUIT X
PHRASE(F,G) ;
 N H
 I F Q $G(^ABS(503339,F,G))
 S H=$O(^ABS(503339,"C",$E(F,1,30),0)) I 'H Q "INVALID PHRASE - CONTACT PROGRAMMER - "_F
 Q $G(^ABS(503339,H,G))
BDATE(AA) ;FUNCTION TO DETERMINE IF DATE IS LESS THAN 5 YEARS IN THE PAST
 ;RETURNS 0 IF < 5 YEARS OR 1 IF GREATER
 ;REQUIRES DT
 N X,Y,Z,%,ABSVXA,ABSVXB
 Q:'$D(ABSV("SITE")) 1
 S X=DT-50000
 Q:(AA<X) 1
 W ! S ABSVXA="Are you sure about this date",ABSVXB="",%=2 D ^ABSVYN
 Q:(%=1) 1
 Q 0
STRIP(X) ;FUNCTION TO STRIP LEADING BLANKS FROM STRING
 F  S:$E(X)=" " X=$E(X,2,$L(X)) Q:$E(X)'=" "
 Q X
