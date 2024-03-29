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
! date: 6 March 2021
! summary: This module contains method to construct finite element matrices

MODULE DiffusionMatrix_Method
USE BaseType
USE GlobalData
IMPLICIT NONE
PRIVATE

PUBLIC :: DiffusionMatrix

!----------------------------------------------------------------------------
!                                     DiffusionMatrix@DiffusionMatrixMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 6 March 2021
! summary: This subroutine returns the diffusion matrix in space domain
!
!# Introduction
!
! If opt is not present.
!
! $$
! M(I,J)=\int\frac{\partial N^{I}}{\partial x_{i}}\frac{\partial N^{J}}
! {\partial x_{i}}d\Omega
! $$
!
! If opt is present.
!
! $$
! \left[M\right]_{IJ}^{ij}=\delta_{ij}\int\frac{\partial N^{I}}
! {\partial x_{k}}\frac{\partial N^{J}}{\partial x_{k}}d\Omega
! $$

INTERFACE
  MODULE PURE FUNCTION DiffusionMatrix_1(test, trial, opt) RESULT(ans)
    CLASS(ElemshapeData_), INTENT(IN) :: test
    CLASS(ElemshapeData_), INTENT(IN) :: trial
    INTEGER(I4B), OPTIONAL, INTENT(IN) :: opt
    REAL(DFP), ALLOCATABLE :: ans(:, :)
  END FUNCTION DiffusionMatrix_1
END INTERFACE

INTERFACE DiffusionMatrix
  MODULE PROCEDURE DiffusionMatrix_1
END INTERFACE DiffusionMatrix

!----------------------------------------------------------------------------
!                                     DiffusionMatrix@DiffusionMatrixMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 6 March 2021
! summary: This subroutine returns the diffusion matrix in space domain
!
!# Introduction
!
! $$
! M(I,J)=\int\rho\frac{\partial N^{I}}{\partial x_{i}}\frac{\partial N^{J}}
! {\partial x_{i}}d\Omega
! $$
!

INTERFACE
  MODULE PURE FUNCTION DiffusionMatrix_2(test, trial, k, krank, opt) &
    & RESULT(ans)
    CLASS(ElemshapeData_), INTENT(IN) :: test
    !! test function
    CLASS(ElemshapeData_), INTENT(IN) :: trial
    !! trial function
    CLASS(FEVariable_), INTENT(IN) :: k
    !! scalar
    TYPE(FEVariableScalar_), INTENT(IN) :: krank
    !! scalar fe variable
    INTEGER(I4B), OPTIONAL, INTENT(IN) :: opt
    REAL(DFP), ALLOCATABLE :: ans(:, :)
  END FUNCTION DiffusionMatrix_2
END INTERFACE

INTERFACE DiffusionMatrix
  MODULE PROCEDURE DiffusionMatrix_2
END INTERFACE DiffusionMatrix

!----------------------------------------------------------------------------
!                                     DiffusionMatrix@DiffusionMatrixMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 6 March 2021
! summary: This subroutine returns the diffusion matrix in space domain
!
!# Introduction
!
! $$
! M(I,J)=\int\frac{\partial N^{I}}{\partial x_{i}}v_{i}v_{j}
! \frac{\partial N^{J}}{\partial x_{j}}d\Omega
! $$

INTERFACE
  MODULE PURE FUNCTION DiffusionMatrix_3(test, trial, k, krank, opt) &
    & RESULT(ans)
    CLASS(ElemshapeData_), INTENT(IN) :: test
    !! test function
    CLASS(ElemshapeData_), INTENT(IN) :: trial
    !! trial function
    CLASS(FEVariable_), INTENT(IN) :: k
    !! vector
    TYPE(FEVariableVector_), INTENT(IN) :: krank
    !! vector
    INTEGER(I4B), OPTIONAL, INTENT(IN) :: opt
    REAL(DFP), ALLOCATABLE :: ans(:, :)
  END FUNCTION DiffusionMatrix_3
END INTERFACE

INTERFACE DiffusionMatrix
  MODULE PROCEDURE DiffusionMatrix_3
