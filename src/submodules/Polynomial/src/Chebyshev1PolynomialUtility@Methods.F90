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

SUBMODULE(Chebyshev1PolynomialUtility) Methods
USE BaseMethod
IMPLICIT NONE
CONTAINS

!----------------------------------------------------------------------------
!                                                       Chebyshev1Alpha
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1Alpha
ans = 0.0_DFP
END PROCEDURE Chebyshev1Alpha

!----------------------------------------------------------------------------
!                                                       Chebyshev1Beta
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1Beta
SELECT CASE (n)
CASE (0_I4B)
  ans = pi
CASE (1_I4B)
  ans = 0.5_DFP
CASE DEFAULT
  ans = 0.25_DFP
END SELECT
END PROCEDURE Chebyshev1Beta

!----------------------------------------------------------------------------
!                                              GetChebyshev1RecurrenceCoeff
!----------------------------------------------------------------------------

MODULE PROCEDURE GetChebyshev1RecurrenceCoeff
IF (n .LE. 0) RETURN
alphaCoeff = 0.0_DFP
betaCoeff(0) = pi
IF (n .EQ. 1) RETURN
betaCoeff(1) = 0.5_DFP
IF (n .EQ. 2) RETURN
betaCoeff(2:) = 0.25_DFP
END PROCEDURE GetChebyshev1RecurrenceCoeff

!----------------------------------------------------------------------------
!                                              GetChebyshev1RecurrenceCoeff
!----------------------------------------------------------------------------

MODULE PROCEDURE GetChebyshev1RecurrenceCoeff2
IF (n .LE. 0) RETURN
A = 2.0_DFP
B = 0.0_DFP
C = 1.0_DFP
END PROCEDURE GetChebyshev1RecurrenceCoeff2

!----------------------------------------------------------------------------
!                                                     Chebyshev1LeadingCoeff
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1LeadingCoeff
IF (n .EQ. 0_I4B) THEN
  ans = 1.0_DFP
ELSE
  ans = 2.0_DFP**(n - 1_I4B)
END IF
END PROCEDURE Chebyshev1LeadingCoeff

!----------------------------------------------------------------------------
!                                                Chebyshev1LeadingCoeffRatio
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1LeadingCoeffRatio
IF (n .EQ. 0_I4B) THEN
  ans = 1.0_DFP
ELSE
  ans = 2.0_DFP
END IF
END PROCEDURE Chebyshev1LeadingCoeffRatio

!----------------------------------------------------------------------------
!                                                          Chebyshev1NormSQR
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1NormSQR
IF (n .EQ. 0_I4B) THEN
  ans = pi
ELSE
  ans = pi / 2.0_DFP
END IF
END PROCEDURE Chebyshev1NormSQR

!----------------------------------------------------------------------------
!                                                        Chebyshev1NormSQR2
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1NormSQR2
ans(0) = pi
IF (n .EQ. 0) RETURN
ans(1:) = 0.5_DFP * pi
END PROCEDURE Chebyshev1NormSQR2

!----------------------------------------------------------------------------
!                                                    Chebyshev1NormSQRRatio
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1NormSQRRatio
ans = 1.0_DFP
END PROCEDURE Chebyshev1NormSQRRatio

!----------------------------------------------------------------------------
!                                                     Chebyshev1JacobiMatrix
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1JacobiMatrix
CALL JacobiJacobiMatrix(n=n, alpha=-0.5_DFP, beta=-0.5_DFP, &
  & D=D, E=E, alphaCoeff=alphaCoeff, betaCoeff=betaCoeff)
END PROCEDURE Chebyshev1JacobiMatrix

!----------------------------------------------------------------------------
!                                                   Chebyshev1GaussQuadrature
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1GaussQuadrature
pt = Chebyshev1Zeros(n=n)
IF (PRESENT(wt)) wt = pi / n
END PROCEDURE Chebyshev1GaussQuadrature

!----------------------------------------------------------------------------
!                                                Chebyshev1JacobiRadauMatrix
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1JacobiRadauMatrix
CALL JacobiJacobiRadauMatrix(a=a, n=n, alpha=-0.5_DFP, beta=-0.5_DFP, &
  & D=D, E=E, alphaCoeff=alphaCoeff, betaCoeff=betaCoeff)
END PROCEDURE Chebyshev1JacobiRadauMatrix

