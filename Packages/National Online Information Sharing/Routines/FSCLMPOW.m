FSCLMPOW ;SLC/STAFF-NOIS List Manager Protocol Other Workload ;1/11/98  18:37
 ;;1.1;NOIS;;Sep 06, 1998
 ;
WKLD(CALL) ; from FSCLMPO
 N CNT,DATE,HRS,OK,TOTHRS,USER,WKLD
 K ^TMP("FSCWKLD",$J)
 S OK=1,TOTHRS=+$P(^FSCD("CALL",CALL,0),U,13)
 I 'TOTHRS D
 .W !,"No time entries."
 E  D
 .W !?5,"Total hours: ",TOTHRS
 .S WKLD=0 F  S WKLD=$O(^FSCD("WKLD","B",CALL,WKLD)) Q:WKLD<1  D
 ..S DATE=$P(^FSCD("WKLD",WKLD,0),U,3),HRS=+$P(^(0),U,4),USER=$P(^(0),U,2),USER=$$VALUE^FSCGET(USER,7103.5,1)
 ..I $L(DATE),$L(USER) D
 ...S ^TMP("FSCWKLD",$J,"DU",DATE,USER)=HRS
 ...S ^TMP("FSCWKLD",$J,"UD",USER,DATE)=HRS
 ...S ^(DATE)=$G(^TMP("FSCWKLD",$J,"D",DATE))+HRS
 ...S ^(USER)=$G(^TMP("FSCWKLD",$J,"U",USER))+HRS
 .W !,"By Date | Specialist:"
 .S CNT=3
 .S DATE=0 F  S DATE=$O(^TMP("FSCWKLD",$J,"DU",DATE)) Q:DATE<1  D  I 'OK Q
 ..W !?5,$$FMTE^XLFDT(DATE),"  (",^TMP("FSCWKLD",$J,"D",DATE),")"
 ..S CNT=CNT+1 I CNT'<(IOSL-1) S CNT=1 D PAUSE^FSCU(.OK) I 'OK Q
 ..S USER="" F  S USER=$O(^TMP("FSCWKLD",$J,"DU",DATE,USER)) Q:USER=""  S HRS=^(USER) D  I 'OK Q
 ...W !,?20,USER,?50,HRS
 ...S CNT=CNT+1 I CNT'<(IOSL-1) S CNT=1 D PAUSE^FSCU(.OK) I 'OK Q
 .W !,"By Specialist | Date:"
 .S CNT=CNT+1 I CNT'<(IOSL-1) S CNT=1 D PAUSE^FSCU(.OK) I 'OK Q
 .S USER="" F  S USER=$O(^TMP("FSCWKLD",$J,"UD",USER)) Q:USER=""  D  I 'OK Q
 ..W !?5,USER,"  (",^TMP("FSCWKLD",$J,"U",USER),")"
 ..S CNT=CNT+1 I CNT'<(IOSL-1) S CNT=1 D PAUSE^FSCU(.OK) I 'OK Q
 ..S DATE=0 F  S DATE=$O(^TMP("FSCWKLD",$J,"UD",USER,DATE)) Q:DATE<1  S HRS=^(DATE) D  I 'OK Q
 ...W !,?20,$$FMTE^XLFDT(DATE),?50,HRS
 ...S CNT=CNT+1 I CNT'<(IOSL-1) S CNT=1 D PAUSE^FSCU(.OK) I 'OK Q
 K ^TMP("FSCWKLD",$J)
 I 'OK Q
 D PAUSE^FSCU(.OK)
 Q