END INTERFACE DiffusionMatrix

!----------------------------------------------------------------------------
!                                     DiffusionMatrix@DiffusionMatrixMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 6 March 2021
! summary: This subroutine returns the diffusion matrix in space domain
!
!# Introduction
!
! $$
! M(I,J)=\int\frac{\partial N^{I}}{\partial x_{i}}k_{ij}
! \frac{\partial N^{J}}{\partial x_{j}}d\Omega
! $$

INTERFACE
  MODULE PURE FUNCTION DiffusionMatrix_4(test, trial, k, krank, opt) &
    & RESULT(ans)
    CLASS(ElemshapeData_), INTENT(IN) :: test
    !! test function
    CLASS(ElemshapeData_), INTENT(IN) :: trial
    !! trial function
    CLASS(FEVariable_), INTENT(IN) :: k
    !! matrix
    TYPE(FEVariableMatrix_), INTENT(IN) :: krank
    !! matrix
    INTEGER(I4B), OPTIONAL, INTENT(IN) :: opt
    !! ncopy
    REAL(DFP), ALLOCATABLE :: ans(:, :)
  END FUNCTION DiffusionMatrix_4
END INTERFACE

INTERFACE DiffusionMatrix
  MODULE PROCEDURE DiffusionMatrix_4
END INTERFACE DiffusionMatrix

!----------------------------------------------------------------------------
!                                     DiffusionMatrix@DiffusionMatrixMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 6 March 2021
! summary: This subroutine returns the diffusion matrix in space domain
!
!# Introduction
!
! $$
! M(I,J)=\int\frac{\partial N^{I}}{\partial x_{i}}u_{i}v_{j}
! \frac{\partial N^{J}}{\partial x_{j}}d\Omega
! $$

INTERFACE
  MODULE PURE FUNCTION DiffusionMatrix_5(test, trial, c1, c2, c1rank, &
    & c2rank, opt) RESULT(ans)
    CLASS(ElemshapeData_), INTENT(IN) :: test
    !! test function
    CLASS(ElemshapeData_), INTENT(IN) :: trial
    !! trial function
    CLASS(FEVariable_), INTENT(IN) :: c1
    !! Scalar
    CLASS(FEVariable_), INTENT(IN) :: c2
    !! Scalar
    TYPE(FEVariableScalar_), INTENT(IN) :: c1rank
    !! Scalar
    TYPE(FEVariableScalar_), INTENT(IN) :: c2rank
    !! Scalar
    INTEGER(I4B), OPTIONAL, INTENT(IN) :: opt
    !! ncopy
    REAL(DFP), ALLOCATABLE :: ans(:, :)
  END FUNCTION DiffusionMatrix_5
END INTERFACE

INTERFACE DiffusionMatrix
  MODULE PROCEDURE DiffusionMatrix_5
END INTERFACE DiffusionMatrix

!----------------------------------------------------------------------------
!                                     DiffusionMatrix@DiffusionMatrixMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 6 March 2021
! summary: This subroutine returns the diffusion matrix in space domain
!
!# Introduction
!
! $$
! M(I,J)=\int\rho\frac{\partial N^{I}}{\partial x_{i}}k_{ij}
! \frac{\partial N^{J}}{\partial x_{j}}d\Omega
! $$

INTERFACE
  MODULE PURE FUNCTION DiffusionMatrix_6(test, trial, c1, c2, c1rank, &
    & c2rank, opt) RESULT(ans)
    CLASS(ElemshapeData_), INTENT(IN) :: test
    !! test function
    CLASS(ElemshapeData_), INTENT(IN) :: trial
    !! trial function
    CLASS(FEVariable_), INTENT(IN) :: c1
    !! Scalar
    CLASS(FEVariable_), INTENT(IN) :: c2
    !! Vector
    TYPE(FEVariableScalar_), INTENT(IN) :: c1rank
    !! Scalar
    TYPE(FEVariableVector_), INTENT(IN) :: c2rank
    !! Vector
    INTEGER(I4B), OPTIONAL, INTENT(IN) :: opt
    !! ncopy
    REAL(DFP), ALLOCATABLE :: ans(:, :)
  END FUNCTION DiffusionMatrix_6
