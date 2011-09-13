PRCHHI7 ;WISC/TGH-IFCAP SEGMENT DL -(IT) ;8/12/92  10:00 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;;
DL(A,VAR1,NUM,DLCNT) ;Prism delivery Order Line
 N A2,A3,DAT,DESCLN,SKU,X,Y,I0,I2,I4,ITEM,KEPNUM,PRCHNSN,PRCHDIFF,PRCHQTY,PRCHJUDT
 S (ITEM,ITEMCNT)=0,TOTAL=$P($G(^PRC(442,VAR1,2,0)),U,4)+7
 S A2=2,A3="DE"
 D NOW^%DTC S X=$P(%,".") D JD^PRCFDLN S DAT=$E(X,1,3)+1700_$E(Y,1,3)
 F  S ITEM=$O(^PRC(442,VAR1,2,ITEM)) K PRCHTP1 Q:ITEM'>0  D
  .S DLCNT=DLCNT+1
  .S I0=$G(^PRC(442,VAR1,2,ITEM,0))
  .S DESCLN=$G(^PRC(442,VAR1,2,ITEM,1,0)),DESCLN=$P(DESCLN,U,4)
  .S I2=$G(^PRC(442,VAR1,2,ITEM,2))
  .S I4=$G(^PRC(442,VAR1,2,ITEM,4))
  .;
  .S PRCHTP1(0,20)="|DL"
  .S PRCHTP1(0,2)=$P(I0,U,13) ;NSN
  .S PRCHTP1(0,1)=$P(I0,U) ;ITEM LINE NO.
  .S PRCHTP1(1,8)=$P(I2,U,2) ;CONTRACT #
  .S PRCHTP1(0,11)=$P(A,U,10) ;DEL DATE
  .S PRCHTP1(1,1)=$P(I0,U,2)\1 ;QTY ORDERED
  .S SKU=$P(I0,U,16) I SKU]"" S SKU=$G(^PRCD(420.5,SKU,0))
  .S PRCHTP1(0,3)=$P(SKU,U)
  .S PRCHTP1(1,10)=DESCLN
  .D
  ..N I,J S (I,J)=""
  ..;S $P(^PRCF(423,PRCFA("CSDA"),52,0),U,3,4)=$P(^PRC(442,VAR1,2,0),U,3,4)
  ..;F  S I=$O(PRCHTP1(I)) Q:I=""  F  S J=$O(PRCHTP1(I,J)) Q:J=""  D
  ..; WAS 3.'s $P(^PRCF(423,PRCFA("CSDA"),52,ITEM,I),U,J)=PRCHTP1(I,J)
  ..;REMOVE DASHES FROM NSN & FORMAT UPTO 20 CHARS W TRAILING SPACES
  ..S PRCHNSN=$TR($P(I0,U,13),"-")
  ..I $D(PRCHNSN) S PRCHNSN=PRCHNSN_"                    ",PRCHNSN=$E(PRCHNSN,1,20)
  ..;
  ..;LINE ITEM NUMBER FORMAT UPTO 3 CHARS W LEADING ZEROS
  ..S PRCHLINU=$P(I0,U),PRCHLINE="00"_PRCHLINU
  ..I $D(PRCHLINU) S PRCHLINE=$E(PRCHLINE,$L(PRCHLINE)-2,99)
  ..;
  ..;REQUESTED DEL DATE FORMAT UPTO 7 CHARS W JULIAN DATE
  ..S X=$P(A,U,10) D JD^PRCFDLN S PRCHJUDT=$E(X,1,3)+1700_$E(Y,1,3)
  ..;
  ..;QTY ORDERED FORMATTED UPTO 9 CHARS W LEADING ZEROS & 2 DEC. IMPLIED
  ..S PRCHQTY=$TR($J($P(I0,U,2),0,2),".")
  ..S PRCHQTY="000000000"_PRCHQTY
  ..S PRCHQTY=$E(PRCHQTY,$L(PRCHQTY)-8,99)
  ..; 
  ..S NUM=NUM+1
  ..S ^TMP($J,"STRING",NUM)="DL"_"^^^"_PRCHNSN_"^"_PRCHLINE_"^"_$P(I2,U,2)_"^^"_PRCHJUDT_"^"_PRCHQTY_"^^^^"_$P(SKU,U)_"^^^^^|"
  ..S KEPNUM=NUM D CO^PRCHHI9(A2,A3,VAR1,ITEM,.NUM)
  ..;
  ..;#DE SEGMENT (DESCR. COUNT) FORMATTED UPTO 3 CHARS W LEADING ZEROS
  ..;IN DL STRING (3lines above) THE 17Tth piece is set to null
  ..S PRCHDIFF=NUM-KEPNUM,PRCHDIFF="00"_PRCHDIFF
  ..S PRCHDIFF=$E(PRCHDIFF,$L(PRCHDIFF)-2,99)
  ..S $P(^TMP($J,"STRING",KEPNUM),U,17)=PRCHDIFF
  ..Q