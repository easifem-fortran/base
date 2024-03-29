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
! summary:         This submodule implements set methods of [[IntVector_]]

SUBMODULE(IntVector_SetMethod) Methods
USE BaseMethod
IMPLICIT NONE
CONTAINS

!----------------------------------------------------------------------------
!                                                        setTotalDimension
!----------------------------------------------------------------------------

MODULE PROCEDURE IntVec_setTotalDimension
obj%tDimension = tDimension
END PROCEDURE IntVec_setTotalDimension

!----------------------------------------------------------------------------
!                                                                 setMethod
!----------------------------------------------------------------------------

MODULE PROCEDURE intVec_set1
IF (ALLOCATED(obj%val)) THEN
  IF (SIZE(VALUE) .EQ. 1) THEN
    obj%val(Indx) = VALUE(1)
  ELSE
    obj%val(Indx) = VALUE
  END IF
END IF
END PROCEDURE intVec_set1

!----------------------------------------------------------------------------
!                                                                 setMethod
!----------------------------------------------------------------------------

MODULE PROCEDURE intVec_set2
IF (ALLOCATED(obj%val)) THEN
  obj%val(Indx) = VALUE
END IF
END PROCEDURE intVec_set2

!----------------------------------------------------------------------------
!                                                             RemoveDuplicate
!----------------------------------------------------------------------------

MODULE PROCEDURE IntVec_RemoveDuplicates_1
! Define internal variables
INTEGER(I4B) :: i, k, j, N
INTEGER(I4B), ALLOCATABLE :: Res(:)
LOGICAL(LGT) :: isok

isok = ALLOCATED(obj%val)
IF (.NOT. isok) RETURN

N = SIZE(obj%val)
isok = N .GT. 0
IF (.NOT. isok) RETURN

ALLOCATE (Res(N))
Res = 0
Res(1) = obj%val(1)
k = 1
DO i = 2, N
  IF (.NOT. ANY(Res .EQ. obj%val(i))) THEN
    k = k + 1
    Res(k) = obj%val(i)
  END IF
END DO
obj%val = Res(1:k)
DEALLOCATE (Res)
END PROCEDURE IntVec_RemoveDuplicates_1

!----------------------------------------------------------------------------
!                                                                     Repeat
!----------------------------------------------------------------------------

MODULE PROCEDURE IntVec_Repeat_1
Ans = REPEAT(obj%val, rtimes)
END PROCEDURE IntVec_Repeat_1

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

END SUBMODULE Methods
