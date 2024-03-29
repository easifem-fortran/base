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

MODULE IntegerUtility
USE GlobalData
IMPLICIT NONE
PRIVATE

PUBLIC :: OPERATOR(.in.)
PUBLIC :: OPERATOR(.isin.)
PUBLIC :: RemoveDuplicates
PUBLIC :: Repeat
PUBLIC :: SIZE
PUBLIC :: GetMultiIndices
PUBLIC :: GetIndex
PUBLIC :: Get

!----------------------------------------------------------------------------
!                                                           Size@Methods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 4 Sept 2022
! summary:         Get the number of touples

INTERFACE Size
  MODULE PURE FUNCTION obj_Size1(n, d) RESULT(ans)
    INTEGER(I4B), INTENT(IN) :: n, d
    INTEGER(I4B) :: ans
  END FUNCTION obj_Size1
END INTERFACE Size

!----------------------------------------------------------------------------
!                                                           Size@Methods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 4 Sept 2022
! summary:         Get the number of touples

INTERFACE Size
  MODULE PURE FUNCTION obj_Size2(n, d, upto) RESULT(ans)
    INTEGER(I4B), INTENT(IN) :: n, d
    LOGICAL(LGT), INTENT(IN) :: upto
    INTEGER(I4B) :: ans
  END FUNCTION obj_Size2
END INTERFACE Size

!----------------------------------------------------------------------------
!                                                         GetIndices@Methods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 4 Sept 2022
! summary:         Get Indices

INTERFACE GetMultiIndices
  MODULE RECURSIVE PURE FUNCTION obj_GetMultiIndices1(n, d) RESULT(ans)
    INTEGER(I4B), INTENT(IN) :: n, d
    INTEGER(I4B), ALLOCATABLE :: ans(:, :)
  END FUNCTION obj_GetMultiIndices1
END INTERFACE GetMultiIndices

!----------------------------------------------------------------------------
!                                                         GetIndices@Methods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 4 Sept 2022
! summary:         Get Indices upto order n

INTERFACE GetMultiIndices
  MODULE RECURSIVE PURE FUNCTION obj_GetMultiIndices2(n, d, upto) RESULT(ans)
    INTEGER(I4B), INTENT(IN) :: n, d
    LOGICAL(LGT), INTENT(IN) :: upto
    INTEGER(I4B), ALLOCATABLE :: ans(:, :)
  END FUNCTION obj_GetMultiIndices2
END INTERFACE GetMultiIndices

!----------------------------------------------------------------------------
!                                             Operator(.in.)@IntegerMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 2021-11-11
! update: 2021-11-11
! summary: Returns true if a integer set is inside another

INTERFACE OPERATOR(.in.)
  MODULE PURE FUNCTION in_1a(a, b) RESULT(Ans)
    INTEGER(INT8), INTENT(IN) :: a(:)
    INTEGER(INT8), INTENT(IN) :: b(:)
    LOGICAL(LGT) :: ans
  END FUNCTION in_1a

  MODULE PURE FUNCTION in_1b(a, b) RESULT(Ans)
    INTEGER(INT16), INTENT(IN) :: a(:)
    INTEGER(INT16), INTENT(IN) :: b(:)
    LOGICAL(LGT) :: ans
  END FUNCTION in_1b

  MODULE PURE FUNCTION in_1c(a, b) RESULT(Ans)
    INTEGER(INT32), INTENT(IN) :: a(:)
    INTEGER(INT32), INTENT(IN) :: b(:)
    LOGICAL(LGT) :: ans
  END FUNCTION in_1c

  MODULE PURE FUNCTION in_1d(a, b) RESULT(Ans)
    INTEGER(INT64), INTENT(IN) :: a(:)
    INTEGER(INT64), INTENT(IN) :: b(:)
    LOGICAL(LGT) :: ans
  END FUNCTION in_1d

END INTERFACE OPERATOR(.in.)

