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

  INTEGER(I4B) :: nrow, ncol

  nrow = SIZE(b,1) + 1
  ncol = MAX(SIZE(b,2), SIZE(a))

  CALL reallocate(ans, nrow, ncol)

  ans(1, 1:SIZE(a)) = a

  ans(2:, 1:SIZE(b,2)) = b
