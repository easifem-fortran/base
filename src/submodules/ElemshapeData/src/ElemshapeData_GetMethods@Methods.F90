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

SUBMODULE(ElemshapeData_GetMethods) Methods
USE BaseMethod
IMPLICIT NONE
CONTAINS

!----------------------------------------------------------------------------
!                                                                 getNormal
!----------------------------------------------------------------------------

MODULE PROCEDURE elemsd_getnormal_1
IF (PRESENT(nsd)) THEN
  normal = obj%normal(1:nsd, :)
ELSE
  normal = obj%normal
END IF
END PROCEDURE elemsd_GetNormal_1

!----------------------------------------------------------------------------
!                                                                 getNormal
!----------------------------------------------------------------------------

MODULE PROCEDURE elemsd_getnormal_2
IF (PRESENT(nsd)) THEN
  normal = QuadratureVariable(obj%normal(1:nsd, :), &
    & TypeFEVariableVector, &
    & TypeFEVariableSpace)
ELSE
  normal = QuadratureVariable(obj%normal, &
    & TypeFEVariableVector, &
    & TypeFEVariableSpace)
END IF
END PROCEDURE elemsd_getnormal_2

!----------------------------------------------------------------------------
!                                                                 getNormal
!----------------------------------------------------------------------------

MODULE PROCEDURE elemsd_getnormal_3
  !!
REAL(DFP), ALLOCATABLE :: m3(:, :, :)
INTEGER(I4B) :: ii
  !!
IF (PRESENT(nsd)) THEN
    !!
  CALL Reallocate(m3, &
    & nsd, &
    & SIZE(obj(1)%normal, 2), &
    & SIZE(obj))
    !!
  DO ii = 1, SIZE(obj)
    m3(1:nsd, :, ii) = obj(ii)%normal(1:nsd, :)
  END DO
    !!
ELSE
    !!
  CALL Reallocate(m3, &
    & SIZE(obj(1)%normal, 1), &
    & SIZE(obj(1)%normal, 2), &
    & SIZE(obj))
    !!
  DO ii = 1, SIZE(obj)
    m3(:, :, ii) = obj(ii)%normal
  END DO
    !!
END IF
  !!
normal = QuadratureVariable(m3, TypeFEVariableVector, &
  & TypeFEVariableSpaceTime)
  !!
DEALLOCATE (m3)
  !!
END PROCEDURE elemsd_getnormal_3

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

END SUBMODULE Methods
