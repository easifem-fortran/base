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
! date: 5 March 2021
! summary: This module contains methods for [[ReferenceQuadrangle_]]

MODULE ReferenceQuadrangle_Method
USE GlobalData
USE BaseType
IMPLICIT NONE
PRIVATE
PUBLIC :: Initiate
PUBLIC :: ReferenceQuadrangle
PUBLIC :: ReferenceQuadrangle_Pointer
PUBLIC :: HighorderElement_Quadrangle
PUBLIC :: Measure_Simplex_Quadrangle
PUBLIC :: Quadrangle_Quality
PUBLIC :: Quality_Quadrangle
PUBLIC :: QuadArea3D, QuadrangleArea3D
PUBLIC :: QuadArea2D, QuadrangleArea2D
PUBLIC :: QuadrangleName
PUBLIC :: GetEdgeConnectivity_Quadrangle
PUBLIC :: RefQuadrangleCoord
PUBLIC :: RefCoord_Quadrangle
PUBLIC :: FaceShapeMetaData_Quadrangle
PUBLIC :: FacetElements_Quadrangle
PUBLIC :: DEFAULT_OPT_QUADRANGLE_EDGE_CON
PUBLIC :: ElementOrder_Quadrangle
PUBLIC :: ElementType_Quadrangle
PUBLIC :: TotalNodesInElement_Quadrangle

INTEGER(I4B), PUBLIC, PARAMETER :: HelpFaceData_Quadrangle(5, 4) =  &
& RESHAPE([ &
& 2, 4, 3, 2, 4, &
& 1, 3, 4, 3, 1, &
& 2, 4, 1, 4, 2, &
& 1, 3, 2, 1, 3 &
], [5, 4])

#ifdef _QUADRANGLE_EDGE_CON_DEFAULT_OPT_2
INTEGER(I4B), PARAMETER :: DEFAULT_OPT_QUADRANGLE_EDGE_CON = 1_I4B
!! This means edges are [1,2], [4,3], [1,4], [2, 3]
#else
INTEGER(I4B), PARAMETER :: DEFAULT_OPT_QUADRANGLE_EDGE_CON = 2_I4B
!! This means edges are [1,2], [2,3], [3,4], [4,1]
!! This is default option
#endif

!----------------------------------------------------------------------------
!                                             TotalNodesInElement_Quadrangle
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date:  2024-03-22
! summary:  Returns total nodes in element

INTERFACE
  MODULE PURE FUNCTION TotalNodesInElement_Quadrangle(elemType) RESULT(ans)
    INTEGER(I4B), INTENT(IN) :: elemType
    INTEGER(I4B) :: ans
  END FUNCTION TotalNodesInElement_Quadrangle
END INTERFACE

!----------------------------------------------------------------------------
!                                                    ElementType_Quadrangle
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date:  2024-03-22
! summary:  Returns the type of element from char name

INTERFACE
  MODULE PURE FUNCTION ElementType_Quadrangle(elemName) RESULT(ans)
    CHARACTER(*), INTENT(IN) :: elemName
    INTEGER(I4B) :: ans
  END FUNCTION ElementType_Quadrangle
END INTERFACE

!----------------------------------------------------------------------------
!                                                    ElementOrder_Quadrangle
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date:  2024-03-22
! summary:  Returns the order of element

INTERFACE
  MODULE PURE FUNCTION ElementOrder_Quadrangle(elemType) RESULT(ans)
    INTEGER(I4B), INTENT(IN) :: elemType
    INTEGER(I4B) :: ans
  END FUNCTION ElementOrder_Quadrangle
END INTERFACE

!----------------------------------------------------------------------------
!                                                   FacetElements_Quadrangle
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date:  2024-03-21
! summary:  Get FacetElements

INTERFACE FacetElements_Quadrangle
  MODULE SUBROUTINE FacetElements_Quadrangle1(refelem, ans)
    CLASS(ReferenceElement_), INTENT(IN) :: refelem
    TYPE(ReferenceElement_), INTENT(INOUT) :: ans(:)
  END SUBROUTINE FacetElements_Quadrangle1
END INTERFACE FacetElements_Quadrangle

!----------------------------------------------------------------------------
!                                                   FacetElements_Quadrangle
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date:  2024-03-21
! summary:  Get FacetElements

