
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
! date:         24 Feb 2021
! summary:         This module contains methods of [[IntVector_]] data type.
!
!###Introduction
!
! This module contains methods of [[IntVector_]] data type.
! This module only contains the definition of the interfaces of these
! methods. The actual implementation is given inside the submodules. This
! modules has following submodules:
!

MODULE IntVector_Method
USE IntVector_ConstructorMethod
USE IntVector_IOMethod
USE IntVector_EnquireMethod
USE IntVector_GetMethod
USE IntVector_SetMethod
USE IntVector_AppendMethod
END MODULE IntVector_Method
