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

SUBMODULE (RealMatrix_Method) ConstructorMethods
USE BaseMethod
IMPLICIT NONE
CONTAINS

!----------------------------------------------------------------------------
!                                                                      Shape
!----------------------------------------------------------------------------

MODULE PROCEDURE get_shape
  IF( ALLOCATED( obj%val ) ) THEN
    Ans = SHAPE( obj%val )
  ELSE
    Ans = 0
  END IF
END PROCEDURE get_shape

!----------------------------------------------------------------------------
!                                                                       Size
!----------------------------------------------------------------------------

MODULE PROCEDURE get_size
  !Define internal variables
  INTEGER( I4B ) :: S( 2 )
  IF( ALLOCATED( obj%val ) ) THEN
    S = SHAPE( obj%val )
    IF( PRESENT( Dims ) ) THEN
      Ans = S( Dims )
    ELSE
      Ans = S( 1 ) * S( 2 )
    END IF
  ELSE
    Ans = 0
  END IF
END PROCEDURE get_size

!----------------------------------------------------------------------------
!                                                         getTotalDimension
!----------------------------------------------------------------------------

MODULE PROCEDURE get_tdimension
  ans = obj%tDimension
END PROCEDURE get_tdimension

!----------------------------------------------------------------------------
!                                                         setTotalDimension
!----------------------------------------------------------------------------

MODULE PROCEDURE set_tdimension
  obj%tDimension = tDimension
END PROCEDURE set_tdimension

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

MODULE PROCEDURE allocate_data
  CALL Reallocate( obj%val, Dims(1), Dims(2) )
  CALL setTotalDimension( obj, 2_I4B )
END PROCEDURE allocate_data

!----------------------------------------------------------------------------
!                                                             Deallocate
!----------------------------------------------------------------------------

MODULE PROCEDURE Deallocate_Data
  IF( ALLOCATED( obj%val ) ) DEALLOCATE( obj%val )
  CALL setTotalDimension( obj, 0 )
END PROCEDURE Deallocate_Data

!----------------------------------------------------------------------------
!                                                                   Initiate
!----------------------------------------------------------------------------

MODULE PROCEDURE realmat_initiate1
  CALL Allocate( obj, Dims )
END PROCEDURE realmat_initiate1

!----------------------------------------------------------------------------
!                                                                   Initiate
!----------------------------------------------------------------------------

MODULE PROCEDURE realmat_initiate2
  CALL Allocate( obj, [nrow, ncol] )
END PROCEDURE realmat_initiate2

!----------------------------------------------------------------------------
!                                                                   Initiate
!----------------------------------------------------------------------------

MODULE PROCEDURE realmat_initiate3
  INTEGER( I4B ) :: j
  DO j = 1, SIZE( obj )
    CALL Allocate( obj( j ), Dims )
  END DO
END PROCEDURE realmat_initiate3

!----------------------------------------------------------------------------
!                                                                   Initiate
!----------------------------------------------------------------------------

MODULE PROCEDURE realmat_initiate4
  INTEGER( I4B ) :: j
  DO j = 1, SIZE( obj )
    CALL Allocate( obj( j ), Dims( j, : ) )
  END DO
END PROCEDURE realmat_initiate4

!----------------------------------------------------------------------------
!                                                                   Initiate
!----------------------------------------------------------------------------

MODULE PROCEDURE realmat_initiate5
  obj%val = val
  CALL setTotalDimension( obj, 2_I4B )
END PROCEDURE realmat_initiate5

!----------------------------------------------------------------------------
!                                                                     Matrix
!----------------------------------------------------------------------------

MODULE PROCEDURE Constructor1
  CALL Initiate( obj, Dims )
END PROCEDURE Constructor1

!----------------------------------------------------------------------------
!                                                                        Eye
!----------------------------------------------------------------------------

MODULE PROCEDURE realMat_eye1
  INTEGER( I4B ) :: i
  CALL Initiate( Ans, [m,m] )
  DO i = 1, m
    Ans%val ( i, i ) = 1.0
  END DO
END PROCEDURE realMat_eye1

!----------------------------------------------------------------------------
!                                                                 Convert
!----------------------------------------------------------------------------

MODULE PROCEDURE realmat_convert_1
  CALL Convert( From=From%val, To=To%val, Conversion=Conversion, nns=nns, &
    & tdof=tdof )
END PROCEDURE realmat_convert_1

!----------------------------------------------------------------------------
!                                                                       Sym
!----------------------------------------------------------------------------

MODULE PROCEDURE sym_array
  Ans = 0.5_DFP * ( obj + TRANSPOSE( obj ) )
END PROCEDURE sym_array

