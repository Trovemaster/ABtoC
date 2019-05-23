C
      SUBROUTINE GENDIP ( DMPARR , DMPERP , DMMPXR )
      IMPLICIT REAL*8 (A-H,O-Z)
C             :
C DATE        : 18.02.1988
C AUTHOR      : PER JENSEN
C UPDATES     :
C LANGUAGE    : FORTRAN
C PURPOSE     : GENERATION OF THE EXPANSION COEFFICIENTS OF THE
C             : ELECTRONIC DIPOLE MOMENT COMPONENTS
C             : IN THE RHO DEPENDENT FORM.
C             : EXPANSION COEFFICIENTS FOR R SUB I'S ARE CALCULATED.
C             : THE CODE IS GENERATED BY REDUCE.
C             :
C SUBPROGRAMS :
C      CALLED :
C             :
C    FOR EXPLANATIONS OF ARRAY CONTENTS SEE COMMENTS IN
C    SUBROUTINE TRNSDP
C
C
C
C
C
      INTEGER V1 ,V2, V3 , V2P1,
     1        NTEST 
C


C

      REAL*8 DMPARR(15),DMPERP(15),AUXILI(15),DMMPXR(15),
     1       SBARS(6),SBARR(15),AUXIR(15),AUXI2(15),REC12(15),
     1       REC32(15)
C

      REAL*8 DIPACP(53),
     1       DIPACQ(53),
     2       DIPBCX(53)

      COMMON /DIPAC/ DIPACP,DIPACQ
      COMMON /DIPBC/ DIPBCX 
C
      include 'molcul.h'
      include 'value.h'
      include 'dipole.h'
c      include 'dimen.h'
      include 'crcoef.h'


C

      SBARS(1)=SR*RE12*RE32
      SBARS(2)=
     .    (SR*(M**2*M2**2*RE32+M*CR**2*M3*M1*M2*RE32+M*CR*
     . M3*M1*M2*RE12+M*CR*M1*M2**2*RE12+2.*M*SR**2*M3*M1*M2
     . *RE32+CR**2*SR**2*M3**2*M1**2*RE32+CR*SR**2*M3**2*M1
     . **2*RE12+CR*SR**2*M3*M1**2*M2*RE12+SR**4*M3**2*M1**2
     . *RE32))/(M**2*M2**2+2.*M*SR**2*M3*M1*M2+SR**4*M3**2*
     . M1**2)
      SBARS(3)=
     .    (SR*(M**2*M2**2*RE12+M*CR**2*M3*M1*M2*RE12+M*CR*
     . M3*M1*M2*RE32+M*CR*M3*M2**2*RE32+2.*M*SR**2*M3*M1*M2
     . *RE12+CR**2*SR**2*M3**2*M1**2*RE12+CR*SR**2*M3**2*M1
     . **2*RE32+CR*SR**2*M3**2*M1*M2*RE32+SR**4*M3**2*M1**2
     . *RE12))/(M**2*M2**2+2.*M*SR**2*M3*M1*M2+SR**4*M3**2*
     . M1**2)
      SBARS(4)=
     .     (M*CR*SR*M1*M2*(M3+M2))/(M**2*M2**2+2.*M*SR**2*
     . M3*M1*M2+SR**4*M3**2*M1**2)
      SBARS(5)=
     .     (M*CR*SR*M3*M2*(M1+M2))/(M**2*M2**2+2.*M*SR**2*
     . M3*M1*M2+SR**4*M3**2*M1**2)
      SBARS(6)=
     .     (SR*(M**2*M2**2+2.*M*CR**2*M3*M1*M2+2.*M*SR**2*
     . M3*M1*M2+CR**2*SR**2*M3**2*M1**2+SR**4*M3**2*M1**2-
     . SR**2*M3**2*M1**2-SR**2*M3**2*M1*M2-SR**2*M3*M1**2*
     . M2-SR**2*M3*M1*M2**2))/(M**2*M2**2+2.*M*SR**2*M3*M1*
     . M2+SR**4*M3**2*M1**2)
C
      CALL TRNSSR ( SBARS , AUXIR )
C
      REC32( 1)=1.0D+00/RE32
      REC32( 2)=0.0D+00
      REC32( 3)=-1.0D+00/RE32**2
      REC32( 4)=0.0D+00
      REC32( 5)=1.0D+00/RE32**3
      REC32( 6)=0.0D+00
      REC32( 7)=0.0D+00
      REC32( 8)=-1.0D+00/RE32**4
      REC32( 9)=0.0D+00
      REC32(10)=0.0D+00
      REC32(11)=0.0D+00
      REC32(12)=1.0D+00/RE32**5
      REC32(13)=0.0D+00
      REC32(14)=0.0D+00
      REC32(15)=0.0D+00
C
      CALL PLMLT2 ( REC32 , AUXIR  , AUXI2  )
C
      REC12( 1)=1.0D+00/RE12
      REC12( 2)=-1.0D+00/RE12**2
      REC12( 3)=0.0D+00
      REC12( 4)=1.0D+00/RE12**3
      REC12( 5)=0.0D+00
      REC12( 6)=0.0D+00
      REC12( 7)=-1.0D+00/RE12**4
      REC12( 8)=0.0D+00
      REC12( 9)=0.0D+00
      REC12(10)=0.0D+00
      REC12(11)=1.0D+00/RE12**5
      REC12(12)=0.0D+00
      REC12(13)=0.0D+00
      REC12(14)=0.0D+00
      REC12(15)=0.0D+00
C
      CALL PLMLT2 ( REC12 , AUXI2  , SBARR  )
C
C

      IF (SYMM) THEN

C
C     PARR-Komponente 
C

      CORO=1.0D+00-COS(RHO)
      CALL TRNSDP ( DIPACP , DMPARR )

C
C     PERP-Komponente 
C

      CORO=1.0D+00-COS(RHO)
      CALL TRNSDP ( DIPACQ , AUXILI )
      CALL PLMLT2 ( SBARR , AUXILI , DMPERP )

C
C     x-Komponente zwischen den beiden Funktionen     
C

      CORO=1.0D+00-COS(RHO)
      CALL TRNSDP(DIPBCX,AUXILI)
      CALL PLMLT2 ( SBARR , AUXILI , DMMPXR) 
C

      ELSE 

C
C     PARR-Komponente 
C

      CORO=1.0D+00-COS(RHO)
      CALL TRNSDP ( DIPACP , AUXILI )
      CALL PLMLT2 ( SBARR , AUXILI , DMPARR )

C
C     PERP-Komponente 
C

      CORO=1.0D+00-COS(RHO)
      CALL TRNSDP ( DIPACQ , DMPERP )

C
C     x-Komponente zwischen den beiden Funktionen     
C
      CORO=1.0D+00-COS(RHO)
      CALL TRNSDP(DIPBCX,DMMPXR)

      ENDIF

C
      RETURN
      END
