ESPOID ;DALISC/CKA; FIND A UNIQUE ID #;7/92
 ;;1.0;POLICE & SECURITY;**22**;Mar 31, 1994
VIO D NOW^%DTC S YR=$E(%I(3),2,3),S=+$$SITE^VASITE,X=$P(^ESP(914,0),U,3) S:$E(X,$L(S)+1,$L(S)+2)'=YR $P(^ESP(914,0),U,3)=S_YR_"000000"
 S X=$P(^ESP(914,0),U,3)+1 F I=1:1 Q:'$D(^ESP(914,X))  S X=X+1
 Q
OFF D NOW^%DTC S YR=$E(%I(3),2,3),S=+$$SITE^VASITE,X=$P(^ESP(912,0),U,3) S:$E(X,$L(S)+1,$L(S)+2)'=YR!(X="") $P(^ESP(912,0),U,3)=S_YR_"000000"
 S X=$P(^ESP(912,0),U,3)+1 F I=1:1 Q:'$D(^ESP(912,X))  S X=X+1
 Q