!----------------------------------------------------------------------------
!                                             Chebyshev1GaussRadauQuadrature
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1GaussRadauQuadrature
INTEGER(I4B) :: ii, c
REAL(DFP) :: avar, avar2
!!
IF (a .LT. 0.0_DFP) THEN
  c = 0_I4B
ELSE
  c = 1_I4B
END IF
!!
avar = pi / (2.0_DFP * n + 1.0_DFP)
!!
avar2 = pi / (2.0_DFP * n + 1.0_DFP)
!!
IF (PRESENT(wt)) THEN
  DO ii = 0, n
    pt(ii + 1) = -COS(avar * (2 * ii + c))
    wt(ii + 1) = avar2
  END DO
!!
  wt(1) = wt(1) / 2.0_DFP
ELSE
  DO ii = 0, n
    pt(ii + 1) = -COS(avar * (2 * ii + c))
  END DO
END IF
!!
END PROCEDURE Chebyshev1GaussRadauQuadrature

!----------------------------------------------------------------------------
!                                             Chebyshev1JacobiLobattoMatrix
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1JacobiLobattoMatrix
CALL JacobiJacobiLobattoMatrix(n=n, alpha=-0.5_DFP, beta=-0.5_DFP, &
  & D=D, E=E, alphaCoeff=alphaCoeff, betaCoeff=betaCoeff)
END PROCEDURE Chebyshev1JacobiLobattoMatrix

!----------------------------------------------------------------------------
!                                           Chebyshev1GaussLobattoQuadrature
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1GaussLobattoQuadrature
INTEGER(I4B) :: ii
REAL(DFP) :: avar
!!
avar = pi / (n + 1.0_DFP)
!!
IF (PRESENT(wt)) THEN
  wt = avar
  wt(1) = wt(1) / 2.0_DFP
  wt(n + 2) = wt(n + 2) / 2.0_DFP
END IF
!!
DO ii = 0, n + 1
  pt(ii + 1) = -COS(avar * ii)
END DO
!!
END PROCEDURE Chebyshev1GaussLobattoQuadrature

!----------------------------------------------------------------------------
!                                                           Chebyshev1Zeros
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1Zeros
INTEGER(I4B) :: ii
REAL(DFP) :: aval
aval = pi * 0.5_DFP / REAL(n, KIND=DFP)
DO ii = 1, n
  ans(ii) = -COS((2.0_DFP * ii - 1.0_DFP) * aval)
END DO
END PROCEDURE Chebyshev1Zeros

!----------------------------------------------------------------------------
!                                                       Chebyshev1Quadrature
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1Quadrature
INTEGER(I4B) :: order
REAL(DFP), PARAMETER :: left = -1.0_DFP, right = 1.0_DFP
REAL(DFP), ALLOCATABLE :: p(:), w(:)
LOGICAL(LGT) :: inside
!!
IF (PRESENT(onlyInside)) THEN
  inside = onlyInside
ELSE
  inside = .FALSE.
END IF
!!
SELECT CASE (QuadType)
CASE (Gauss)
  !!
  order = n
  CALL Chebyshev1GaussQuadrature(n=order, pt=pt, wt=wt)
  !!
CASE (GaussRadau, GaussRadauLeft)
  !!
  IF (inside) THEN
    order = n
    ALLOCATE (p(n + 1), w(n + 1))
    CALL Chebyshev1GaussRadauQuadrature(a=left, n=order, pt=p, wt=w)
    pt = p(2:); wt = w(2:)
    DEALLOCATE (p, w)
  ELSE
    order = n - 1
    CALL Chebyshev1GaussRadauQuadrature(a=left, n=order, pt=pt, wt=wt)
  END IF
  !!
CASE (GaussRadauRight)
  !!
  IF (inside) THEN
    order = n
    ALLOCATE (p(n + 1), w(n + 1))
    CALL Chebyshev1GaussRadauQuadrature(a=right, n=order, pt=p, wt=w)
    pt = p(1:n); wt = w(1:n)
  ELSE
    order = n - 1
    CALL Chebyshev1GaussRadauQuadrature(a=right, n=order, pt=pt, wt=wt)
  END IF
  !!
