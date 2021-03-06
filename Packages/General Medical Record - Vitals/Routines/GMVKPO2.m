GMVKPO2 ;HIOFO/YH,FT-KYOCERA PULSE OXIMETRY/RESP. MACRO-1 ;11/6/01  15:00
 ;;5.0;GEN. MED. REC. - VITALS;;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; <None>
 ;
EN1 W !,"!R! RES; DAM;"
BOX W !,"MCRO BOX;"
 W !,"UNIT C; SLM 3; STM 1; MAP 0,0; SPD 0.05; BOX 16,22.8; MAP -3,20; BOX 19,2.8;"
 W !,"FONT 40; MAP -2,0.5; TEXT 'Date/Time'; MAP -2.5,1; TEXT 'Pulse Ox.'; MAP -1,1; TEXT 'Resp.';"
 W !,"SPD 0.01; MAP -2,2; TEXT '100'; MAP -1,2; TEXT ' 40'; MAP 0,1; DAP 16,1;"
 W !,"MAP -2,3; TEXT ' 98'; MAP -1,3; TEXT ' 38'; MAP 0,2; DAP 16.2,2;"
 W !,"MAP -2,4; TEXT ' 96'; MAP -1,4; TEXT ' 36'; MAP 0,3; DAP 16,3;"
 W:GTNM=0 "MAP 2,5; TEXT 'THERE  IS  NO  DATA  FOR  THIS  PERIOD';"
 W !,"MAP -2,5; TEXT ' 94'; MAP -1,5; TEXT ' 34'; MAP 0,4; DAP 16,4;"
 W !,"MAP -2,6; TEXT ' 92'; MAP -1,6; TEXT ' 32'; MAP 0,5; DAP 16,5;"
 W !,"MAP -2,7; TEXT ' 90'; MAP -1,7; TEXT ' 30'; MAP 0,6; DAP 16,6;"
 W !,"MAP -2,8; TEXT ' 88'; MAP -1,8; TEXT ' 28'; MAP 0,7; DAP 16,7;"
 W !,"MAP -2,9; TEXT ' 86'; MAP -0.8,9; TEXT '26'; MAP 0,8; DAP 16,8;"
 W !,"SPD 0.01; MAP -2,10; TEXT ' 84'; MAP -0.8,10; TEXT '24'; MAP 0,9; DAP 16,9;"
 W !,"MAP -2,11; TEXT ' 82'; MAP -0.8,11; TEXT '22'; MAP 0,10; DAP 16,10;"
 W !,"MAP -1.8,12; TEXT '80'; MAP -0.8,12; TEXT '20'; MAP 0,11; DAP 16,11;"
 W !,"MAP -1.8,13; TEXT '78'; MAP -0.8,13; TEXT '18'; MAP 0,12; DAP 16,12;"
 W !,"MAP -1.8,14; TEXT '76'; MAP -0.8,14; TEXT '16'; MAP 0,13; DAP 16,13;"
 W !,"MAP -1.8,15; TEXT '74'; MAP -0.8,15; TEXT '14'; MAP 0,14; DAP 16,14;"
 W !,"MAP -1.8,16; TEXT '72'; MAP -0.8,16; TEXT '12'; MAP 0,15; DAP 16,15;"
 W !,"MAP -1.8,17; TEXT '70'; MAP -0.8,17; TEXT '10'; MAP 0,16; DAP 16,16;"
 W !,"MAP -1.8,18; TEXT '68'; MAP -0.8,18; TEXT '8'; MAP 0,17; DAP 16,17;"
 W !,"MAP -1.8,19; TEXT '66'; MAP -0.8,19; TEXT '6'; MAP 0,18; DAP 16,18;"
 W !,"MAP 0,19; DAP 16,19;"
BOX2 ;
 W !,"FONT 57; MAP -3,20.3; TEXT 'Respiration'; MAP -3,20.7; TEXT 'Pulse Oximetry';"
 W !,"MAP -2.5,21.1; TEXT 'L/Min'; MAP -2.5,21.5; TEXT %1; MAP -2.5,21.9; TEXT 'Method';"
 W !,"MAP -3,22.3; TEXT 'Pulse';"
VERT W !,"SPD 0.05;" S I(1)="" F I=1:1:9 S I(1)=I(1)_"MAP "_(1.6*I)_",0; DAP "_(1.6*I)_",22.8;"
 W !,I(1)
 W !,"SPD 0.01; MAP -3,20.4; DAP 16,20.4; MAP 16,20.8; DAP -3,20.8; MAP -3,21.2; DAP 16,21.2; MAP 16,21.6; DAP -3,21.6;"
 W !,"MAP -3,22; DAP 16,22; MAP 16,22.4; DAP -3,22.4;"
 W !,"MAP -3,23.2; TEXT 'R: Respiration          POx: Pulse Oximetry          * - Abnormal value          ** - Abnormal value off of graph';"
FORM W !,"MAP 10,24.4; FONT 56; TEXT 'Medical Record'; MAP 10,24.8; TEXT 'Pulse Oximetry/Respiration Graph'; MAP 10,25.2; TEXT 'SF 512';"
 W !,"ENDM;"
DATE W !,"MCRO DATE; FONT 56;" S J=0.4 D WRTEXT^GMVBP2
 W !,"ENDM;"
TIME W !,"MCRO TIME;" S J=0.8 D WRTEXT^GMVBP2
 W !,"ENDM;"
 Q
