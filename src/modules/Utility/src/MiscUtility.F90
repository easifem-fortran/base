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

MODULE MiscUtility
USE GlobalData
IMPLICIT NONE
PRIVATE

PUBLIC :: radian
PUBLIC :: Degrees
PUBLIC :: SearchNearestCoord
PUBLIC :: ExecuteCommand
PUBLIC :: getUnitNo
PUBLIC :: Factorial
PUBLIC :: Int2Str
PUBLIC :: Real2Str
PUBLIC :: ARTH
PUBLIC :: outerdiff
PUBLIC :: IMAXLOC
PUBLIC :: IMINLOC
PUBLIC :: IMG

!----------------------------------------------------------------------------
!                                                               Radian@MISC
!----------------------------------------------------------------------------

!> author: Dr. Vikas Sharma
!
! Convert degrees into radian

INTERFACE
  MODULE PURE FUNCTION radian_dfp(deg) RESULT(Ans)
    REAL(DFP), INTENT(IN) :: deg
    REAL(DFP) :: Ans
  END FUNCTION
END INTERFACE

!----------------------------------------------------------------------------
!                                                               Radian@MISC
!----------------------------------------------------------------------------

!> author: Dr. Vikas Sharma
!
! Converts degrees into radian

INTERFACE
  MODULE PURE FUNCTION radian_int(deg) RESULT(Ans)
    INTEGER(I4B), INTENT(IN) :: deg
    REAL(DFP) :: Ans
  END FUNCTION
END INTERFACE

INTERFACE radian
  MODULE PROCEDURE radian_dfp, radian_int
END INTERFACE

!----------------------------------------------------------------------------
!                                                              Degrees@MISC
!----------------------------------------------------------------------------

!> author: Dr. Vikas Sharma
!
! This function converts radian into degrees
! Belongs to `Degrees`

INTERFACE
  MODULE PURE FUNCTION degrees_dfp(rad) RESULT(Ans)
    REAL(DFP), INTENT(IN) :: rad
    REAL(DFP) :: Ans
  END FUNCTION
END INTERFACE

INTERFACE Degrees
  MODULE PROCEDURE degrees_dfp
END INTERFACE Degrees

!----------------------------------------------------------------------------
!                                                                 @MISC
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 3 April 2021
! summary: Search the loc of nearest point to x in the array
!
!# Introduction
!
! This subroutine search the location of nearest point to x in the
! array of coordinates; Array
!
! ## Usage
! ```fortran
! real( dfp ) :: xij( 2, 20 ), x( 2 )
! integer( i4b ) :: id
!
! call random_number( xij )
! x = [11.0, 100.0]
! xij( 1:2, 15 ) = x
! id = searchNearestCoord(Array=xij, x=x)
! call display( id==15, "test4:: " )
!```

INTERFACE
  MODULE FUNCTION Loc_Nearest_Point(Array, x) RESULT(id)
    REAL(DFP), INTENT(IN) :: Array(:, :)
  !! Nodal coordinates in XiJ format
    REAL(DFP), INTENT(IN) :: x(:)
    INTEGER(I4B) :: id
  END FUNCTION
END INTERFACE

INTERFACE LOC_NearestPoint
  MODULE PROCEDURE Loc_Nearest_Point
END INTERFACE LOC_NearestPoint

PUBLIC :: LOC_NearestPoint

INTERFACE SearchNearestCoord
  MODULE PROCEDURE Loc_Nearest_Point
END INTERFACE SearchNearestCoord

!----------------------------------------------------------------------------
!                                                        ExecuteCommand@MISC
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date:         3 April 2021
! summary:         This subroutine run a system commoand on terminal

INTERFACE
  MODULE SUBROUTINE exe_cmd(CMD, Str)
    CHARACTER(LEN=*), INTENT(IN) :: CMD, Str
  END SUBROUTINE
END INTERFACE

INTERFACE ExecuteCommand
  MODULE PROCEDURE exe_cmd
END INTERFACE ExecuteCommand

!----------------------------------------------------------------------------
!                                                             getUnitNo@MISC
!----------------------------------------------------------------------------

INTERFACE
  MODULE FUNCTION getUnitNo_1() RESULT(ans)
    INTEGER(I4B) :: ans
  END FUNCTION getUnitNo_1
END INTERFACE

INTERFACE getUnitNo
  MODULE PROCEDURE getUnitNo_1
END INTERFACE getUnitNo

!----------------------------------------------------------------------------
!                                                             Factorial@MISC
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date:         3 April 2021
! summary: This FUNCTION computes the factorial of an INTEGER

INTERFACE
  MODULE PURE RECURSIVE FUNCTION Factorial(N) RESULT(Ans)
    INTEGER(I4B), INTENT(IN) :: N
    INTEGER(I4B) :: Ans
  END FUNCTION
END INTERFACE

!----------------------------------------------------------------------------
!                                                               Int2STR@MISC
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date:         3 April 2021
! summary:         Convert INTEGER  to  string

INTERFACE
  MODULE PURE FUNCTION Int2Str(I)
    INTEGER(I4B), INTENT(IN) :: I
    CHARACTER(LEN=15) :: Int2Str
  END FUNCTION
END INTERFACE

!----------------------------------------------------------------------------
!                                                              Real2Str@MISC
!----------------------------------------------------------------------------

INTERFACE
  MODULE FUNCTION SP2Str(I)
    REAL(SP), INTENT(IN) :: I
    CHARACTER(LEN=20) :: SP2Str
  END FUNCTION
END INTERFACE

