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

SUBMODULE(LagrangePolynomialUtility) Methods
USE BaseMethod
IMPLICIT NONE
CONTAINS

!----------------------------------------------------------------------------
!                                                             RefElemDomain
!----------------------------------------------------------------------------

MODULE PROCEDURE RefElemDomain
SELECT CASE (elemType)
CASE (Point)
  ans = ""

CASE (Line)
  ans = RefElemDomain_Line(baseContinuity, baseInterpol)

CASE (Triangle)
  ans = RefElemDomain_Triangle(baseContinuity, baseInterpol)

CASE (Quadrangle)
  ans = RefElemDomain_Quadrangle(baseContinuity, baseInterpol)

CASE (Tetrahedron)
  ans = RefElemDomain_Tetrahedron(baseContinuity, baseInterpol)

CASE (Hexahedron)
  ans = RefElemDomain_Hexahedron(baseContinuity, baseInterpol)

CASE (Prism)
  ans = RefElemDomain_Prism(baseContinuity, baseInterpol)

CASE (Pyramid)
  ans = RefElemDomain_Pyramid(baseContinuity, baseInterpol)
END SELECT

END PROCEDURE RefElemDomain

!----------------------------------------------------------------------------
!                                                                  RefCoord
!----------------------------------------------------------------------------

MODULE PROCEDURE RefCoord
SELECT CASE (elemType)
CASE (Point)
  CALL Reallocate(ans, 3_I4B, 1_I4B)

CASE (Line)
  ans = RefCoord_Line(refElem)

CASE (Triangle)
  ans = RefCoord_Triangle(refElem)

CASE (Quadrangle)
  ans = RefCoord_Quadrangle(refElem)

CASE (Tetrahedron)
  ans = RefCoord_Tetrahedron(refElem)

CASE (Hexahedron)
  ans = RefCoord_Hexahedron(refElem)

CASE (Prism)
  ans = RefCoord_Prism(refElem)

CASE (Pyramid)
  ans = RefCoord_Pyramid(refElem)

END SELECT
END PROCEDURE RefCoord

!----------------------------------------------------------------------------
!                                                               LagrangeDOF
!----------------------------------------------------------------------------

MODULE PROCEDURE LagrangeDOF
SELECT CASE (elemType)
CASE (Point)
  ans = 1
CASE (Line)
  ans = LagrangeDOF_Line(order=order)
CASE (Triangle)
  ans = LagrangeDOF_Triangle(order=order)
CASE (Quadrangle)
  ans = LagrangeDOF_Quadrangle(order=order)
CASE (Tetrahedron)
  ans = LagrangeDOF_Tetrahedron(order=order)
CASE (Hexahedron)
  ans = LagrangeDOF_Hexahedron(order=order)
CASE (Prism)
  ans = LagrangeDOF_Prism(order=order)
CASE (Pyramid)
  ans = LagrangeDOF_Pyramid(order=order)
END SELECT
END PROCEDURE LagrangeDOF

!----------------------------------------------------------------------------
!                                                             LagrangeInDOF
!----------------------------------------------------------------------------

MODULE PROCEDURE LagrangeInDOF
SELECT CASE (elemType)
CASE (Point)
  ans = 0
CASE (Line)
  ans = LagrangeInDOF_Line(order=order)
CASE (Triangle)
  ans = LagrangeInDOF_Triangle(order=order)
CASE (Quadrangle)
  ans = LagrangeInDOF_Quadrangle(order=order)
CASE (Tetrahedron)
  ans = LagrangeInDOF_Tetrahedron(order=order)
CASE (Hexahedron)
  ans = LagrangeInDOF_Hexahedron(order=order)
CASE (Prism)
  ans = LagrangeInDOF_Prism(order=order)
CASE (Pyramid)
  ans = LagrangeInDOF_Pyramid(order=order)
END SELECT
END PROCEDURE LagrangeInDOF

!----------------------------------------------------------------------------
!                                                             LagrangeDegree
!----------------------------------------------------------------------------

MODULE PROCEDURE LagrangeDegree
SELECT CASE (elemType)
CASE (Point)
  ALLOCATE (ans(0, 0))
CASE (Line)
  ans = LagrangeDegree_Line(order=order)
