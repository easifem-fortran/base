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
! date:         25 Feb 2021
! summary:         This submodule contains set methods of [[RealVector_]]

SUBMODULE(RealVector_AppendMethods) Methods
USE BaseMethod
IMPLICIT NONE
CONTAINS

!----------------------------------------------------------------------------
!                                                                     Append
!----------------------------------------------------------------------------

MODULE PROCEDURE realVec_Append1
CALL Append(obj%val, VALUE)
END PROCEDURE realVec_Append1

!----------------------------------------------------------------------------
!                                                                     Append
!----------------------------------------------------------------------------

MODULE PROCEDURE realVec_Append2
CALL Append(obj%val, VALUE)
END PROCEDURE realVec_Append2

!----------------------------------------------------------------------------
!                                                                     Append
!----------------------------------------------------------------------------

MODULE PROCEDURE realVec_Append3
CALL Append(obj%val, Anotherobj%val)
END PROCEDURE realVec_Append3

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

END SUBMODULE Methods