END INTERFACE

INTERFACE DiffusionMatrix
  MODULE PROCEDURE DiffusionMatrix_6
END INTERFACE DiffusionMatrix

!----------------------------------------------------------------------------
!                                     DiffusionMatrix@DiffusionMatrixMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 6 March 2021
! summary: This subroutine returns the diffusion matrix in space domain
!
!# Introduction
!
! $$
! M(I,J)=\int\rho_{1}\frac{\partial N^{I}}{\partial x_{i}}k_{ij}
! \frac{\partial N^{J}}{\partial x_{j}}d\Omega
! $$

INTERFACE
  MODULE PURE FUNCTION DiffusionMatrix_7(test, trial, c1, c2, c1rank, &
    & c2rank, opt) RESULT(ans)
    CLASS(ElemshapeData_), INTENT(IN) :: test
    !! test function
    CLASS(ElemshapeData_), INTENT(IN) :: trial
    !! trial function
    CLASS(FEVariable_), INTENT(IN) :: c1
    !! Scalar
    CLASS(FEVariable_), INTENT(IN) :: c2
    !! Matrix
    TYPE(FEVariableScalar_), INTENT(IN) :: c1rank
    !! Scalar
    TYPE(FEVariableMatrix_), INTENT(IN) :: c2rank
    !! Matrix
    INTEGER(I4B), OPTIONAL, INTENT(IN) :: opt
    !! ncopy
    REAL(DFP), ALLOCATABLE :: ans(:, :)
  END FUNCTION DiffusionMatrix_7
END INTERFACE

INTERFACE DiffusionMatrix
  MODULE PROCEDURE DiffusionMatrix_7
END INTERFACE DiffusionMatrix

!----------------------------------------------------------------------------
!                                     DiffusionMatrix@DiffusionMatrixMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 6 March 2021
! summary: This subroutine returns the diffusion matrix in space domain
!
!# Introduction
!
! $$
!
! $$

INTERFACE
  MODULE PURE FUNCTION DiffusionMatrix_8(test, trial, c1, c2, c1rank, &
    & c2rank, opt) RESULT(ans)
    CLASS(ElemshapeData_), INTENT(IN) :: test
    !! test function
    CLASS(ElemshapeData_), INTENT(IN) :: trial
    !! trial function
    CLASS(FEVariable_), INTENT(IN) :: c1
    !! Vector
    CLASS(FEVariable_), INTENT(IN) :: c2
    !! Scalar
    TYPE(FEVariableVector_), INTENT(IN) :: c1rank
    !! Vector
    TYPE(FEVariableScalar_), INTENT(IN) :: c2rank
    !! Scalar
    INTEGER(I4B), OPTIONAL, INTENT(IN) :: opt
    !! ncopy
    REAL(DFP), ALLOCATABLE :: ans(:, :)
  END FUNCTION DiffusionMatrix_8
END INTERFACE

INTERFACE DiffusionMatrix
  MODULE PROCEDURE DiffusionMatrix_8
END INTERFACE DiffusionMatrix

!----------------------------------------------------------------------------
!                                     DiffusionMatrix@DiffusionMatrixMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 6 March 2021
! summary: This subroutine returns the diffusion matrix in space domain
!
!# Introduction
!
! $$
!
! $$

INTERFACE
  MODULE PURE FUNCTION DiffusionMatrix_9(test, trial, c1, c2, c1rank, &
    & c2rank, opt) RESULT(ans)
    CLASS(ElemshapeData_), INTENT(IN) :: test
    !! test function
    CLASS(ElemshapeData_), INTENT(IN) :: trial
    !! trial function
    CLASS(FEVariable_), INTENT(IN) :: c1
    !! Vector
    CLASS(FEVariable_), INTENT(IN) :: c2
    !! Vector
    TYPE(FEVariableVector_), INTENT(IN) :: c1rank
    !! Vector
    TYPE(FEVariableVector_), INTENT(IN) :: c2rank
    !! Vector
    INTEGER(I4B), OPTIONAL, INTENT(IN) :: opt
    !! ncopy
    REAL(DFP), ALLOCATABLE :: ans(:, :)
  END FUNCTION DiffusionMatrix_9