CASE (Triangle)
  ans = LagrangeDegree_Triangle(order=order)
CASE (Quadrangle)
  ans = LagrangeDegree_Quadrangle(order=order)
CASE (Tetrahedron)
  ans = LagrangeDegree_Tetrahedron(order=order)
CASE (Hexahedron)
  ans = LagrangeDegree_Hexahedron(order=order)
CASE (Prism)
  ans = LagrangeDegree_Prism(order=order)
CASE (Pyramid)
  ans = LagrangeDegree_Pyramid(order=order)
END SELECT
END PROCEDURE LagrangeDegree

!----------------------------------------------------------------------------
!                                                       LagrangeVandermonde
!----------------------------------------------------------------------------

MODULE PROCEDURE LagrangeVandermonde
INTEGER(I4B), ALLOCATABLE :: degree(:, :)
INTEGER(I4B) :: m, n, jj, nsd, ii

degree = LagrangeDegree(order=order, elemType=elemType)
m = SIZE(xij, 2)
nsd = SIZE(degree, 2)
n = SIZE(degree, 1)
ALLOCATE (ans(m, n))

SELECT CASE (nsd)
CASE (1)
  DO jj = 1, n
    ans(:, jj) = xij(1, :)**degree(jj, 1)
  END DO
CASE (2)
  DO jj = 1, n
    ans(:, jj) = xij(1, :)**degree(jj, 1) * xij(2, :)**degree(jj, 2)
  END DO
CASE (3)
  ! ans = 0.0_DFP
  DO CONCURRENT(jj=1:n, ii=1:m)
    ans(ii, jj) = (xij(1, ii)**degree(jj, 1)) * (xij(2, ii)**degree(jj, 2))  &
                 & * (xij(3, ii)**degree(jj, 3))
  END DO
END SELECT

IF (ALLOCATED(degree)) DEALLOCATE (degree)
END PROCEDURE LagrangeVandermonde

!----------------------------------------------------------------------------
!                                                          EquidistancePoint
!----------------------------------------------------------------------------

MODULE PROCEDURE EquidistancePoint
SELECT CASE (elemType)
CASE (Point)
  IF (PRESENT(xij)) THEN
    ans = xij
  ELSE
    ALLOCATE (ans(0, 0))
  END IF

CASE (Line)
  ans = EquidistancePoint_Line(order=order, xij=xij)

CASE (Triangle)
  ans = EquidistancePoint_Triangle(order=order, xij=xij)

CASE (Quadrangle)
  ans = EquidistancePoint_Quadrangle(order=order, xij=xij)

CASE (Tetrahedron)
  ans = EquidistancePoint_Tetrahedron(order=order, xij=xij)

CASE (Hexahedron)
  ans = EquidistancePoint_Hexahedron(order=order, xij=xij)

CASE (Prism)
  ans = EquidistancePoint_Prism(order=order, xij=xij)

CASE (Pyramid)
  ans = EquidistancePoint_Pyramid(order=order, xij=xij)

CASE DEFAULT
  CALL Errormsg(&
    & msg="No CASE FOUND: elemType="//tostring(elemType), &
    & unitno=stdout,  &
    & line=__LINE__,  &
    & routine="EquidistancePoint()",  &
    & file=__FILE__)
END SELECT
END PROCEDURE EquidistancePoint

!----------------------------------------------------------------------------
!                                                         InterpolationPoint
!----------------------------------------------------------------------------

MODULE PROCEDURE InterpolationPoint
SELECT CASE (elemType)
CASE (Point)
  IF (PRESENT(xij)) THEN
    ans = xij
  ELSE
    ALLOCATE (ans(0, 0))
  END IF

CASE (Line)
  ans = InterpolationPoint_Line(&
    & order=order, &
    & ipType=ipType, &
    & xij=xij, &
    & layout=layout, &
    & alpha=alpha, beta=beta, lambda=lambda)

CASE (Triangle)
  ans = InterpolationPoint_Triangle( &
    & order=order, &
    & ipType=ipType, &
    & xij=xij, &
    & layout=layout,  &
    & alpha=alpha, beta=beta, lambda=lambda)