C
C***************************************************************C
C***************************************************************C
      SUBROUTINE PLMLT2 ( FAC1 , FAC2 , PROD )
C***************************************************************C
      IMPLICIT REAL*8 (A-H,O-Z)
C
      REAL*8   FAC1(15),FAC2(15),PROD(15)

      REAL*8   PA0,PA1,PA3,PA11,PA33,PA13,PA111,PA333,PA113,
     1         PA133,PA1111,PA3333,PA1113,PA1333,PA1133,
     2         PB0,PB1,PB3,PB11,PB33,PB13,PB111,PB333,PB113,
     3         PB133,PB1111,PB3333,PB1113,PB1333,PB1133


C
      PA0    =   FAC1( 1)
      PA1    =   FAC1( 2)
      PA3    =   FAC1( 3)
      PA11   =   FAC1( 4)
      PA33   =   FAC1( 5)
      PA13   =   FAC1( 6)
      PA111  =   FAC1( 7)
      PA333  =   FAC1( 8)
      PA113  =   FAC1( 9)
      PA133  =   FAC1(10)
      PA1111 =   FAC1(11)
      PA3333 =   FAC1(12)
      PA1113 =   FAC1(13)
      PA1333 =   FAC1(14)
      PA1133 =   FAC1(15)
C
      PB0    =   FAC2( 1)
      PB1    =   FAC2( 2)
      PB3    =   FAC2( 3)
      PB11   =   FAC2( 4)
      PB33   =   FAC2( 5)
      PB13   =   FAC2( 6)
      PB111  =   FAC2( 7)
      PB333  =   FAC2( 8)
      PB113  =   FAC2( 9)
      PB133  =   FAC2(10)
      PB1111 =   FAC2(11)
      PB3333 =   FAC2(12)
      PB1113 =   FAC2(13)
      PB1333 =   FAC2(14)
      PB1133 =   FAC2(15)
C
      PROD( 1)=PA0*PB0
      PROD( 2)=PA0*PB1+PA1*PB0
      PROD( 3)=PA0*PB3+PA3*PB0
      PROD( 4)=PA0*PB11+PA1*PB1+PA11*PB0
      PROD( 5)=PA0*PB33+PA3*PB3+PA33*PB0
      PROD( 6)=PA0*PB13+PA1*PB3+PA13*PB0+PA3*PB1
      PROD( 7)=PA0*PB111+PA1*PB11+PA11*PB1+PA111*
     . PB0
      PROD( 8)=PA0*PB333+PA3*PB33+PA33*PB3+PA333*
     . PB0
      PROD( 9)=PA0*PB113+PA1*PB13+PA11*PB3+PA113*
     . PB0+PA13*PB1+PA3*PB11
      PROD(10)=PA0*PB133+PA1*PB33+PA13*PB3+PA133*
     . PB0+PA3*PB13+PA33*PB1
      PROD(11)=PA0*PB1111+PA1*PB111+PA11*PB11+PA111
     . *PB1+PA1111*PB0
      PROD(12)=PA0*PB3333+PA3*PB333+PA33*PB33+PA333
     . *PB3+PA3333*PB0
      PROD(13)=PA0*PB1113+PA1*PB113+PA11*PB13+PA111
     . *PB3+PA1113*PB0+PA113*PB1+PA13*PB11+PA3*
     . PB111
      PROD(14)=PA0*PB1333+PA1*PB333+PA13*PB33+PA133
     . *PB3+PA1333*PB0+PA3*PB133+PA33*PB13+PA333
     . *PB1
      PROD(15)=PA0*PB1133+PA1*PB133+PA11*PB33+PA113
     . *PB3+PA1133*PB0+PA13*PB13+PA133*PB1+PA3*
     . PB113+PA33*PB11
       RETURN
       END
C
C
      SUBROUTINE RECCOS ( COSREC )
      IMPLICIT REAL*8 (A-H,O-Z)
C             :
C DATE        : 18.02.1988
C AUTHOR      : PER JENSEN
C UPDATES     :
C LANGUAGE    : FORTRAN
C PURPOSE     : GENERATION OF THE EXPANSION COEFFICIENTS OF THE
C             : FACTORS COS(RHOBAR/2) AND SIN(RHOBAR/2).
C             : EXPANSION COEFFICIENTS FOR R SUB I'S ARE CALCULATED.
C             : THE CODE IS GENERATED BY REDUCE.
C             :
C SUBPROGRAMS :
C      CALLED :
C             :
C    FOR EXPLANATIONS OF ARRAY CONTENTS SEE COMMENTS IN
C    SUBROUTINE TRNSDP
C
C
      REAL*8   COSREC(15),FACTOR
C

      REAL*8   PA1,PA3,PA11,PA33,PA13,PA111,PA333,PA113,
     1         PA133,PA1111,PA3333,PA1113,PA1333,PA1133

      include 'value.h'
      include 'crcoef.h'
C
C
C
C***********************************************************************
C                                                           -1
C     GENERATE EXPANSION COEFFICIENTS FOR SQRT(2 COS RHOBAR)
C
C***********************************************************************
C
      FACTOR=1.0D+00/(1.0D+00+CR)
      PA1    = -FACTOR*CR1
      PA3    = -FACTOR*CR3
      PA11   = -FACTOR*CR11
      PA33   = -FACTOR*CR33
      PA13   = -FACTOR*CR13
      PA111  = -FACTOR*CR111
      PA333  = -FACTOR*CR333
      PA113  = -FACTOR*CR113
      PA133  = -FACTOR*CR133
      PA1111 = -FACTOR*CR1111
      PA3333 = -FACTOR*CR3333
      PA1113 = -FACTOR*CR1113
      PA1333 = -FACTOR*CR1333
      PA1133 = -FACTOR*CR1133
      FACTOR=1.0D+00/DSQRT((1.0D+00+CR)*2.0D+00)