INTERFACE FacetElements_Quadrangle
  MODULE SUBROUTINE FacetElements_Quadrangle2(elemType, nsd, ans)
    INTEGER(I4B), INTENT(IN) :: elemType
    INTEGER(I4B), INTENT(IN) :: nsd
    TYPE(ReferenceElement_), INTENT(INOUT) :: ans(:)
  END SUBROUTINE FacetElements_Quadrangle2
END INTERFACE FacetElements_Quadrangle

!----------------------------------------------------------------------------
!                                                       QuadrangleName
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date:  2023-07-17
! summary:  Returns integer name of quadragle from order

INTERFACE QuadrangleName
  MODULE PURE FUNCTION QuadrangleName1(order) RESULT(ans)
    INTEGER(I4B), INTENT(IN) :: order
    INTEGER(I4B) :: ans
  END FUNCTION QuadrangleName1
END INTERFACE QuadrangleName

!----------------------------------------------------------------------------
!                                                       Initiate@Quadrangle
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 1 March 2021
! summary: Returns linear quadrangle element

INTERFACE Initiate
  MODULE PURE SUBROUTINE initiate_ref_Quadrangle(obj, NSD, xij, domainName)
    CLASS(ReferenceQuadrangle_), INTENT(INOUT) :: obj
    INTEGER(I4B), INTENT(IN) :: NSD
    REAL(DFP), INTENT(IN), OPTIONAL :: xij(:, :)
    CHARACTER(*), OPTIONAL, INTENT(IN) :: domainName
  END SUBROUTINE initiate_ref_Quadrangle
END INTERFACE Initiate

!----------------------------------------------------------------------------
!                                            ReferenceQuadrangle@Quadrangle
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 1 March 2021
! summary: Returns Lienar Quadrangle element

INTERFACE ReferenceQuadrangle
  MODULE PURE FUNCTION reference_Quadrangle(NSD, xij, domainName) RESULT(obj)
    INTEGER(I4B), INTENT(IN) :: NSD
    REAL(DFP), INTENT(IN), OPTIONAL :: xij(:, :)
    CHARACTER(*), OPTIONAL, INTENT(IN) :: domainName
    TYPE(ReferenceQuadrangle_) :: obj
  END FUNCTION reference_Quadrangle
END INTERFACE ReferenceQuadrangle

!----------------------------------------------------------------------------
!                                     ReferenceQuadrangle_Pointer@Quadrangle
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 1 March 2021
! summary: Returns linear Quadrangle element

INTERFACE ReferenceQuadrangle_Pointer
  MODULE FUNCTION reference_Quadrangle_Pointer(NSD, xij, domainName)  &
    & RESULT(obj)
    INTEGER(I4B), INTENT(IN) :: NSD
    REAL(DFP), INTENT(IN), OPTIONAL :: xij(:, :)
    CHARACTER(*), OPTIONAL, INTENT(IN) :: domainName
    CLASS(ReferenceQuadrangle_), POINTER :: obj
  END FUNCTION reference_Quadrangle_Pointer
END INTERFACE ReferenceQuadrangle_Pointer

!----------------------------------------------------------------------------
!                                                LagrangeElement@Quadrangle
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date:         3 March 2021
! summary:         Higher order lagrange elements
!
!### Usage
!
!```fortran
! subroutine test4
!   class( ReferenceElement_ ), pointer :: obj_ptr => null()
!   type( ReferenceQuadrangle_ ) :: obj
!   obj_ptr => referenceQuadrangle_pointer( nsd = 2 )
!   call obj_ptr%LagrangeElement( order = 2, Highorderobj = obj )
!   call display( obj, "higher order obj : ")
!   call obj_ptr%LagrangeElement( order = 3, Highorderobj = obj )
!   call display( obj, "3rd order obj : ")
! end
!```

INTERFACE
  MODULE SUBROUTINE HighorderElement_Quadrangle(refelem, order, obj, &
    & ipType)
    CLASS(ReferenceElement_), INTENT(IN) :: refelem
    INTEGER(I4B), INTENT(IN) :: order
    CLASS(ReferenceElement_), INTENT(INOUT) :: obj
    INTEGER(I4B), INTENT(IN) :: ipType
  END SUBROUTINE HighorderElement_Quadrangle
END INTERFACE

!----------------------------------------------------------------------------
!                                                 MeasureSimplex@Geometry
!----------------------------------------------------------------------------

INTERFACE
  MODULE PURE FUNCTION Measure_Simplex_Quadrangle(refelem, xij) RESULT(Ans)
    CLASS(ReferenceElement_), INTENT(IN) :: refelem
    REAL(DFP), INTENT(IN) :: xij(:, :)
    REAL(DFP) :: Ans
  END FUNCTION Measure_Simplex_Quadrangle
