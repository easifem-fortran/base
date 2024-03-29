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

!> author: Vikas Sharma, Ph. D.
! date: 1 March 2021
! summary: This module contains the methods for data type [[QuadraturePoint_]]

MODULE QuadraturePoint_Method
USE BaseType
USE GlobalData
USE String_Class, ONLY: String
IMPLICIT NONE
PRIVATE
PUBLIC :: Initiate
PUBLIC :: QuadraturePoint
PUBLIC :: QuadraturePoint_Pointer
PUBLIC :: DEALLOCATE
PUBLIC :: SIZE
PUBLIC :: GetTotalQuadraturepoints
PUBLIC :: GetQuadraturepoints
PUBLIC :: Outerprod
PUBLIC :: Display
PUBLIC :: QuadraturePoint_MdEncode
PUBLIC :: QuadraturePointIdToName
PUBLIC :: QuadraturePointNameToId
PUBLIC :: MdEncode

!----------------------------------------------------------------------------
!                                 QuadratuePointNameToId@ConstructorMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date:  2023-08-06
! summary:  Quadrature point name to quadrature point id

INTERFACE
  MODULE FUNCTION QuadraturePointNameToId(name) RESULT(ans)
    CHARACTER(*), INTENT(IN) :: name
    INTEGER(I4B) :: ans
  END FUNCTION QuadraturePointNameToId
END INTERFACE

!----------------------------------------------------------------------------
!                                 QuadratuePointIdToName@ConstructorMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date:  2023-08-06
! summary:  Quadrature point name to quadrature point id

INTERFACE
  MODULE FUNCTION QuadraturePointIdToName(name) RESULT(ans)
    INTEGER(I4B), INTENT(IN) :: name
    TYPE(String) :: ans
  END FUNCTION QuadraturePointIdToName
END INTERFACE

!----------------------------------------------------------------------------
!                                                Initiate@ConstructorMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 23 July 2021
! summary: This routine initiates the quadrature points

INTERFACE Initiate
  MODULE PURE SUBROUTINE quad_initiate1(obj, points)
    CLASS(QuadraturePoint_), INTENT(INOUT) :: obj
    REAL(DFP), INTENT(IN) :: points(:, :)
    !! points contains the quadrature points and weights
    !! points( :, ipoint ) contains quadrature points and weights of ipoint
    !! quadrature point. The last row contains the weight. The rest of the
    !! rows contains the coordinates of quadrature.
  END SUBROUTINE quad_initiate1
END INTERFACE Initiate

!----------------------------------------------------------------------------
!                                                Initiate@ConstructorMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 23 July 2021
! summary: This routine initiates the quadrature points

INTERFACE Initiate
  MODULE PURE SUBROUTINE quad_initiate2(obj, tXi, tpoints)
    CLASS(QuadraturePoint_), INTENT(INOUT) :: obj
    INTEGER(I4B), INTENT(IN) :: tXi
    !! Total number of xidimension
    !! For line tXi=1
    !! For 2D element tXi=2
    !! For 3D element tXi=3
    INTEGER(I4B), INTENT(IN) :: tpoints
    !! Total number quadrature points
  END SUBROUTINE quad_initiate2
END INTERFACE Initiate

!----------------------------------------------------------------------------
!                                                Initiate@ConstructorMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 23 July 2021
! summary: This routine initiates the quadrature points

INTERFACE Initiate
  MODULE SUBROUTINE quad_initiate3(obj, refElem, order, quadratureType,  &
    & alpha, beta, lambda)
    TYPE(QuadraturePoint_), INTENT(INOUT) :: obj
    !! Total number of xidimension
    CLASS(ReferenceElement_), INTENT(IN) :: refElem
    !! Reference element
    INTEGER(I4B), INTENT(IN) :: order
    !! order of integrand
    CHARACTER(*), INTENT(IN) :: quadratureType
    !! Type of quadrature points
    !! "GaussLegendre"
    !! "GaussLegendreLobatto"
    !! "GaussLegendreRadau", "GaussLegendreRadauLeft"
    !! "GaussLegendreRadauRight"
    !! "GaussChebyshev"
    !! "GaussChebyshevLobatto"
    !! "GaussChebyshevRadau", "GaussChebyshevRadauLeft"
    !! "GaussChebyshevRadauRight"
    REAL(DFP), OPTIONAL, INTENT(IN) :: alpha
    !! Jacobi parameter
    REAL(DFP), OPTIONAL, INTENT(IN) :: beta
    !! Jacobi parameter
    REAL(DFP), OPTIONAL, INTENT(IN) :: lambda
    !! Ultraspherical parameter
  END SUBROUTINE quad_initiate3
