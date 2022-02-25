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

!> authors: Vikas Sharma, Ph. D.
! date: 13 Jul 2021
! summary: Input output related methods

SUBMODULE(CSRSparsity_Method) setMethods
USE BaseMethod
IMPLICIT NONE
CONTAINS

!----------------------------------------------------------------------------
!                                                                   Display
!----------------------------------------------------------------------------

MODULE PROCEDURE csr_setSparsity1
  INTEGER( I4B ) :: ii !n, a, b, m, tdof
  INTEGER( I4B ), ALLOCATABLE :: n2ntemp( : ), rowIndex( : )
  !> main
  !> check
  IF( .NOT. obj%isInitiated ) THEN
    CALL ErrorMSG( &
      & "Instance of CSRSparsity is not initiated!", &
      & "CSRSparsity_Method@setMethods.F90", &
      & "csr_setSparsity1()", &
      & __LINE__, stderr )
    STOP
  END IF
  !> check
  IF( obj%isSparsityLock ) THEN
    CALL ErrorMSG( &
      & "Instance of CSRSparsity is locked for setting sparsity pattern!", &
      & "CSRSparsity_Method@setMethods.F90", &
      & "csr_setSparsity1()", &
      & __LINE__, stderr )
    STOP
  END IF
  IF( .NOT. ALLOCATED( obj%row ) ) ALLOCATE( obj%row( obj%nrow ) )
  n2ntemp = SORT( getIndex( obj=obj%dof, nodeNum=Col ) )
  rowIndex = SORT( getIndex( obj=obj%dof, nodeNum=Row ) )
  obj%nnz = obj%nnz + SIZE(Col) * ( .tdof. obj%dof ) * SIZE(rowIndex)
  DO ii = 1, SIZE(rowIndex)
    CALL APPEND( obj%Row( rowIndex(ii) ), n2ntemp )
  END DO
  IF( ALLOCATED( n2ntemp ) ) DEALLOCATE( n2ntemp )
  IF( ALLOCATED( rowIndex ) ) DEALLOCATE( rowIndex )
END PROCEDURE csr_setSparsity1

!----------------------------------------------------------------------------
!                                                                setSparsity
!----------------------------------------------------------------------------

MODULE PROCEDURE csr_setSparsity2
  INTEGER( I4B ) :: i
  DO i = 1, SIZE( Row )
    CALL setSparsity( obj, Row( i ), Col( i )%Val )
  END DO
END PROCEDURE csr_setSparsity2

!----------------------------------------------------------------------------
!                                                                setSparsity
!----------------------------------------------------------------------------

MODULE PROCEDURE csr_setSparsity3
  INTEGER( I4B ) :: ii
  INTEGER( I4B ), ALLOCATABLE :: n2ntemp( : ), rowIndex( : )
  !> main
  !> check
  IF( .NOT. obj%isInitiated ) THEN
    CALL ErrorMSG( &
      & "Instance of CSRSparsity is not initiated!", &
      & "CSRSparsity_Method@setMethods.F90", &
      & "csr_setSparsity3()", &
      & __LINE__, stderr )
    STOP
  END IF
  !> check
  IF( obj%isSparsityLock ) THEN
    CALL ErrorMSG( &
      & "Instance of CSRSparsity is locked for setting sparsity pattern!", &
      & "CSRSparsity_Method@setMethods.F90", &
      & "csr_setSparsity3()", &
      & __LINE__, stderr )
    STOP
  END IF
  !> check
  IF( obj%dof%StorageFMT .EQ. NODES_FMT ) THEN
    CALL ErrorMSG( &
      & "This subroutine works for storage format FMT_DOF, only", &
      & "CSRSparsity_Method@setMethods.F90", &
      & "csr_setSparsity3()", &
      & __LINE__, stderr )
    STOP
  END IF
  !> some pruning
  IF( .NOT. ALLOCATED( obj%row ) ) ALLOCATE( obj%row( obj%nrow ) )
  n2ntemp = SORT( getIndex( obj=obj%dof, nodeNum=Col, iVar=jvar ) )
  rowIndex = SORT( getIndex( obj=obj%dof, nodeNum=Row, iVar=ivar ) )
  obj%nnz = obj%nnz + SIZE(Col) * (obj%dof .tdof. jvar) * SIZE(rowIndex)
  DO ii = 1, SIZE(rowIndex)
    CALL APPEND( obj%Row( rowIndex(ii) ), n2ntemp )
  END DO
  IF( ALLOCATED( n2ntemp ) ) DEALLOCATE( n2ntemp )
  IF( ALLOCATED( rowIndex ) ) DEALLOCATE( rowIndex )
END PROCEDURE csr_setSparsity3

!----------------------------------------------------------------------------
!                                                                setSparsity
!----------------------------------------------------------------------------

MODULE PROCEDURE csr_setSparsity4
  INTEGER( I4B ) :: i
  DO i = 1, SIZE( Row )
    CALL setSparsity( obj, Row( i ), Col( i )%Val, ivar, jvar )
  END DO
END PROCEDURE csr_setSparsity4

!----------------------------------------------------------------------------
!                                                                setSparsity
!----------------------------------------------------------------------------

MODULE PROCEDURE csr_setSparsity_final
  INTEGER( I4B ) :: i, j, k
  INTEGER( I4B ), ALLOCATABLE :: intvec( : )
  IF( .NOT. obj%isInitiated ) THEN
    CALL ErrorMSG( &
      & "Instance of CSRSparsity is not initiated!", &
      & "CSRSparsity_Method@setMethods.F90", &
      & "csr_setSparsity_final()", &
      & __LINE__, stderr )
    STOP
  END IF
  IF( obj%isSparsityLock ) THEN
    CALL WarningMSG( &
      & "Instance of CSRSparsity is locked for setting sparsity pattern!", &
      & "CSRSparsity_Method@setMethods.F90", &
      & "csr_setSparsity_final()", &
      & __LINE__, stderr )
    RETURN
  ELSE
    obj%isSparsityLock = .TRUE.
  END IF
  !<--- Remove duplicate entries in obj%Row( irow )%Col
  IF( ALLOCATED( obj%Row ) ) THEN
    k = 0
    DO i = 1, obj%nrow
      CALL RemoveDuplicates( obj%Row( i ) )
      k = k + SIZE( obj%Row( i ) )
    END DO
    !<--- update nnz: number of non zeros
    obj%nnz = k
    !<--- allocate obj%JA and obj%A
    CALL Reallocate( obj%JA, obj%nnz )
    !<--- convert data into IA, JA
    obj%IA( 1 ) = 1
    DO i = 1, obj%nrow
      ! obj%RowSize( i ) = SIZE( obj%Row( i ) )
      k = SIZE( obj%Row( i ) )
      obj%IA( i + 1 ) = obj%IA( i ) + k
      IF( k .NE. 0 ) &
        & obj%JA( obj%IA( i ) : obj%IA( i + 1 ) - 1 ) = obj%Row( i )%Val
    END DO
    DEALLOCATE( obj%Row )
  END IF
  j = SIZE( obj%JA )
  IF( j .GT. obj%nnz ) THEN
    intvec = obj%JA( 1 : obj%nnz )
    CALL Reallocate( obj%JA, obj%nnz )
    obj%JA = intvec
    CALL Reallocate( intvec, obj%ncol )
  END IF
END PROCEDURE csr_setSparsity_final

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

END SUBMODULE setMethods