CASE (Quadrangle)
  ans = InterpolationPoint_Quadrangle( &
    & order=order, &
    & ipType=ipType, &
    & xij=xij, &
    & layout=layout,  &
    & alpha=alpha, beta=beta, lambda=lambda)

CASE (Tetrahedron)
  ans = InterpolationPoint_Tetrahedron( &
    & order=order, &
    & ipType=ipType, &
    & xij=xij, &
    & layout=layout,  &
    & alpha=alpha, beta=beta, lambda=lambda)

CASE (Hexahedron)
  ans = InterpolationPoint_Hexahedron( &
    & order=order, &
    & ipType=ipType, &
    & xij=xij, &
    & layout=layout,  &
    & alpha=alpha, beta=beta, lambda=lambda)

CASE (Prism)
  ans = InterpolationPoint_Prism( &
    & order=order, &
    & ipType=ipType, &
    & xij=xij, &
    & layout=layout,  &
    & alpha=alpha, beta=beta, lambda=lambda)

CASE (Pyramid)
  ans = InterpolationPoint_Pyramid( &
    & order=order, &
    & ipType=ipType, &
    & xij=xij, &
    & layout=layout,  &
    & alpha=alpha, beta=beta, lambda=lambda)

CASE DEFAULT
  CALL Errormsg(&
    & msg="No CASE FOUND: elemType="//tostring(elemType), &
    & unitno=stdout,  &
    & line=__LINE__,  &
    & routine="InterpolationPoint()",  &
    & file=__FILE__)
  RETURN
END SELECT

END PROCEDURE InterpolationPoint

!----------------------------------------------------------------------------
!                                                             LagrangeCoeff
!----------------------------------------------------------------------------

MODULE PROCEDURE LagrangeCoeff1
SELECT CASE (elemType)
CASE (Point)
CASE (Line)
  ans = LagrangeCoeff_Line(order=order, xij=xij, i=i)

CASE (Triangle)
  ans = LagrangeCoeff_Triangle(order=order, xij=xij, i=i)

CASE (Quadrangle)
  ans = LagrangeCoeff_Quadrangle(order=order, xij=xij, i=i)

CASE (Tetrahedron)
  ans = LagrangeCoeff_Tetrahedron(order=order, xij=xij, i=i)

CASE (Hexahedron)
  ans = LagrangeCoeff_Hexahedron(order=order, xij=xij, i=i)

CASE (Prism)
  ans = LagrangeCoeff_Prism(order=order, xij=xij, i=i)

CASE (Pyramid)
  ans = LagrangeCoeff_Pyramid(order=order, xij=xij, i=i)

CASE DEFAULT
  CALL Errormsg(&
    & msg="No CASE FOUND: elemType="//tostring(elemType), &
    & unitno=stdout,  &
    & line=__LINE__,  &
    & routine="LagrangeCoeff1()",  &
    & file=__FILE__)
END SELECT
END PROCEDURE LagrangeCoeff1

!----------------------------------------------------------------------------
!                                                             LagrangeCoeff
!----------------------------------------------------------------------------

MODULE PROCEDURE LagrangeCoeff2
SELECT CASE (elemType)
CASE (Point)

CASE (Line)
  ans = LagrangeCoeff_Line(order=order, xij=xij)

CASE (Triangle)
  ans = LagrangeCoeff_Triangle(order=order, xij=xij)

CASE (Quadrangle)
  ans = LagrangeCoeff_Quadrangle(order=order, xij=xij)

CASE (Tetrahedron)
  ans = LagrangeCoeff_Tetrahedron(order=order, xij=xij)

CASE (Hexahedron)
  ans = LagrangeCoeff_Hexahedron(order=order, xij=xij)

CASE (Prism)
  ans = LagrangeCoeff_Prism(order=order, xij=xij)

CASE (Pyramid)
  ans = LagrangeCoeff_Pyramid(order=order, xij=xij)

CASE DEFAULT
  CALL Errormsg(&
    & msg="No CASE FOUND: elemType="//tostring(elemType), &
    & unitno=stdout,  &
    & line=__LINE__,  &
    & routine="LagrangeCoeff2()",  &
    & file=__FILE__)
END SELECT
END PROCEDURE LagrangeCoeff2