CASE (GaussLobatto)
  !!
  IF (inside) THEN
    order = n
    ALLOCATE (p(n + 2), w(n + 2))
    CALL Chebyshev1GaussLobattoQuadrature(n=order, pt=p, wt=w)
    pt = p(2:n + 1); wt = w(2:n + 1)
  ELSE
    order = n - 2
    CALL Chebyshev1GaussLobattoQuadrature(n=order, pt=pt, wt=wt)
  END IF
END SELECT
  !!
END PROCEDURE Chebyshev1Quadrature

!----------------------------------------------------------------------------
!                                                             Chebyshev1Eval1
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1Eval1
INTEGER(I4B) :: i
REAL(DFP) :: ans_1, ans_2
!!
ans = 0.0_DFP
!!
IF (n < 0) THEN
  RETURN
END IF
!!
ans = 1.0_DFP
ans_2 = ans
!!
IF (n .EQ. 0) THEN
  RETURN
END IF
!!
ans = x
!!
DO i = 1, n - 1
  !!
  ans_1 = ans
  ans = (2.0_DFP * x) * ans - ans_2
  ans_2 = ans_1
  !!
END DO
END PROCEDURE Chebyshev1Eval1

!----------------------------------------------------------------------------
!                                                            Chebyshev1Eval2
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1Eval2
INTEGER(I4B) :: i
REAL(DFP), DIMENSION(SIZE(x)) :: ans_1, ans_2
!!
ans = 0.0_DFP
!!
IF (n < 0) THEN
  RETURN
END IF
!!
ans = 1.0_DFP
ans_2 = ans
!!
IF (n .EQ. 0) THEN
  RETURN
END IF
!!
ans = x
!!
DO i = 1, n - 1
  !!
  ans_1 = ans
  ans = (2.0_DFP * x) * ans - ans_2
  ans_2 = ans_1
  !!
END DO
END PROCEDURE Chebyshev1Eval2

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1EvalAll1
INTEGER(I4B) :: i
!!
ans = 0.0_DFP
!!
IF (n < 0) THEN
  RETURN
END IF
!!
ans(1) = 1.0_DFP
!!
IF (n .EQ. 0) THEN
  RETURN
END IF
!!
ans(2) = x
!!
DO i = 2, n
  ans(i + 1) = (2.0_DFP * x) * ans(i) - ans(i - 1)
END DO
!!
END PROCEDURE Chebyshev1EvalAll1

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1EvalAll2
INTEGER(I4B) :: i
!!
ans = 0.0_DFP
!!
IF (n < 0) THEN
  RETURN
END IF
!!
ans(:, 1) = 1.0_DFP
!!
IF (n .EQ. 0) THEN
  RETURN
END IF
!!
ans(:, 2) = x
!!
DO i = 2, n
  ans(:, i + 1) = (2.0_DFP * x) * ans(:, i) - ans(:, i - 1)
END DO
!!
END PROCEDURE Chebyshev1EvalAll2

!----------------------------------------------------------------------------
!                                             Chebyshev1MonomialExpansionAll
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1MonomialExpansionAll
INTEGER(I4B), PARAMETER :: rk = 1.0_DFP
INTEGER(I4B) :: ii
!!
IF (n < 0) THEN
  RETURN
END IF
!!
ans = 0.0_DFP
ans(1, 1) = 1.0_DFP
!!
IF (n .EQ. 0) THEN
  RETURN
END IF
!!
ans(2, 2) = 1.0_DFP
!!
DO ii = 2, n
  !!
  ! ans(ii + 1, 1) = -ans(ii - 1, 1)
  ans(1, ii + 1) = -ans(1, ii - 1)
  !!
  ! ans(ii + 1, 2:ii - 1) = 2.0_DFP*ans(ii, 1:ii - 2) - ans(ii - 1, 2:ii - 1)
  ans(2:ii - 1, ii + 1) = 2.0_DFP * ans(1:ii - 2, ii) - ans(2:ii - 1, ii - 1)
  !!
  ! ans(ii + 1, ii) = 2.0_DFP * ans(ii, ii - 1)
  ans(ii, ii + 1) = 2.0_DFP * ans(ii - 1, ii)
  !!
  ! ans(ii + 1, ii + 1) = 2.0_DFP * ans(ii, ii)
  ans(ii + 1, ii + 1) = 2.0_DFP * ans(ii, ii)
  !!
END DO
!!
END PROCEDURE Chebyshev1MonomialExpansionAll

