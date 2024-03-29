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
!!
!! main
!!
SELECT CASE (obj%vartype)
!!
!!
!!
!!
CASE (constant)
  !!
  IF( obj%defineon .EQ. nodal ) THEN
    ans = NodalVariable( &
      & RESHAPE(_ELEM_METHOD_(obj%val(:)), obj%s(1:2)), &
      & typeFEVariableMatrix, &
      & typeFEVariableConstant)
  ELSE
    ans = QuadratureVariable( &
      & RESHAPE(_ELEM_METHOD_(obj%val(:)), obj%s(1:2)), &
      & typeFEVariableMatrix, &
      & typeFEVariableConstant)
  END IF
!!
!!
!!
!!
CASE (space)
  !!
  IF( obj%defineon .EQ. nodal ) THEN
    ans = NodalVariable(&
      & RESHAPE(_ELEM_METHOD_(obj%val(:)), obj%s(1:3)), &
      & typeFEVariableMatrix, &
      & typeFEVariableSpace)
  ELSE
    ans = QuadratureVariable(&
      & RESHAPE(_ELEM_METHOD_(obj%val(:)), obj%s(1:3)), &
      & typeFEVariableMatrix, &
      & typeFEVariableSpace)
  END IF
!!
!!
!!
!!
CASE (time)
  IF( obj%defineon .EQ. nodal ) THEN
    ans = NodalVariable( &
      & RESHAPE(_ELEM_METHOD_(obj%val(:)), obj%s(1:3)), &
      & typeFEVariableMatrix, &
      & typeFEVariableTime)
  ELSE
    ans = QuadratureVariable( &
      & RESHAPE(_ELEM_METHOD_(obj%val(:)), obj%s(1:3)), &
      & typeFEVariableMatrix, &
      & typeFEVariableTime)
  END IF
!!
!!
!!
!!
CASE (spacetime)
  !!
  IF( obj%defineon .EQ. nodal ) THEN
    ans = NodalVariable(&
      & RESHAPE(_ELEM_METHOD_(obj%val(:)), obj%s(1:4)), &
      & typeFEVariableMatrix, &
      & typeFEVariableSpaceTime)
  ELSE
    ans = QuadratureVariable(&
      & RESHAPE(_ELEM_METHOD_(obj%val(:)), obj%s(1:4)), &
      & typeFEVariableMatrix, &
      & typeFEVariableSpaceTime)
  END IF
!!
!!
!!
!!
END SELECT
