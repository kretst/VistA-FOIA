RALWKL2 ;HISC/GJC-Workload Reports By Functional Area ;4/12/96  10:15
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
DIVCHK ; Output statistics within division.
 N RA1,RAIMG,RASUM,RATTL0,RATTL1,RAWWU1
 S (RA1,RAIMG,RADIVSUM)="",RASUM=1
 S RAXIT=$$EOS^RAUTL5() D:'RAXIT HD^RALWKL1 Q:RAXIT
 S RATTL0=$G(^TMP($J,"RA",RADIV)),RAWWU1=+$P(RATTL0,"^",5)
 F I=1:1:4 S RATTL1=+$G(RATTL1)+(+$P(RATTL0,"^",I))
 F  S RA1=$O(^TMP($J,"RA1",RADIV,RA1)) Q:RA1']""  D  Q:RAXIT
 . I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() D:'RAXIT HD^RALWKL1 Q:RAXIT
 . S (RATTL2,RATTL3,RAWWU2)=0
 . S RATTL2=$G(^TMP($J,"RA1",RADIV,RA1)),RAWWU2=$P(RATTL2,"^",5)
 . F I=1:1:4 S RATTL3=+$G(RATTL3)+(+$P(RATTL2,"^",I))
 . W !,$E(RA1,1,28),?30,$J(+$P(RATTL2,"^"),5)
 . W ?36,$J(+$P(RATTL2,"^",2),5),?42,$J(+$P(RATTL2,"^",3),5)
 . W ?48,$J(+$P(RATTL2,"^",4),5),?55,$J(RATTL3,5)
 . W:$D(RAFL) ?62,$J($S(RATTL1:(100*RATTL3)/RATTL1,1:0),5,1)
 . W ?68,$J(RAWWU2,5)
 . W:$D(RAFL) ?75,$J($S(RAWWU1:(100*RAWWU2)/RAWWU1,1:0),5,1)
 . Q
 Q:RAXIT
 I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() D:'RAXIT HD^RALWKL1 Q:RAXIT
 K RADIVSUM
 W !,RALN,!!,"Division Total",?30,$J(+$P(RATTL0,"^"),5)
 W ?36,$J(+$P(RATTL0,"^",2),5),?42,$J(+$P(RATTL0,"^",3),5)
 W ?48,$J(+$P(RATTL0,"^",4),5),?55,$J(RATTL1,5) W:$D(RAFL) ?68,$J(RAWWU1,5)
 I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() D:'RAXIT HD^RALWKL1 Q:RAXIT
 W !!?2,"Imaging Type(s): "
 S RAITHLD=""
 F  S RAITHLD=$O(^TMP($J,"RA",RADIV,RAITHLD)) Q:RAXIT!(RAITHLD="")  W:$X>(80-25) !?($X+$L("Imaging Type(s):")+3) D
 .I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() D:'RAXIT HD^RALWKL1 Q:RAXIT
 .W $S($D(^RA(79.2,+$P(RAITHLD,"-",2),0)):$P(^(0),U,1),1:"UNKNOWN"),?($X+3)
 K RAITHLD Q:RAXIT
 W !!?3,"# of "_RATITLE_"s selected: "_$S(RAINPUT=1:"ALL",1:$G(RAFLDCNT))
 S RA1=$O(^TMP($J,"RA",RADIV))
 I RA1]"" N RADIV,RAIMG,RAFLD S RADIV=RA1,RASUM=0 D
 . S RA11=$O(^TMP($J,"RA",RADIV,"")) S:RA11]"" RAIMG=RA11
 . I $G(RAIMG)]"" S RA111=$O(^TMP($J,"RA",RADIV,RAIMG,"")) S:RA111]"" RAFLD=RA111 I $G(RAFLD)]"" S RAXIT=$$EOS^RAUTL5() D:'RAXIT HD^RALWKL1
 . Q
 Q