!----------------------------------------------------------------------------
!                                             Chebyshev1MonomialExpansion
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1MonomialExpansion
REAL(DFP) :: coeff(n + 1, n + 1)
coeff = Chebyshev1MonomialExpansionAll(n)
ans = coeff(:, n + 1)
END PROCEDURE Chebyshev1MonomialExpansion

!----------------------------------------------------------------------------
!                                             Chebyshev1GradientEvalAll1
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1GradientEvalAll1
!!
INTEGER(I4B) :: ii
REAL(DFP) :: p(1:n + 1), r_ii
!!
IF (n < 0) THEN
  RETURN
END IF
!!
p(1) = 1.0_DFP
ans(1) = 0.0_DFP
!!
IF (n < 1) THEN
  RETURN
END IF
!!
IF (n .EQ. 0_I4B) RETURN
!!
p(2) = x
ans(2) = 1.0_DFP
!!
IF (n .EQ. 1_I4B) RETURN
!!
p(3) = 2.0_DFP * x**2 - 1.0_DFP
ans(3) = 4.0_DFP * x
!!
DO ii = 3, n
  !!
  r_ii = REAL(ii, KIND=DFP)
  p(ii + 1) = (2.0_DFP * x) * p(ii) - p(ii - 1)
  ans(ii + 1) = 2.0_DFP * r_ii * p(ii) &
              & + r_ii * ans(ii - 1) / (r_ii - 2.0_DFP)
  !!
END DO
!!
END PROCEDURE Chebyshev1GradientEvalAll1

!----------------------------------------------------------------------------
!                                             Chebyshev1GradientEvalAll2
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1GradientEvalAll2
!!
INTEGER(I4B) :: ii
REAL(DFP) :: p(1:SIZE(x), 1:n + 1), r_ii
!!
IF (n < 0) THEN
  RETURN
END IF
!!
p(:, 1) = 1.0_DFP
ans(:, 1) = 0.0_DFP
!!
IF (n < 1) THEN
  RETURN
END IF
!!
IF (n .EQ. 0_I4B) RETURN
!!
p(:, 2) = x
ans(:, 2) = 1.0_DFP
!!
IF (n .EQ. 1_I4B) RETURN
!!
p(:, 3) = 2.0_DFP * x**2 - 1.0_DFP
ans(:, 3) = 4.0_DFP * x
!!
DO ii = 3, n
  !!
  r_ii = REAL(ii, KIND=DFP)
  p(:, ii + 1) = (2.0_DFP * x) * p(:, ii) - p(:, ii - 1)
  ans(:, ii + 1) = 2.0_DFP * r_ii * p(:, ii) &
              & + r_ii * ans(:, ii - 1) / (r_ii - 2.0_DFP)
  !!
END DO
!!
END PROCEDURE Chebyshev1GradientEvalAll2

!----------------------------------------------------------------------------
!                                             Chebyshev1GradientEval1
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1GradientEval1
!
INTEGER(I4B) :: ii
REAL(DFP) :: r_ii, p, p_1, p_2, ans_1, ans_2
!!
IF (n < 0) THEN
  RETURN
END IF
!!
p = 1.0_DFP
ans = 0.0_DFP
p_2 = p
ans_2 = ans
!!
IF (n < 1) THEN
  RETURN
END IF
!!
IF (n .EQ. 0_I4B) RETURN
!!
p = x
ans = 1.0_DFP
p_2 = p
ans_2 = ans
!!
IF (n .EQ. 1_I4B) RETURN
!!
p = 2.0_DFP * x**2 - 1.0_DFP
ans = 4.0_DFP * x
!!
DO ii = 3, n
  !!
  r_ii = REAL(ii, KIND=DFP)
  p_1 = p
  p = (2.0_DFP * x) * p - p_2
  p_2 = p_1
  !!
  ans_1 = ans
  ans = 2.0_DFP * r_ii * p_1 &
      & + r_ii * ans_2 / (r_ii - 2.0_DFP)
  ans_2 = ans_1
  !!
END DO
!!
END PROCEDURE Chebyshev1GradientEval1

!----------------------------------------------------------------------------
!                                             Chebyshev1GradientEval2
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1GradientEval2
!!
INTEGER(I4B) :: ii
REAL(DFP) :: r_ii
REAL(DFP), DIMENSION(SIZE(x)) :: p, p_1, p_2, ans_1, ans_2
!!
IF (n < 0) THEN
  RETURN