END INTERFACE

!----------------------------------------------------------------------------
!                                                         Quadrangle_quality
!----------------------------------------------------------------------------

INTERFACE Quality_Quadrangle
  MODULE FUNCTION Quadrangle_Quality(refelem, xij, measure) RESULT(Ans)
    CLASS(ReferenceElement_), INTENT(IN) :: refelem
    REAL(DFP), INTENT(IN) :: xij(:, :)
    INTEGER(I4B), INTENT(IN) :: measure
    REAL(DFP) :: Ans
  END FUNCTION Quadrangle_Quality
END INTERFACE Quality_Quadrangle

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 10 Aug 2022
! summary:         Area of quadrangle in 3D
!
!# Introduction
!
!- QUADAREA3D computes the area of a quadrilateral in 3D.
!- A quadrilateral is a polygon defined by 4 vertices.
! It is assumed that the four vertices of the quadrilateral
! are coplanar.
!- This algorithm computes the area of the related Varignon parallelogram
! first.

INTERFACE QuadrangleArea3D
  MODULE PURE SUBROUTINE QuadArea3D(q, ans)
    REAL(DFP), INTENT(IN) :: q(3, 4)
    REAL(DFP), INTENT(OUT) :: ans
  END SUBROUTINE QuadArea3D
END INTERFACE QuadrangleArea3D

!----------------------------------------------------------------------------
!                                                          QuadrangleArea2D
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 10 Aug 2022
! summary:         QuadArea2D
!
!# Introduction
!
!- QUADAREA2D computes the area of a quadrilateral in 2D.
!- A quadrilateral is a polygon defined by 4 vertices.
! This algorithm should be able to handle nonconvex quadrilaterals.
! The vertices of the quadrilateral should be listed in counter clockwise
! order, so that the area is positive.

INTERFACE QuadrangleArea2D
  MODULE PURE SUBROUTINE QuadArea2D(q, ans)
    REAL(DFP), INTENT(IN) :: q(2, 4)
    REAL(DFP), INTENT(OUT) :: ans
  END SUBROUTINE QuadArea2D
END INTERFACE QuadrangleArea2D

!----------------------------------------------------------------------------
!                                                        GetEdgeConnectivity
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 2024-03-08
! summary:  Returns number of edges in the element

INTERFACE
  MODULE PURE SUBROUTINE GetEdgeConnectivity_Quadrangle(con, opt, order)
    INTEGER(I4B), INTENT(INOUT) :: con(:, :)
    !! Connectivity
    !! The columns represents the edge number
    !! The row represents a edge
    !! con should be allocated by the user
    INTEGER(I4B), OPTIONAL, INTENT(IN) :: opt
    !! If opt = 1, then edge connectivity for hierarchial approximation
    !! If opt =2, then edge connectivity for Lagrangian approximation
    !! opt=1 is default
    INTEGER(I4B), OPTIONAL, INTENT(IN) :: order
    !! Order of the element
  END SUBROUTINE GetEdgeConnectivity_Quadrangle
END INTERFACE

!----------------------------------------------------------------------------
!                                                   RefQuadrangleCoord
!----------------------------------------------------------------------------

INTERFACE RefCoord_Quadrangle
  MODULE PURE FUNCTION RefQuadrangleCoord(refQuadrangle) RESULT(ans)
    CHARACTER(*), INTENT(IN) :: refQuadrangle
    REAL(DFP) :: ans(2, 4)
  END FUNCTION RefQuadrangleCoord
END INTERFACE RefCoord_Quadrangle

!----------------------------------------------------------------------------
!                                           FaceShapeMetaData_Quadrangle
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date:  2024-03-13
! summary:  Returns meta data for global orientation of face

INTERFACE
  MODULE SUBROUTINE FaceShapeMetaData_Quadrangle(face, sorted_face,  &
    & faceOrient, localFaces)
    INTEGER(I4B), INTENT(INOUT) :: face(:)
    INTEGER(I4B), INTENT(INOUT) :: sorted_face(:)
    INTEGER(I4B), OPTIONAL, INTENT(INOUT) :: faceOrient(:)
    INTEGER(I4B), OPTIONAL, INTENT(INOUT) :: localFaces(:)
  END SUBROUTINE FaceShapeMetaData_Quadrangle
END INTERFACE

END MODULE ReferenceQuadrangle_Method