END INTERFACE Initiate

!----------------------------------------------------------------------------
!                                               Initiate@ConstructorMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 23 July 2021
! summary: This routine initiates the quadrature points

INTERFACE Initiate
  MODULE SUBROUTINE quad_initiate4(obj, refElem, nips, quadratureType, &
    & alpha, beta, lambda)
    TYPE(QuadraturePoint_), INTENT(INOUT) :: obj
    !! Total number of xidimension
    CLASS(ReferenceElement_), INTENT(IN) :: refElem
    !! Reference element
    INTEGER(I4B), INTENT(IN) :: nips(1)
    !! order of integrand
    CHARACTER(*), INTENT(IN) :: quadratureType
    !! Total number quadrature points
    REAL(DFP), OPTIONAL, INTENT(IN) :: alpha
    !! Jacobi parameter
    REAL(DFP), OPTIONAL, INTENT(IN) :: beta
    !! Jacobi parameter
    REAL(DFP), OPTIONAL, INTENT(IN) :: lambda
    !! Ultraspherical parameter
  END SUBROUTINE quad_initiate4
END INTERFACE Initiate

!----------------------------------------------------------------------------
!                                                Initiate@ConstructorMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 23 July 2021
! summary: This routine constructs the quadrature points

INTERFACE Initiate
  MODULE SUBROUTINE quad_initiate5( &
    & obj, &
    & refElem, &
    & order, &
    & quadratureType,  &
    & alpha, beta, lambda)
    TYPE(QuadraturePoint_), INTENT(INOUT) :: obj
    !! Total number of xidimension
    CLASS(ReferenceElement_), INTENT(IN) :: refElem
    !! Reference-element
    INTEGER(I4B), INTENT(IN) :: order
    !! order of integrand
    INTEGER(I4B), INTENT(IN) :: quadratureType
    !! Type of quadrature points
    !! GaussLegendre
    !! GaussLegendreLobatto
    !! GaussLegendreRadau
    !! GaussLegendreRadauLeft
    !! GaussLegendreRadauRight
    !! GaussChebyshev
    !! GaussChebyshevLobatto
    !! GaussChebyshevRadau
    !! GaussChebyshevRadauLeft
    !! GaussChebyshevRadauRight
    REAL(DFP), OPTIONAL, INTENT(IN) :: alpha
    !! Jacobi parameter
    REAL(DFP), OPTIONAL, INTENT(IN) :: beta
    !! Jacobi parameter
    REAL(DFP), OPTIONAL, INTENT(IN) :: lambda
    !! Ultraspherical parameter
  END SUBROUTINE quad_initiate5
END INTERFACE Initiate

!----------------------------------------------------------------------------
!                                               Initiate@ConstructorMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 23 July 2021
! summary: This routine initiates the quadrature points

INTERFACE Initiate
  MODULE SUBROUTINE quad_initiate6( &
    & obj, &
    & refElem, &
    & nips, &
    & quadratureType, &
    & alpha, &
    & beta, &
    & lambda)
    TYPE(QuadraturePoint_), INTENT(INOUT) :: obj
    !! Total number of xidimension
    CLASS(ReferenceElement_), INTENT(IN) :: refElem
    !! Reference element
    INTEGER(I4B), INTENT(IN) :: nips(1)
    !! order of integrand
    INTEGER(I4B), INTENT(IN) :: quadratureType
    !! Type of quadrature points
    !! GaussLegendre
    !! GaussLegendreLobatto
    !! GaussLegendreRadau
    !! GaussLegendreRadauLeft
    !! GaussLegendreRadauRight
    !! GaussChebyshev
    !! GaussChebyshevLobatto
    !! GaussChebyshevRadau
    !! GaussChebyshevRadauLeft
    !! GaussChebyshevRadauRight
    REAL(DFP), OPTIONAL, INTENT(IN) :: alpha
    !! Jacobi parameter
    REAL(DFP), OPTIONAL, INTENT(IN) :: beta
    !! Jacobi parameter
    REAL(DFP), OPTIONAL, INTENT(IN) :: lambda
    !! Ultraspherical parameter
  END SUBROUTINE quad_initiate6
