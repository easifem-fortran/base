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
! date: 	26 Feb 2021
! summary:

MODULE EASIFEM_BLAS
USE EASIFEM_F77_BLAS
IMPLICIT NONE
PRIVATE
#include "./iface.inc"

CONTAINS
#include "./caxpby.f90"
#include "./caxpy.f90"
#include "./ccopy.f90"
#include "./cdotc.f90"
#include "./cdotu.f90"
#include "./cgbmv.f90"
#include "./cgemm.f90"
#include "./cgemm3m.f90"
#include "./cgemv.f90"
#include "./cgerc.f90"
#include "./cgeru.f90"
#include "./chbmv.f90"
#include "./chemm.f90"
#include "./chemv.f90"
#include "./cher.f90"
#include "./cher2.f90"
#include "./cher2k.f90"
#include "./cherk.f90"
#include "./chpmv.f90"
#include "./chpr.f90"
#include "./chpr2.f90"
#include "./crotg.f90"
#include "./cscal.f90"
#include "./csrot.f90"
#include "./csscal.f90"
#include "./cswap.f90"
#include "./zswap.f90"
#include "./csymm.f90"
#include "./csyr2k.f90"
#include "./csyrk.f90"
#include "./ctbmv.f90"
#include "./ctbsv.f90"
#include "./ctpmv.f90"
#include "./ctpsv.f90"
#include "./ctrmm.f90"
#include "./ctrmv.f90"
#include "./ctrsm.f90"
#include "./ctrsv.f90"
#include "./dasum.f90"
#include "./daxpby.f90"
#include "./daxpy.f90"
#include "./dcabs1.f90"
#include "./dcopy.f90"
#include "./ddot.f90"
#include "./dgbmv.f90"
#include "./dgemm.f90"
#include "./dgemv.f90"
#include "./dger.f90"
#include "./dnrm2.f90"
#include "./drot.f90"
#include "./drotm.f90"
#include "./drotmg.f90"
#include "./drotg.f90"
#include "./dsbmv.f90"
#include "./dscal.f90"
#include "./dsdot.f90"
#include "./dspmv.f90"
#include "./dspr.f90"
#include "./dspr2.f90"
#include "./dswap.f90"
#include "./dsymm.f90"
#include "./dsymv.f90"
#include "./dsyr.f90"
#include "./dsyr2.f90"
#include "./dsyr2k.f90"
#include "./dsyrk.f90"
#include "./dtbmv.f90"
#include "./dtbsv.f90"
#include "./dtpmv.f90"
#include "./dtpsv.f90"
#include "./dtrmm.f90"
#include "./dtrmv.f90"
#include "./dtrsm.f90"
#include "./dtrsv.f90"
#include "./dzasum.f90"
#include "./dznrm2.f90"
#include "./icamax.f90"
#include "./icamin.f90"
#include "./idamax.f90"
#include "./idamin.f90"
#include "./isamax.f90"
#include "./isamin.f90"
#include "./izamax.f90"
#include "./izamin.f90"
#include "./sasum.f90"
#include "./saxpby.f90"
#include "./saxpy.f90"
#include "./scasum.f90"
#include "./scnrm2.f90"
#include "./scopy.f90"
#include "./scabs1.f90"
#include "./sdot.f90"
#include "./sdsdot.f90"
#include "./sgbmv.f90"
#include "./sgemm.f90"
#include "./sgemv.f90"
#include "./sger.f90"
#include "./snrm2.f90"
#include "./srot.f90"
#include "./srotm.f90"
#include "./srotmg.f90"
#include "./srotg.f90"
#include "./ssbmv.f90"
#include "./sscal.f90"
#include "./sspmv.f90"
#include "./sspr.f90"
#include "./sspr2.f90"
#include "./sswap.f90"
#include "./ssymm.f90"
#include "./ssymv.f90"
#include "./ssyr.f90"
#include "./ssyr2.f90"
#include "./ssyr2k.f90"
#include "./ssyrk.f90"
#include "./stbmv.f90"
#include "./stbsv.f90"
#include "./stpmv.f90"
#include "./stpsv.f90"
#include "./strmm.f90"
#include "./strmv.f90"
#include "./strsm.f90"
#include "./strsv.f90"
#include "./zaxpby.f90"
#include "./zaxpy.f90"
#include "./zcopy.f90"
#include "./zdotc.f90"
#include "./zdotu.f90"
#include "./zdrot.f90"
#include "./zdscal.f90"
#include "./zgbmv.f90"
#include "./zgemm.f90"
#include "./zgemm3m.f90"
#include "./zgemv.f90"
#include "./zgerc.f90"
#include "./zgeru.f90"
#include "./zhbmv.f90"
#include "./zhemm.f90"
#include "./zhemv.f90"
#include "./zher.f90"
#include "./zher2.f90"
#include "./zher2k.f90"
#include "./zherk.f90"
#include "./zhpmv.f90"
#include "./zhpr.f90"
#include "./zhpr2.f90"
#include "./zrotg.f90"
#include "./zscal.f90"
#include "./zsymm.f90"
#include "./zsyr2k.f90"
#include "./zsyrk.f90"
#include "./ztbmv.f90"
#include "./ztbsv.f90"
#include "./ztpmv.f90"
#include "./ztpsv.f90"
#include "./ztrmm.f90"
#include "./ztrmv.f90"
#include "./ztrsm.f90"
#include "./ztrsv.f90"

#ifdef USE_INTEL_MKL
#include "./droti.f90"
#include "./sroti.f90"
#include "./zgem2vc.f90"
#include "./cgem2vc.f90"
#include "./dgem2vu.f90"
#include "./sgem2vu.f90"
#include "./caxpyi.f90"
#include "./daxpyi.f90"
#include "./saxpyi.f90"
#include "./zaxpyi.f90"
#include "./ddoti.f90"
#include "./sdoti.f90"
#include "./cdotci.f90"
#include "./zdotci.f90"
#include "./cdotui.f90"
#include "./zdotui.f90"
#include "./cgemm_batch.f90"
#include "./cgemm3m_batch.f90"
#include "./ctrsm_batch.f90"
#include "./dgemm_batch.f90"
#include "./dtrsm_batch.f90"
#include "./sgemm_batch.f90"
#include "./strsm_batch.f90"
#include "./zgemm_batch.f90"
#include "./zgemm3m_batch.f90"
#include "./ztrsm_batch.f90"
#include "./cgemmt.f90"
#include "./dgemmt.f90"
#include "./sgemmt.f90"
#include "./zgemmt.f90"
#include "./cgthr.f90"
#include "./cgthrz.f90"
#include "./dgthr.f90"
#include "./dgthrz.f90"
#include "./sgthr.f90"
#include "./sgthrz.f90"
#include "./zgthr.f90"
#include "./zgthrz.f90"
#include "./dsctr.f90"
#include "./ssctr.f90"
#include "./csctr.f90"
#include "./dzgemm.f90"
#include "./dzgemv.f90"
#include "./scgemm.f90"
#include "./scgemv.f90"
#endif

END MODULE EASIFEM_BLAS