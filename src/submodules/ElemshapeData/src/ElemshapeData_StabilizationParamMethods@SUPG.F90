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
SUBMODULE(ElemshapeData_StabilizationParamMethods) SUPG
USE BaseMethod
IMPLICIT NONE
CONTAINS

!----------------------------------------------------------------------------
!                                                               getSUPGParam
!----------------------------------------------------------------------------

PURE SUBROUTINE elemsd_getSUPGParam_a(obj, tau, c, val, nu, k, &
  & phi, dt, opt)
  CLASS(ElemshapeData_), INTENT(IN) :: obj
  !! element shape data
  TYPE(FEVariable_), INTENT(INOUT) :: tau
  !! stabilizing parameters
  TYPE(FEVariable_), INTENT(IN) :: c
  !! convective velocity
  !! vector variable
  TYPE(FEVariable_), INTENT(IN) :: val
  !! solution
  TYPE(FEVariable_), INTENT(IN) :: nu
  !! diffusivity coefficient
  TYPE(FEVariable_), OPTIONAL, INTENT(IN) :: k
  !! permeability
  TYPE(FEVariable_), OPTIONAL, INTENT(IN) :: phi
  !! porosity
  REAL(DFP), OPTIONAL, INTENT(IN) :: dt
  !! time step size
  !! default value is zero
  INTEGER(I4B), OPTIONAL, INTENT(IN) :: opt
  !! default=1
  !! if opt=1, then we use `SQRT(1.0_DFP / (t1**2 + t2**2 + t3**2 + t4**2))`
  !! if opt=2, then we use `1.0_DFP / (t1 + t2 + t3 + t4)`
  !!
  !!
  !! define internal variables
  !!
  INTEGER(I4B) :: ii, opt0
  REAL(DFP) :: t1, t2, t3, t4
  REAL(DFP), ALLOCATABLE :: p(:, :)
  !! cdNdXt
  REAL(DFP), ALLOCATABLE :: r(:, :)
  !! unit normal
  REAL(DFP), ALLOCATABLE :: q(:, :)
  !! rdNdXt
  REAL(DFP), ALLOCATABLE :: ans(:)
  !! result
  REAL(DFP), ALLOCATABLE :: nubar(:), kbar(:), phibar(:)
  !! value of nu at space quadrature points
  TYPE(FEVariable_) :: rvar
  !! vector variable for keeping r
  !!
  !! Main
  !!
  opt0 = INPUT(default=1_I4B, option=opt)
  !!
  CALL GetProjectionOfdNdXt(obj=obj, cdNdXt=p, val=c)
  !!
  CALL GetUnitNormal(obj=obj, val=val, r=r)
  rvar = QuadratureVariable(r, TypeFEVariableVector, TypeFEVariableSpace)
  CALL GetProjectionOfdNdXt(obj=obj, cdNdXt=q, val=rvar)
  !!
  CALL GetInterpolation(obj=obj, val=nu, interpol=nubar)
  !!
  IF (PRESENT(k)) THEN
    CALL GetInterpolation(obj=obj, val=k, interpol=kbar)
    CALL GetInterpolation(obj=obj, val=phi, interpol=phibar)
  ELSE
    ALLOCATE (kbar(SIZE(nubar)))
    ALLOCATE (phibar(SIZE(nubar)))
    kbar = MaxDFP !! very large number
    phibar = 1.0_DFP
  END IF
  !!
  t2 = 0.0_DFP
  IF (PRESENT(dt)) THEN
    IF (dt .GT. zero) t2 = 2.0_DFP / dt
  END IF
  !!
  CALL Reallocate(ans, SIZE(obj%N, 2))
  !!
  IF (opt0 .EQ. 1_I4B) THEN
    DO ii = 1, SIZE(ans)
      t1 = SUM(ABS(p(:, ii)))
      t3 = nubar(ii) * (SUM(ABS(q(:, ii))))**2
      t4 = 2.0_DFP * phibar(ii) * nubar(ii) / kbar(ii)
      ans(ii) = SQRT(1.0_DFP / (t1**2 + t2**2 + t3**2 + t4**2))
    END DO
  ELSE
    DO ii = 1, SIZE(ans)
      t1 = SUM(ABS(p(:, ii)))
      t3 = nubar(ii) * (SUM(ABS(q(:, ii))))**2
      t4 = 2.0_DFP * phibar(ii) * nubar(ii) / kbar(ii)
      ans(ii) = 1.0_DFP / (t1 + t2 + t3 + t4)
    END DO
  END IF
  !!
  tau = QuadratureVariable(ans, TypeFEVariableScalar, TypeFEVariableSpace)
  !!
  !! cleanup
  IF (ALLOCATED(p)) DEALLOCATE (p)
  IF (ALLOCATED(r)) DEALLOCATE (r)
  IF (ALLOCATED(q)) DEALLOCATE (q)
  IF (ALLOCATED(ans)) DEALLOCATE (ans)
  IF (ALLOCATED(nubar)) DEALLOCATE (nubar)
  IF (ALLOCATED(kbar)) DEALLOCATE (kbar)
  IF (ALLOCATED(phibar)) DEALLOCATE (phibar)
  CALL DEALLOCATE (rvar)
