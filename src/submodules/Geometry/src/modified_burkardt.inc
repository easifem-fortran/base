
!-----------------------------------------------------------------------------
!
!-----------------------------------------------------------------------------

PURE FUNCTION R8MATDET4D(a)
  !.   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .
  !! R8MATDET4D computes the determinant of a 4 by 4 matrix.
  !
  !  Licensing:
  !    This code is distributed under the GNU LGPL license.
  !  Modified:
  !    16 April 1999
  !  Author:
  !    John Burkardt
  !  Parameters:
  !    Input, real ( kind = 8 ) A(4,4), the matrix whose determinant is desired.
  !    Output, real ( kind = 8 ) R8MATDET4D, the determinant of the matrix.
  !.   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .

  REAL(DFP), INTENT(IN) :: a(4, 4)
  REAL(DFP) :: R8MATDET4D

  R8MATDET4D = &
    a(1, 1) * ( &
    a(2, 2) * (a(3, 3) * a(4, 4) - a(3, 4) * a(4, 3)) &
    - a(2, 3) * (a(3, 2) * a(4, 4) - a(3, 4) * a(4, 2)) &
    + a(2, 4) * (a(3, 2) * a(4, 3) - a(3, 3) * a(4, 2))) &
    - a(1, 2) * ( &
    a(2, 1) * (a(3, 3) * a(4, 4) - a(3, 4) * a(4, 3)) &
    - a(2, 3) * (a(3, 1) * a(4, 4) - a(3, 4) * a(4, 1)) &
    + a(2, 4) * (a(3, 1) * a(4, 3) - a(3, 3) * a(4, 1))) &
    + a(1, 3) * ( &
    a(2, 1) * (a(3, 2) * a(4, 4) - a(3, 4) * a(4, 2)) &
    - a(2, 2) * (a(3, 1) * a(4, 4) - a(3, 4) * a(4, 1)) &
    + a(2, 4) * (a(3, 1) * a(4, 2) - a(3, 2) * a(4, 1))) &
    - a(1, 4) * ( &
    a(2, 1) * (a(3, 2) * a(4, 3) - a(3, 3) * a(4, 2)) &
    - a(2, 2) * (a(3, 1) * a(4, 3) - a(3, 3) * a(4, 1)) &
    + a(2, 3) * (a(3, 1) * a(4, 2) - a(3, 2) * a(4, 1)))

END FUNCTION R8MATDET4D

!-----------------------------------------------------------------------------
!
!-----------------------------------------------------------------------------

PURE SUBROUTINE PARALLELOGRAMAREA3D(p, area)

  !.   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .
  !! PARALLELOGRAMAREA3D computes the area of a parallelogram in 3D.
  !
  !  Discussion:
  !    A parallelogram is a polygon having four sides, with the property
  !    that each pair of opposite sides is paralell.
  !    A parallelogram in 3D must have the property that it is "really"
  !    a 2D object, that is, that the four vertices that define it lie
  !    in some plane.
  !    Given the first three vertices of the parallelogram (in 2D or 3D),
  !    P1, P2, and P3, the fourth vertex must satisfy
  !      P4 = P1 + ( P3 - P2 )
  !    This routine uses the fact that the norm of the cross product
  !    of two vectors is the area of the parallelogram they form:
  !      Area = ( P3 - P2 ) x ( P1 - P2 ).
  !
  !        P4<-----P3
  !        /       /
  !       /       /
  !      P1----->P2
  !
  !  Licensing:
  !    This code is distributed under the GNU LGPL license.
  !  Modified:
  !    09 May 2010
  !  Author:
  !    John Burkardt
  !  Parameters:
  !    Input, real ( kind = 8 ) P(3,4), the parallelogram vertices,
  !    given in counterclockwise order.  The fourth vertex is ignored.
  !    Output, real ( kind = 8 ) AREA, the area
  !.   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .

  REAL(DFP), INTENT(IN) :: p(3, 4)
  REAL(DFP), INTENT(OUT) :: area
  REAL(DFP) :: cross(3)

  ! Compute the cross product vector.

  cross(1) = (p(2, 2) - p(2, 1)) * (p(3, 3) - p(3, 1)) &
             - (p(3, 2) - p(3, 1)) * (p(2, 3) - p(2, 1))

  cross(2) = (p(3, 2) - p(3, 1)) * (p(1, 3) - p(1, 1)) &
             - (p(1, 2) - p(1, 1)) * (p(3, 3) - p(3, 1))

  cross(3) = (p(1, 2) - p(1, 1)) * (p(2, 3) - p(2, 1)) &
             - (p(2, 2) - p(2, 1)) * (p(1, 3) - p(1, 1))

  area = SQRT(SUM(cross(1:3)**2))

END SUBROUTINE PARALLELOGRAMAREA3D

!-----------------------------------------------------------------------------
!
!-----------------------------------------------------------------------------