!----------------------------------------------------------------------------
!                                                             LagrangeCoeff
!----------------------------------------------------------------------------

MODULE PROCEDURE LagrangeCoeff3
SELECT CASE (elemType)
CASE (Point)

CASE (Line)
  ans = LagrangeCoeff_Line(order=order, i=i, v=v, isVandermonde=.TRUE.)

CASE (Triangle)
  ans = LagrangeCoeff_Triangle(order=order, i=i, v=v, isVandermonde=.TRUE.)

CASE (Quadrangle)
  ans = LagrangeCoeff_Quadrangle(order=order, i=i, v=v, isVandermonde=.TRUE.)

CASE (Tetrahedron)
  ans = LagrangeCoeff_Tetrahedron(order=order, i=i, v=v, isVandermonde=.TRUE.)

CASE (Hexahedron)
  ans = LagrangeCoeff_Hexahedron(order=order, i=i, v=v, isVandermonde=.TRUE.)

CASE (Prism)
  ans = LagrangeCoeff_Prism(order=order, i=i, v=v, isVandermonde=.TRUE.)

CASE (Pyramid)
  ans = LagrangeCoeff_Pyramid(order=order, i=i, v=v, isVandermonde=.TRUE.)

CASE DEFAULT
  CALL Errormsg(&
    & msg="No CASE FOUND: elemType="//tostring(elemType), &
    & unitno=stdout,  &
    & line=__LINE__,  &
    & routine="LagrangeCoeff2()",  &
    & file=__FILE__)
END SELECT
END PROCEDURE LagrangeCoeff3

!----------------------------------------------------------------------------
!                                                             LagrangeCoeff
!----------------------------------------------------------------------------

MODULE PROCEDURE LagrangeCoeff4
SELECT CASE (elemType)
CASE (Point)

CASE (Line)
  ans = LagrangeCoeff_Line(order=order, i=i, v=v, ipiv=ipiv)

CASE (Triangle)
  ans = LagrangeCoeff_Triangle(order=order, i=i, v=v, ipiv=ipiv)

CASE (Quadrangle)
  ans = LagrangeCoeff_Quadrangle(order=order, i=i, v=v, ipiv=ipiv)

CASE (Tetrahedron)
  ans = LagrangeCoeff_Tetrahedron(order=order, i=i, v=v, ipiv=ipiv)

CASE (Hexahedron)
  ans = LagrangeCoeff_Hexahedron(order=order, i=i, v=v, ipiv=ipiv)

CASE (Prism)
  ans = LagrangeCoeff_Prism(order=order, i=i, v=v, ipiv=ipiv)

CASE (Pyramid)
  ans = LagrangeCoeff_Pyramid(order=order, i=i, v=v, ipiv=ipiv)

CASE DEFAULT
  CALL Errormsg(&
    & msg="No CASE FOUND: elemType="//tostring(elemType), &
    & unitno=stdout,  &
    & line=__LINE__,  &
    & routine="LagrangeCoeff2()",  &
    & file=__FILE__)
END SELECT
END PROCEDURE LagrangeCoeff4

!----------------------------------------------------------------------------
!                                                           LagrangeEvalAll
!----------------------------------------------------------------------------

MODULE PROCEDURE LagrangeEvalAll1
SELECT CASE (elemType)
CASE (Point)

CASE (Line)
  ans = LagrangeEvalAll_Line( &
    & order=order,  &
    & xij=xij,  &
    & x=x,  &
    & coeff=coeff,  &
    & firstCall=firstCall,  &
    & basisType=basisType,  &
    & alpha=alpha,  &
    & beta=beta,  &
    & lambda=lambda)

CASE (Triangle)
  ans = LagrangeEvalAll_Triangle( &
    & order=order,  &
    & x=x,  &
    & xij=xij,  &
    & refTriangle=domainName, &
    & coeff=coeff,  &
    & firstCall=firstCall,  &
    & basisType=basisType,  &
    & alpha=alpha,  &
    & beta=beta,  &
    & lambda=lambda)

CASE (Quadrangle)
  ans = LagrangeEvalAll_Quadrangle( &
    & order=order,  &
    & x=x,  &
    & xij=xij,  &
    & coeff=coeff,  &
    & firstCall=firstCall,  &
    & basisType=basisType,  &
    & alpha=alpha,  &
    & beta=beta,  &
    & lambda=lambda)