C
      COSREC( 1)=FACTOR
      COSREC( 2)=FACTOR*
     . (-PA1)/2.E0
      COSREC( 3)=FACTOR*
     . (-PA3)/2.E0
      COSREC( 4)=FACTOR*
     . (3.E0*PA1**2-4.E0*PA11)/8.E0
      COSREC( 5)=FACTOR*
     . (3.E0*PA3**2-4.E0*PA33)/8.E0
      COSREC( 6)=FACTOR*
     . (3.E0*PA1*PA3-2.E0*PA13)/4.E0
      COSREC( 7)=FACTOR*
     . (-5.E0*PA1**3+12.E0*PA1*PA11-8.E0*PA111)/16.E0
      COSREC( 8)=FACTOR*
     . (-5.E0*PA3**3+12.E0*PA3*PA33-8.E0*PA333)/16.E0
      COSREC( 9)=FACTOR*
     . (-15.E0*PA1**2*PA3+12.E0*PA1*PA13+12.E0*PA11*PA3-8.E0*PA113
     . )/16.E0
      COSREC(10)=FACTOR*
     . (-15.E0*PA1*PA3**2+12.E0*PA1*PA33+12.E0*PA13*PA3-8.E0*PA133
     . )/16.E0
      COSREC(11)=FACTOR*
     . (25.E0*PA1**4-120.*PA1**2*PA11+96.E0*PA1*PA111+48.E0*
     . PA11**2-64.E0*PA1111)/128.E0
      COSREC(12)=FACTOR*
     . (25.E0*PA3**4-120.*PA3**2*PA33+96.E0*PA3*PA333+48.E0*
     . PA33**2-64.E0*PA3333)/128.E0
      COSREC(13)=FACTOR*
     . (25.E0*PA1**3*PA3-30.*PA1**2*PA13-60.*PA1*PA11*PA3+
     . 24.E0*PA1*PA113+24.E0*PA11*PA13+24.E0*PA111*PA3-16.E0*
     . PA1113)/32.E0
      COSREC(14)=FACTOR*
     . (25.E0*PA1*PA3**3-60.*PA1*PA3*PA33+24.E0*PA1*PA333-30.
     . *PA13*PA3**2+24.E0*PA13*PA33+24.E0*PA133*PA3-16.E0*
     . PA1333)/32.E0
      COSREC(15)=FACTOR*
     . (75.E0*PA1**2*PA3**2-60.*PA1**2*PA33-120.*PA1*PA13*
     . PA3+48.E0*PA1*PA133-60.*PA11*PA3**2+48.E0*PA11*PA33+
     . 48.E0*PA113*PA3-32.E0*PA1133+24.E0*PA13**2)/64.E0
      RETURN
      END
C
C
      SUBROUTINE TRNSDP ( CINPUT , DPCOEF )
      IMPLICIT REAL*8 (A-H,O-Z)
C             :
C DATE        : 16.02.1988
C AUTHOR      : PER JENSEN
C UPDATES     :
C LANGUAGE    : FORTRAN
C PURPOSE     : TRANSFORMATION OF THE ELECTRONIC DIPOLE COMPONENTS
C             : FROM THE RHO BAR DEPENDENT FORM TO THE RHO
C             : DEPENDENT FORM.
C             : EXPANSION COEFFICIENTS FOR R SUB I'S ARE CALCULATED.
C             : THE CODE IS GENERATED BY REDUCE.
C             :
C SUBPROGRAMS :
C      CALLED :
C             :
C    THE ARRAY CONTAINS THE COEFFICIENTS OF THE FOLLOWING
C    QUANTITIES:
C                         I  THE ELEMENT CINPUT(I) IS THE
C                         I  COEFFICIENT OF:
C                         I
C                         I              J       K       L
C    I        DPCOEF(I)   I  I       CORO     DR1     DR3
C  -------------------------------------------------------------
C    1        1           I  1       0        0       0
C    2        R1          I  2       1        0       0
C    3        R3          I  3       2        0       0
C    4        R1**2       I  4       3        0       0
C    5        R3**2       I  5       4        0       0
C    6        R1*R3       I  6       5        0       0
C    7        R1**3       I  7       6        0       0
C    8        R3**3       I  8       7        0       0
C    9        R1**2*R3    I  9       8        0       0
C   10        R1*R3**2    I 10       0        1       0
C   11        R1**4       I 11       1        1       0
C   12        R3**4       I 12       2        1       0
C   13        R1**3*R3    I 13       3        1       0
C   14        R1*R3**3    I 14       4        1       0
C   15        R1**2*R3**2 I 15       0        0       1
C                         I 16       1        0       1
C                         I 17       2        0       1
C                         I 18       3        0       1
C                         I 19       4        0       1
C                         I 20       0        2       0
C                         I 21       1        2       0
C                         I 22       2        2       0
C                         I 23       3        2       0
C                         I 24       0        0       2
C                         I 25       1        0       2
C                         I 26       2        0       2
C                         I 27       3        0       2
C                         I 28       0        1       1
C                         I 29       1        1       1
C                         I 30       2        1       1
C                         I 31       3        1       1
C                         I 32       0        3       0
C                         I 33       1        3       0
C                         I 34       2        3       0
C                         I 35       0        0       3
C                         I 36       1        0       3
C                         I 37       2        0       3
C                         I 38       0        2       1
C                         I 39       1        2       1
C                         I 40       2        2       1
C                         I 41       0        1       2
C                         I 42       1        1       2
C                         I 43       2        1       2
C                         I 44       0        4       0
C                         I 45       1        4       0
C                         I 46       0        0       4
C                         I 47       1        0       4
C                         I 48       0        3       1
C                         I 49       1        3       1
C                         I 50       0        1       3
C                         I 51       1        1       3
C                         I 52       0        2       2
C                         I 53       1        2       2
C

C
C
      INTEGER V1 ,V2, V3 , V2P1,
     1       NTEST 
C
C
C
      
      REAL*8  CORO2,CORO3,CORO4,CORO5,CORO6,CORO7,
     4       Q1,Q3,Q11,Q33,Q13,
     5       Q111,Q333,Q113,Q133,
     6       Q1111,Q3333,Q1113,Q1333,Q1133,
     7       DPCOEF(15),ANS1,CINPUT(53)

      REAL*8 Q0,Z01,Z02,Z03,Z04,Z05,Z06,Z07,Z08,
     1       Z1A,Z1A1,Z1A2,Z1A3,Z1A4,Z3A,Z3A1,Z3A2,
     2       Z3A3,Z3A4,Z11A,Z11A1,Z11A2,Z11A3,Z33A,
     3       Z33A1,Z33A2,Z33A3,Z13A,Z13A1,Z13A2,Z13A3,
     4       Z111A,Z111A1,Z111A2,Z333A,Z333A1,Z333A2,
     5       Z113A,Z113A1,Z113A2,Z133A,Z133A1,Z133A2,
     6       Z1111,Z1111A,Z3333,Z3333A,Z1113,Z1113A,
     7       Z1333,Z1333A,Z1133,Z1133A

      REAL*8  C1,C3,C11,C33,C13,C111,C333,C113,C133

      REAL*8 W1,W3,W11,W33,W13,W111,W333,W113,W133,
     1       W1111,W3333,W1113,W1333,W1133





      include 'value.h'
      include 'molcul.h'
c      include 'dimen.h'
      include 'crcoef.h'