INTERFACE
  MODULE FUNCTION DP2Str(I)
    REAL(DP), INTENT(IN) :: I
    CHARACTER(LEN=20) :: DP2Str
  END FUNCTION
END INTERFACE

INTERFACE Real2Str
  MODULE PROCEDURE SP2Str, DP2Str
END INTERFACE Real2Str

!----------------------------------------------------------------------------
!                                                                       ARTH
!----------------------------------------------------------------------------

INTERFACE
  MODULE PURE FUNCTION arth_r(first, increment, n)
    REAL(SP), INTENT(IN) :: first, increment
    INTEGER(I4B), INTENT(IN) :: n
    REAL(SP) :: arth_r(n)
  END FUNCTION
END INTERFACE

INTERFACE
  MODULE PURE FUNCTION arth_d(first, increment, n)
    REAL(DP), INTENT(IN) :: first, increment
    INTEGER(I4B), INTENT(IN) :: n
    REAL(DP) :: arth_d(n)
  END FUNCTION
END INTERFACE

INTERFACE
  MODULE PURE FUNCTION arth_i(first, increment, n)
    INTEGER(I4B), INTENT(IN) :: first, increment, n
    INTEGER(I4B) :: arth_i(n)
  END FUNCTION
END INTERFACE

INTERFACE ARTH
  MODULE PROCEDURE arth_d, arth_i, arth_r
END INTERFACE ARTH

!----------------------------------------------------------------------------
!                                                             outerdiff@MISC
!----------------------------------------------------------------------------

INTERFACE
  MODULE PURE FUNCTION outerdiff_r(a, b)
    REAL(SP), DIMENSION(:), INTENT(IN) :: a, b
    REAL(SP), DIMENSION(size(a), size(b)) :: outerdiff_r
  END FUNCTION
END INTERFACE

INTERFACE
  MODULE PURE FUNCTION outerdiff_d(a, b)
    REAL(DP), DIMENSION(:), INTENT(IN) :: a, b
    REAL(DP), DIMENSION(size(a), size(b)) :: outerdiff_d
  END FUNCTION
END INTERFACE

INTERFACE
  MODULE PURE FUNCTION outerdiff_i(a, b)
    INTEGER(I4B), DIMENSION(:), INTENT(IN) :: a, b
    INTEGER(I4B), DIMENSION(size(a), size(b)) :: outerdiff_i
  END FUNCTION
END INTERFACE

INTERFACE outerdiff
  MODULE PROCEDURE outerdiff_r, outerdiff_i, outerdiff_d
END INTERFACE

!----------------------------------------------------------------------------
!                                                              IMAXLOC@MISC
!----------------------------------------------------------------------------

INTERFACE
  MODULE PURE FUNCTION imaxloc_r(arr)
    REAL(DFP), INTENT(IN) :: arr(:)
    INTEGER(I4B) :: imaxloc_r
  END FUNCTION
END INTERFACE

INTERFACE
  MODULE PURE FUNCTION imaxloc_i(iarr)
    INTEGER(I4B), INTENT(IN) :: iarr(:)
    INTEGER(I4B) :: imaxloc_i
  END FUNCTION
END INTERFACE

INTERFACE IMAXLOC
  MODULE PROCEDURE imaxloc_r, imaxloc_i
END INTERFACE

!----------------------------------------------------------------------------
!                                                                 IMIN@MISC
!----------------------------------------------------------------------------

INTERFACE
  MODULE FUNCTION iminloc_r(arr)
    REAL(DFP), INTENT(IN) :: arr(:)
    INTEGER(I4B) :: iminloc_r
  END FUNCTION
END INTERFACE

INTERFACE IMINLOC
  MODULE PROCEDURE iminloc_r
END INTERFACE IMINLOC

!----------------------------------------------------------------------------
!                                                                      IMG
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 5 March 2022
! summary: Return imaginary part of complex value

INTERFACE
  MODULE ELEMENTAL FUNCTION IMG_1(x) RESULT(ans)
    COMPLEX(Real32), INTENT(IN) :: x
    REAL(Real32) :: ans
  END FUNCTION IMG_1
END INTERFACE

INTERFACE IMG
  MODULE PROCEDURE IMG_1
END INTERFACE IMG

!----------------------------------------------------------------------------
!                                                                      IMG
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 5 March 2022
! summary: Return imaginary part of complex value

INTERFACE
  MODULE ELEMENTAL FUNCTION IMG_2(x) RESULT(ans)
    COMPLEX(Real64), INTENT(IN) :: x
    REAL(Real64) :: ans
  END FUNCTION IMG_2
END INTERFACE

INTERFACE IMG
  MODULE PROCEDURE IMG_2
END INTERFACE IMG

!----------------------------------------------------------------------------
!                                                                 safe_ACOS
!----------------------------------------------------------------------------

INTERFACE
  MODULE ELEMENTAL FUNCTION safe_ACOS(c) RESULT(ans)
    REAL(DFP), INTENT(IN) :: c
    REAL(DFP) :: ans
  END FUNCTION safe_ACOS
END INTERFACE

PUBLIC :: safe_ACOS

!----------------------------------------------------------------------------
!                                                                 safe_ASIN
!----------------------------------------------------------------------------

INTERFACE
  MODULE ELEMENTAL FUNCTION safe_ASIN(s) RESULT(ans)
    REAL(DFP), INTENT(IN) :: s
    REAL(DFP) :: ans
  END FUNCTION safe_ASIN
END INTERFACE

PUBLIC :: safe_ASIN

!----------------------------------------------------------------------------
!                                                            Factorial@MISC
!----------------------------------------------------------------------------

END MODULE MiscUtility