CASE (Tetrahedron)
  ans = LagrangeEvalAll_Tetrahedron( &
    & order=order,  &
    & x=x,  &
    & xij=xij,  &
    & refTetrahedron=domainName, &
    & coeff=coeff,  &
    & firstCall=firstCall,  &
    & basisType=basisType,  &
    & alpha=alpha, &
    & beta=beta,  &
    & lambda=lambda)

CASE (Hexahedron)
  ans = LagrangeEvalAll_Hexahedron( &
    & order=order,  &
    & x=x,  &
    & xij=xij,  &
    & coeff=coeff,  &
    & firstCall=firstCall,  &
    & basisType=basisType,  &
    & alpha=alpha, &
    & beta=beta,  &
    & lambda=lambda)

CASE (Prism)
  ans = LagrangeEvalAll_Prism( &
    & order=order,  &
    & x=x,  &
    & xij=xij,  &
    & refPrism=domainName, &
    & coeff=coeff,  &
    & firstCall=firstCall,  &
    & basisType=basisType,  &
    & alpha=alpha, &
    & beta=beta,  &
    & lambda=lambda)

CASE (Pyramid)
  ans = LagrangeEvalAll_Pyramid( &
    & order=order,  &
    & x=x,  &
    & xij=xij,  &
    & refPyramid=domainName, &
    & coeff=coeff,  &
    & firstCall=firstCall,  &
    & basisType=basisType,  &
    & alpha=alpha, &
    & beta=beta,  &
    & lambda=lambda)

CASE DEFAULT
  CALL Errormsg(&
    & msg="No CASE FOUND: elemType="//tostring(elemType), &
    & unitno=stdout,  &
    & line=__LINE__,  &
    & routine="LagrangeEvalAll2()",  &
    & file=__FILE__)
END SELECT
END PROCEDURE LagrangeEvalAll1

!----------------------------------------------------------------------------
!                                                 LagrangeGradientEvalAll
!----------------------------------------------------------------------------

MODULE PROCEDURE LagrangeGradientEvalAll1
SELECT CASE (elemType)
CASE (Point)

CASE (Line)
  IF (SIZE(x, 1) .NE. 1 .OR. SIZE(xij, 1) .NE. 1) THEN
    CALL Errormsg( &
    & msg="SIZE(x, 1) or SIZE(xij, 1) .NE. 1",  &
    & unitno=stderr,  &
    & line=__LINE__,  &
    & routine="LagrangeGradientEvalAll1",  &
    & file=__FILE__)
    RETURN
  END IF

  ans(:, :, 1:1) = LagrangeGradientEvalAll_Line( &
    & order=order,  &
    & x=x,  &
    & xij=xij,  &
    & coeff=coeff,  &
    & firstCall=firstCall,  &
    & basisType=basisType,  &
    & alpha=alpha,  &
    & beta=beta,  &
    & lambda=lambda)

CASE (Triangle)

  IF (SIZE(x, 1) .NE. 2 .OR. SIZE(xij, 1) .NE. 2) THEN
    CALL Errormsg( &
    & msg="SIZE(x, 1) or SIZE(xij, 1) .NE. 2",  &
    & unitno=stderr,  &
    & line=__LINE__,  &
    & routine="LagrangeGradientEvalAll1",  &
    & file=__FILE__)
    RETURN
  END IF

  ans(:, :, 1:2) = LagrangeGradientEvalAll_Triangle( &
    & order=order,  &
    & x=x,  &
    & xij=xij,  &
    & refTriangle=domainName, &
    & coeff=coeff,  &
    & firstCall=firstCall,  &
    & basisType=basisType,  &
    & alpha=alpha,  &
    & beta=beta,  &
    & lambda=lambda)

