! This program is a part of EASIFEM library
! Copyright (C) 2020-2021  Vikas Sharma, Ph.D
!
! This program is free software: you can redistribute it and/or modify
! it under the terms of the GNU General Public License as published by
! the Free Software Foundation, either version 3 of the License, or
! (at your option) any later version.
!
! This program is distributed in the hope that it will be useful,
! but WITHOUT ANY WARRANTY; without even the implied warranty of
! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
! GNU General Public License for more details.
!
! You should have received a copy of the GNU General Public License
! along with this program.  If not, see <https: //www.gnu.org/licenses/>
!

SUBMODULE( FEVariable_Method ) GetMethod
IMPLICIT NONE
CONTAINS

!----------------------------------------------------------------------------
!                                                                      Size
!----------------------------------------------------------------------------

MODULE PROCEDURE Size_Obj
  SELECT CASE( Obj%Rank )
  CASE( Scalar )
    Ans = 1
  CASE( Vector )
    SELECT CASE( Obj%VarType )
    CASE( Constant )
      Ans = SIZE( Obj%R1 )
    CASE( Space )
      Ans = SIZE( Obj%R2, 1 )
    CASE( SpaceTime )
      Ans = SIZE( Obj%R3, 1 )
    END SELECT
  CASE( Matrix )
    SELECT CASE( Obj%VarType )
    CASE( Constant )
      Ans = SIZE( Obj%R2, Dim )
    CASE( Space )
      Ans = SIZE( Obj%R3, Dim )
    CASE( SpaceTime )
      Ans = SIZE( Obj%R4, Dim )
    END SELECT
  END SELECT
END PROCEDURE Size_Obj

!----------------------------------------------------------------------------
!                                                                      Shape
!----------------------------------------------------------------------------

MODULE PROCEDURE Shape_Obj
  SELECT CASE( Obj%Rank )
  CASE( Scalar )
    SELECT CASE( Obj%VarType )
    CASE( Constant )
      Ans = [1]
    CASE( Space )
      Ans = SHAPE( Obj%R1 )
    CASE( SpaceTime )
      Ans = SHAPE( Obj%R2 )
    END SELECT
  CASE( Vector )
    SELECT CASE( Obj%VarType )
    CASE( Constant )
      Ans = SHAPE( Obj%R1 )
    CASE( Space )
      Ans = SHAPE( Obj%R2 )
    CASE( SpaceTime )
      Ans = SHAPE( Obj%R3 )
    END SELECT
  CASE( Matrix )
    SELECT CASE( Obj%VarType )
    CASE( Constant )
      Ans = SHAPE( Obj%R2 )
    CASE( Space )
      Ans = SHAPE( Obj%R3 )
    CASE( SpaceTime )
      Ans = SHAPE( Obj%R4 )
    END SELECT
  END SELECT
END PROCEDURE Shape_Obj

!----------------------------------------------------------------------------
!                                                            getNodalValues
!----------------------------------------------------------------------------

MODULE PROCEDURE Scalar_Constant
  Val = Obj%R0
END PROCEDURE Scalar_Constant

!----------------------------------------------------------------------------
!                                                            getNodalValues
!----------------------------------------------------------------------------

MODULE PROCEDURE Scalar_Space
  Val = Obj%R1
END PROCEDURE Scalar_Space

!----------------------------------------------------------------------------
!                                                            getNodalValues
!----------------------------------------------------------------------------

MODULE PROCEDURE Scalar_SpaceTime
  Val = Obj%R2
END PROCEDURE Scalar_SpaceTime

!----------------------------------------------------------------------------
!                                                            getNodalValues
!----------------------------------------------------------------------------

MODULE PROCEDURE Vector_Constant
  Val = Obj%R1
END PROCEDURE Vector_Constant

!----------------------------------------------------------------------------
!                                                            getNodalValues
!----------------------------------------------------------------------------

MODULE PROCEDURE Vector_Space
  Val = Obj%R2
END PROCEDURE Vector_Space

!----------------------------------------------------------------------------
!                                                            getNodalValues
!----------------------------------------------------------------------------

MODULE PROCEDURE Vector_SpaceTime
  Val = Obj%R3
END PROCEDURE Vector_SpaceTime

!----------------------------------------------------------------------------
!                                                            getNodalValues
!----------------------------------------------------------------------------

MODULE PROCEDURE Matrix_Constant
  Val = Obj%R2
END PROCEDURE Matrix_Constant

!----------------------------------------------------------------------------
!                                                            getNodalValues
!----------------------------------------------------------------------------

MODULE PROCEDURE Matrix_Space
  Val = Obj%R3
END PROCEDURE Matrix_Space

!----------------------------------------------------------------------------
!                                                            getNodalValues
!----------------------------------------------------------------------------

MODULE PROCEDURE Matrix_SpaceTime
  Val = Obj%R4
END PROCEDURE Matrix_SpaceTime

END SUBMODULE GetMethod