IMGCHK ; Check for EOS on I-Type
 N RA1,RA11,RA111,RASUM,RATTL0,RATTL1,RATTL2,RATTL3,RAWWU1,RAWWU2
 S (RA111,RAIMGSUM)="",RASUM=1
 I RAPG S RAXIT=$$EOS^RAUTL5() D:'RAXIT HD^RALWKL1 Q:RAXIT
 D:'RAPG HD^RALWKL1 Q:RAXIT
 S RATTL0=$G(^TMP($J,"RA",RADIV,RAIMG)),RAWWU1=+$P(RATTL0,"^",5)
 F I=1:1:4 S RATTL1=+$G(RATTL1)+(+$P(RATTL0,"^",I))
 F  S RA111=$O(^TMP($J,"RA",RADIV,RAIMG,RA111)) Q:RA111']""  D  Q:RAXIT
 . I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() D:'RAXIT HD^RALWKL1 Q:RAXIT
 . S (RATTL2,RATTL3,RAWWU2)=0
 . S RATTL2=$G(^TMP($J,"RA",RADIV,RAIMG,RA111)),RAWWU2=+$P(RATTL2,"^",5)
 . F I=1:1:4 S RATTL3=+$G(RATTL3)+(+$P(RATTL2,"^",I))
 . W !,$E(RA111,1,28),?30,$J(+$P(RATTL2,"^"),5)
 . W ?36,$J(+$P(RATTL2,"^",2),5),?42,$J(+$P(RATTL2,"^",3),5)
 . W ?48,$J(+$P(RATTL2,"^",4),5),?55,$J(RATTL3,5)
 . W:$D(RAFL) ?62,$J($S(RATTL1:(100*RATTL3)/RATTL1,1:0),5,1)
 . W ?68,$J(RAWWU2,5)
 . W:$D(RAFL) ?75,$J($S(RAWWU1:(100*RAWWU2)/RAWWU1,1:0),5,1)
 . Q
 I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() D:'RAXIT HD^RALWKL1 Q:RAXIT
 K RAIMGSUM
 W !,RALN,!!,"Imaging Type Total",?30,$J(+$P(RATTL0,"^"),5)
 W ?36,$J(+$P(RATTL0,"^",2),5),?42,$J(+$P(RATTL0,"^",3),5)
 W ?48,$J(+$P(RATTL0,"^",4),5),?55,$J(RATTL1,5),?68,$J(RAWWU1,5)
 W !!?3,"# of "_RATITLE_"s selected: "_$S(RAINPUT=1:"ALL",1:$G(RAFLDCNT))
 S RA1=$O(^TMP($J,"RA",RADIV,RAIMG))
 I RA1]"" N RAFLD,RAIMG S RAIMG=RA1,RASUM=0 D
 . S RA11=$O(^TMP($J,"RA",RADIV,RAIMG,"")) Q:RA11']""  S RAFLD=RA11
 . S RA111=$O(^TMP($J,"RA",RADIV,RAIMG,RAFLD,"")) Q:RA111']""
 . S RAXIT=$$EOS^RAUTL5() D:'RAXIT HD^RALWKL1
 . Q
 Q
PURGE ; Kill & Quit
 K %DT,A,A1,B,B1,BEGDATE,C,DIROUT,DIRUT,DTOUT,DUOUT,ENDDATE,I,J,RA1,RA11
 K RA111,RABEG,RACNI,RACRT,RAD0,RADFN,RADIV,RADIFLG
 K RADIVNME,RADIVSUM,RADTE,RADTI,RAEND,RAFILE,RAFL,RAFL1,RAFLD,RAFLDCNT,RAIMG,RAIMGSUM
 K RAINPUT,RALN,RALN1,RAMES,RAMIS,RANUM,RAP0,RAPCE,RAPG,RAPOP,RAPRC
 K RAPRI,RAQI,RAQUIT,RASUM,RASV,RATDY,RATITLE,RATTL0,RATTL1,RATTL2
 K RATTL3,RAWWU1,RAWWU2,RAXIT,X,Y,ZTDESC,ZTRTN,ZTSAVE
 K ^TMP($J,"RA"),^TMP($J,"RA1"),^TMP($J,"RA D-TYPE"),^TMP($J,"RA I-TYPE")
 K ^TMP($J,"RAFLD") K:$D(RAPSTX) RACCESS,RAPSTX D CLOSE^RAUTL K POP
 Q
ZEROUT ; Zero out the data globals.
 N A,A1,B,B1
 S A="" F  S A=$O(RACCESS(DUZ,"DIV-IMG",A)) Q:A']""  D
 . Q:'$D(^TMP($J,"RA D-TYPE",A))  S A1=$O(^TMP($J,"RA D-TYPE",A,0)) Q:A1'>0  S RADIFLG(A1)=0
 . S ^TMP($J,"RA",A1)="0^0^0^0^0",B=""
 . F  S B=$O(RACCESS(DUZ,"DIV-IMG",A,B)) Q:B']""  D
 .. Q:'$D(^TMP($J,"RA I-TYPE",B))  D IT Q:B1'?3AP1"-".N  S RADIFLG(A1)=RADIFLG(A1)+1
 .. S ^TMP($J,"RA",A1,B1)="0^0^0^0^0"
 .. Q
 . Q
 K RACCESS(DUZ,"DIV-IMG")
 Q
IT ; calculate imaging type subscript
 S B1=$O(^RA(79.2,"B",B,0)) Q:B1'>0
 S B1=$E($P($G(^RA(79.2,+B1,0)),U,1),1,3)_"-"_B1
 Q