C
      Q0 =CINPUT( 1)
      Z01=CINPUT( 2)
      Z02=CINPUT( 3)
      Z03=CINPUT( 4)
      Z04=CINPUT( 5)
      Z05=CINPUT( 6)
      Z06=CINPUT( 7)
      Z07=CINPUT( 8)
      Z08=CINPUT( 9)
      Z1A  = CINPUT(10)
      Z1A1 = CINPUT(11)
      Z1A2 = CINPUT(12)
      Z1A3 = CINPUT(13)
      Z1A4 = CINPUT(14)
      Z3A  = CINPUT(15)
      Z3A1 = CINPUT(16)
      Z3A2 = CINPUT(17)
      Z3A3 = CINPUT(18)
      Z3A4 = CINPUT(19)
      Z11A  = CINPUT(20)
      Z11A1 = CINPUT(21)
      Z11A2 = CINPUT(22)
      Z11A3 = CINPUT(23)
      Z33A  = CINPUT(24)
      Z33A1 = CINPUT(25)
      Z33A2 = CINPUT(26)
      Z33A3 = CINPUT(27)
      Z13A  = CINPUT(28)
      Z13A1 = CINPUT(29)
      Z13A2 = CINPUT(30)
      Z13A3 = CINPUT(31)
      Z111A  = CINPUT(32)
      Z111A1 = CINPUT(33)
      Z111A2 = CINPUT(34)
      Z333A  = CINPUT(35)
      Z333A1 = CINPUT(36)
      Z333A2 = CINPUT(37)
      Z113A  = CINPUT(38)
      Z113A1 = CINPUT(39)
      Z113A2 = CINPUT(40)
      Z133A  = CINPUT(41)
      Z133A1 = CINPUT(42)
      Z133A2 = CINPUT(43)
      Z1111   = CINPUT(44)
      Z1111A  = CINPUT(45)
      Z3333   = CINPUT(46)
      Z3333A  = CINPUT(47)
      Z1113   = CINPUT(48)
      Z1113A  = CINPUT(49)
      Z1333   = CINPUT(50)
      Z1333A  = CINPUT(51)
      Z1133   = CINPUT(52)
      Z1133A  = CINPUT(53)
      CORO2=CORO*CORO
      CORO3=CORO2*CORO
      CORO4=CORO3*CORO
      CORO5=CORO4*CORO
      CORO6=CORO5*CORO
      CORO7=CORO6*CORO
      Q1=CORO*(8.E0*CORO6*Z08+7.E0*CORO5*Z07+6.E0*CORO4*Z06+5.E0*
     1 CORO3*Z05+4.E0*CORO2*Z04+3.E0*CORO*Z03+2.E0*Z02)*CR1
     2 +Z01*CR1
      Q3=CORO*(8.E0*CORO6*Z08+7.E0*CORO5*Z07+6.E0*CORO4*Z06+5.E0*
     1 CORO3*Z05+4.E0*CORO2*Z04+3.E0*CORO*Z03+2.E0*Z02)*CR3
     2 +Z01*CR3
      Q11=8.E0*CR11*CORO7*Z08+7.E0*CR11*CORO6*Z07+6.E0*CR11*CORO**
     1 5*Z06+5.E0*CR11*CORO4*Z05+4.E0*CR11*CORO3*Z04+3.E0*CR11*
     1 CORO2*Z03+2.E0*CR11*CORO*Z02+28.E0*CR1**2*CORO6*Z08+21.E0*
     1 CR1**2*CORO5*Z07+15.E0*CR1**2*CORO4*Z06+10.E0*CR1**2*CORO
     1 **3*Z05+6.E0*CR1**2*CORO2*Z04+3.E0*CR1**2*CORO*Z03+CR1**2*
     1 Z02+Z01*CR11
      Q33=8.E0*CR33*CORO7*Z08+7.E0*CR33*CORO6*Z07+6.E0*CR33*CORO**
     1 5*Z06+5.E0*CR33*CORO4*Z05+4.E0*CR33*CORO3*Z04+3.E0*CR33*
     1 CORO2*Z03+2.E0*CR33*CORO*Z02+28.E0*CR3**2*CORO6*Z08+21.E0*
     1 CR3**2*CORO5*Z07+15.E0*CR3**2*CORO4*Z06+10.E0*CR3**2*CORO
     1 **3*Z05+6.E0*CR3**2*CORO2*Z04+3.E0*CR3**2*CORO*Z03+CR3**2*
     1 Z02+Z01*CR33
      Q13=8.E0*CR13*CORO7*Z08+7.E0*CR13*CORO6*Z07+6.E0*CR13*CORO**
     1 5*Z06+5.E0*CR13*CORO4*Z05+4.E0*CR13*CORO3*Z04+3.E0*CR13*
     1 CORO2*Z03+2.E0*CR13*CORO*Z02+56.E0*CR3*CR1*CORO6*Z08+42.E0*
     1 CR3*CR1*CORO5*Z07+30.E0*CR3*CR1*CORO4*Z06+20.E0*CR3*CR1*
     1 CORO3*Z05+12.E0*CR3*CR1*CORO2*Z04+6.E0*CR3*CR1*CORO*Z03+
     1 2.E0*CR3*CR1*Z02+Z01*CR13
      Q111=8.E0*CR111*CORO7*Z08+7.E0*CR111*CORO6*Z07+6.E0*CR111*
     1 CORO5*Z06+5.E0*CR111*CORO4*Z05+4.E0*CR111*CORO3*Z04+3.E0*
     1 CR111*CORO2*Z03+2.E0*CR111*CORO*Z02+56.E0*CR11*CR1*CORO6*
     1 Z08+42.E0*CR11*CR1*CORO5*Z07+30.E0*CR11*CR1*CORO4*Z06+20.E0
     1 *CR11*CR1*CORO3*Z05+12.E0*CR11*CR1*CORO2*Z04+6.E0*CR11*
     1 CR1*CORO*Z03+2.E0*CR11*CR1*Z02+56.E0*CR1**3*CORO5*Z08+35.E0*
     1 CR1**3*CORO4*Z07+20.E0*CR1**3*CORO3*Z06+10.E0*CR1**3*CORO
     1 **2*Z05+4.E0*CR1**3*CORO*Z04+CR1**3*Z03+Z01*CR111
      Q333=8.E0*CR333*CORO7*Z08+7.E0*CR333*CORO6*Z07+6.E0*CR333*
     1 CORO5*Z06+5.E0*CR333*CORO4*Z05+4.E0*CR333*CORO3*Z04+3.E0*
     1 CR333*CORO2*Z03+2.E0*CR333*CORO*Z02+56.E0*CR33*CR3*CORO6*
     1 Z08+42.E0*CR33*CR3*CORO5*Z07+30.E0*CR33*CR3*CORO4*Z06+20.E0
     1 *CR33*CR3*CORO3*Z05+12.E0*CR33*CR3*CORO2*Z04+6.E0*CR33*
     1 CR3*CORO*Z03+2.E0*CR33*CR3*Z02+56.E0*CR3**3*CORO5*Z08+35.E0*
     1 CR3**3*CORO4*Z07+20.E0*CR3**3*CORO3*Z06+10.E0*CR3**3*CORO
     1 **2*Z05+4.E0*CR3**3*CORO*Z04+CR3**3*Z03+Z01*CR333
      Q113=8.E0*CR113*CORO7*Z08+7.E0*CR113*CORO6*Z07+6.E0*CR113*
     1 CORO5*Z06+5.E0*CR113*CORO4*Z05+4.E0*CR113*CORO3*Z04+3.E0*
     1 CR113*CORO2*Z03+2.E0*CR113*CORO*Z02+56.E0*CR13*CR1*CORO6*
     1 Z08+42.E0*CR13*CR1*CORO5*Z07+30.E0*CR13*CR1*CORO4*Z06+20.E0
     1 *CR13*CR1*CORO3*Z05+12.E0*CR13*CR1*CORO2*Z04+6.E0*CR13*
     1 CR1*CORO*Z03+2.E0*CR13*CR1*Z02+56.E0*CR11*CR3*CORO6*Z08+42.E0
     1 *CR11*CR3*CORO5*Z07+30.E0*CR11*CR3*CORO4*Z06+20.E0*CR11*
     1 CR3*CORO3*Z05+12.E0*CR11*CR3*CORO2*Z04+6.E0*CR11*CR3*CORO
     1 *Z03+2.E0*CR11*CR3*Z02+168.E0*CR3*CR1**2*CORO5*Z08+105.E0*CR3
     1 *CR1**2*CORO4*Z07+60.E0*CR3*CR1**2*CORO3*Z06+30.E0*CR3*
     1 CR1**2*CORO2*Z05+12.E0*CR3*CR1**2*CORO*Z04+3.E0*CR3*CR1**2*
     1 Z03+Z01*CR113
      Q133=8.E0*CR133*CORO7*Z08+7.E0*CR133*CORO6*Z07+6.E0*CR133*
     1 CORO5*Z06+5.E0*CR133*CORO4*Z05+4.E0*CR133*CORO3*Z04+3.E0*
     1 CR133*CORO2*Z03+2.E0*CR133*CORO*Z02+56.E0*CR13*CR3*CORO6*
     1 Z08+42.E0*CR13*CR3*CORO5*Z07+30.E0*CR13*CR3*CORO4*Z06+20.E0
     1 *CR13*CR3*CORO3*Z05+12.E0*CR13*CR3*CORO2*Z04+6.E0*CR13*
     1 CR3*CORO*Z03+2.E0*CR13*CR3*Z02+56.E0*CR33*CR1*CORO6*Z08+42.E0
     1 *CR33*CR1*CORO5*Z07+30.E0*CR33*CR1*CORO4*Z06+20.E0*CR33*
     1 CR1*CORO3*Z05+12.E0*CR33*CR1*CORO2*Z04+6.E0*CR33*CR1*CORO
     1 *Z03+2.E0*CR33*CR1*Z02+168.E0*CR3**2*CR1*CORO5*Z08+105.E0*CR3
     1 **2*CR1*CORO4*Z07+60.E0*CR3**2*CR1*CORO3*Z06+30.E0*CR3**2
     1 *CR1*CORO2*Z05+12.E0*CR3**2*CR1*CORO*Z04+3.E0*CR3**2*CR1*
     1 Z03+Z01*CR133
      Q1111=8.E0*CR1111*CORO7*Z08+7.E0*CR1111*CORO6*Z07+6.E0*
     1 CR1111*CORO5*Z06+5.E0*CR1111*CORO4*Z05+4.E0*CR1111*CORO**
     1 3*Z04+3.E0*CR1111*CORO2*Z03+2.E0*CR1111*CORO*Z02+56.E0*CR111*
     1 CR1*CORO6*Z08+42.E0*CR111*CR1*CORO5*Z07+30.E0*CR111*CR1*
     1 CORO4*Z06+20.E0*CR111*CR1*CORO3*Z05+12.E0*CR111*CR1*CORO
     1 **2*Z04+6.E0*CR111*CR1*CORO*Z03+2.E0*CR111*CR1*Z02+28.E0*CR11**
     1 2*CORO6*Z08+21.E0*CR11**2*CORO5*Z07+15.E0*CR11**2*CORO4
     1 *Z06+10.E0*CR11**2*CORO3*Z05+6.E0*CR11**2*CORO2*Z04+3.E0*
     1 CR11**2*CORO*Z03+CR11**2*Z02+168.E0*CR11*CR1**2*CORO5*Z08
     1 +105.E0*CR11*CR1**2*CORO4*Z07+60.E0*CR11*CR1**2*CORO3*Z06
     1 +30.E0*CR11*CR1**2*CORO2*Z05+12.E0*CR11*CR1**2*CORO*Z04+3.E0*
     1 CR11*CR1**2*Z03+70.E0*CR1**4*CORO4*Z08+35.E0*CR1**4*CORO3
     1 *Z07+15.E0*CR1**4*CORO2*Z06+5.E0*CR1**4*CORO*Z05+CR1**4*Z04
     1 +Z01*CR1111
      Q3333=8.E0*CR3333*CORO7*Z08+7.E0*CR3333*CORO6*Z07+6.E0*
     1 CR3333*CORO5*Z06+5.E0*CR3333*CORO4*Z05+4.E0*CR3333*CORO**
     1 3*Z04+3.E0*CR3333*CORO2*Z03+2.E0*CR3333*CORO*Z02+56.E0*CR333*
     1 CR3*CORO6*Z08+42.E0*CR333*CR3*CORO5*Z07+30.E0*CR333*CR3*
     1 CORO4*Z06+20.E0*CR333*CR3*CORO3*Z05+12.E0*CR333*CR3*CORO
     1 **2*Z04+6.E0*CR333*CR3*CORO*Z03+2.E0*CR333*CR3*Z02+28.E0*CR33**
     1 2*CORO6*Z08+21.E0*CR33**2*CORO5*Z07+15.E0*CR33**2*CORO4
     1 *Z06+10.E0*CR33**2*CORO3*Z05+6.E0*CR33**2*CORO2*Z04+3.E0*
     1 CR33**2*CORO*Z03+CR33**2*Z02+168.E0*CR33*CR3**2*CORO5*Z08
     1 +105.E0*CR33*CR3**2*CORO4*Z07+60.E0*CR33*CR3**2*CORO3*Z06
     1 +30.E0*CR33*CR3**2*CORO2*Z05+12.E0*CR33*CR3**2*CORO*Z04+3.E0*
     1 CR33*CR3**2*Z03+70.E0*CR3**4*CORO4*Z08+35.E0*CR3**4*CORO3
     1 *Z07+15.E0*CR3**4*CORO2*Z06+5.E0*CR3**4*CORO*Z05+CR3**4*Z04
     1 +Z01*CR3333
      ANS1=280.E0*CR3*CR1**3*CORO4*Z08+140.E0*CR3*CR1**3*CORO3*
     1 Z07+60.E0*CR3*CR1**3*CORO2*Z06+20.E0*CR3*CR1**3*CORO*Z05+4.E0
     1 *CR3*CR1**3*Z04
      Q1113=8.E0*CR1113*CORO7*Z08+7.E0*CR1113*CORO6*Z07+6.E0*
     1 CR1113*CORO5*Z06+5.E0*CR1113*CORO4*Z05+4.E0*CR1113*CORO**
     1 3*Z04+3.E0*CR1113*CORO2*Z03+2.E0*CR1113*CORO*Z02+56.E0*CR113*
     1 CR1*CORO6*Z08+42.E0*CR113*CR1*CORO5*Z07+30.E0*CR113*CR1*
     1 CORO4*Z06+20.E0*CR113*CR1*CORO3*Z05+12.E0*CR113*CR1*CORO
     1 **2*Z04+6.E0*CR113*CR1*CORO*Z03+2.E0*CR113*CR1*Z02+56.E0*CR111*
     1 CR3*CORO6*Z08+42.E0*CR111*CR3*CORO5*Z07+30.E0*CR111*CR3*
     1 CORO4*Z06+20.E0*CR111*CR3*CORO3*Z05+12.E0*CR111*CR3*CORO
     1 **2*Z04+6.E0*CR111*CR3*CORO*Z03+2.E0*CR111*CR3*Z02+56.E0*CR13*
     1 CR11*CORO6*Z08+42.E0*CR13*CR11*CORO5*Z07+30.E0*CR13*CR11*
     1 CORO4*Z06+20.E0*CR13*CR11*CORO3*Z05+12.E0*CR13*CR11*CORO
     1 **2*Z04+6.E0*CR13*CR11*CORO*Z03+2.E0*CR13*CR11*Z02+168.E0*CR13*
     1 CR1**2*CORO5*Z08+105.E0*CR13*CR1**2*CORO4*Z07+60.E0*CR13*
     1 CR1**2*CORO3*Z06+30.E0*CR13*CR1**2*CORO2*Z05+12.E0*CR13*
     1 CR1**2*CORO*Z04+3.E0*CR13*CR1**2*Z03+336.E0*CR11*CR3*CR1*CORO
     1 **5*Z08+210.E0*CR11*CR3*CR1*CORO4*Z07+120.E0*CR11*CR3*CR1*
     1 CORO3*Z06+60.E0*CR11*CR3*CR1*CORO2*Z05+24.E0*CR11*CR3*CR1
     1 *CORO*Z04+6.E0*CR11*CR3*CR1*Z03+ANS1+Z01*CR1113
      ANS1=280.E0*CR3**3*CR1*CORO4*Z08+140.E0*CR3**3*CR1*CORO3*
     1 Z07+60.E0*CR3**3*CR1*CORO2*Z06+20.E0*CR3**3*CR1*CORO*Z05+4.E0
     1 *CR3**3*CR1*Z04
      Q1333=8.E0*CR1333*CORO7*Z08+7.E0*CR1333*CORO6*Z07+6.E0*
     1 CR1333*CORO5*Z06+5.E0*CR1333*CORO4*Z05+4.E0*CR1333*CORO**
     1 3*Z04+3.E0*CR1333*CORO2*Z03+2.E0*CR1333*CORO*Z02+56.E0*CR133*
     1 CR3*CORO6*Z08+42.E0*CR133*CR3*CORO5*Z07+30.E0*CR133*CR3*
     1 CORO4*Z06+20.E0*CR133*CR3*CORO3*Z05+12.E0*CR133*CR3*CORO
     1 **2*Z04+6.E0*CR133*CR3*CORO*Z03+2.E0*CR133*CR3*Z02+56.E0*CR333*
     1 CR1*CORO6*Z08+42.E0*CR333*CR1*CORO5*Z07+30.E0*CR333*CR1*
     1 CORO4*Z06+20.E0*CR333*CR1*CORO3*Z05+12.E0*CR333*CR1*CORO
     1 **2*Z04+6.E0*CR333*CR1*CORO*Z03+2.E0*CR333*CR1*Z02+56.E0*CR13*
     1 CR33*CORO6*Z08+42.E0*CR13*CR33*CORO5*Z07+30.E0*CR13*CR33*
     1 CORO4*Z06+20.E0*CR13*CR33*CORO3*Z05+12.E0*CR13*CR33*CORO
     1 **2*Z04+6.E0*CR13*CR33*CORO*Z03+2.E0*CR13*CR33*Z02+168.E0*CR13*
     1 CR3**2*CORO5*Z08+105.E0*CR13*CR3**2*CORO4*Z07+60.E0*CR13*
     1 CR3**2*CORO3*Z06+30.E0*CR13*CR3**2*CORO2*Z05+12.E0*CR13*
     1 CR3**2*CORO*Z04+3.E0*CR13*CR3**2*Z03+336.E0*CR33*CR3*CR1*CORO
     1 **5*Z08+210.E0*CR33*CR3*CR1*CORO4*Z07+120.E0*CR33*CR3*CR1*
     1 CORO3*Z06+60.E0*CR33*CR3*CR1*CORO2*Z05+24.E0*CR33*CR3*CR1
     1 *CORO*Z04+6.E0*CR33*CR3*CR1*Z03+ANS1+Z01*CR1333
      ANS1=168.E0*CR33*CR1**2*CORO5*Z08+105.E0*CR33*CR1**2*CORO4
     1 *Z07+60.E0*CR33*CR1**2*CORO3*Z06+30.E0*CR33*CR1**2*CORO2*
     1 Z05+12.E0*CR33*CR1**2*CORO*Z04+3.E0*CR33*CR1**2*Z03+168.E0*CR11
     1 *CR3**2*CORO5*Z08+105.E0*CR11*CR3**2*CORO4*Z07+60.E0*CR11
     1 *CR3**2*CORO3*Z06+30.E0*CR11*CR3**2*CORO2*Z05+12.E0*CR11*
     1 CR3**2*CORO*Z04+3.E0*CR11*CR3**2*Z03+420.E0*CR3**2*CR1**2*
     1 CORO4*Z08+210.E0*CR3**2*CR1**2*CORO3*Z07+90.E0*CR3**2*CR1
     1 **2*CORO2*Z06+30.E0*CR3**2*CR1**2*CORO*Z05+6.E0*CR3**2*CR1
     1 **2*Z04
      Q1133=8.E0*CR1133*CORO7*Z08+7.E0*CR1133*CORO6*Z07+6.E0*
     1 CR1133*CORO5*Z06+5.E0*CR1133*CORO4*Z05+4.E0*CR1133*CORO**
     1 3*Z04+3.E0*CR1133*CORO2*Z03+2.E0*CR1133*CORO*Z02+56.E0*CR133*
     1 CR1*CORO6*Z08+42.E0*CR133*CR1*CORO5*Z07+30.E0*CR133*CR1*
     1 CORO4*Z06+20.E0*CR133*CR1*CORO3*Z05+12.E0*CR133*CR1*CORO
     1 **2*Z04+6.E0*CR133*CR1*CORO*Z03+2.E0*CR133*CR1*Z02+56.E0*CR113*
     1 CR3*CORO6*Z08+42.E0*CR113*CR3*CORO5*Z07+30.E0*CR113*CR3*
     1 CORO4*Z06+20.E0*CR113*CR3*CORO3*Z05+12.E0*CR113*CR3*CORO2
     1 *Z04+6.E0*CR113*CR3*CORO*Z03+2.E0*CR113*CR3*Z02+28.E0*CR13**
     1 2*CORO6*Z08+21.E0*CR13**2*CORO5*Z07+15.E0*CR13**2*CORO4
     1 *Z06+10.E0*CR13**2*CORO3*Z05+6.E0*CR13**2*CORO2*Z04+3.E0*
     1 CR13**2*CORO*Z03+CR13**2*Z02+336.E0*CR13*CR3*CR1*CORO5*
     1 Z08+210.E0*CR13*CR3*CR1*CORO4*Z07+120.E0*CR13*CR3*CR1*CORO3
     1 *Z06+60.E0*CR13*CR3*CR1*CORO2*Z05+24.E0*CR13*CR3*CR1*
     1 CORO*Z04+6.E0*CR13*CR3*CR1*Z03+56.E0*CR33*CR11*CORO6*Z08+
     1 42.E0*CR33*CR11*CORO5*Z07+30.E0*CR33*CR11*CORO4*Z06+20.E0*
     1 CR33*CR11*CORO3*Z05+12.E0*CR33*CR11*CORO2*Z04+6.E0*CR33*
     1 CR11*CORO*Z03+2.E0*CR33*CR11*Z02+ANS1+Z01*CR1133
