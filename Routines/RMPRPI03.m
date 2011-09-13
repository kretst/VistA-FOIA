RMPRPI03 ;HINCIO/ODJ - PIP Report APIs ;3/8/01
 ;;3.0;PROSTHETICS;**61**;Feb 09, 1996
 Q
 ;
 ; THIS - returns a ^TMP array structured as follows:-
 ;        ^TMP($J,N,H,I,S)=data (^ delimiter)
 ;
 ;        where N = ^TMP array name (eg. RMPRPI03)
 ;              H = HCPCS code (eg. L5000)
 ;              A = Item name
 ;              I = Item number (eg. 1)
 ;              S = Sequence (1,2,etc)
 ;
 ;      data pc 1 = Date
 ;              2 = Time
 ;              3 = Opening Balance
 ;              4 = Closing Balance
 ;              5 = Quantity
 ;              6 = Value
 ;              7 = Transaction Type desc.
 ;              8 = Patient Name (if patient issue, else null)
 ;              9 = Patient SSN (if patient issue, else null)
 ;             10 = User name
 ;
THIS(RMPRNM,RMPRSTN,RMPRSDT,RMPREDT,RMPRHCPC) ;
 N RMPRERR,RMPRH,RMPR,RMPROLD,RMPREOF,RMPRE,RMPR11
 N RMPROBAL,RMPRCBAL,RMPRSEQ,RMPRRX,RMPRFMDT,RMPR60,RMPR69
 N VA,VADM,DFN
 S RMPRERR=0
 I $G(RMPRNM)="" S RMPRNM="RMPRPI03"
 I $G(RMPRSTN)="" S RMPRERR=1 G THISX
 I '$D(RMPRHCPC) S RMPRHCPC="*"
 K ^TMP($J,RMPRNM)
 S RMPRH=""
THIS1 S RMPRH=$O(RMPRHCPC(RMPRH))
 I RMPRH="" G THISX
 K RMPR
 S RMPR("HCPCS")=RMPRH
THIS1A S RMPR("DATE&TIME")=RMPRSDT
 S RMPRERR=$$SRCH^RMPRPIXA(.RMPR,"XHDS","DATE&TIME",1,,.RMPREOF)
 I RMPRERR G THISX
 I RMPREOF G THIS1
 I $G(RMPRHCPC)'="*",RMPR("HCPCS")'=RMPRH G THIS1
THIS2 S RMPRERR=$$NEXT^RMPRPIXA(.RMPR,"XHDS","",1,.RMPROLD,.RMPREOF)
 I RMPRERR G THISX
 I RMPREOF G THISX
 I RMPROLD("HCPCS")'=RMPR("HCPCS") G:$G(RMPRHCPC)'="*" THIS1 G THIS1A
 I RMPR("DATE")>RMPREDT G:$G(RMPRHCPC)="*" THIS3 G THIS1
 S RMPRFMDT=RMPR("DATE")
 K RMPRE
 M RMPRE=RMPR
 S RMPRERR=$$GET^RMPRPIX6(.RMPRE)
 I RMPRERR G THISX
 S RMPRERR=$$STNIEN^RMPRPIX6(.RMPRE)
 I RMPRERR G THISX
 I RMPRE("STATION IEN")'=RMPRSTN G THIS2
 K RMPR11
 S RMPR11("STATION")=RMPRSTN
 S RMPR11("HCPCS")=RMPR("HCPCS")
 S RMPR11("ITEM")=RMPRE("ITEM")
 S RMPRERR=$$GET^RMPRPIX1(.RMPR11)
 I '$D(RMPR11("DESCRIPTION")) S RMPR11("DESCRIPTION")="NO DESCRIPTION"
 S RMPRSEQ=$O(^TMP($J,RMPRNM,RMPR("HCPCS"),RMPR11("DESCRIPTION"),RMPRE("ITEM"),""),-1)
 I RMPRSEQ'="" D
 . S RMPROBAL=$P(^TMP($J,RMPRNM,RMPR("HCPCS"),RMPR11("DESCRIPTION"),RMPRE("ITEM"),RMPRSEQ),"^",4)
 . Q
 E  D
 . K RMPRRX
 . S RMPRRX("STA")=RMPRSTN
 . S RMPRRX("HCP")=RMPR("HCPCS")
 . S RMPRRX("ITE")=RMPRE("ITEM")
 . S RMPRRX("RDT")=RMPRSDT
 . S RMPROBAL=$$SQTY^RMPRPIXJ(.RMPRRX)
 . Q
 S RMPRERR=$$TFLOW^RMPRPIX6(.RMPRE)
 I RMPRE("TRAN FLOW")="+" D
 . S RMPRCBAL=RMPROBAL+RMPRE("QUANTITY")
 . Q
 I RMPRE("TRAN FLOW")="-" D
 . S RMPRCBAL=RMPROBAL-RMPRE("QUANTITY")
 . Q
 I RMPRE("TRAN FLOW")="=" D
 . K RMPR69
 . S RMPR69("TRANS IEN")=RMPRE("IEN")
 . S RMPRERR=$$GET^RMPRPIXB(.RMPR69)
 . I '$D(RMPR69("GAIN/LOSS")) S (RMPRE("QUANTITY"),RMPRE("VALUE"),RMPROBAL,RMPRCBAL)=0 Q
 . S RMPRCBAL=RMPROBAL+RMPR69("GAIN/LOSS")
 . S RMPRE("QUANTITY")=RMPR69("GAIN/LOSS")
 . S RMPRE("VALUE")=RMPR69("GAIN/LOSS VALUE")
 . Q
 I RMPRE("TRAN FLOW")="" D
 . S RMPRCBAL=RMPROBAL
 . Q
 S RMPRSTR=""
 S $P(RMPRSTR,"^",1)=$E(RMPRFMDT,4,5)_"/"_$E(RMPRFMDT,6,7)_"/"_$E(RMPRFMDT,2,3)
 S $P(RMPRSTR,"^",2)=RMPRE("TIME")
 S $P(RMPRSTR,"^",3)=RMPROBAL
 S $P(RMPRSTR,"^",4)=RMPRCBAL
 S $P(RMPRSTR,"^",5)=RMPRE("QUANTITY")
 S $P(RMPRSTR,"^",6)=RMPRE("VALUE")
 S $P(RMPRSTR,"^",7)=RMPRE("TRAN TYPE")
 S $P(RMPRSTR,"^",10)=RMPRE("USER")
 K RMPR60
 S RMPRERR=$$IEN60^RMPRPIX6(.RMPRE,.RMPR60)
 I 'RMPRERR,$G(RMPR60("IEN"))'="" D
 . S DFN=$P($G(^RMPR(660,RMPR60("IEN"),0)),"^",2)
 . D DEM^VADPT
 . S $P(RMPRSTR,"^",8)=$G(VADM(1))
 . S $P(RMPRSTR,"^",9)=$P($G(VADM(2)),"^",2)
 . Q
 S ^TMP($J,RMPRNM,RMPR("HCPCS"),RMPR11("DESCRIPTION"),RMPRE("ITEM"),RMPRSEQ+1)=RMPRSTR
 G THIS2
THIS3 S RMPRERR=$$NEXT^RMPRPIXA(.RMPR,"XHDS","HCPCS",1,.RMPROLD,.RMPREOF)
 I RMPREOF G THISX
 G THIS1A
THISX Q RMPRERR