PSO5241 ;BHAM ISC/SAB- encap II API to return pending Rx data ; 04/07/05 10:30 am
 ;;7.0;OUTPATIENT PHARMACY;**213**;DEC 1997
 ;^PSDRUG supported by DBIA 221
 ;^PS(50.7 supported by DBIA 2223
 ;
PEN(DFN,LIST,IEN,PLACER) ;
 ;
 ;DFN: Patient's IEN 
 ;LIST: Subscript name used in ^TMP global [REQUIRED]
 ;IEN: Internal record number [optional]
 ;PLACER: Pointer to Orders file (#100) [optional]
 ;
 Q:$G(DFN)']""  Q:$G(LIST)=""
 N DA,DR,PSOPOST,DIC,DIQ,ND,LK K ^TMP($J,LIST)
 S ^TMP($J,LIST,DFN,0)=0
 I $G(IEN) D PROCESS G CLEAN
 I $G(PLACER)]"",'$G(IEN) S IEN=$O(^PS(52.41,"B",PLACER,0)) D  G CLEAN
 .I 'IEN S ^TMP($J,LIST,DFN,0)="-1^NO DATA FOUND" Q
 .D PROCESS
 F IEN=0:0 S IEN=$O(^PS(52.41,"P",DFN,IEN)) Q:'IEN  D PROCESS
CLEAN I ^TMP($J,LIST,DFN,0)=0 S ^TMP($J,LIST,DFN,0)="-1^NO DATA FOUND"
 K DA,DR,DIC,PSOPOST,DIQ
 Q
PROCESS ;
 Q:$P($G(^PS(52.41,IEN,0)),"^",3)="DC"  Q:$P($G(^PS(52.41,IEN,0)),"^",3)="DE"
 I DFN'=$P($G(^PS(52.41,IEN,0)),"^",2) S ^TMP($J,LIST,IEN,0)="-1^NO DATA FOUND (MISMATCHED PATIENT)" Q
 I $G(^PS(52.41,IEN,0))']"" S ^TMP($J,LIST,DFN,IEN,0)="-1^NO DATA FOUND" Q
 K PSOPOST S DIC=52.41,DA=IEN,DR=".01;2;8;9;11",DIQ="PSOPOST",DIQ(0)="IE" D EN^DIQ1
 F DR=.01,2,8 D  I DR=8 D OI
 .I DR=.01 S ^TMP($J,LIST,DFN,"B",PSOPOST(52.41,DA,DR,"I"),IEN)=""
 .I PSOPOST(52.41,DA,DR,"E")'=PSOPOST(52.41,DA,DR,"I") S ^TMP($J,LIST,DFN,IEN,DR)=PSOPOST(52.41,DA,DR,"I")_"^"_PSOPOST(52.41,DA,DR,"E") Q
 .S ^TMP($J,LIST,DFN,IEN,DR)=PSOPOST(52.41,DA,DR,"I")
 S DR=11 D
 .I PSOPOST(52.41,IEN,DR,"E")'=PSOPOST(52.41,IEN,DR,"I") S ^TMP($J,LIST,DFN,IEN,DR)=PSOPOST(52.41,IEN,DR,"I")_"^"_PSOPOST(52.41,IEN,DR,"E") Q
 .S ^TMP($J,LIST,DFN,IEN,DR)=PSOPOST(52.41,IEN,DR,"I")
 S ^TMP($J,LIST,DFN,0)=^TMP($J,LIST,DFN,0)+1
 K DA,DR,PSOPOST,DIC,DIQ
 Q
OI ;orderable item
 S DIC=50.7,DA=PSOPOST(52.41,DA,DR,"I"),DR=.02,DIQ(0)="IE" D EN^DIQ1
 S ^TMP($J,LIST,DFN,IEN,8)=^TMP($J,LIST,DFN,IEN,8)_"^"_PSOPOST(50.7,DA,DR,"I")_"^"_PSOPOST(50.7,DA,DR,"E")
 Q