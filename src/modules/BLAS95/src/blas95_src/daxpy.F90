!===============================================================================
! Copyright 2005-2020 Intel Corporation.
!
! This software and the related documents are Intel copyrighted  materials,  and
! your !USE of  them is  governed by the  express license  under which  they were
! provided to you (License).  Unless the License provides otherwise, you may not
! !USE, modify, copy, publish, distribute,  disclose or transmit this software or
! the related documents without Intel's prior written permission.
!
! This software and the related documents  are provided as  is,  with no express
! or implied  warranties,  other  than those  that are  expressly stated  in the
! License.
!===============================================================================

!  Content:
!      F95 interface for BLAS routines
!*******************************************************************************
! This file was generated automatically!
!*******************************************************************************

PURE SUBROUTINE DAXPY_F95(X,Y,A)
    ! Fortran77 call:
    ! DAXPY(N,A,X,INCX,Y,INCY)
    ! Default A=1
    ! <<< !USE statements >>>
    !USE F77_BLAS, ONLY: F77_AXPY
    ! <<< Implicit statement >>>
    !IMPLICIT NONE
    ! <<< Kind parameter >>>
    INTEGER, PARAMETER :: WP = KIND(1.0D0)
    ! <<< Scalar arguments >>>
    REAL(WP), INTENT(IN), OPTIONAL :: A
    ! <<< Array arguments >>>
    REAL(WP), INTENT(IN) :: X(:)
    REAL(WP), INTENT(INOUT ) :: Y(:)
    ! <<< Local declarations >>>
    ! <<< Parameters >>>
    CHARACTER(LEN=4), PARAMETER :: SRNAME = 'AXPY'
    ! <<< Local scalars >>>
    REAL(WP) :: O_A
    INTEGER :: INCX
    INTEGER :: INCY
    INTEGER :: N
    ! <<< Intrinsic functions >>>
    INTRINSIC PRESENT, SIZE
    ! <<< Executable statements >>>
    ! <<< Init optional and skipped scalars >>>
    IF(PRESENT(A)) THEN
        O_A = A
    ELSE
        O_A = 1
    ENDIF
    INCX = 1
    INCY = 1
    N = SIZE(X)
    ! <<< Call blas77 routine >>>
    CALL F77_AXPY(N,O_A,X,INCX,Y,INCY)
END SUBROUTINE DAXPY_F95
