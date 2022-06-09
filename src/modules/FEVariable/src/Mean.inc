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

PUBLIC :: MEAN

!----------------------------------------------------------------------------
!                                                          MEAN@MeanMethods
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 27 May 2022
! summary: FEVariable = Mean( obj )

INTERFACE
  MODULE PURE FUNCTION fevar_Mean1(obj) RESULT(ans)
    CLASS(FEVariable_), INTENT(IN) :: obj
    TYPE(FEVariable_) :: ans
  END FUNCTION fevar_Mean1
END INTERFACE

INTERFACE MEAN
  MODULE PROCEDURE fevar_Mean1
END INTERFACE MEAN

!----------------------------------------------------------------------------
!                                                          MEAN@MeanMethods
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 27 May 2022
! summary: FEVariable = Mean( obj )

INTERFACE
  MODULE PURE FUNCTION fevar_Mean2(obj, dataType) RESULT(ans)
    CLASS(FEVariable_), INTENT(IN) :: obj
    TYPE(FEVariableScalar_), INTENT( IN ) :: dataType
    REAL(DFP) :: ans
  END FUNCTION fevar_Mean2
END INTERFACE

INTERFACE MEAN
  MODULE PROCEDURE fevar_Mean2
END INTERFACE MEAN

!----------------------------------------------------------------------------
!                                                          MEAN@MeanMethods
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 27 May 2022
! summary: FEVariable = Mean( obj )

INTERFACE
  MODULE PURE FUNCTION fevar_Mean3(obj, dataType) RESULT(ans)
    CLASS(FEVariable_), INTENT(IN) :: obj
    TYPE(FEVariableVector_), INTENT( IN ) :: dataType
    REAL(DFP), ALLOCATABLE :: ans( : )
  END FUNCTION fevar_Mean3
END INTERFACE

INTERFACE MEAN
  MODULE PROCEDURE fevar_Mean3
END INTERFACE MEAN

!----------------------------------------------------------------------------
!                                                          MEAN@MeanMethods
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 27 May 2022
! summary: FEVariable = Mean( obj )

INTERFACE
  MODULE PURE FUNCTION fevar_Mean4(obj, dataType) RESULT(ans)
    CLASS(FEVariable_), INTENT(IN) :: obj
    TYPE(FEVariableMatrix_), INTENT( IN ) :: dataType
    REAL(DFP), ALLOCATABLE :: ans( :, : )
  END FUNCTION fevar_Mean4
END INTERFACE

INTERFACE MEAN
  MODULE PROCEDURE fevar_Mean4
END INTERFACE MEAN