END INTERFACE Initiate

!----------------------------------------------------------------------------
!                                                Initiate@ConstructorMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 23 July 2021
! summary: This routine initiates the quadrature points

INTERFACE Initiate
  MODULE SUBROUTINE quad_initiate7( &
    & obj, &
    & refElem, &
    & p, q, r, &
    & quadratureType1, &
    & quadratureType2, &
    & quadratureType3, &
    & alpha1, beta1, lambda1,  &
    & alpha2, beta2, lambda2,  &
    & alpha3, beta3, lambda3)
    TYPE(QuadraturePoint_), INTENT(INOUT) :: obj
    !! Total number of xidimension
    CLASS(ReferenceElement_), INTENT(IN) :: refElem
    !! Reference-element
    INTEGER(I4B), INTENT(IN) :: p
    !! order of integrand in x
    INTEGER(I4B), INTENT(IN) :: q
    !! order of integrand in y
    INTEGER(I4B), INTENT(IN) :: r
    !! order of integrand in z direction
    INTEGER(I4B), INTENT(IN) :: quadratureType1
    !! Type of quadrature points
    !! GaussLegendre
    !! GaussLegendreLobatto
    !! GaussLegendreRadau
    !! GaussLegendreRadauLeft
    !! GaussLegendreRadauRight
    !! GaussChebyshev
    !! GaussChebyshevLobatto
    !! GaussChebyshevRadau
    !! GaussChebyshevRadauLeft
    !! GaussChebyshevRadauRight
    INTEGER(I4B), INTENT(IN) :: quadratureType2
    !! Type of quadrature points
    INTEGER(I4B), INTENT(IN) :: quadratureType3
    !! Type of quadrature points
    REAL(DFP), OPTIONAL, INTENT(IN) :: alpha1, beta1, lambda1
    !! Jacobi parameter and Ultraspherical parameters
    REAL(DFP), OPTIONAL, INTENT(IN) :: alpha2, beta2, lambda2
    !! Jacobi parameter and Ultraspherical parameters
    REAL(DFP), OPTIONAL, INTENT(IN) :: alpha3, beta3, lambda3
    !! Jacobi parameter and Ultraspherical parameters
  END SUBROUTINE quad_initiate7
END INTERFACE Initiate

!----------------------------------------------------------------------------
!                                               Initiate@ConstructorMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 23 July 2021
! summary: This routine initiates the quadrature points

INTERFACE Initiate
  MODULE SUBROUTINE quad_initiate8( &
    & obj, &
    & refElem, &
    & nipsx, &
    & nipsy, &
    & nipsz, &
    & quadratureType1, &
    & quadratureType2, &
    & quadratureType3, &
    & alpha1, beta1, lambda1, &
    & alpha2, beta2, lambda2, &
    & alpha3, beta3, lambda3)
    TYPE(QuadraturePoint_), INTENT(INOUT) :: obj
    !! Total number of xidimension
    CLASS(ReferenceElement_), INTENT(IN) :: refElem
    !! Reference element
    INTEGER(I4B), INTENT(IN) :: nipsx(1)
    !! number of integration points in x direction
    INTEGER(I4B), INTENT(IN) :: nipsy(1)
    !! number of integration points in y direction
    INTEGER(I4B), INTENT(IN) :: nipsz(1)
    !! number of integration points in z direction
    INTEGER(I4B), INTENT(IN) :: quadratureType1
    !! Type of quadrature points
    !! GaussLegendre
    !! GaussLegendreLobatto
    !! GaussLegendreRadau
    !! GaussLegendreRadauLeft
    !! GaussLegendreRadauRight
    !! GaussChebyshev
    !! GaussChebyshevLobatto
    !! GaussChebyshevRadau
    !! GaussChebyshevRadauLeft
    !! GaussChebyshevRadauRight
    INTEGER(I4B), INTENT(IN) :: quadratureType2
    !! Type of quadrature points
    INTEGER(I4B), INTENT(IN) :: quadratureType3
    !! Type of quadrature points
    REAL(DFP), OPTIONAL, INTENT(IN) :: alpha1, beta1, lambda1
    !! Jacobi parameter and Ultraspherical parameter
    REAL(DFP), OPTIONAL, INTENT(IN) :: alpha2, beta2, lambda2
    !! Jacobi parameter and Ultraspherical parameter
    REAL(DFP), OPTIONAL, INTENT(IN) :: alpha3, beta3, lambda3
    !! Jacobi parameter and Ultraspherical parameter
  END SUBROUTINE quad_initiate8