PURE SUBROUTINE PARALLELOGRAMAREA2D(p, area)

  !.   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .
  !
  !! PARALLELOGRAMAREA2D computes the area of a parallelogram in 2D.
  !
  !  Discussion:
  !    A parallelogram is a polygon having four sides, with the property
  !    that each pair of opposite sides is paralell.
  !    Given the first three vertices of the parallelogram,
  !    P1, P2, and P3, the fourth vertex must satisfy
  !
  !      P4 = P1 + ( P3 - P2 )
  !
  !    This routine uses the fact that the norm of the cross product
  !    of two vectors is the area of the parallelogram they form:
  !
  !      Area = ( P3 - P2 ) x ( P1 - P2 ).
  !
  !        P4<-----P3
  !        /       /
  !       /       /
  !      P1----->P2
  !
  !  Licensing:
  !    This code is distributed under the GNU LGPL license.
  !  Modified:
  !    09 May 2010
  !  Author:
  !    John Burkardt
  !  Parameters:
  !    Input, real ( kind = 8 ) P(2,4), the parallelogram vertices,
  !    given in counterclockwise order.  The fourth vertex is ignored.
  !    Output, real ( kind = 8 ) AREA, the (signed) area.
  !.   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .

  REAL(DFP), INTENT(IN) :: p(2, 4)
  REAL(DFP), INTENT(OUT) :: area

  !  Compute the cross product vector, which only has a single
  !  nonzero component.

  area = (p(1, 2) - p(1, 1)) * (p(2, 3) - p(2, 1)) &
         - (p(2, 2) - p(2, 1)) * (p(1, 3) - p(1, 1))

END SUBROUTINE PARALLELOGRAMAREA2D

!-----------------------------------------------------------------------------
!
!-----------------------------------------------------------------------------

PURE SUBROUTINE TETRAHEDRONVOLUME3D(tetra, volume)

  !.   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .
  !
  !! TETRAHEDRONVOLUME3D computes the volume of a tetrahedron in 3D.
  !
  !  Licensing:
  !    This code is distributed under the GNU LGPL license.
  !  Modified:
  !    30 December 2004
  !  Author:
  !    John Burkardt
  !  Parameters:
  !    Input, real ( kind = 8 ) TETRA(3,4), the vertices of the tetrahedron.
  !    Output, real ( kind = 8 ) VOLUME, the volume of the tetrahedron.
  !.   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .

  REAL(DFP), INTENT(IN) :: tetra(3, 4)
  REAL(DFP), INTENT(OUT) :: volume

  INTEGER(I4B), PARAMETER :: dim_num = 3
  REAL(DFP) :: a(4, 4)

  a(1:dim_num, 1:4) = tetra(1:dim_num, 1:4)
  a(4, 1:4) = 1.0_DFP

  volume = ABS(R8MATDET4D(a)) / 6.0_DFP

END SUBROUTINE TETRAHEDRONVOLUME3D

!-----------------------------------------------------------------------------
!
!-----------------------------------------------------------------------------

PURE SUBROUTINE POLYHEDRONVOLUME3D(coord, order_max, face_num, node, &
  & node_num, order, volume)

  !.   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .
  !
  !! POLYHEDRONVOLUME3D computes the volume of a polyhedron in 3D.
  !
  !  Licensing:
  !    This code is distributed under the GNU LGPL license.
  !  Modified:
  !    19 August 2003
  !  Author:
  !    John Burkardt
  !  Parameters:
  !
  !    Input, real ( kind = 8 ) COORD(3,NODE_NUM), the coordinates of
  !    the vertices.  The vertices may be listed in any order.
  !
  !    Input, integer ( kind = 4 ) ORDER_MAX, the maximum number of vertices
  !    that make up a face of the polyhedron.
  !
  !    Input, integer ( kind = 4 ) FACE_NUM, the number of faces of the
  !    polyhedron.
  !
  !    Input, integer ( kind = 4 ) NODE(FACE_NUM,ORDER_MAX).  Face I is
  ! defined by
  !    the vertices NODE(I,1) through NODE(I,ORDER(I)).  These vertices
  !    are listed in neighboring order.
  !
  !    Input, integer ( kind = 4 ) NODE_NUM, the number of points stored in
  ! COORD.
  !
  !    Input, integer ( kind = 4 ) ORDER(FACE_NUM), the number of vertices
  ! making
  !    up each face.
  !
  !    Output, real ( kind = 8 ) VOLUME, the volume of the polyhedron.
  !.   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .

  INTEGER(I4B), INTENT(IN) :: order_max
  INTEGER(I4B), INTENT(IN) :: face_num
  INTEGER(I4B), INTENT(IN) :: node(face_num, order_max)
  INTEGER(I4B), INTENT(IN) :: node_num
  REAL(DFP), INTENT(IN) :: coord(3, node_num)
  INTEGER(I4B), INTENT(IN) :: order(face_num)
  REAL(DFP), INTENT(OUT) :: volume

  INTEGER(I4B), PARAMETER :: dim_num = 3
  INTEGER(I4B) :: face
  INTEGER(I4B) :: n1
  INTEGER(I4B) :: n2
  INTEGER(I4B) :: n3
  INTEGER(I4B) :: v
  volume = 0.0_DFP

  ! Triangulate each face.
  DO face = 1, face_num

    n3 = node(face, order(face))

    DO v = 1, order(face) - 2
      n1 = node(face, v)
      n2 = node(face, v + 1)
      volume = volume &
               + coord(1, n1) &
               * (coord(2, n2) * coord(3, n3) - coord(2, n3) * coord(3, n2)) &
               + coord(1, n2) &
               * (coord(2, n3) * coord(3, n1) - coord(2, n1) * coord(3, n3)) &
               + coord(1, n3) &
               * (coord(2, n1) * coord(3, n2) - coord(2, n2) * coord(3, n1))
    END DO
  END DO

  volume = volume / 6.0_DFP

END SUBROUTINE POLYHEDRONVOLUME3D
