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

!> author: Vikas Sharma, Ph. D.
! date: 	7 March 2021
! summary: This module contains IO methods for [[RealMatrix_]]

SUBMODULE(RealMatrix_Method) IOMethods
USE BaseMethod
IMPLICIT NONE
CONTAINS

!----------------------------------------------------------------------------
!                                                                   Display
!----------------------------------------------------------------------------

MODULE PROCEDURE realmat_Display1
  CALL Display( obj%Val, msg, UnitNo=UnitNo )
END PROCEDURE realmat_Display1

!----------------------------------------------------------------------------
!                                                                   Display
!----------------------------------------------------------------------------

MODULE PROCEDURE realmat_Display2
  INTEGER( I4B ) :: j
  !!
  DO j = 1, SIZE( obj )
    !!
    CALL Display( &
      & obj( j )%Val, &
      & trim(msg)// ' (' // tostring(j) // '): ', &
      & UnitNo=UnitNo )
    !!
    CALL Blanklines( UnitNo = UnitNo, NOL = 2 )
    !!
  END DO
  !!
END PROCEDURE realmat_Display2

END SUBMODULE IOMethods