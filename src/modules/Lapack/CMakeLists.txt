# This program is a part of EASIFEM library
# Copyright (C) 2020-2021  Vikas Sharma, Ph.D
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https: //www.gnu.org/licenses/>
#

IF( USE_LAPACK95 )
    LIST( APPEND TARGET_COMPILE_DEF "-DUSE_LAPACK95" )
    SET(src_path "${CMAKE_CURRENT_LIST_DIR}/src/")
    TARGET_SOURCES(
      ${PROJECT_NAME} PRIVATE
      ${src_path}/GE_CompRoutineMethods.F90
      ${src_path}/GE_EigenValueMethods.F90
      ${src_path}/GE_LUMethods.F90
      ${src_path}/GE_LinearSolveMethods.F90
      ${src_path}/GE_SingularValueMethods.F90
      ${src_path}/GE_Lapack_Method.F90
      ${src_path}/Sym_CompRoutineMethods.F90
      ${src_path}/Sym_EigenValueMethods.F90
      ${src_path}/Sym_LUMethods.F90
      ${src_path}/Sym_LinearSolveMethods.F90
      ${src_path}/Sym_SingularValueMethods.F90
      ${src_path}/Sym_Lapack_Method.F90
      ${src_path}/Lapack_Method.F90
      )
ENDIF(  )