END INTERFACE

INTERFACE DiffusionMatrix
  MODULE PROCEDURE DiffusionMatrix_9
END INTERFACE DiffusionMatrix

!----------------------------------------------------------------------------
!                                     DiffusionMatrix@DiffusionMatrixMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 6 March 2021
! summary: This subroutine returns the diffusion matrix in space domain

INTERFACE
  MODULE PURE FUNCTION DiffusionMatrix_10(test, trial, c1, c2, c1rank, &
    & c2rank, opt) RESULT(ans)
    CLASS(ElemshapeData_), INTENT(IN) :: test
    !! test function
    CLASS(ElemshapeData_), INTENT(IN) :: trial
    !! trial function
    CLASS(FEVariable_), INTENT(IN) :: c1
    !! Vector
    CLASS(FEVariable_), INTENT(IN) :: c2
    !! Matrix
    TYPE(FEVariableVector_), INTENT(IN) :: c1rank
    !! Vector
    TYPE(FEVariableMatrix_), INTENT(IN) :: c2rank
    !! Matrix
    INTEGER(I4B), OPTIONAL, INTENT(IN) :: opt
    !! ncopy
    REAL(DFP), ALLOCATABLE :: ans(:, :)
  END FUNCTION DiffusionMatrix_10
END INTERFACE

INTERFACE DiffusionMatrix
  MODULE PROCEDURE DiffusionMatrix_10
END INTERFACE DiffusionMatrix

!----------------------------------------------------------------------------
!                                     DiffusionMatrix@DiffusionMatrixMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 6 March 2021
! summary: This subroutine returns the diffusion matrix in space domain

INTERFACE
  MODULE PURE FUNCTION DiffusionMatrix_11(test, trial, c1, c2, c1rank, &
    & c2rank, opt) RESULT(ans)
    CLASS(ElemshapeData_), INTENT(IN) :: test
    !! test function
    CLASS(ElemshapeData_), INTENT(IN) :: trial
    !! trial function
    CLASS(FEVariable_), INTENT(IN) :: c1
    !! Matrix
    CLASS(FEVariable_), INTENT(IN) :: c2
    !! Scalar
    TYPE(FEVariableMatrix_), INTENT(IN) :: c1rank
    !! Matrix
    TYPE(FEVariableScalar_), INTENT(IN) :: c2rank
    !! Scalar
    INTEGER(I4B), OPTIONAL, INTENT(IN) :: opt
    !! ncopy
    REAL(DFP), ALLOCATABLE :: ans(:, :)
  END FUNCTION DiffusionMatrix_11
END INTERFACE

INTERFACE DiffusionMatrix
  MODULE PROCEDURE DiffusionMatrix_11
END INTERFACE DiffusionMatrix

!----------------------------------------------------------------------------
!                                     DiffusionMatrix@DiffusionMatrixMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 6 March 2021
! summary: This subroutine returns the diffusion matrix in space domain

INTERFACE
  MODULE PURE FUNCTION DiffusionMatrix_12(test, trial, c1, c2, c1rank, &
    & c2rank, opt) RESULT(ans)
    CLASS(ElemshapeData_), INTENT(IN) :: test
    !! test function
    CLASS(ElemshapeData_), INTENT(IN) :: trial
    !! trial function
    CLASS(FEVariable_), INTENT(IN) :: c1
    !! Matrix
    CLASS(FEVariable_), INTENT(IN) :: c2
    !! Vector
    TYPE(FEVariableMatrix_), INTENT(IN) :: c1rank
    !! Matrix
    TYPE(FEVariableVector_), INTENT(IN) :: c2rank
    !! Vector
    INTEGER(I4B), OPTIONAL, INTENT(IN) :: opt
    !! ncopy
    REAL(DFP), ALLOCATABLE :: ans(:, :)
  END FUNCTION DiffusionMatrix_12
