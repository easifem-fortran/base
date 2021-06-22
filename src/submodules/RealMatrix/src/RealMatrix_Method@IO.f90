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

!> authors: Vikas Sharma, Ph. D.
! date: 	7 March 2021
! summary: This module contains IO methods for [[RealMatrix_]]

SUBMODULE( RealMatrix_Method ) IO
USE BaseMethod
IMPLICIT NONE
CONTAINS

!----------------------------------------------------------------------------
!                                                                   Display
!----------------------------------------------------------------------------

MODULE PROCEDURE Display_Obj
  INTEGER( I4B ) :: I
  I = Input( option=UnitNo, default=stdout )
  IF( LEN_TRIM( msg ) .NE. 0 ) WRITE( I, "(A)") "#" // TRIM( Msg )
  CALL Display( Obj%Val, "", I )
END PROCEDURE Display_Obj

!----------------------------------------------------------------------------
!                                                                   Display
!----------------------------------------------------------------------------

MODULE PROCEDURE Display_Obj_vec
  INTEGER( I4B ) :: I, j
  I = Input( option=UnitNo, default=stdout )
  IF( LEN_TRIM( msg ) .NE. 0 ) WRITE( I, "(A)") "#" // TRIM( Msg )
  DO j = 1, SIZE( Obj )
    CALL Display( Obj( j )%Val, "", I )
    CALL Blanklines( UnitNo = I, NOL = 1 )
  END DO
END PROCEDURE Display_Obj_vec

END SUBMODULE IO