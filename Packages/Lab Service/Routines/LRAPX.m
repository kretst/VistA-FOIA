LRAPX ;AVAMC/REG/WTY - AP CODING ;11/26/01
 ;;5.2;LAB SERVICE;**72,259**;Sep 27, 1994
 ;
 D ^LRAP
 I '$D(Y) D END Q
 D @LRSS,END
 Q
SP ;SNOMED coding, surg path
 S LR(2)=1,DR="K LRREL D RELCHK^LRAPX I LRREL(1) S Y=10;.03;10"
 S DR(2,63.12)=".01;S LR(8)=$P(^LAB(61,X,0),U,4);S:'LR(8) Y=4;2;4;"
 S DR(2,63.12)=DR(2,63.12)_"I '$D(LR(1)) S Y=0;1;1.5;3"
 S DR(3,63.16)=".01;I '$D(LR(1)) S Y=0;1"
 S DR(3,63.82)=".01;S:'$P(^LAB(61.5,X,0),U,3) Y=0;.02"
 D ^LRAPDA,END
 Q
CY ;SNOMED coding, cytopath
 S LR(2)=1,DR="K LRREL D RELCHK^LRAPX I LRREL(1) S Y=10;.03;10"
 S DR(2,63.912)=".01;S LR(8)=$P(^LAB(61,X,0),U,4);S:'LR(8) Y=4;2;4;"
 S DR(2,63.912)=DR(2,63.912)_"I '$D(LR(1)) S Y=0;1;1.5;3"
 S DR(3,63.916)=".01;I '$D(LR(1)) S Y=0;1"
 S DR(3,63.982)=".01;S:'$P(^LAB(61.5,X,0),U,3) Y=0;.02"
 D ^LRAPDA,END
 Q
EM ;SNOMED coding, EM
 S LR(2)=1,DR="K LRREL D RELCHK^LRAPX I LRREL(1) S Y=10;.03;10"
 S DR(2,63.212)=".01;S LR(8)=$P(^LAB(61,X,0),U,4);S:'LR(8) Y=4;2;4;"
 S DR(2,63.212)=DR(2,63.212)_"I '$D(LR(1)) S Y=0;1;1.5;3"
 S DR(3,63.216)=".01;I '$D(LR(1)) S Y=0;1"
 S DR(3,63.282)=".01;S:'$P(^LAB(61.5,X,0),U,3) Y=0;.02"
 D ^LRAPDA,END
 Q
AU ;SNOMED coding, autopsy
 S LR(2)=1
 S DR="K LRREL D RELCHK^LRAPX I LRREL(1) S Y=13.01;13;"
 S DR=DR_"13.01///^S X=LRWHO;32"
 S DR(2,63.2)=".01;I '$D(LR(1)) S Y=4;1;1.5;3;4"
 S DR(3,63.21)=".01"
 S DR(3,63.22)=".01;I '$D(LR(1)) S Y=0;1"
 S DR(3,63.24)=".01;S:'$P(^LAB(61.5,X,0),U,3) Y=0;.02"
 S DR(4,63.23)=".01"
 ;SET LRSOP="H" SO IT WILL SKIP ALL EDITS AND ONLY EXECUTE DIR
 S LRSOP="H"
 D ^LRAPDA,END
 Q
ISP ;ICD9CM coding, surg path
 S DR="K LRREL D RELCHK^LRAPX I LRREL(1) S Y=80;.03;80"
 D ^LRAPDA,END
 Q
ICY ;ICD9CM coding, cytopath
 S DR="K LRREL D RELCHK^LRAPX I LRREL(1) S Y=80;.03;80"
 D ^LRAPDA,END
 Q
IEM ;ICD9CM coding, EM
 S DR="K LRREL D RELCHK^LRAPX I LRREL(1) S Y=80;.03;80"
 D ^LRAPDA,END
 Q
IAU ;ICD9CM coding, autopsy
 S DR=80
 D ^LRAPDA,END
 Q
EN ;entry point for ICD9CM coding
 D ^LRAP
 I '$D(Y) D END Q
 D @("I"_LRSS),END
 Q
RELCHK ;Check to see if report is released
 D RELEASE^LRAPUTL(.LRREL,LRDFN,LRSS,LRI)
 Q
END ;
 K LRREL
 D V^LRU
 Q