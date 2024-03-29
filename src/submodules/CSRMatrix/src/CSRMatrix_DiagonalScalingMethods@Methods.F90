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

SUBMODULE(CSRMatrix_DiagonalScalingMethods) Methods
USE BaseMethod
IMPLICIT NONE
CONTAINS

!----------------------------------------------------------------------------
!                                                           DiagonalScaling
!----------------------------------------------------------------------------

MODULE PROCEDURE csrmat_DiagonalScaling_1
REAL(DFP), ALLOCATABLE :: diag_(:)
CALL getDiagonal(obj=obj, diag=diag_)
CALL DiagonalScaling(obj=obj, diag=diag_, OPERATOR=OPERATOR, side=side)
IF (ALLOCATED(diag_)) DEALLOCATE (diag_)
END PROCEDURE csrmat_DiagonalScaling_1

!----------------------------------------------------------------------------
!                                                           DiagonalScaling
!----------------------------------------------------------------------------

MODULE PROCEDURE csrmat_DiagonalScaling_2
INTEGER(I4B) :: ii, jj
CHARACTER(:), ALLOCATABLE :: op
REAL(DFP) :: avar

IF (PRESENT(OPERATOR)) THEN
  op = OPERATOR
ELSE
  op = 'SQRT'
END IF

SELECT CASE (TRIM(side))

CASE ('LEFT', 'Left', 'left')

  SELECT CASE (TRIM(op))

  CASE ('SQRT')

    DO ii = 1, obj%csr%nrow

      DO jj = obj%csr%IA(ii), obj%csr%IA(ii + 1) - 1
        IF (ABS(diag(ii)) .GT. zero) THEN
          obj%A(jj) = obj%A(jj) / SQRT(ABS(diag(ii)))
        END IF

      END DO
    END DO

  CASE ('NONE')
    !
    DO ii = 1, obj%csr%nrow
      !
      DO jj = obj%csr%IA(ii), obj%csr%IA(ii + 1) - 1
        !
        obj%A(jj) = obj%A(jj) / diag(ii)
        !
      END DO
    END DO
    !
  END SELECT
  !
  !
  !
CASE ('RIGHT', 'Right', 'right')
  !
  !
  SELECT CASE (TRIM(op))
    !
    !
    !
  CASE ('SQRT')
    !
    DO ii = 1, obj%csr%nrow
      !
      DO jj = obj%csr%IA(ii), obj%csr%IA(ii + 1) - 1
        !
        obj%A(jj) = obj%A(jj) / SQRT(ABS(diag(obj%csr%JA(jj))))
        !
      END DO
    END DO
    !
    !
    !
  CASE ('NONE')
    !
    DO ii = 1, obj%csr%nrow
      !
      DO jj = obj%csr%IA(ii), obj%csr%IA(ii + 1) - 1
        !
        obj%A(jj) = obj%A(jj) / diag(obj%csr%JA(jj))
        !
      END DO
    END DO
    !
  END SELECT
  !
  !
  !
CASE ('BOTH', 'Both', 'both')
  !
  !
  SELECT CASE (TRIM(op))
    !
    !
    !
  CASE ('SQRT')
    !
    DO ii = 1, obj%csr%nrow
      !
      DO jj = obj%csr%IA(ii), obj%csr%IA(ii + 1) - 1
        !
        avar = ABS(diag(ii) * diag(obj%csr%JA(jj)))

        IF (avar .GT. zero) THEN
          obj%A(jj) = obj%A(jj) / SQRT(avar)
        END IF
        !
      END DO
    END DO
    !
    !
    !
  CASE ('NONE')
    !
    DO ii = 1, obj%csr%nrow
      !
      DO jj = obj%csr%IA(ii), obj%csr%IA(ii + 1) - 1
        !
        obj%A(jj) = obj%A(jj) / diag(ii) / diag(obj%csr%JA(jj))
        !
      END DO
    END DO
    !
  END SELECT
  !
  !
  !
END SELECT
!
!
!
END PROCEDURE csrmat_DiagonalScaling_2

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

END SUBMODULE Methods