END INTERFACE Initiate

!----------------------------------------------------------------------------
!                                       QuadraturePoint@ConstructureMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 23 July 2021
! summary: This routine initiate an instance of quadrature points

INTERFACE QuadraturePoint
  MODULE PURE FUNCTION quad_Constructor1(points) RESULT(obj)
    TYPE(QuadraturePoint_) :: obj
    REAL(DFP), INTENT(IN) :: points(:, :)
  END FUNCTION quad_Constructor1
END INTERFACE QuadraturePoint

!----------------------------------------------------------------------------
!                                 QuadraturePoint_Pointer@ConstructorMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 23 July 2021
! summary: Returns a pointer to a newly created instance of quadrature points

INTERFACE QuadraturePoint_Pointer
  MODULE PURE FUNCTION quad_Constructor_1(points) RESULT(obj)
    CLASS(QuadraturePoint_), POINTER :: obj
    REAL(DFP), INTENT(IN) :: points(:, :)
  END FUNCTION quad_Constructor_1
END INTERFACE QuadraturePoint_Pointer

!----------------------------------------------------------------------------
!                                             Deallocate@ConstructorMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 23 July 2021
! summary: Deallocates the data stored inside the quadrature point

INTERFACE DEALLOCATE
  MODULE PURE SUBROUTINE quad_Deallocate(obj)
    CLASS(QuadraturePoint_), INTENT(INOUT) :: obj
  END SUBROUTINE quad_Deallocate
END INTERFACE DEALLOCATE

!----------------------------------------------------------------------------
!                                                           SIZE@GetMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 23 July 2021
! summary: This routine returns the size of obj%points,

INTERFACE SIZE
  MODULE PURE FUNCTION quad_Size(obj, dims) RESULT(ans)
    CLASS(QuadraturePoint_), INTENT(IN) :: obj
    INTEGER(I4B), INTENT(IN) :: dims
    INTEGER(I4B) :: ans
  END FUNCTION quad_Size
END INTERFACE SIZE

!----------------------------------------------------------------------------
!                                       getTotalQuadraturepoints@GetMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 23 July 2021
! summary: This routine returns total number of quadrature points

INTERFACE GetTotalQuadraturepoints
  MODULE PURE FUNCTION quad_getTotalQuadraturepoints(obj, dims) RESULT(ans)
    CLASS(QuadraturePoint_), INTENT(IN) :: obj
    INTEGER(I4B), INTENT(IN) :: dims
    INTEGER(I4B) :: ans
  END FUNCTION quad_getTotalQuadraturepoints
END INTERFACE GetTotalQuadraturepoints

!----------------------------------------------------------------------------
!                                              GetQuadraturePoint@GetMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 23 July 2021
! summary: This routine returns quadrature points

INTERFACE
  MODULE PURE SUBROUTINE quad_GetQuadraturepoints1(obj, points, weights, num)
    CLASS(QuadraturePoint_), INTENT(IN) :: obj
    REAL(DFP), INTENT(INOUT) :: points(3)
    !! [xi, eta, zeta]
    REAL(DFP), INTENT(INOUT) :: weights
    !! weights
    INTEGER(I4B), INTENT(IN) :: num
    !! quadrature number
  END SUBROUTINE quad_GetQuadraturepoints1
END INTERFACE

INTERFACE GetQuadraturepoints
  MODULE PROCEDURE quad_GetQuadraturepoints1
END INTERFACE

!----------------------------------------------------------------------------
!                                              GetQuadraturePoint@GetMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 23 July 2021
! summary: This routine returns total number of quadrature points

