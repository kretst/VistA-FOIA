DGPMVBM ;ALB/MIR - BUILDING MANAGMENT BULLETIN GENERATOR ; 9 OCT 90
 ;;5.3;Registration;;Aug 13, 1993
 ;This routine will generate a bulletin to building management (if
 ;a site so desires).  This bulletin gets fired under the following
 ;conditions:
 ;
 ;1 - The site must choose to have a bulletin generated by assigning
 ;    members to the DG BLDG MANAGEMENT mailgroup.  If there are no
 ;    members, no bulletin will be generated.
 ;2 - The entry must not be a deletion.
 ;3 - If the entry is new and it's a a transfer, discharge, or check-
 ;    out lodger and it is the last movement on file (not a back-date).
 ;4 - if it's the latest movement, it's an edit, and it's an admission,
 ;    transfer, or check-in lodger, the user will be asked whether they
 ;    want to generate a bulletin or not.
 ;
EN ;begin checks for bulletin generation
 S DGPMX=$O(^XMB(3.8,"B","DG BLDG MANAGEMENT",0)) I '$O(^XMB(3.8,+DGPMX,1,0)) K DGPMX Q  ;if no mailgroup members, quit
 I DGPMT=6!'DGPMA Q
 D NOW^%DTC S X=$O(^DGPM("APRD",DFN,+DGPMA+.0000005)),X=$O(^(+X,0)),X=$S($D(^DGPM(+X,0)):+^(0),1:0) I X,(X<%) G Q ;quit if not latest movement...check for pseudo d/c
 I 'DGPMP,("^2^3^5^"[("^"_DGPMT_"^")) D SET Q
 I 'DGPMP!("^1^2^4^"'[("^"_DGPMT_"^")) D Q Q
 ;edit existing entry for admit, xfr, or check-in...set variables
 I $P(DGPMP,"^",7)=$P(DGPMA,"^",7)!'$P(DGPMP,"^",7) D Q Q
 W !!,"You have made a change to the room-bed."
ASK ;ask if bulletin should be sent
 W !,"Do you want to notify Building Management" S %=1 D YN^DICN I %<0!(%=2) D Q Q
 I '% W !?3,"Respond 'Y'es to notify Building Management of vacated bed, otherwise, 'N'o." G ASK
 S DGPMOW=$P(DGPMP,"^",6),DGPMOB=$P(DGPMP,"^",7) D FILE,Q Q
SET ;set up variables for new transfers, discharges, or check-outs
 I DGPMT=2!(DGPMT=3) S X=$O(^DGPM("APID",DFN,10000000-+DGPMA)),X=$O(^(+X,0)) I $D(^DGPM(+X,0)) S DGPMOB=$P(^(0),"^",7),DGPMOW=$P(^(0),"^",6) I 'DGPMOB D Q Q
 I DGPMT=5 S X=$P(DGPMAN,"^",14) I $D(^DGPM(+X,0)) S DGPMOB=$P(^(0),"^",7),DGPMOW=$P(^(0),"^",6) I 'DGPMOB D Q Q
 I '$D(DGPMOB) D Q Q
FILE ;send bulletin
 I '$D(^DG(405.4,+DGPMOB,0)) D Q Q
 K ^UTILITY("DGPM BLDG MGMT",$J,"TEXT")
 S XMSUB="Room-bed Vacated",XMTEXT="^UTILITY(""DGPM BLDG MGMT"",$J,""TEXT"",",DGPMBLN=0
 N XMCHAN S X="G.DG BLDG MANAGEMENT",XMDUZ=DUZ,XMCHAN=1 D WHO^XMA21
 S DGPMBL=" " D SETLN
 S DGPMBL="Room-bed "_$P(^DG(405.4,+DGPMOB,0),"^",1)_" on ward "_$S($D(^DIC(42,+DGPMOW,0)):$P(^(0),"^",1),1:"UNKNOWN")_" has been vacated." D SETLN
 S DGPMBL="This bed will require cleaning." D SETLN
 S DGPMBL=" " D SETLN
 S DGPMBL="Patient Movement:  "_$S(DGPMT=1:"ADMISSION",DGPMT=2:"TRANSFER",DGPMT=3:"DISCHARGE",DGPMT=4:"CHECK-IN LODGER",DGPMT=5:"CHECK-OUT LODGER",1:"UNKNOWN") D SETLN
 S DGPMBL=" " D SETLN
 D ^XMD
 K ^UTILITY("DGPM BLDG MGMT",$J),DGPMBL,DGPMBLN,XMY,XMSUB,XMTEXT
Q K %,%Y,DGPMOB,DGPMOW,DGPMX,I,X Q
SETLN ; -- set line in xmtext array
 S DGPMBLN=DGPMBLN+1
 S ^UTILITY("DGPM BLDG MGMT",$J,"TEXT",DGPMBLN,0)=DGPMBL
 Q