END INTERFACE

INTERFACE DiffusionMatrix
  MODULE PROCEDURE DiffusionMatrix_12
END INTERFACE DiffusionMatrix

!----------------------------------------------------------------------------
!                                     DiffusionMatrix@DiffusionMatrixMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 6 March 2021
! summary: This subroutine returns the diffusion matrix in space domain

INTERFACE
  MODULE PURE FUNCTION DiffusionMatrix_13(test, trial, c1, c2, c1rank, &
    & c2rank, opt) RESULT(ans)
    CLASS(ElemshapeData_), INTENT(IN) :: test
    !! test function
    CLASS(ElemshapeData_), INTENT(IN) :: trial
    !! trial function
    CLASS(FEVariable_), INTENT(IN) :: c1
    !! Matrix
    CLASS(FEVariable_), INTENT(IN) :: c2
    !! Matrix
    TYPE(FEVariableMatrix_), INTENT(IN) :: c1rank
    !! Matrix
    TYPE(FEVariableMatrix_), INTENT(IN) :: c2rank
    !! Matrix
    INTEGER(I4B), OPTIONAL, INTENT(IN) :: opt
    !! ncopy
    REAL(DFP), ALLOCATABLE :: ans(:, :)
  END FUNCTION DiffusionMatrix_13
END INTERFACE

INTERFACE DiffusionMatrix
  MODULE PROCEDURE DiffusionMatrix_13
END INTERFACE DiffusionMatrix

!----------------------------------------------------------------------------
!                                     DiffusionMatrix@DiffusionMatrixMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 1 May 2022
! summary: This subroutine returns the diffusion matrix in space domain
!
!# Introduction
!
! If opt is [1] then:
!
! $$
! \left[M\right]_{IJ}^{ij}=\int\frac{\partial N^{I}}{\partial x_{i}}
! \frac{\partial N^{J}}{\partial x_{j}}d\Omega
! $$
!
! If opt is [2] then:
!
! $$
! \left[M\right]_{IJ}^{ij}=\int\frac{\partial N^{I}}{\partial x_{j}}
! \frac{\partial N^{J}}{\partial x_{i}}d\Omega
! $$

INTERFACE
  MODULE PURE FUNCTION DiffusionMatrix_14(test, trial, opt) RESULT(ans)
    CLASS(ElemshapeData_), INTENT(IN) :: test
    CLASS(ElemshapeData_), INTENT(IN) :: trial
    INTEGER(I4B), INTENT(IN) :: opt(1)
    REAL(DFP), ALLOCATABLE :: ans(:, :)
  END FUNCTION DiffusionMatrix_14
END INTERFACE

INTERFACE DiffusionMatrix
  MODULE PROCEDURE DiffusionMatrix_14
END INTERFACE DiffusionMatrix

!----------------------------------------------------------------------------
!                                     DiffusionMatrix@DiffusionMatrixMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 6 March 2021
! summary: This subroutine returns the diffusion matrix in space domain
!
!# Introduction
!
! $$
! M(I,J)=\int\rho\frac{\partial N^{I}}{\partial x_{i}}\frac{\partial N^{J}}
! {\partial x_{i}}d\Omega
! $$
!

INTERFACE
  MODULE PURE FUNCTION DiffusionMatrix_15(test, trial, k, krank, opt) &
    & RESULT(ans)
    CLASS(ElemshapeData_), INTENT(IN) :: test
    !! test function
    CLASS(ElemshapeData_), INTENT(IN) :: trial
    !! trial function
    CLASS(FEVariable_), INTENT(IN) :: k
    !! scalar
    TYPE(FEVariableScalar_), INTENT(IN) :: krank
    !! scalar fe variable
    INTEGER(I4B), INTENT(IN) :: opt(1)
    REAL(DFP), ALLOCATABLE :: ans(:, :)
  END FUNCTION DiffusionMatrix_15
END INTERFACE

INTERFACE DiffusionMatrix
  MODULE PROCEDURE DiffusionMatrix_15
END INTERFACE DiffusionMatrix

END MODULE DiffusionMatrix_Method