INTERFACE
  MODULE PURE SUBROUTINE quad_GetQuadraturepoints2(obj, points, weights)
    CLASS(QuadraturePoint_), INTENT(IN) :: obj
    REAL(DFP), ALLOCATABLE, INTENT(INOUT) :: points(:, :)
    !! Point( :, j ) = [xi, eta, zeta] of jth quadrature point
    REAL(DFP), ALLOCATABLE, INTENT(INOUT) :: weights(:)
    !! Weight(j) weight of jth quadrature point
  END SUBROUTINE quad_GetQuadraturepoints2
END INTERFACE

INTERFACE GetQuadraturepoints
  MODULE PROCEDURE quad_GetQuadraturepoints2
END INTERFACE

!----------------------------------------------------------------------------
!                                                       OuterProd@GetMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 1 Nov 2022
! summary:         Performs outerproduct of quadrature points

INTERFACE Outerprod
  MODULE PURE FUNCTION quad_Outerprod(obj1, obj2) RESULT(ans)
    CLASS(QuadraturePoint_), INTENT(IN) :: obj1
    !! quadrature points in 1D
    CLASS(QuadraturePoint_), INTENT(IN) :: obj2
    !! quadrature points in 1D
    TYPE(QuadraturePoint_) :: ans
    !! quadrature points in 2D
  END FUNCTION quad_Outerprod
END INTERFACE Outerprod

!----------------------------------------------------------------------------
!                                                          Display@IOMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 23 July 2021
! summary:  Display the content of quadrature point

INTERFACE Display
  MODULE SUBROUTINE quad_Display(obj, msg, unitno)
    CLASS(QuadraturePoint_), INTENT(IN) :: obj
    CHARACTER(*), INTENT(IN) :: msg
    INTEGER(I4B), INTENT(IN), OPTIONAL :: unitno
  END SUBROUTINE quad_Display
END INTERFACE Display

!----------------------------------------------------------------------------
!                                                        MdEncode@IOMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 23 July 2021
! summary:  Display the content of quadrature point

INTERFACE MdEncode
  MODULE FUNCTION QuadraturePoint_MdEncode(obj) RESULT(ans)
    CLASS(QuadraturePoint_), INTENT(IN) :: obj
    TYPE(String) :: ans
  END FUNCTION QuadraturePoint_MdEncode
END INTERFACE MdEncode

!----------------------------------------------------------------------------
!                                      GaussLegendreQuadrature@GaussLegendre
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 23 July 2021
! summary: Returns the Gauss Legendre Quadrature points based on given order

! INTERFACE GaussLegendreQuadrature
!   MODULE FUNCTION getGaussLegendreQP1(refelem, order) RESULT(obj)
!     CLASS(ReferenceElement_), INTENT(IN) :: refelem
!     INTEGER(I4B), INTENT(IN) :: order
!     !! order of accuracy in each direction
!     TYPE(QuadraturePoint_) :: obj
!   END FUNCTION getGaussLegendreQP1
! END INTERFACE GaussLegendreQuadrature

!----------------------------------------------------------------------------
!                                      GaussLegendreQuadrature@GaussLegendre
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 23 July 2021
! summary: Returns the Gauss-Legendre Quadrature points

! INTERFACE GaussLegendreQuadrature
!   MODULE FUNCTION getGaussLegendreQP2(refelem, nips) RESULT(obj)
!     CLASS(ReferenceElement_), INTENT(IN) :: refelem
!     INTEGER(I4B), INTENT(IN) :: nips(:)
!     !! number of integration points
!     !! IF size(nips) = 1, then sqrt(nips(1)) points are used in both dirn
!     !! IF size(nips) = 2, then in x1 direction nips(1) points and in
!     !! x2 direction nips(2) points are used.
!     TYPE(QuadraturePoint_) :: obj
!   END FUNCTION getGaussLegendreQP2
! END INTERFACE GaussLegendreQuadrature

!----------------------------------------------------------------------------
!                                      GaussLegendreQuadrature@GaussLegendre
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 23 July 2021
! summary: Returns the Gauss Legendre Quadrature points based on given order