END IF
!!
p = 1.0_DFP
ans = 0.0_DFP
p_2 = p
ans_2 = ans
!!
IF (n < 1) THEN
  RETURN
END IF
!!
IF (n .EQ. 0_I4B) RETURN
!!
p = x
ans = 1.0_DFP
p_2 = p
ans_2 = ans
!!
IF (n .EQ. 1_I4B) RETURN
!!
p = 2.0_DFP * x**2 - 1.0_DFP
ans = 4.0_DFP * x
!!
DO ii = 3, n
  !!
  r_ii = REAL(ii, KIND=DFP)
  p_1 = p
  p = (2.0_DFP * x) * p - p_2
  p_2 = p_1
  !!
  ans_1 = ans
  ans = 2.0_DFP * r_ii * p_1 &
      & + r_ii * ans_2 / (r_ii - 2.0_DFP)
  ans_2 = ans_1
  !!
END DO
!!
END PROCEDURE Chebyshev1GradientEval2

!----------------------------------------------------------------------------
!                                                         Chebyshev1EvalSum
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1EvalSum1
REAL(DFP) :: xx, t, b1, b2
INTEGER(I4B) :: i
!!
IF (n .LT. 0) RETURN
b1 = 0.0_DFP
b2 = 0.0_DFP
xx = 2.0_DFP * x
!!
DO i = n, 1, -1
  t = xx * b1 - b2 + coeff(i)
  b2 = b1
  b1 = t
END DO
ans = x * b1 - b2 + coeff(0)
END PROCEDURE Chebyshev1EvalSum1

!----------------------------------------------------------------------------
!                                                         Chebyshev1EvalSum
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1EvalSum2
REAL(DFP), DIMENSION(SIZE(x)) :: xx, t, b1, b2
INTEGER(I4B) :: i
!!
IF (n .LT. 0) RETURN
b1 = 0.0_DFP
b2 = 0.0_DFP
xx = 2.0_DFP * x
!!
DO i = n, 1, -1
  t = xx * b1 - b2 + coeff(i)
  b2 = b1
  b1 = t
END DO
ans = x * b1 - b2 + coeff(0)
END PROCEDURE Chebyshev1EvalSum2

!----------------------------------------------------------------------------
!                                                 Chebyshev1GradientEvalSum
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1GradientEvalSum1
REAL(DFP) :: xx, t, b1, b2
INTEGER(I4B) :: i
IF (n .LT. 0) RETURN
b1 = 0.0_DFP
b2 = 0.0_DFP
xx = 2.0_DFP * x
!!
DO i = n - 1, 0, -1
  t = xx * b1 - b2 + (i + 1) * coeff(i + 1);
  b2 = b1;
  b1 = t;
END DO
!!
ans = b1
END PROCEDURE Chebyshev1GradientEvalSum1

!----------------------------------------------------------------------------
!                                                  Chebyshev1GradientEvalSum
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1GradientEvalSum2
REAL(DFP), DIMENSION(SIZE(x)) :: xx, t, b1, b2
INTEGER(I4B) :: i
IF (n .LT. 0) RETURN
b1 = 0.0_DFP
b2 = 0.0_DFP
xx = 2.0_DFP * x
!!
DO i = n - 1, 0, -1
  t = xx * b1 - b2 + (i + 1) * coeff(i + 1);
  b2 = b1;
  b1 = t;
END DO
!!
ans = b1
END PROCEDURE Chebyshev1GradientEvalSum2

!----------------------------------------------------------------------------
!                                                  Chebyshev1GradientEvalSum
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1GradientEvalSum3
REAL(DFP) :: s, t, b1, b2
INTEGER(I4B) :: i
REAL(DFP) :: j
!!
IF (n .LT. 0) RETURN
!!
IF (k .EQ. 0) THEN
  !!
  ans = Chebyshev1EvalSum(coeff=coeff, n=n, x=x)
  !!