CASE (Quadrangle)

  IF (SIZE(x, 1) .NE. 2 .OR. SIZE(xij, 1) .NE. 2) THEN
    CALL Errormsg( &
    & msg="SIZE(x, 1) or SIZE(xij, 1) .NE. 2",  &
    & unitno=stderr,  &
    & line=__LINE__,  &
    & routine="LagrangeGradientEvalAll1",  &
    & file=__FILE__)
    RETURN
  END IF
  ans(:, :, 1:2) = LagrangeGradientEvalAll_Quadrangle( &
    & order=order,  &
    & x=x,  &
    & xij=xij,  &
    & coeff=coeff,  &
    & firstCall=firstCall,  &
    & basisType=basisType,  &
    & alpha=alpha,  &
    & beta=beta,  &
    & lambda=lambda)

CASE (Tetrahedron)

  IF (SIZE(x, 1) .NE. 3 .OR. SIZE(xij, 1) .NE. 3) THEN
    CALL Errormsg( &
    & msg="SIZE(x, 1) or SIZE(xij, 1) .NE. 3",  &
    & unitno=stderr,  &
    & line=__LINE__,  &
    & routine="LagrangeGradientEvalAll1",  &
    & file=__FILE__)
    RETURN
  END IF
  ans(:, :, 1:3) = LagrangeGradientEvalAll_Tetrahedron( &
    & order=order,  &
    & x=x,  &
    & xij=xij,  &
    & refTetrahedron=domainName, &
    & coeff=coeff,  &
    & firstCall=firstCall,  &
    & basisType=basisType,  &
    & alpha=alpha,  &
    & beta=beta,  &
    & lambda=lambda)

CASE (Hexahedron)

  IF (SIZE(x, 1) .NE. 3 .OR. SIZE(xij, 1) .NE. 3) THEN
    CALL Errormsg( &
    & msg="SIZE(x, 1) or SIZE(xij, 1) .NE. 3",  &
    & unitno=stderr,  &
    & line=__LINE__,  &
    & routine="LagrangeGradientEvalAll1",  &
    & file=__FILE__)
    RETURN
  END IF
  ans(:, :, 1:3) = LagrangeGradientEvalAll_Hexahedron( &
    & order=order,  &
    & x=x,  &
    & xij=xij,  &
    & coeff=coeff,  &
    & firstCall=firstCall,  &
    & basisType=basisType,  &
    & alpha=alpha,  &
    & beta=beta,  &
    & lambda=lambda)

CASE (Prism)

  IF (SIZE(x, 1) .NE. 3 .OR. SIZE(xij, 1) .NE. 3) THEN
    CALL Errormsg( &
    & msg="SIZE(x, 1) or SIZE(xij, 1) .NE. 3",  &
    & unitno=stderr,  &
    & line=__LINE__,  &
    & routine="LagrangeGradientEvalAll1",  &
    & file=__FILE__)
    RETURN
  END IF
  ans(:, :, 1:3) = LagrangeGradientEvalAll_Prism( &
    & order=order,  &
    & x=x,  &
    & xij=xij,  &
    & refPrism=domainName, &
    & coeff=coeff,  &
    & firstCall=firstCall,  &
    & basisType=basisType,  &
    & alpha=alpha,  &
    & beta=beta,  &
    & lambda=lambda)

CASE (Pyramid)

  IF (SIZE(x, 1) .NE. 3 .OR. SIZE(xij, 1) .NE. 3) THEN
    CALL Errormsg( &
    & msg="SIZE(x, 1) or SIZE(xij, 1) .NE. 3",  &
    & unitno=stderr,  &
    & line=__LINE__,  &
    & routine="LagrangeGradientEvalAll1",  &
    & file=__FILE__)
    RETURN
  END IF
  ans(:, :, 1:3) = LagrangeGradientEvalAll_Pyramid( &
    & order=order,  &
    & x=x,  &
    & xij=xij,  &
    & refPyramid=domainName, &
    & coeff=coeff,  &
    & firstCall=firstCall,  &
    & basisType=basisType,  &
    & alpha=alpha,  &
    & beta=beta,  &
    & lambda=lambda)

CASE DEFAULT
  CALL Errormsg(&
    & msg="No CASE FOUND: elemType="//tostring(elemType), &
    & unitno=stdout,  &
    & line=__LINE__,  &
    & routine="LagrangeGradientEvalAll1()",  &
    & file=__FILE__)
  RETURN
END SELECT
END PROCEDURE LagrangeGradientEvalAll1

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

END SUBMODULE Methods