! INTERFACE GaussLegendreQuadrature
!   MODULE FUNCTION getGaussLegendreQP3(refelem, p, q, r) RESULT(obj)
!     CLASS(ReferenceElement_), INTENT(IN) :: refelem
!     INTEGER(I4B), INTENT(IN) :: p
!     !! order of accuracy in x1 direction
!     INTEGER(I4B), INTENT(IN) :: q
!     !! order of accuracy in x2 direction
!     INTEGER(I4B), OPTIONAL, INTENT(IN) :: r
!     !! order of accuracy in x3 direction
!     TYPE(QuadraturePoint_) :: obj
!   END FUNCTION getGaussLegendreQP3
! END INTERFACE GaussLegendreQuadrature

!----------------------------------------------------------------------------
!                         GaussLegendreLobattoQuadrature@GaussLegendreLobatto
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 23 July 2021
! summary: Returns the Gauss LegendreLobatto Quadrature points

! INTERFACE GaussLegendreLobattoQuadrature
!   MODULE FUNCTION getGaussLegendreLobattoQP1(refelem, order) RESULT(obj)
!     CLASS(ReferenceElement_), INTENT(IN) :: refelem
!     INTEGER(I4B), INTENT(IN) :: order
!     !! order of accuracy in each direction
!     TYPE(QuadraturePoint_) :: obj
!   END FUNCTION getGaussLegendreLobattoQP1
! END INTERFACE GaussLegendreLobattoQuadrature

!----------------------------------------------------------------------------
!                         GaussLegendreLobattoQuadrature@GaussLegendreLobatto
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 23 July 2021
! summary: Returns the Gauss-LegendreLobatto Quadrature points

! INTERFACE GaussLegendreLobattoQuadrature
!   MODULE FUNCTION getGaussLegendreLobattoQP2(refelem, nips) RESULT(obj)
!     CLASS(ReferenceElement_), INTENT(IN) :: refelem
!     INTEGER(I4B), INTENT(IN) :: nips(:)
!     !! number of integration points
!     !! IF size(nips) = 1, then sqrt(nips(1)) points are used in both dirn
!     !! IF size(nips) = 2, then in x1 direction nips(1) points and in
!     !! x2 direction nips(2) points are used.
!     TYPE(QuadraturePoint_) :: obj
!   END FUNCTION getGaussLegendreLobattoQP2
! END INTERFACE GaussLegendreLobattoQuadrature

!----------------------------------------------------------------------------
!                       GaussLegendreLobattoQuadrature@GaussLegendreLobatto
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 23 July 2021
! summary: Returns the Gauss LegendreLobatto Quadrature points

! INTERFACE GaussLegendreLobattoQuadrature
!   MODULE FUNCTION getGaussLegendreLobattoQP3(refelem, p, q, r) RESULT(obj)
!     CLASS(ReferenceElement_), INTENT(IN) :: refelem
!     INTEGER(I4B), INTENT(IN) :: p
!     !! order of accuracy in x1 direction
!     INTEGER(I4B), INTENT(IN) :: q
!     !! order of accuracy in x2 direction
!     INTEGER(I4B), OPTIONAL, INTENT(IN) :: r
!     !! order of accuracy in x3 direction
!     TYPE(QuadraturePoint_) :: obj
!   END FUNCTION getGaussLegendreLobattoQP3
! END INTERFACE GaussLegendreLobattoQuadrature

!----------------------------------------------------------------------------
!                   GaussLegendreRadauLeftQuadrature@GaussLegendreRadauLeft
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 23 July 2021
! summary: Returns the LegendreRadauLeft Quadrature points

! INTERFACE GaussLegendreRadauLeftQuadrature
!   MODULE FUNCTION getGaussLegendreRadauLeftQP1(refelem, order) RESULT(obj)
!     CLASS(ReferenceElement_), INTENT(IN) :: refelem
!     INTEGER(I4B), INTENT(IN) :: order
!     !! order of accuracy in each direction
!     TYPE(QuadraturePoint_) :: obj
!   END FUNCTION getGaussLegendreRadauLeftQP1
! END INTERFACE GaussLegendreRadauLeftQuadrature

!----------------------------------------------------------------------------
!                   GaussLegendreRadauLeftQuadrature@GaussLegendreRadauLeft
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 23 July 2021
! summary: Returns the Gauss-LegendreRadauLeft Quadrature points