ELSE
  !!
  b1 = 0.0_DFP
  b2 = 0.0_DFP
  s = 1.0_DFP
  !!
  DO i = k - 1, 1, -1
    s = 2.0_DFP * s * i
  END DO
  !!
  DO i = n - k, 0, -1
    j = REAL(i, KIND=DFP)
    t = 2 * (j + k) / (j + 1) * x * b1 - (j + 2 * k) &
      & / (j + 2) * b2 + (j + k) * coeff(i + k);
    b2 = b1;
    b1 = t;
  END DO
  !!
  ans = s * b1
END IF
END PROCEDURE Chebyshev1GradientEvalSum3

!----------------------------------------------------------------------------
!                                                  Chebyshev1GradientEvalSum
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1GradientEvalSum4
REAL(DFP) :: s
REAL(DFP), DIMENSION(SIZE(x)) :: t, b1, b2
INTEGER(I4B) :: i
REAL(DFP) :: j
!!
IF (n .LT. 0) RETURN
!!
IF (k .EQ. 0) THEN
  !!
  ans = Chebyshev1EvalSum(coeff=coeff, n=n, x=x)
  !!
ELSE
  !!
  b1 = 0.0_DFP
  b2 = 0.0_DFP
  s = 1.0_DFP
  !!
  DO i = k - 1, 1, -1
    s = 2.0_DFP * s * i
  END DO
  !!
  DO i = n - k, 0, -1
    j = REAL(i, KIND=DFP)
    t = 2 * (j + k) / (j + 1) * x * b1 - (j + 2 * k) &
      & / (j + 2) * b2 + (j + k) * coeff(i + k);
    b2 = b1;
    b1 = t;
  END DO
  !!
  ans = s * b1
END IF

END PROCEDURE Chebyshev1GradientEvalSum4

!----------------------------------------------------------------------------
!                                                   Chebyshev1Transform
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1Transform1
REAL(DFP), DIMENSION(0:n) :: nrmsqr, temp
REAL(DFP), DIMENSION(0:n, 0:n) :: PP
INTEGER(I4B) :: jj
REAL(DFP) :: rn
!!
nrmsqr = Chebyshev1NormSQR2(n=n)
!!
!! Correct nrmsqr(n)
!!
rn = REAL(n, KIND=DFP)
!!
IF (quadType .EQ. GaussLobatto) THEN
  nrmsqr(n) = pi
END IF
!!
PP = Chebyshev1EvalAll(n=n, x=x)
!!
DO jj = 0, n
  temp = PP(:, jj) * w * coeff
  ans(jj) = SUM(temp) / nrmsqr(jj)
END DO
!!
END PROCEDURE Chebyshev1Transform1

!----------------------------------------------------------------------------
!                                                    Chebyshev1Transform
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1Transform2
REAL(DFP), DIMENSION(0:n) :: nrmsqr, temp
REAL(DFP), DIMENSION(0:n, 0:n) :: PP
INTEGER(I4B) :: jj, kk
REAL(DFP) :: rn
!!
nrmsqr = Chebyshev1NormSQR2(n=n)
!!
!! Correct nrmsqr(n)
!!
rn = REAL(n, KIND=DFP)
!!
IF (quadType .EQ. GaussLobatto) THEN
  nrmsqr(n) = pi
END IF
!!
PP = Chebyshev1EvalAll(n=n, x=x)
!!
DO kk = 1, SIZE(coeff, 2)
  DO jj = 0, n
    temp = PP(:, jj) * w * coeff(:, kk)
    ans(jj, kk) = SUM(temp) / nrmsqr(jj)
  END DO
END DO
!!
END PROCEDURE Chebyshev1Transform2

!----------------------------------------------------------------------------
!                                                    Chebyshev1Transform
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1Transform3
REAL(DFP) :: pt(0:n), wt(0:n), coeff(0:n)
INTEGER(I4B) :: ii
!!
CALL Chebyshev1Quadrature(n=n + 1, pt=pt, wt=wt,&
  & quadType=quadType)
!!
DO ii = 0, n
  coeff(ii) = f(pt(ii))
END DO
!!
ans = Chebyshev1Transform(n=n, coeff=coeff, x=pt, &
  & w=wt, quadType=quadType)
!!
END PROCEDURE Chebyshev1Transform3

