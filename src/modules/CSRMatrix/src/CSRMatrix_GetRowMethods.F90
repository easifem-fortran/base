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

MODULE CSRMatrix_GetRowMethods
USE GlobalData, ONLY: I4B, DFP, LGT
USE BaseType, ONLY: CSRMatrix_
IMPLICIT NONE

PRIVATE
PUBLIC :: GetRow

!----------------------------------------------------------------------------
!                                                          GetRow@getMethod
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 24 July 2021
! summary: This routine returns the row of a sparse matrix
!
!# Introduction
!
! - This routine returns the row of a sparse matrix
! - This rouine does not care about the storage pattern
! - Therefore, it should be used with care.
! - The result is returned inside the value
! - `value` should be allocated
! - the size of `value` should be atleast the number of columns in csrmatrix
!
! If addContribution is not present
! then the this routine performs the following action
!
!```fortran
! value = 0.0_DFP
! value(obj%csr%JA(a:b)) = obj%A( a:b )
!```

INTERFACE GetRow
  MODULE SUBROUTINE obj_GetRow1(obj, irow, VALUE, scale, addContribution)
    TYPE(CSRMatrix_), INTENT(IN) :: obj
    INTEGER(I4B), INTENT(IN) :: irow
  !! index of row in csr matrix
    REAL(DFP), INTENT(INOUT) :: VALUE(:)
  !!
    REAL(DFP), OPTIONAL, INTENT(IN) :: scale
    LOGICAL(LGT), OPTIONAL, INTENT(IN) :: addContribution
  END SUBROUTINE obj_GetRow1
END INTERFACE GetRow

!----------------------------------------------------------------------------
!                                                          GetRow@getMethod
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 24 July 2021
! summary: This routine returns the row of a sparse matrix
!
!# Introduction
!
! - This routine returns the row of a sparse matrix
! - This rouine does not care about the storage pattern
! - Therefore, it should be used with care.
! - The result is returned inside the value
! - `value` should be allocated
! - the size of `value` should be atleast the number of columns in csrmatrix
!
! If addContribution is not present
! then the this routine performs the following action
!
!```fortran
! value = 0.0_DFP
! value(obj%csr%JA(a:b)) = obj%A( a:b )
!```

INTERFACE GetRow
  MODULE SUBROUTINE obj_GetRow1b(obj, irow, VALUE, scale, addContribution)
    TYPE(CSRMatrix_), INTENT(IN) :: obj
    INTEGER(I4B), INTENT(IN) :: irow(:)
  !! index of row in csr matrix
    REAL(DFP), INTENT(INOUT) :: VALUE(:)
  !!
    REAL(DFP), OPTIONAL, INTENT(IN) :: scale
    LOGICAL(LGT), OPTIONAL, INTENT(IN) :: addContribution
  END SUBROUTINE obj_GetRow1b
END INTERFACE GetRow

!----------------------------------------------------------------------------
!                                                          GetRow@getMethod
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 24 July 2021
! summary: This routine returns the row of a sparse matrix
!
!# Introduction
!
! - This routine returns the row of a sparse matrix. The row index is
! calculated using the nodenum and idof.
! - `nodenum` is the node number
! - `idof` is the degree of freedom number
! - `irow` calculated from nodenum and idof depends upon the storageFMT.
!
!@note
! idofs are continuously numbered, so if there are two
! or more physical variables, then idof of the second or later physical
! variables will not start from 1.
!@endnote
!
!@note
! This routine calls [[DOF_Method:GetNodeLoc]] method to calculate
! the row index from nodenum and idof
!@endnote

INTERFACE GetRow
  MODULE SUBROUTINE obj_GetRow2(obj, nodenum, idof, VALUE, scale, &
    & addContribution)
    TYPE(CSRMatrix_), INTENT(IN) :: obj
    INTEGER(I4B), INTENT(IN) :: nodenum
    INTEGER(I4B), INTENT(IN) :: idof
    REAL(DFP), INTENT(INOUT) :: VALUE(:)
    REAL(DFP), OPTIONAL, INTENT(IN) :: scale
    LOGICAL(LGT), OPTIONAL, INTENT(IN) :: addContribution
  END SUBROUTINE obj_GetRow2
