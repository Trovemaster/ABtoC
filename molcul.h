      REAL*8 AA1,AA3,RE12 , RE32, M1, M2, M3, M,
     1       U1 , U3 , U13 , V , RHOMAX,XMULTI,
     2       F11,F33,RE0(2,3),REFM1,REFM2,REFM3,
     3       LambdaAB,LambdaC

      COMMON /MOLCUL/ AA1,AA3,
     1               RE12 , RE32 , M1 , M2 , M3 , M ,
     2               U1 , U3 , U13 , V , RHOMAX,XMULTI,
     3               F11,F33,RE0,REFM1,REFM2,REFM3,
     4       LambdaAB,LambdaC

      LOGICAL SYMM,IntACT
      COMMON /MOLSYM/  SYMM,IntACT