!----------------------------------------------------------------------------
!                                             Operator(.in.)@IntegerMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 2021-11-11
! update: 2021-11-11
! summary: Returns true if a integer set is inside another
!
!# Introduction
!
! This function returns a vector of booleans
! if a(i) is inside the b, then ans(i) is true, otherwise false.

INTERFACE OPERATOR(.isin.)
  MODULE PURE FUNCTION isin_1a(a, b) RESULT(Ans)
    INTEGER(INT8), INTENT(IN) :: a(:)
    INTEGER(INT8), INTENT(IN) :: b(:)
    LOGICAL(LGT) :: ans(SIZE(a))
  END FUNCTION isin_1a

  MODULE PURE FUNCTION isin_1b(a, b) RESULT(Ans)
    INTEGER(INT16), INTENT(IN) :: a(:)
    INTEGER(INT16), INTENT(IN) :: b(:)
    LOGICAL(LGT) :: ans(SIZE(a))
  END FUNCTION isin_1b

  MODULE PURE FUNCTION isin_1c(a, b) RESULT(Ans)
    INTEGER(INT32), INTENT(IN) :: a(:)
    INTEGER(INT32), INTENT(IN) :: b(:)
    LOGICAL(LGT) :: ans(SIZE(a))
  END FUNCTION isin_1c

  MODULE PURE FUNCTION isin_1d(a, b) RESULT(Ans)
    INTEGER(INT64), INTENT(IN) :: a(:)
    INTEGER(INT64), INTENT(IN) :: b(:)
    LOGICAL(LGT) :: ans(SIZE(a))
  END FUNCTION isin_1d
END INTERFACE OPERATOR(.isin.)

!----------------------------------------------------------------------------
!                                             Operator(.in.)@IntegerMethods
!----------------------------------------------------------------------------

!> author: Vikas Sharma, Ph. D.
! date: 2021-11-11
! update: 2021-11-11
! summary: Returns true if a integer set is inside another

INTERFACE OPERATOR(.in.)

  MODULE PURE FUNCTION in_2a(a, b) RESULT(Ans)
    INTEGER(INT8), INTENT(IN) :: a
    INTEGER(INT8), INTENT(IN) :: b(:)
    LOGICAL(LGT) :: ans
  END FUNCTION in_2a

  MODULE PURE FUNCTION in_2b(a, b) RESULT(Ans)
    INTEGER(INT16), INTENT(IN) :: a
    INTEGER(INT16), INTENT(IN) :: b(:)
    LOGICAL(LGT) :: ans
  END FUNCTION in_2b

  MODULE PURE FUNCTION in_2c(a, b) RESULT(Ans)
    INTEGER(INT32), INTENT(IN) :: a
    INTEGER(INT32), INTENT(IN) :: b(:)
    LOGICAL(LGT) :: ans
  END FUNCTION in_2c

  MODULE PURE FUNCTION in_2d(a, b) RESULT(Ans)
    INTEGER(INT64), INTENT(IN) :: a
    INTEGER(INT64), INTENT(IN) :: b(:)
    LOGICAL(LGT) :: ans
  END FUNCTION in_2d

END INTERFACE OPERATOR(.in.)

INTERFACE OPERATOR(.isin.)
  MODULE PROCEDURE in_2a, in_2b, in_2c, in_2d
END INTERFACE OPERATOR(.isin.)

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

INTERFACE RemoveDuplicates
  MODULE PURE SUBROUTINE RemoveDuplicates_1a(obj)
    INTEGER(INT8), ALLOCATABLE, INTENT(INOUT) :: obj(:)
  END SUBROUTINE RemoveDuplicates_1a
  MODULE PURE SUBROUTINE RemoveDuplicates_1b(obj)
    INTEGER(INT16), ALLOCATABLE, INTENT(INOUT) :: obj(:)
  END SUBROUTINE RemoveDuplicates_1b
  MODULE PURE SUBROUTINE RemoveDuplicates_1c(obj)
    INTEGER(INT32), ALLOCATABLE, INTENT(INOUT) :: obj(:)
  END SUBROUTINE RemoveDuplicates_1c
  MODULE PURE SUBROUTINE RemoveDuplicates_1d(obj)
    INTEGER(INT64), ALLOCATABLE, INTENT(INOUT) :: obj(:)
  END SUBROUTINE RemoveDuplicates_1d