!----------------------------------------------------------------------------
!                                                  Chebyshev1Transform4
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1Transform4
INTEGER(I4B) :: ii, jj
REAL(DFP) :: avar
!!
ans = 0.0_DFP
!!
IF (quadType .EQ. GaussLobatto) THEN
  !!
  DO jj = 0, n
    !!
    ans(jj) = coeff(0) * 0.5_DFP + coeff(n) * 0.5_DFP * (-1.0)**jj
    !!
    DO ii = 1, n - 1
      ans(jj) = ans(jj) + coeff(ii) * COS(jj * pi * ii / n)
    END DO
    !!
    ans(jj) = ans(jj) * 2.0_DFP / n
    !!
  END DO
  !!
  ans(0) = ans(0) * 0.5_DFP
  ans(n) = ans(n) * 0.5_DFP
  !!
ELSE
  !!
  DO jj = 0, n
    !!
    avar = jj * pi * 0.5_DFP / (n + 1.0_DFP)
    !!
    DO ii = 0, n
      ans(jj) = ans(jj) + coeff(ii) * COS((2.0 * ii + 1.0) * avar)
    END DO
    !!
    ans(jj) = ans(jj) * 2.0_DFP / (n + 1.0)
    !!
  END DO
  !!
  ans(0) = ans(0) * 0.5_DFP
  !!
END IF
!!
END PROCEDURE Chebyshev1Transform4

!----------------------------------------------------------------------------
!                                                Chebyshev1InvTransform
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1InvTransform1
ans = Chebyshev1EvalSum(n=n, coeff=coeff, x=x)
END PROCEDURE Chebyshev1InvTransform1

!----------------------------------------------------------------------------
!                                                Chebyshev1InvTransform
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1InvTransform2
ans = Chebyshev1EvalSum(n=n, coeff=coeff, x=x)
END PROCEDURE Chebyshev1InvTransform2

!----------------------------------------------------------------------------
!                                                Chebyshev1GradientCoeff
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1GradientCoeff1
REAL(DFP) :: a, b, c
INTEGER(I4B) :: ii
REAL(DFP) :: jj
!!
ans(n) = 0.0_DFP
IF (n .EQ. 0) RETURN
!!
IF (n .EQ. 1) THEN
  c = 2.0_DFP
ELSE
  c = 1.0_DFP
END IF
!!
ans(n - 1) = 2.0_DFP * n * coeff(n) / c
!!
DO ii = n - 1, 1, -1
  jj = REAL(ii, KIND=DFP)
  ans(ii - 1) = 2.0_DFP * jj * coeff(ii) + ans(ii + 1)
END DO
!!
ans(0) = 0.5_DFP * ans(0)
!!
END PROCEDURE Chebyshev1GradientCoeff1

!----------------------------------------------------------------------------
!                                                          Chebyshev1DMatrix
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1DMatrix1
SELECT CASE (quadType)
CASE (GaussLobatto)
  CALL Chebyshev1DMatrixGL2(n=n, x=x, D=ans)
CASE (Gauss)
  CALL Chebyshev1DMatrixG2(n=n, x=x, D=ans)
END SELECT
END PROCEDURE Chebyshev1DMatrix1

!----------------------------------------------------------------------------
!                                                    Chebyshev1DMatrixGL
!----------------------------------------------------------------------------

PURE SUBROUTINE Chebyshev1DMatrixGL2(n, x, D)
  INTEGER(I4B), INTENT(IN) :: n
  !! order of Jacobi polynomial
  REAL(DFP), INTENT(IN) :: x(0:n)
  !! quadrature points
  REAL(DFP), INTENT(OUT) :: D(0:n, 0:n)
  !! D matrix
  !!
  !! main
  !!
  REAL(DFP) :: rn, j1, j2
  INTEGER(I4B) :: ii, jj, nb2
  !!
  nb2 = int(n / 2)
  rn = REAL(n, KIND=DFP)
  !!
  D = 0.0_DFP
  !!
  DO jj = 0, n
    DO ii = 0, nb2
      j1 = SIN(0.5 * (ii + jj) * pi / rn)
      j2 = SIN(0.5 * (ii - jj) * pi / rn)
      IF (ii .NE. jj) &
        & D(ii, jj) = 0.5 * (-1)**(ii + jj) / j1 / j2
    END DO
  END DO
  !!
  D(0, :) = D(0, :) * 2.0_DFP
  D(:, 0) = D(:, 0) * 0.5_DFP
  D(:, n) = D(:, n) * 0.5_DFP
  !!
  !! correct diagonal entries
  !!
  D(0, 0) = -(2.0_DFP * rn**2 + 1.0_DFP) / 6.0_DFP
  !!
  DO ii = 1, nb2
    D(ii, ii) = -x(ii) * 0.5_DFP / (SIN(pi * ii / rn))**2
  END DO
  !!
  !! copy
  !!
  DO jj = 0, n
    DO ii = 0, nb2
      D(n - ii, n - jj) = -D(ii, jj)
    END DO
  END DO
  !!