END SUBROUTINE elemsd_getSUPGParam_a

!----------------------------------------------------------------------------
!                                                              getSUPGParam
!----------------------------------------------------------------------------

PURE SUBROUTINE elemsd_getSUPGParam_b(obj, tau, c, val, nu, k, &
  & phi, dt, opt)
  CLASS(STElemshapeData_), INTENT(IN) :: obj
  !! space-time element shape data
  TYPE(FEVariable_), INTENT(INOUT) :: tau
  !! stabilization parameter
  TYPE(FEVariable_), INTENT(IN) :: c
  !! convective velocity
  !! vector variable
  TYPE(FEVariable_), INTENT(IN) :: val
  !! solution
  !! scalar/vector variable
  TYPE(FEVariable_), INTENT(IN) :: nu
  !! diffusivity
  TYPE(FEVariable_), OPTIONAL, INTENT(IN) :: k
  !! permeability
  TYPE(FEVariable_), OPTIONAL, INTENT(IN) :: phi
  !! porosity
  REAL(DFP), OPTIONAL, INTENT(IN) :: dt
  !! time-step size
  !! This parameter is not used currently.
  INTEGER(I4B), OPTIONAL, INTENT(IN) :: opt
  !! default=1
  !! opt=1, then `ans(ii) = SQRT(1.0_DFP / (t12**2 + t3**2 + t4**2))`
  !! opt=2, then `ans(ii) = 1.0_DFP / (t12 + t3 + t4)`
  !!
  !! INTERNAL VARIABLES
  !!
  INTEGER(I4B) :: ii, opt0
  REAL(DFP) :: t12, t3, t4
  REAL(DFP), ALLOCATABLE :: p(:, :, :)
  !! cdNTdxt
  REAL(DFP), ALLOCATABLE :: r(:, :)
  !! vector at space quad points
  REAL(DFP), ALLOCATABLE :: q(:, :, :)
  !!
  REAL(DFP), ALLOCATABLE :: ans(:)
  REAL(DFP), ALLOCATABLE :: nubar(:)
  REAL(DFP), ALLOCATABLE :: kbar(:)
  REAL(DFP), ALLOCATABLE :: phibar(:)
  TYPE(FEVariable_) :: rvar
  !!
  !! MAIN
  !!
  opt0 = INPUT(option=opt, default=1_I4B)
  !!
  CALL GetProjectionOfdNTdXt(obj=obj, cdNTdXt=p, val=c)
  !!
  !! make cdNTdxt + dNTdt
  !!
  p = p + obj%dNTdt
  !!
  CALL GetUnitNormal(obj=obj, val=val, r=r)
  rvar = QuadratureVariable(r, TypeFEVariableVector, TypeFEVariableSpace)
  CALL GetProjectionOfdNTdXt(obj=obj, cdNTdXt=q, val=rvar)
  CALL GetInterpolation(obj=obj, val=nu, interpol=nubar)
  !!
  IF (PRESENT(k)) THEN
    CALL GetInterpolation(obj=obj, val=k, interpol=kbar)
    CALL GetInterpolation(obj=obj, val=phi, interpol=phibar)
  ELSE
    ALLOCATE (kbar(SIZE(nubar)))
    ALLOCATE (phibar(SIZE(nubar)))
    kbar = MaxDFP !! very large number
    phibar = 1.0_DFP
  END IF
  !!
  CALL reallocate(ans, SIZE(obj%N, 2))
  !!
  IF (opt0 .EQ. 1_I4B) THEN
    DO ii = 1, SIZE(ans, 1)
      t12 = SUM(ABS(p(:, :, ii)))
      t3 = nubar(ii) * (SUM(ABS(q(:, :, ii))))**2
      t4 = 2.0_DFP * phibar(ii) * nubar(ii) / kbar(ii)
      ans(ii) = SQRT(1.0_DFP / (t12**2 + t3**2 + t4**2))
    END DO
  ELSE
    DO ii = 1, SIZE(ans, 1)
      t12 = SUM(ABS(p(:, :, ii)))
      t3 = nubar(ii) * (SUM(ABS(q(:, :, ii))))**2
      t4 = 2.0_DFP * phibar(ii) * nubar(ii) / kbar(ii)
      ans(ii) = 1.0_DFP / (t12 + t3 + t4)
    END DO
  END IF
  !!
  tau = QuadratureVariable(ans, TypeFEVariableScalar, TypeFEVariableSpace)
  !!
  !! cleanup
  !!
  IF (ALLOCATED(p)) DEALLOCATE (p)
  IF (ALLOCATED(r)) DEALLOCATE (r)
  IF (ALLOCATED(q)) DEALLOCATE (q)
  IF (ALLOCATED(ans)) DEALLOCATE (ans)
  IF (ALLOCATED(nubar)) DEALLOCATE (nubar)
  IF (ALLOCATED(kbar)) DEALLOCATE (kbar)
  IF (ALLOCATED(phibar)) DEALLOCATE (phibar)
  CALL DEALLOCATE (rvar)