END INTERFACE RemoveDuplicates

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

INTERFACE Repeat
  MODULE PURE FUNCTION Repeat_1a(Val, rtimes) RESULT(Ans)
    INTEGER(INT8), INTENT(IN) :: Val(:)
    INTEGER(I4B), INTENT(IN) :: rtimes
    INTEGER(INT8) :: Ans(SIZE(Val) * rtimes)
  END FUNCTION Repeat_1a
  MODULE PURE FUNCTION Repeat_1b(Val, rtimes) RESULT(Ans)
    INTEGER(INT16), INTENT(IN) :: Val(:)
    INTEGER(I4B), INTENT(IN) :: rtimes
    INTEGER(INT16) :: Ans(SIZE(Val) * rtimes)
  END FUNCTION Repeat_1b
  MODULE PURE FUNCTION Repeat_1c(Val, rtimes) RESULT(Ans)
    INTEGER(INT32), INTENT(IN) :: Val(:)
    INTEGER(I4B), INTENT(IN) :: rtimes
    INTEGER(INT32) :: Ans(SIZE(Val) * rtimes)
  END FUNCTION Repeat_1c
  MODULE PURE FUNCTION Repeat_1d(Val, rtimes) RESULT(Ans)
    INTEGER(INT64), INTENT(IN) :: Val(:)
    INTEGER(I4B), INTENT(IN) :: rtimes
    INTEGER(INT64) :: Ans(SIZE(Val) * rtimes)
  END FUNCTION Repeat_1d
  MODULE PURE FUNCTION Repeat_1e(Val, rtimes) RESULT(Ans)
    REAL(REAL32), INTENT(IN) :: Val(:)
    INTEGER(I4B), INTENT(IN) :: rtimes
    REAL(REAL32) :: Ans(SIZE(Val) * rtimes)
  END FUNCTION Repeat_1e
  MODULE PURE FUNCTION Repeat_1f(Val, rtimes) RESULT(Ans)
    REAL(REAL64), INTENT(IN) :: Val(:)
    INTEGER(I4B), INTENT(IN) :: rtimes
    REAL(REAL64) :: Ans(SIZE(Val) * rtimes)
  END FUNCTION Repeat_1f
END INTERFACE Repeat

!----------------------------------------------------------------------------
!                                                         getIndex@getMethod
!----------------------------------------------------------------------------

INTERFACE GetIndex
  MODULE PURE FUNCTION GetIndex1(obj, val) RESULT(ans)
    INTEGER(I4B), INTENT(IN) :: obj(:)
    INTEGER(I4B), INTENT(IN) :: val
    INTEGER(I4B) :: ans
  END FUNCTION GetIndex1
END INTERFACE GetIndex

!----------------------------------------------------------------------------
!                                                         getIndex@getMethod
!----------------------------------------------------------------------------

INTERFACE GetIndex
  MODULE PURE FUNCTION GetIndex2(obj, Val) RESULT(Ans)
    INTEGER(I4B), INTENT(IN) :: obj(:)
    INTEGER(I4B), INTENT(IN) :: Val(:)
    INTEGER(I4B), ALLOCATABLE :: Ans(:)
  END FUNCTION GetIndex2
END INTERFACE GetIndex

!----------------------------------------------------------------------------
!                                                           Get
!----------------------------------------------------------------------------