! INTERFACE GaussLegendreRadauLeftQuadrature
!   MODULE FUNCTION getGaussLegendreRadauLeftQP2(refelem, nips) RESULT(obj)
!     CLASS(ReferenceElement_), INTENT(IN) :: refelem
!     INTEGER(I4B), INTENT(IN) :: nips(:)
!     !! number of integration points
!     !! IF size(nips) = 1, then sqrt(nips(1)) points are used in both dirn
!     !! IF size(nips) = 2, then in x1 direction nips(1) points and in
!     !! x2 direction nips(2) points are used.
!     TYPE(QuadraturePoint_) :: obj
!   END FUNCTION getGaussLegendreRadauLeftQP2
! END INTERFACE GaussLegendreRadauLeftQuadrature

!----------------------------------------------------------------------------
!                   GaussLegendreRadauLeftQuadrature@GaussLegendreRadauLeft
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 23 July 2021
! summary: Returns the Gauss LegendreRadauLeft Quadrature points

! INTERFACE GaussLegendreRadauLeftQuadrature
!   MODULE FUNCTION getGaussLegendreRadauLeftQP3(refelem, p, q, r) RESULT(obj)
!     CLASS(ReferenceElement_), INTENT(IN) :: refelem
!     INTEGER(I4B), INTENT(IN) :: p
!     !! order of accuracy in x1 direction
!     INTEGER(I4B), INTENT(IN) :: q
!     !! order of accuracy in x2 direction
!     INTEGER(I4B), OPTIONAL, INTENT(IN) :: r
!     !! order of accuracy in x3 direction
!     TYPE(QuadraturePoint_) :: obj
!   END FUNCTION getGaussLegendreRadauLeftQP3
! END INTERFACE GaussLegendreRadauLeftQuadrature

!----------------------------------------------------------------------------
!                  GaussLegendreRadauRightQuadrature@GaussLegendreRadauRight
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 23 July 2021
! summary: Returns the LegendreRadauRight Quadrature points

! INTERFACE GaussLegendreRadauRightQuadrature
!   MODULE FUNCTION getGaussLegendreRadauRightQP1(refelem, order) RESULT(obj)
!     CLASS(ReferenceElement_), INTENT(IN) :: refelem
!     INTEGER(I4B), INTENT(IN) :: order
!     !! order of accuracy in each direction
!     TYPE(QuadraturePoint_) :: obj
!   END FUNCTION getGaussLegendreRadauRightQP1
! END INTERFACE GaussLegendreRadauRightQuadrature

!----------------------------------------------------------------------------
!                  GaussLegendreRadauRightQuadrature@GaussLegendreRadauRight
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 23 July 2021
! summary: Returns the Gauss-LegendreRadauRight Quadrature points

! INTERFACE GaussLegendreRadauRightQuadrature
!   MODULE FUNCTION getGaussLegendreRadauRightQP2(refelem, nips) RESULT(obj)
!     CLASS(ReferenceElement_), INTENT(IN) :: refelem
!     INTEGER(I4B), INTENT(IN) :: nips(:)
!     !! number of integration points
!     !! IF size(nips) = 1, then sqrt(nips(1)) points are used in both dirn
!     !! IF size(nips) = 2, then in x1 direction nips(1) points and in
!     !! x2 direction nips(2) points are used.
!     TYPE(QuadraturePoint_) :: obj
!   END FUNCTION getGaussLegendreRadauRightQP2
! END INTERFACE GaussLegendreRadauRightQuadrature

!----------------------------------------------------------------------------
!                  GaussLegendreRadauRightQuadrature@GaussLegendreRadauRight
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 23 July 2021
! summary: Returns the Gauss LegendreRadauRight Quadrature points

! INTERFACE GaussLegendreRadauRightQuadrature
!   MODULE FUNCTION getGaussLegendreRadauRightQP3(refelem, p, q, r) RESULT(obj)
!     CLASS(ReferenceElement_), INTENT(IN) :: refelem
!     INTEGER(I4B), INTENT(IN) :: p
!     !! order of accuracy in x1 direction
!     INTEGER(I4B), INTENT(IN) :: q
!     !! order of accuracy in x2 direction
!     INTEGER(I4B), OPTIONAL, INTENT(IN) :: r
!     !! order of accuracy in x3 direction
!     TYPE(QuadraturePoint_) :: obj
!   END FUNCTION getGaussLegendreRadauRightQP3
! END INTERFACE GaussLegendreRadauRightQuadrature

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

END MODULE QuadraturePoint_Method