END SUBROUTINE Chebyshev1DMatrixGL2

!----------------------------------------------------------------------------
!                                                    Chebyshev1DMatrixG
!----------------------------------------------------------------------------

PURE SUBROUTINE Chebyshev1DMatrixG(n, x, D)
  INTEGER(I4B), INTENT(IN) :: n
  !! order of Jacobi polynomial
  REAL(DFP), INTENT(IN) :: x(0:n)
  !! quadrature points
  REAL(DFP), INTENT(OUT) :: D(0:n, 0:n)
  !! D matrix
  !!
  !! internal variables
  !!
  REAL(DFP) :: rn, j3, j4
  INTEGER(I4B) :: ii, jj, nb2
  !!
  !! main
  !!
  rn = REAL(n, KIND=DFP)
  nb2 = int(n / 2)
  D = 0.0_DFP
  !!
  DO jj = 0, n
    j4 = (rn + 1.0) * SIN((2.0 * jj + 1) * 0.5 * pi) &
    & / SIN((2.0 * jj + 1) * 0.5 * pi / (rn + 1.0))
    DO ii = 0, nb2
      j3 = (rn + 1.0) * SIN((2.0 * ii + 1) * 0.5 * pi) &
      & / SIN((2.0 * ii + 1) * 0.5 * pi / (rn + 1.0))
      IF (ii .NE. jj) &
        & D(ii, jj) = j3 / j4 / (x(ii) - x(jj))
    END DO
  END DO
  !!
  !! correct diagonal entries
  !!
  DO ii = 0, nb2
    D(ii, ii) = x(ii) * 0.5_DFP / (1.0_DFP - x(ii)**2)
  END DO
  !!
  !! copy
  !!
  DO jj = 0, n
    DO ii = 0, nb2
      D(n - ii, n - jj) = -D(ii, jj)
    END DO
  END DO
  !!
END SUBROUTINE Chebyshev1DMatrixG

!----------------------------------------------------------------------------
!                                                    Chebyshev1DMatrixG
!----------------------------------------------------------------------------

PURE SUBROUTINE Chebyshev1DMatrixG2(n, x, D)
  INTEGER(I4B), INTENT(IN) :: n
  !! order of Jacobi polynomial
  REAL(DFP), INTENT(IN) :: x(0:n)
  !! quadrature points
  REAL(DFP), INTENT(OUT) :: D(0:n, 0:n)
  !! D matrix
  !!
  !! internal variables
  !!
  REAL(DFP) :: rn
  REAL(DFP) :: J(0:n)
  INTEGER(I4B) :: ii, jj, nb2
  !!
  !! main
  !!
  rn = REAL(n, KIND=DFP)
  nb2 = int(n / 2)
  D = 0.0_DFP
  !!
  J = Chebyshev1GradientEval(n=n + 1, x=x)
  !!
  DO jj = 0, n
    DO ii = 0, nb2
      IF (ii .NE. jj) &
        & D(ii, jj) = J(ii) / J(jj) / (x(ii) - x(jj))
    END DO
  END DO
  !!
  !! correct diagonal entries
  !!
  DO ii = 0, nb2
    D(ii, ii) = x(ii) * 0.5_DFP / (1.0_DFP - x(ii)**2)
  END DO
  !!
  !! copy
  !!
  DO jj = 0, n
    DO ii = 0, nb2
      D(n - ii, n - jj) = -D(ii, jj)
    END DO
  END DO
  !!
END SUBROUTINE Chebyshev1DMatrixG2

!----------------------------------------------------------------------------
!                                                       Chebyshev1DMatEvenOdd
!----------------------------------------------------------------------------

MODULE PROCEDURE Chebyshev1DMatEvenOdd1
CALL UltrasphericalDMatEvenOdd(n=n, D=D, o=o, e=e)
END PROCEDURE Chebyshev1DMatEvenOdd1

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

END SUBMODULE Methods