C
      C1=CR1
      C3=CR3
      C11=CR11
      C33=CR33
      C13=CR13
      C111=CR111
      C333=CR333
      C113=CR113
      C133=CR133
C
      W1=CORO**4*Z1A4+CORO**3*Z1A3+CORO**2*Z1A2+CORO*Z1A1+Z1A
      W3=CORO**4*Z3A4+CORO**3*Z3A3+CORO**2*Z3A2+CORO*Z3A1+Z3A
      W11=4.E0*CORO**3*C1*Z1A4+CORO**3*Z11A3+3.E0*CORO**2*C1*Z1A3+
     . CORO**2*Z11A2+2.E0*CORO*C1*Z1A2+CORO*Z11A1+C1*Z1A1+Z11A
      W33=4.E0*CORO**3*C3*Z3A4+CORO**3*Z33A3+3.E0*CORO**2*C3*Z3A3+
     . CORO**2*Z33A2+2.E0*CORO*C3*Z3A2+CORO*Z33A1+C3*Z3A1+Z33A
      W13=4.E0*CORO**3*C1*Z3A4+4.E0*CORO**3*C3*Z1A4+CORO**3*Z13A3+
     . 3.E0*CORO**2*C1*Z3A3+3.E0*CORO**2*C3*Z1A3+CORO**2*Z13A2+2.E0*
     . CORO*C1*Z3A2+2.E0*CORO*C3*Z1A2+CORO*Z13A1+C1*Z3A1+C3*Z1A1+
     . Z13A
      W111=4.E0*CORO**3*C11*Z1A4+6.E0*CORO**2*C1**2*Z1A4+3.E0*CORO**
     . 2*C1*Z11A3+3.E0*CORO**2*C11*Z1A3+CORO**2*Z111A2+3.E0*CORO*C1
     . **2*Z1A3+2.E0*CORO*C1*Z11A2+2.E0*CORO*C11*Z1A2+CORO*Z111A1+C1
     . **2*Z1A2+C1*Z11A1+C11*Z1A1+Z111A
      W333=4.E0*CORO**3*C33*Z3A4+6.E0*CORO**2*C3**2*Z3A4+3.E0*CORO**
     . 2*C3*Z33A3+3.E0*CORO**2*C33*Z3A3+CORO**2*Z333A2+3.E0*CORO*C3
     . **2*Z3A3+2.E0*CORO*C3*Z33A2+2.E0*CORO*C33*Z3A2+CORO*Z333A1+C3
     . **2*Z3A2+C3*Z33A1+C33*Z3A1+Z333A
      W113=4.E0*CORO**3*C11*Z3A4+4.E0*CORO**3*C13*Z1A4+6.E0*CORO**2*
     . C1**2*Z3A4+12.E0*CORO**2*C1*C3*Z1A4+3.E0*CORO**2*C1*Z13A3+3.E0*
     . CORO**2*C11*Z3A3+3.E0*CORO**2*C13*Z1A3+3.E0*CORO**2*C3*Z11A3+
     . CORO**2*Z113A2+3.E0*CORO*C1**2*Z3A3+6.E0*CORO*C1*C3*Z1A3+2.E0*
     . CORO*C1*Z13A2+2.E0*CORO*C11*Z3A2+2.E0*CORO*C13*Z1A2+2.E0*CORO*
     . C3*Z11A2+CORO*Z113A1+C1**2*Z3A2+2.E0*C1*C3*Z1A2+C1*Z13A1+
     . C11*Z3A1+C13*Z1A1+C3*Z11A1+Z113A
      W133=4.E0*CORO**3*C13*Z3A4+4.E0*CORO**3*C33*Z1A4+12.E0*CORO**2
     . *C1*C3*Z3A4+3.E0*CORO**2*C1*Z33A3+3.E0*CORO**2*C13*Z3A3+6.E0*
     . CORO**2*C3**2*Z1A4+3.E0*CORO**2*C3*Z13A3+3.E0*CORO**2*C33*
     . Z1A3+CORO**2*Z133A2+6.E0*CORO*C1*C3*Z3A3+2.E0*CORO*C1*Z33A2+
     . 2.E0*CORO*C13*Z3A2+3.E0*CORO*C3**2*Z1A3+2.E0*CORO*C3*Z13A2+
     . 2.E0*
     . CORO*C33*Z1A2+CORO*Z133A1+2.E0*C1*C3*Z3A2+C1*Z33A1+C13*Z3A1
     . +C3**2*Z1A2+C3*Z13A1+C33*Z1A1+Z133A
      W1111=4.E0*CORO**3*C111*Z1A4+12.E0*CORO**2*C1*C11*Z1A4+3.E0*
     . CORO**2*C11*Z11A3+3.E0*CORO**2*C111*Z1A3+4.E0*CORO*C1**3*Z1A4
     . +3.E0*CORO*C1**2*Z11A3+6.E0*CORO*C1*C11*Z1A3+2.E0*CORO*C1*
     . Z111A2+2.E0*CORO*C11*Z11A2+2.E0*CORO*C111*Z1A2+CORO*Z1111A +
     . C1**3*Z1A3+C1**2*Z11A2+2.E0*C1*C11*Z1A2+C1*Z111A1+C11*Z11A1
     . +C111*Z1A1+Z1111
      W3333=4.E0*CORO**3*C333*Z3A4+12.E0*CORO**2*C3*C33*Z3A4+3.E0*
     . CORO**2*C33*Z33A3+3.E0*CORO**2*C333*Z3A3+4.E0*CORO*C3**3*Z3A4
     . +3.E0*CORO*C3**2*Z33A3+6.E0*CORO*C3*C33*Z3A3+2.E0*CORO*C3*
     . Z333A2+2.E0*CORO*C33*Z33A2+2.E0*CORO*C333*Z3A2+CORO*Z3333A +
     . C3**3*Z3A3+C3**2*Z33A2+2.E0*C3*C33*Z3A2+C3*Z333A1+C33*Z33A1
     . +C333*Z3A1+Z3333
      W1113=4.E0*CORO**3*C111*Z3A4+4.E0*CORO**3*C113*Z1A4+12.E0*CORO
     . **2*C1*C11*Z3A4+12.E0*CORO**2*C1*C13*Z1A4+12.E0*CORO**2*C11*
     . C3*Z1A4+3.E0*CORO**2*C11*Z13A3+3.E0*CORO**2*C111*Z3A3+3.E0*CORO
     . **2*C113*Z1A3+3.E0*CORO**2*C13*Z11A3+4.E0*CORO*C1**3*Z3A4+12.E0
     . *CORO*C1**2*C3*Z1A4+3.E0*CORO*C1**2*Z13A3+6.E0*CORO*C1*C11*
     . Z3A3+6.E0*CORO*C1*C13*Z1A3+6.E0*CORO*C1*C3*Z11A3+2.E0*CORO*C1*
     . Z113A2+6.E0*CORO*C11*C3*Z1A3+2.E0*CORO*C11*Z13A2+2.E0*CORO*C111
     . *Z3A2+2.E0*CORO*C113*Z1A2+2.E0*CORO*C13*Z11A2+2.E0*CORO*C3*
     . Z111A2+CORO*Z1113A +C1**3*Z3A3+3.E0*C1**2*C3*Z1A3+C1**2*
     . Z13A2+2.E0*C1*C11*Z3A2+2.E0*C1*C13*Z1A2+2.E0*C1*C3*Z11A2+C1*
     . Z113A1+2.E0*C11*C3*Z1A2+C11*Z13A1+C111*Z3A1+C113*Z1A1+C13*
     . Z11A1+C3*Z111A1+Z1113
      W1333=4.E0*CORO**3*C133*Z3A4+4.E0*CORO**3*C333*Z1A4+12.E0*CORO
     . **2*C1*C33*Z3A4+12.E0*CORO**2*C13*C3*Z3A4+3.E0*CORO**2*C13*
     . Z33A3+3.E0*CORO**2*C133*Z3A3+12.E0*CORO**2*C3*C33*Z1A4+3.E0*
     . CORO**2*C33*Z13A3+3.E0*CORO**2*C333*Z1A3+12.E0*CORO*C1*C3**2*
     . Z3A4+6.E0*CORO*C1*C3*Z33A3+6.E0*CORO*C1*C33*Z3A3+2.E0*CORO*C1*
     . Z333A2+6.E0*CORO*C13*C3*Z3A3+2.E0*CORO*C13*Z33A2+2.E0*CORO*C133
     . *Z3A2+4.E0*CORO*C3**3*Z1A4+3.E0*CORO*C3**2*Z13A3+6.E0*CORO*C3*
     . C33*Z1A3+2.E0*CORO*C3*Z133A2+2.E0*CORO*C33*Z13A2+2.E0*CORO*C333
     . *Z1A2+CORO*Z1333A +3.E0*C1*C3**2*Z3A3+2.E0*C1*C3*Z33A2+2.E0*C1*
     . C33*Z3A2+C1*Z333A1+2.E0*C13*C3*Z3A2+C13*Z33A1+C133*Z3A1+C3
     . **3*Z1A3+C3**2*Z13A2+2.E0*C3*C33*Z1A2+C3*Z133A1+C33*Z13A1+
     . C333*Z1A1+Z1333
      W1133=4.E0*CORO**3*C113*Z3A4+4.E0*CORO**3*C133*Z1A4+12.E0*CORO
     . **2*C1*C13*Z3A4+12.E0*CORO**2*C1*C33*Z1A4+12.E0*CORO**2*C11*
     . C3*Z3A4+3.E0*CORO**2*C11*Z33A3+3.E0*CORO**2*C113*Z3A3+12.E0*
     . CORO**2*C13*C3*Z1A4+3.E0*CORO**2*C13*Z13A3+3.E0*CORO**2*C133*
     . Z1A3+3.E0*CORO**2*C33*Z11A3+12.E0*CORO*C1**2*C3*Z3A4+3.E0*CORO*
     . C1**2*Z33A3+6.E0*CORO*C1*C13*Z3A3+12.E0*CORO*C1*C3**2*Z1A4+6.E0
     . *CORO*C1*C3*Z13A3+6.E0*CORO*C1*C33*Z1A3+2.E0*CORO*C1*Z133A2+
     . 6.E0*CORO*C11*C3*Z3A3+2.E0*CORO*C11*Z33A2+2.E0*CORO*C113*
     . Z3A2+6.E0
     . *CORO*C13*C3*Z1A3+2.E0*CORO*C13*Z13A2+2.E0*CORO*C133*Z1A2+3.E0*
     . CORO*C3**2*Z11A3+2.E0*CORO*C3*Z113A2+2.E0*CORO*C33*Z11A2+CORO
     . *Z1133A +3.E0*C1**2*C3*Z3A3+C1**2*Z33A2+2.E0*C1*C13*Z3A2+3.E0*
     . C1*C3**2*Z1A3+2.E0*C1*C3*Z13A2+2.E0*C1*C33*Z1A2+C1*Z133A1+2.E0*
     . C11*C3*Z3A2+C11*Z33A1+C113*Z3A1+2.E0*C13*C3*Z1A2+C13*Z13A1+
     . C133*Z1A1+C3**2*Z11A2+C3*Z113A1+C33*Z11A1+Z1133
C
      DPCOEF(1)=Q0+Z01*CORO+Z02*CORO2+Z03*CORO3+Z04*CORO4
     .            +Z05*CORO5+Z06*CORO6+Z07*CORO7+Z08*CORO7*CORO
      DPCOEF(2)=Q1+W1
      DPCOEF(3)=Q3+W3
      DPCOEF(4)=Q11+W11
      DPCOEF(5)=Q33+W33
      DPCOEF(6)=Q13+W13
      DPCOEF(7)=Q111+W111
      DPCOEF(8)=Q333+W333
      DPCOEF(9)=Q113+W113
      DPCOEF(10)=Q133+W133
      DPCOEF(11)=Q1111+W1111
      DPCOEF(12)=Q3333+W3333
      DPCOEF(13)=Q1113+W1113
      DPCOEF(14)=Q1333+W1333
      DPCOEF(15)=Q1133+W1133
      RETURN
      END
C
C