END SUBROUTINE elemsd_getSUPGParam_b

!----------------------------------------------------------------------------
!                                                               getSUPGParam
!----------------------------------------------------------------------------

MODULE PROCEDURE elemsd_getSUPGParam1
SELECT TYPE (obj)
TYPE IS (ElemshapeData_)
  !!
  CALL elemsd_getSUPGParam_a( &
    & obj=obj, &
    & tau=tau, &
    & c=c, &
    & val=val, &
    & nu=nu, &
    & k=k, &
    & phi=phi, &
    & dt=dt, &
    & opt=opt)
  !!
CLASS IS (STElemshapeData_)
  !!
  CALL elemsd_getSUPGParam_b( &
    & obj=obj, &
    & tau=tau, &
    & c=c, &
    & val=val, &
    & nu=nu, &
    & k=k, &
    & phi=phi, &
    & dt=dt, &
    & opt=opt)
  !!
END SELECT
END PROCEDURE elemsd_getSUPGParam1

!----------------------------------------------------------------------------
!                                                             GetSUPGParam
!----------------------------------------------------------------------------

MODULE PROCEDURE elemsd_GetSUPGParam2
INTEGER(I4B) :: ii
REAL(DFP), ALLOCATABLE :: ans(:, :)
TYPE(FEVariable_) :: a
!!
!! main
!!
CALL Reallocate(ans, SIZE(obj(1)%N, 2), SIZE(obj))
!!
DO ii = 1, SIZE(obj)
  !!
  CALL elemsd_getSUPGParam_b( &
    & obj=obj(ii), &
    & tau=a, &
    & c=c, &
    & val=val, &
    & nu=nu, &
    & k=k, &
    & phi=phi, &
    & dt=dt, &
    & opt=opt)
  !!
  ans(:, ii) = Get(a, TypeFEVariableScalar, TypeFEVariableSpace)
  !!
END DO
!!
tau = QuadratureVariable( &
  & ans, &
  & TypeFEVariableScalar, &
  & TypeFEVariableSpaceTime)
!!
CALL DEALLOCATE (a); DEALLOCATE (ans)
END PROCEDURE elemsd_GetSUPGParam2

!----------------------------------------------------------------------------
!                                                               getSUPGParam
!----------------------------------------------------------------------------