END INTERFACE GetRow

!----------------------------------------------------------------------------
!                                                          GetRow@getMethod
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 24 July 2021
! summary: This routine returns the row of a sparse matrix
!
!# Introduction
!
! - This routine returns the row of a sparse matrix. The row index is
! calculated using the nodenum and idof.
! - `nodenum` is the node number
! - `idof` is the degree of freedom number
! - `irow` calculated from nodenum and idof depends upon the storageFMT.
!
!@note
! This routine calls [[DOF_Method:GetNodeLoc]] method to calculate
! the row index from nodenum and idof
!@endnote

INTERFACE GetRow
  MODULE SUBROUTINE obj_GetRow3(obj, nodenum, ivar, idof, VALUE, scale, &
    & addContribution)
    TYPE(CSRMatrix_), INTENT(IN) :: obj
    INTEGER(I4B), INTENT(IN) :: nodenum
    INTEGER(I4B), INTENT(IN) :: ivar
    INTEGER(I4B), INTENT(IN) :: idof
    REAL(DFP), INTENT(INOUT) :: VALUE(:)
    REAL(DFP), OPTIONAL, INTENT(IN) :: scale
    LOGICAL(LGT), OPTIONAL, INTENT(IN) :: addContribution
  END SUBROUTINE obj_GetRow3
END INTERFACE GetRow

!----------------------------------------------------------------------------
!                                                          GetRow@getMethod
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 24 July 2021
! summary: This routine returns the row of a sparse matrix
!
!# Introduction
!
! - This routine returns the row of a sparse matrix. The row index is
! calculated using the nodenum and idof.
! - `nodenum` is the node number
! - `idof` is the degree of freedom number
! - `irow` calculated from nodenum and idof depends upon the storageFMT.
!
!@note
! This routine calls [[DOF_Method:GetNodeLoc]] method to calculate
! the row index from nodenum and idof
!@endnote

INTERFACE GetRow
  MODULE SUBROUTINE obj_GetRow4(obj, nodenum, ivar, spacecompo, &
    & timecompo, VALUE, scale, addContribution)
    TYPE(CSRMatrix_), INTENT(IN) :: obj
    INTEGER(I4B), INTENT(IN) :: nodenum
    INTEGER(I4B), INTENT(IN) :: ivar
    INTEGER(I4B), INTENT(IN) :: spacecompo
    INTEGER(I4B), INTENT(IN) :: timecompo
    REAL(DFP), INTENT(INOUT) :: VALUE(:)
    REAL(DFP), OPTIONAL, INTENT(IN) :: scale
    LOGICAL(LGT), OPTIONAL, INTENT(IN) :: addContribution
  END SUBROUTINE obj_GetRow4
END INTERFACE GetRow

!----------------------------------------------------------------------------
!                                                          GetRow@getMethod
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 24 July 2021
! summary: This routine returns the row of a sparse matrix
!
!# Introduction
!
! - This routine returns the row of a sparse matrix. The row index is
! calculated using the nodenum and idof.
! - `nodenum` is the node number
! - `idof` is the degree of freedom number
! - `irow` calculated from nodenum and idof depends upon the storageFMT.
!
!@note
! This routine calls [[DOF_Method:GetNodeLoc]] method to calculate
! the row index from nodenum and idof
!@endnote

INTERFACE GetRow
  MODULE SUBROUTINE obj_GetRow5(obj, nodenum, ivar, spacecompo, &
    & timecompo, VALUE, scale, addContribution)
    TYPE(CSRMatrix_), INTENT(IN) :: obj
    INTEGER(I4B), INTENT(IN) :: nodenum
    INTEGER(I4B), INTENT(IN) :: ivar
    INTEGER(I4B), INTENT(IN) :: spacecompo
    INTEGER(I4B), INTENT(IN) :: timecompo(:)
    REAL(DFP), INTENT(INOUT) :: VALUE(:)
    REAL(DFP), OPTIONAL, INTENT(IN) :: scale
    LOGICAL(LGT), OPTIONAL, INTENT(IN) :: addContribution
  END SUBROUTINE obj_GetRow5
END INTERFACE GetRow

