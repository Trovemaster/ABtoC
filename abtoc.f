      PROGRAM ABTOC
C********************************************************
C
C  A program for generating line strengths of transitions
C  in the a,b -> c electronic band of CH2.
C
C  Rovibronic wavefunctions for the a,b states are calculated
C  by RENNER and read from disk
C
C  Rovibronic wavefunctions for the c state are calculated
C  by MORBID and read from disk.
C
C  Version 1.0     07/03/2000
C
C********************************************************
C

C********************************************************
C
C  Read input data
C
C********************************************************

      CALL ReadInputData 

C********************************************************
C
C  Check input data
C
C********************************************************

      CALL CheckInputData

C********************************************************
C
C  Transform pqx representation of the dipole moment function 
C  to the xyz represenration in the Y_i expantion 
C
C********************************************************

      CALL PQX2XYZ

C********************************************************
C  Calculation of the dipole moment matrix elements on the 
C  symmetrized stretching functions |NVib GammaVib> 
C  and bending functions |V2 K>
C********************************************************
  
      CALL Calc_VibrationMatrixElement


      CALL Read_VibrationMatrixElement


C********************************************************
C
C  Calculate linestrength 
C
C********************************************************

       CALL Calc_LineStrength


      END