!----------------------------------------------------------------------------
!                                                                       Sym
!----------------------------------------------------------------------------

MODULE PROCEDURE sym_obj
  Ans%val = 0.5_DFP * ( obj%val + TRANSPOSE( obj%val ) )
END PROCEDURE sym_obj

!----------------------------------------------------------------------------
!                                                                    SkewSym
!----------------------------------------------------------------------------

MODULE PROCEDURE SkewSym_array
  Ans = 0.5_DFP * ( obj - TRANSPOSE( obj ) )
END PROCEDURE SkewSym_array

!----------------------------------------------------------------------------
!                                                                    SkewSym
!----------------------------------------------------------------------------

MODULE PROCEDURE SkewSym_obj
  Ans%val = 0.5_DFP * ( obj%val - TRANSPOSE( obj%val ) )
END PROCEDURE SkewSym_obj

!----------------------------------------------------------------------------
!                                                         MakeDiagonalCopies
!----------------------------------------------------------------------------

MODULE PROCEDURE realmat_make_diag_copy1
  INTEGER( I4B ) :: I, s( 2 )
  REAL( DFP ), ALLOCATABLE :: DummyMat2( :, : )

  IF( ALLOCATED( mat ) ) THEN
    s = SHAPE( mat )
    DummyMat2 = mat
    CALL Reallocate( mat, s( 1 )*nCopy, s( 2 )*nCopy )
    DO I = 1, nCopy
        mat( ( I - 1 ) * s( 1 ) + 1 : I * s( 1 ), &
        & ( I - 1 ) * s( 2 ) + 1 : I * s( 2 ) ) &
        & = DummyMat2( :, : )
    END DO
    DEALLOCATE( DummyMat2 )
  END IF
END PROCEDURE realmat_make_diag_copy1

!----------------------------------------------------------------------------
!                                                         MakeDiagonalCopies
!----------------------------------------------------------------------------

MODULE PROCEDURE realmat_make_diag_copy2
  INTEGER( I4B ) :: I, S( 2 )
  S = SHAPE( From )
  CALL Reallocate( To, S( 1 )*nCopy, S( 2 )*nCopy )
  To = 0.0_DFP
  DO I = 1, nCopy
      To( ( I - 1 ) * S( 1 ) + 1 : I * S( 1 ), &
      & ( I - 1 ) * S( 2 ) + 1 : I * S( 2 ) ) &
      & = From( :, : )
  END DO
END PROCEDURE realmat_make_diag_copy2

!----------------------------------------------------------------------------
!                                                         MakeDiagonalCopies
!----------------------------------------------------------------------------

MODULE PROCEDURE realmat_make_diag_copy3
  CALL realmat_make_diag_copy1( Mat = Mat%val, nCopy = nCopy )
END PROCEDURE realmat_make_diag_copy3

!----------------------------------------------------------------------------
!                                                         MakeDiagonalCopies
!----------------------------------------------------------------------------

MODULE PROCEDURE realmat_make_diag_copy4
  CALL realmat_make_diag_copy2( From = From%val, To = To%val, &
    & nCopy = nCopy )
END PROCEDURE realmat_make_diag_copy4

!----------------------------------------------------------------------------
!                                                              Random_Number
!----------------------------------------------------------------------------

MODULE PROCEDURE realmat_random_number
  IF( PRESENT( m ) .AND. PRESENT( n ) ) THEN
    CALL Reallocate( obj%val, m, n )
    CALL RANDOM_NUMBER( obj%val )
    RETURN
  END IF

  IF( PRESENT( m ) ) THEN
    CALL Reallocate( obj%val, m, m )
    CALL RANDOM_NUMBER( obj%val )
    RETURN
  END IF

  IF( PRESENT( n ) ) THEN
    CALL Reallocate( obj%val, n, n )
    CALL RANDOM_NUMBER( obj%val )
    RETURN
  END IF

  CALL RANDOM_NUMBER( obj%val )

END PROCEDURE realmat_random_number

!----------------------------------------------------------------------------
!                                                                 testMatrix
!----------------------------------------------------------------------------

MODULE PROCEDURE TestMatrix
  SELECT CASE( matNo )
  CASE( 1 )
    ALLOCATE( Ans( 4, 4 ) )
    Ans( :, 1 ) = [3.0, -3.0, 6.0, -9.0]
    Ans( :, 2 ) = [-7.0, 5.0, -4.0, 5.0]
    Ans( :, 3 ) = [-2.0, 1.0, 0.0, -5.0]
    Ans( :, 4 ) = [2.0, 0.0, -5.0, 12.0]
  END SELECT
END PROCEDURE TestMatrix

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------
END SUBMODULE ConstructorMethods