!----------------------------------------------------------------------------
!                                                          GetRow@getMethod
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 24 July 2021
! summary: This routine returns the row of a sparse matrix
!
!# Introduction
!
! - This routine returns the row of a sparse matrix. The row index is
! calculated using the nodenum and idof.
! - `nodenum` is the node number
! - `idof` is the degree of freedom number
! - `irow` calculated from nodenum and idof depends upon the storageFMT.
!
!@note
! This routine calls [[DOF_Method:GetNodeLoc]] method to calculate
! the row index from nodenum and idof
!@endnote

INTERFACE GetRow
  MODULE SUBROUTINE obj_GetRow6(obj, nodenum, ivar, spacecompo, &
    & timecompo, VALUE, scale, addContribution)
    TYPE(CSRMatrix_), INTENT(IN) :: obj
    INTEGER(I4B), INTENT(IN) :: nodenum
    INTEGER(I4B), INTENT(IN) :: ivar
    INTEGER(I4B), INTENT(IN) :: spacecompo(:)
    INTEGER(I4B), INTENT(IN) :: timecompo
    REAL(DFP), INTENT(INOUT) :: VALUE(:)
    REAL(DFP), OPTIONAL, INTENT(IN) :: scale
    LOGICAL(LGT), OPTIONAL, INTENT(IN) :: addContribution
  END SUBROUTINE obj_GetRow6
END INTERFACE GetRow

!----------------------------------------------------------------------------
!                                                          GetRow@getMethod
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 24 July 2021
! summary: This routine returns the row of a sparse matrix
!
!# Introduction
!
! - This routine returns the row of a sparse matrix. The row index is
! calculated using the nodenum and idof.
! - `nodenum` is the node number
! - `idof` is the degree of freedom number
! - `irow` calculated from nodenum and idof depends upon the storageFMT.
!
!@note
! This routine calls [[DOF_Method:GetNodeLoc]] method to calculate
! the row index from nodenum and idof
!@endnote

INTERFACE GetRow
  MODULE SUBROUTINE obj_GetRow7(obj, nodenum, ivar, spacecompo, &
    & timecompo, VALUE, scale, addContribution)
    TYPE(CSRMatrix_), INTENT(IN) :: obj
    INTEGER(I4B), INTENT(IN) :: nodenum(:)
    INTEGER(I4B), INTENT(IN) :: ivar
    INTEGER(I4B), INTENT(IN) :: spacecompo
    INTEGER(I4B), INTENT(IN) :: timecompo(:)
    REAL(DFP), INTENT(INOUT) :: VALUE(:)
    REAL(DFP), OPTIONAL, INTENT(IN) :: scale
    LOGICAL(LGT), OPTIONAL, INTENT(IN) :: addContribution
  END SUBROUTINE obj_GetRow7
END INTERFACE GetRow

!----------------------------------------------------------------------------
!                                                          GetRow@getMethod
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 24 July 2021
! summary: This routine returns the row of a sparse matrix
!
!# Introduction
!
! - This routine returns the row of a sparse matrix. The row index is
! calculated using the nodenum and idof.
! - `nodenum` is the node number
! - `idof` is the degree of freedom number
! - `irow` calculated from nodenum and idof depends upon the storageFMT.
!
!@note
! This routine calls [[DOF_Method:GetNodeLoc]] method to calculate
! the row index from nodenum and idof
!@endnote

INTERFACE GetRow
  MODULE SUBROUTINE obj_GetRow8(obj, nodenum, ivar, spacecompo, &
    & timecompo, VALUE, scale, addContribution)
    TYPE(CSRMatrix_), INTENT(IN) :: obj
    INTEGER(I4B), INTENT(IN) :: nodenum(:)
    INTEGER(I4B), INTENT(IN) :: ivar
    INTEGER(I4B), INTENT(IN) :: spacecompo(:)
    INTEGER(I4B), INTENT(IN) :: timecompo
    REAL(DFP), INTENT(INOUT) :: VALUE(:)
    REAL(DFP), OPTIONAL, INTENT(IN) :: scale
    LOGICAL(LGT), OPTIONAL, INTENT(IN) :: addContribution
  END SUBROUTINE obj_GetRow8
END INTERFACE GetRow

END MODULE CSRMatrix_GetRowMethods