PURE SUBROUTINE elemsd_getSUPGParam_c(obj, tau, c, val, nu, k, &
  & phi, dt, opt)
  CLASS(ElemshapeData_), INTENT(IN) :: obj
  !! element shape data
  TYPE(FEVariable_), INTENT(INOUT) :: tau
  !! stabilizing parameters
  TYPE(FEVariable_), INTENT(IN) :: c
  !! convective velocity
  !! vector variable
  TYPE(FEVariable_), INTENT(IN) :: val
  !! solution
  REAL(DFP), INTENT(IN) :: nu
  !! diffusivity coefficient
  REAL(DFP), OPTIONAL, INTENT(IN) :: k
  !! permeability
  REAL(DFP), OPTIONAL, INTENT(IN) :: phi
  !! porosity
  REAL(DFP), OPTIONAL, INTENT(IN) :: dt
  !! time step size
  !! default value is zero
  INTEGER(I4B), OPTIONAL, INTENT(IN) :: opt
  !! default = 1
  !! opt=1
  !! opt=2
  !
  !!
  !! internal variables
  !!
  INTEGER(I4B) :: ii, opt0
  REAL(DFP) :: t1, t2, t3, t4, kbar, phibar
  REAL(DFP), ALLOCATABLE :: p(:, :)
  !! cdNdXt
  REAL(DFP), ALLOCATABLE :: r(:, :)
  !! unit normal
  REAL(DFP), ALLOCATABLE :: q(:, :)
  !! rdNdXt
  REAL(DFP), ALLOCATABLE :: ans(:)
  !! result
  !! value of nu at space quadrature points
  TYPE(FEVariable_) :: rvar
  !! vector variable for keeping r
  !!
  !! MAIN
  !!
  opt0 = INPUT(default=1_I4B, option=opt)
  !!
  CALL GetProjectionOfdNdXt(obj=obj, cdNdXt=p, val=c)
  !!
  CALL GetUnitNormal(obj=obj, val=val, r=r)
  rvar = QuadratureVariable(r, TypeFEVariableVector, TypeFEVariableSpace)
  CALL GetProjectionOfdNdXt(obj=obj, cdNdXt=q, val=rvar)
  !!
  IF (PRESENT(k)) THEN
    kbar = k
    phibar = phi
  ELSE
    kbar = MaxDFP
    phibar = 1.0_DFP
  END IF
  !!
  t2 = 0.0_DFP
  IF (PRESENT(dt)) THEN
    t2 = 2.0_DFP / dt
  END IF
  !!
  CALL Reallocate(ans, SIZE(obj%N, 2))
  !!
  IF (opt0 .EQ. 1_I4B) THEN
    DO ii = 1, SIZE(ans)
      t1 = SUM(ABS(p(:, ii)))
      t3 = nu * (SUM(ABS(q(:, ii))))**2
      t4 = 2.0_DFP * phibar * nu / kbar
      ans(ii) = SQRT(1.0_DFP / (t1**2 + t2**2 + t3**2 + t4**2))
    END DO
  ELSE
    DO ii = 1, SIZE(ans)
      t1 = SUM(ABS(p(:, ii)))
      t3 = nu * (SUM(ABS(q(:, ii))))**2
      t4 = 2.0_DFP * phibar * nu / kbar
      ans(ii) = 1.0_DFP / (t1 + t2 + t3 + t4)
    END DO
  END IF
  !!
  tau = QuadratureVariable(ans, TypeFEVariableScalar, TypeFEVariableSpace)
  !!
  !! cleanup
  DEALLOCATE (p, r, q, ans)
  CALL DEALLOCATE (rvar)
END SUBROUTINE elemsd_getSUPGParam_c

!----------------------------------------------------------------------------
!                                                              getSUPGParam
!----------------------------------------------------------------------------