INTERFACE Get
  MODULE PURE FUNCTION Get1_Int8(val, indx) RESULT(ans)
    INTEGER(INT8), INTENT(IN) :: val(:)
    INTEGER(I4B), INTENT(IN) :: indx
    INTEGER(INT8) :: ans
  END FUNCTION Get1_Int8

  MODULE PURE FUNCTION Get1_Int16(val, indx) RESULT(ans)
    INTEGER(INT16), INTENT(IN) :: val(:)
    INTEGER(I4B), INTENT(IN) :: indx
    INTEGER(INT16) :: ans
  END FUNCTION Get1_Int16

  MODULE PURE FUNCTION Get1_Int32(val, indx) RESULT(ans)
    INTEGER(INT32), INTENT(IN) :: val(:)
    INTEGER(I4B), INTENT(IN) :: indx
    INTEGER(INT32) :: ans
  END FUNCTION Get1_Int32

  MODULE PURE FUNCTION Get1_Int64(val, indx) RESULT(ans)
    INTEGER(INT64), INTENT(IN) :: val(:)
    INTEGER(I4B), INTENT(IN) :: indx
    INTEGER(INT64) :: ans
  END FUNCTION Get1_Int64
END INTERFACE Get

!----------------------------------------------------------------------------
!                                                           Get
!----------------------------------------------------------------------------

INTERFACE Get
  MODULE PURE FUNCTION Get2_Int8(val, indx) RESULT(ans)
    INTEGER(INT8), INTENT(IN) :: val(:)
    INTEGER(I4B), INTENT(IN) :: indx(:)
    INTEGER(INT8) :: ans(SIZE(indx))
  END FUNCTION Get2_Int8

  MODULE PURE FUNCTION Get2_Int16(val, indx) RESULT(ans)
    INTEGER(INT16), INTENT(IN) :: val(:)
    INTEGER(I4B), INTENT(IN) :: indx(:)
    INTEGER(INT8) :: ans(SIZE(indx))
  END FUNCTION Get2_Int16

  MODULE PURE FUNCTION Get2_Int32(val, indx) RESULT(ans)
    INTEGER(INT32), INTENT(IN) :: val(:)
    INTEGER(I4B), INTENT(IN) :: indx(:)
    INTEGER(INT8) :: ans(SIZE(indx))
  END FUNCTION Get2_Int32

  MODULE PURE FUNCTION Get2_Int64(val, indx) RESULT(ans)
    INTEGER(INT64), INTENT(IN) :: val(:)
    INTEGER(I4B), INTENT(IN) :: indx(:)
    INTEGER(INT8) :: ans(SIZE(indx))
  END FUNCTION Get2_Int64
END INTERFACE Get

!----------------------------------------------------------------------------
!                                                           Get
!----------------------------------------------------------------------------

INTERFACE Get
  MODULE PURE FUNCTION Get3_Int8(val, istart, iend, stride) RESULT(ans)
    INTEGER(INT8), INTENT(IN) :: val(:)
    INTEGER(I4B), INTENT(IN) :: istart, iend, stride
    INTEGER(INT8) :: ans(INT((iend - istart) / stride) + 1)
  END FUNCTION Get3_Int8

  MODULE PURE FUNCTION Get3_Int16(val, istart, iend, stride) RESULT(ans)
    INTEGER(INT16), INTENT(IN) :: val(:)
    INTEGER(I4B), INTENT(IN) :: istart, iend, stride
    INTEGER(INT8) :: ans(INT((iend - istart) / stride) + 1)
  END FUNCTION Get3_Int16

  MODULE PURE FUNCTION Get3_Int32(val, istart, iend, stride) RESULT(ans)
    INTEGER(INT32), INTENT(IN) :: val(:)
    INTEGER(I4B), INTENT(IN) :: istart, iend, stride
    INTEGER(INT8) :: ans(INT((iend - istart) / stride) + 1)
  END FUNCTION Get3_Int32

  MODULE PURE FUNCTION Get3_Int64(val, istart, iend, stride) RESULT(ans)
    INTEGER(INT64), INTENT(IN) :: val(:)
    INTEGER(I4B), INTENT(IN) :: istart, iend, stride
    INTEGER(INT8) :: ans(INT((iend - istart) / stride) + 1)
  END FUNCTION Get3_Int64
END INTERFACE Get

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

END MODULE IntegerUtility
