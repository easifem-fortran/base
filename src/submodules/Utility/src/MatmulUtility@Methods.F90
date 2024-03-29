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
! date:         3 April 2021
! summary:         Methods for matrix multiplication

SUBMODULE(MatmulUtility) Methods
IMPLICIT NONE
CONTAINS

!----------------------------------------------------------------------------
!                                                                     MATMUL
!----------------------------------------------------------------------------

MODULE PROCEDURE matmul_r4_r1
INTEGER(I4B) :: ii
ans = a2(1) * a1(:, :, :, 1)
DO ii = 2, SIZE(a2)
  ans = ans + a2(ii) * a1(:, :, :, ii)
END DO
END PROCEDURE matmul_r4_r1

!----------------------------------------------------------------------------
!                                                                     MATMUL
!----------------------------------------------------------------------------

MODULE PROCEDURE matmul_r4_r2
INTEGER(I4B) :: ii
!!
DO ii = 1, SIZE(a2, 2)
  ans(:,:,:,ii) = matmul(a1, a2(:,ii))
END DO
END PROCEDURE matmul_r4_r2

!----------------------------------------------------------------------------
!                                                                     MATMUL
!----------------------------------------------------------------------------

MODULE PROCEDURE matmul_r4_r3
INTEGER(I4B) :: ii
!!
DO ii = 1, SIZE(a2, 3)
  ans(:,:,:,:,ii) = matmul(a1, a2(:,:,ii))
END DO
END PROCEDURE matmul_r4_r3

!----------------------------------------------------------------------------
!                                                                     MATMUL
!----------------------------------------------------------------------------

MODULE PROCEDURE matmul_r4_r4
INTEGER(I4B) :: ii
!!
DO ii = 1, SIZE(a2, 4)
  ans(:,:,:,:,:,ii) = matmul(a1, a2(:,:,:,ii))
END DO
END PROCEDURE matmul_r4_r4

!----------------------------------------------------------------------------
!                                                                     MATMUL
!----------------------------------------------------------------------------

MODULE PROCEDURE matmul_r3_r1
INTEGER(I4B) :: ii
ans = a2(1) * a1(:, :, 1)
DO ii = 2, SIZE(a2)
  ans = ans + a2(ii) * a1(:, :, ii)
END DO
END PROCEDURE matmul_r3_r1

!----------------------------------------------------------------------------
!                                                                     MATMUL
!----------------------------------------------------------------------------

MODULE PROCEDURE matmul_r3_r2
INTEGER(I4B) :: ii
DO ii = 1, SIZE(a2, 2)
  ans(:, :, ii) = MATMUL(a1, a2(:, ii))
END DO
END PROCEDURE matmul_r3_r2

!----------------------------------------------------------------------------
!                                                                     MATMUL
!----------------------------------------------------------------------------

MODULE PROCEDURE matmul_r3_r3
INTEGER(I4B) :: ii
DO ii = 1, SIZE(a2, 3)
  ans(:,:,:,ii) = matmul(a1, a2(:, :, ii))
END DO
END PROCEDURE matmul_r3_r3

!----------------------------------------------------------------------------
!                                                                     MATMUL
!----------------------------------------------------------------------------

MODULE PROCEDURE matmul_r3_r4
INTEGER(I4B) :: ii
DO ii = 1, SIZE(a2, 4)
  ans(:,:,:,:,ii) = matmul(a1, a2(:, :, :,ii))
END DO
END PROCEDURE matmul_r3_r4

!----------------------------------------------------------------------------
!                                                                     MATMUL
!----------------------------------------------------------------------------

MODULE PROCEDURE matmul_r2_r3
INTEGER(I4B) :: ii
DO ii = 1, SIZE(a2, 3)
  ans(:, :, ii) = MATMUL(a1, a2(:, :, ii))
END DO
END PROCEDURE matmul_r2_r3

!----------------------------------------------------------------------------
!                                                                     MATMUL
!----------------------------------------------------------------------------

MODULE PROCEDURE matmul_r2_r4
INTEGER(I4B) :: ii
DO ii = 1, SIZE(a2, 4)
  ans(:, :, :, ii) = MATMUL(a1, a2(:, :, :, ii))
END DO
END PROCEDURE matmul_r2_r4

!----------------------------------------------------------------------------
!                                                                     MATMUL
!----------------------------------------------------------------------------

MODULE PROCEDURE matmul_r1_r1
  ans = DOT_PRODUCT(a1, a2)
END PROCEDURE matmul_r1_r1

!----------------------------------------------------------------------------
!                                                                     MATMUL
!----------------------------------------------------------------------------

MODULE PROCEDURE matmul_r1_r3
INTEGER(I4B) :: ii
ans = a1(1) * a2(1, :, :)
DO ii = 2, SIZE(a1)
  ans = ans + a1(ii) * a2(ii, :, :)
END DO
END PROCEDURE matmul_r1_r3

!----------------------------------------------------------------------------
!                                                                     MATMUL
!----------------------------------------------------------------------------

MODULE PROCEDURE matmul_r1_r4
INTEGER(I4B) :: ii
ans = a1(1) * a2(1, :, :, :)
DO ii = 2, SIZE(a1)
  ans = ans + a1(ii) * a2(ii, :, :, :)
END DO
END PROCEDURE matmul_r1_r4

END SUBMODULE Methods