PURE SUBROUTINE elemsd_getSUPGParam_d(obj, tau, c, val, nu, k, &
  & phi, dt, opt)
  CLASS(STElemshapeData_), INTENT(IN) :: obj
  !! space-time element shape data
  TYPE(FEVariable_), INTENT(INOUT) :: tau
  !! stabilization parameter
  TYPE(FEVariable_), INTENT(IN) :: c
  !! convective velocity
  !! vector variable
  TYPE(FEVariable_), INTENT(IN) :: val
  !! solution
  !! scalar/vector variable
  REAL(DFP), INTENT(IN) :: nu
  !! diffusivity
  REAL(DFP), OPTIONAL, INTENT(IN) :: k
  !! permeability
  REAL(DFP), OPTIONAL, INTENT(IN) :: phi
  !! porosity
  REAL(DFP), OPTIONAL, INTENT(IN) :: dt
  !! time-step size
  INTEGER(I4B), OPTIONAL, INTENT(IN) :: opt
  !! default=1
  !! opt=1,
  !! opt=2
  !!
  !! INTERNAL VARIABLES
  !!
  INTEGER(I4B) :: ii, opt0
  REAL(DFP) :: t12, t3, t4, kbar, phibar
  REAL(DFP), ALLOCATABLE :: p(:, :, :)
  !! cdNTdxt
  REAL(DFP), ALLOCATABLE :: r(:, :)
  !! vector at space quad points
  REAL(DFP), ALLOCATABLE :: q(:, :, :)
  !!
  REAL(DFP), ALLOCATABLE :: ans(:)
  TYPE(FEVariable_) :: rvar
  !!
  !! MAIN
  !!
  opt0 = INPUT(default=1_I4B, option=opt)
  !!
  CALL GetProjectionOfdNTdXt(obj=obj, cdNTdXt=p, val=c)
  !!
  !! make cdNTdxt + dNTdt
  !!
  p = p + obj%dNTdt
  !!
  CALL GetUnitNormal(obj=obj, val=val, r=r)
  rvar = QuadratureVariable(r, TypeFEVariableVector, TypeFEVariableSpace)
  CALL GetProjectionOfdNTdXt(obj=obj, cdNTdXt=q, val=rvar)
  !!
  IF (PRESENT(k)) THEN
    kbar = k
    phibar = phi
  ELSE
    kbar = MaxDFP
    phibar = 1.0_DFP
  END IF
  !!
  !!
  CALL reallocate(ans, SIZE(obj%N, 2))
  !!
  IF (opt0 .EQ. 1_I4B) THEN
    DO ii = 1, SIZE(ans, 1)
      t12 = SUM(ABS(p(:, :, ii)))
      t3 = nu * (SUM(ABS(q(:, :, ii))))**2
      t4 = 2.0_DFP * phibar * nu / kbar
      ans(ii) = SQRT(1.0_DFP / (t12**2 + t3**2 + t4**2))
    END DO
  ELSE
    DO ii = 1, SIZE(ans, 1)
      t12 = SUM(ABS(p(:, :, ii)))
      t3 = nu * (SUM(ABS(q(:, :, ii))))**2
      t4 = 2.0_DFP * phibar * nu / kbar
      ans(ii) = 1.0_DFP / (t12 + t3 + t4)
    END DO
  END IF
  !!
  tau = QuadratureVariable(ans, TypeFEVariableScalar, TypeFEVariableSpace)
  !!
  !! cleanup
  !!
  DEALLOCATE (p, r, q, ans)
  CALL DEALLOCATE (rvar)
END SUBROUTINE elemsd_getSUPGParam_d

!----------------------------------------------------------------------------
!                                                               getSUPGParam
!----------------------------------------------------------------------------

MODULE PROCEDURE elemsd_getSUPGParam3
SELECT TYPE (obj)
TYPE IS (ElemshapeData_)
  !!
  CALL elemsd_getSUPGParam_c( &
    & obj=obj, &
    & tau=tau, &
    & c=c, &
    & val=val, &
    & nu=nu, &
    & k=k, &
    & phi=phi, &
    & dt=dt, &
    & opt=opt)
  !!
CLASS IS (STElemshapeData_)
  !!
  CALL elemsd_getSUPGParam_d( &
    & obj=obj, &
    & tau=tau, &
    & c=c, &
    & val=val, &
    & nu=nu, &
    & k=k, &
    & phi=phi, &
    & dt=dt, &
    & opt=opt)
  !!
END SELECT
END PROCEDURE elemsd_getSUPGParam3

!----------------------------------------------------------------------------
!                                                             GetSUPGParam
!----------------------------------------------------------------------------

MODULE PROCEDURE elemsd_GetSUPGParam4
INTEGER(I4B) :: ii
REAL(DFP), ALLOCATABLE :: ans(:, :)
TYPE(FEVariable_) :: a
  !!
  !! main
  !!
CALL Reallocate(ans, SIZE(obj(1)%N, 2), SIZE(obj))
  !!
DO ii = 1, SIZE(obj)
    !!
  CALL elemsd_getSUPGParam_d( &
    & obj=obj(ii), &
    & tau=a, &
    & c=c, &
    & val=val, &
    & nu=nu, &
    & k=k, &
    & phi=phi, &
    & dt=dt, &
    & opt=opt)
    !!
  ans(:, ii) = Get(a, TypeFEVariableScalar, TypeFEVariableSpace)
    !!
END DO
  !!
tau = QuadratureVariable( &
  & ans, &
  & TypeFEVariableScalar, &
  & TypeFEVariableSpaceTime)
  !!
  !!
CALL DEALLOCATE (a)
DEALLOCATE (ans)
END PROCEDURE elemsd_GetSUPGParam4

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

END SUBMODULE SUPG
