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

MODULE GlobalData
USE, INTRINSIC :: ISO_FORTRAN_ENV, ONLY: INPUT_UNIT, &
  & OUTPUT_UNIT, ERROR_UNIT
IMPLICIT NONE
PUBLIC

SAVE
INTEGER, PARAMETER :: stdin = INPUT_UNIT
INTEGER, PARAMETER :: stdout = OUTPUT_UNIT
INTEGER, PARAMETER :: stderr = OUTPUT_UNIT
INTEGER, PARAMETER :: endianL = 1
INTEGER, PARAMETER :: endianB = 0
INTEGER :: endian = endianL
#ifdef USE_Real128
INTEGER, PARAMETER :: REAL128 = SELECTED_REAL_KIND(33, 4931)
#else
INTEGER, PARAMETER :: REAL128 = SELECTED_REAL_KIND(15, 307)
#endif
INTEGER, PARAMETER :: REAL64 = SELECTED_REAL_KIND(15, 307)
INTEGER, PARAMETER :: REAL32 = SELECTED_REAL_KIND(6, 37)
#ifdef USE_Real64
INTEGER, PARAMETER :: Float = REAL64 ! Default
#else
INTEGER, PARAMETER :: Float = REAL32 ! Default
#endif
#ifdef USE_Real64
INTEGER, PARAMETER :: DFP = REAL64
#else
INTEGER, PARAMETER :: DFP = REAL32
#endif
INTEGER, PARAMETER :: INT64 = SELECTED_INT_KIND(18)
INTEGER, PARAMETER :: INT32 = SELECTED_INT_KIND(9)
INTEGER, PARAMETER :: INT16 = SELECTED_INT_KIND(4)
INTEGER, PARAMETER :: INT8 = SELECTED_INT_KIND(2)
#ifdef USE_Int64
INTEGER, PARAMETER :: I4B = INT64
INTEGER, PARAMETER :: DIP = INT64
#else
INTEGER, PARAMETER :: I4B = INT32
INTEGER, PARAMETER :: DIP = INT32
#endif
INTEGER, PARAMETER :: SP = REAL32
INTEGER, PARAMETER :: DP = REAL64
INTEGER, PARAMETER :: SPC = KIND((1.0_REAL32, 1.0_REAL32))
INTEGER, PARAMETER :: DPC = KIND((1.0_REAL64, 1.0_REAL64))
#ifdef USE_Real64
INTEGER, PARAMETER :: DFPC = KIND((1.0_REAL64, 1.0_REAL64))
#else
INTEGER, PARAMETER :: DFPC = KIND((1.0_REAL32, 1.0_REAL32))
#endif
INTEGER, PARAMETER :: LGT = KIND(.TRUE.)
! Logical
!
!Format parameters
#ifdef USE_Real128
CHARACTER(*), PARAMETER :: FReal128 = '(E42.33E4)'
#else
CHARACTER(*), PARAMETER :: FReal128 = '(E23.15E3)'
#endif
CHARACTER(*), PARAMETER :: FReal64 = '(E23.15E3)'
CHARACTER(*), PARAMETER :: FReal32 = '(E13.6E2)'
#ifdef USE_Real64
CHARACTER(*), PARAMETER :: FReal = FReal64
CHARACTER(*), PARAMETER :: FFloat = FReal64
#else
CHARACTER(*), PARAMETER :: FReal = FReal32
CHARACTER(*), PARAMETER :: FFloat = FReal32
#endif
#ifdef USE_Real64
CHARACTER(*), PARAMETER :: FDFP = FReal64 ! Default
#else
CHARACTER(*), PARAMETER :: FDFP = FReal32 ! Default
#endif
CHARACTER(*), PARAMETER :: FInt64 = '(I20)'
CHARACTER(*), PARAMETER :: FInt64ZP = '(I20.19)'
CHARACTER(*), PARAMETER :: FInt32 = '(I11)'
CHARACTER(*), PARAMETER :: FInt32ZP = '(I11.10)'
CHARACTER(*), PARAMETER :: FInt16 = '(I6)'
CHARACTER(*), PARAMETER :: FInt16ZP = '(I6.5)'
CHARACTER(*), PARAMETER :: FInt8 = '(I4)'
CHARACTER(*), PARAMETER :: FInt8ZP = '(I4.3)'
#ifdef USE_Int64
CHARACTER(*), PARAMETER :: FInt = FInt64
CHARACTER(*), PARAMETER :: FI4B = FInt64
CHARACTER(*), PARAMETER :: FI4BZP = FInt64ZP
CHARACTER(*), PARAMETER :: FIntZP = FInt64ZP
#else
CHARACTER(*), PARAMETER :: FInt = FInt32 !Default
CHARACTER(*), PARAMETER :: FI4B = FInt32 !Default
CHARACTER(*), PARAMETER :: FI4BZP = FInt32ZP
CHARACTER(*), PARAMETER :: FIntZP = FInt32ZP
#endif
! Length (number of digits) of formatted numbers
#ifdef USE_Real128
INTEGER, PARAMETER :: DReal128 = 42
#else
INTEGER, PARAMETER :: DReal128 = 23
#endif
INTEGER, PARAMETER :: DReal64 = 23
INTEGER, PARAMETER :: DReal32 = 13
#ifdef USE_Real64
INTEGER, PARAMETER :: DReal = DReal64
INTEGER, PARAMETER :: DFloat = DReal64
INTEGER, PARAMETER :: DDFP = DReal64
#else
INTEGER, PARAMETER :: DReal = DReal32
INTEGER, PARAMETER :: DFloat = DReal32
INTEGER, PARAMETER :: DDFP = DReal32
#endif
INTEGER, PARAMETER :: DInt64 = 20
INTEGER, PARAMETER :: DInt32 = 11
INTEGER, PARAMETER :: DInt16 = 6
INTEGER, PARAMETER :: DInt8 = 4
#ifdef USE_Int64
INTEGER, PARAMETER :: DInt = DInt64
INTEGER, PARAMETER :: DI4B = DInt64
#else
INTEGER, PARAMETER :: DInt = DInt32
INTEGER, PARAMETER :: DI4B = DInt32
#endif
! Minimum and maximum (representable) values
REAL(REAL128), PARAMETER :: TypeReal128 = 1.0
REAL(REAL128), PARAMETER :: MinReal128 = -HUGE(1._REAL128)
REAL(REAL128), PARAMETER :: MaxReal128 = HUGE(1._REAL128)
REAL(REAL64), PARAMETER :: TypeReal64 = 1.0
REAL(REAL64), PARAMETER :: MinReal64 = -HUGE(1._REAL64)
REAL(REAL64), PARAMETER :: MaxReal64 = HUGE(1._REAL64)
REAL(REAL32), PARAMETER :: TypeReal32 = 1.0
REAL(REAL32), PARAMETER :: MinReal32 = -HUGE(1._REAL32)
REAL(REAL32), PARAMETER :: MaxReal32 = HUGE(1._REAL32)
#ifdef USE_Real64
REAL(Float), PARAMETER :: MinFloat = MinReal64
REAL(Float), PARAMETER :: MinReal = MinReal64
REAL(Float), PARAMETER :: MaxFloat = MaxReal64
REAL(Float), PARAMETER :: MaxReal = MaxReal64
REAL(Float), PARAMETER :: MinDFP = MinReal64
REAL(Float), PARAMETER :: MaxDFP = MaxReal64
#else
REAL(Float), PARAMETER :: MinFloat = MinReal32
REAL(Float), PARAMETER :: MinReal = MinReal32
REAL(Float), PARAMETER :: MaxFloat = MaxReal32
REAL(Float), PARAMETER :: MaxReal = MaxReal32
REAL(Float), PARAMETER :: MinDFP = MinReal32
REAL(Float), PARAMETER :: MaxDFP = MaxReal32
#endif
REAL(DFP), PARAMETER :: TypeReal = 1.0
REAL(DFP), PARAMETER :: TypeDFP = 1.0
REAL(Float), PARAMETER :: TypeFloat = 1.0
INTEGER(INT64), PARAMETER :: MinInt64 = -HUGE(1_INT64), TypeInt64 = 1
INTEGER(INT32), PARAMETER :: MinInt32 = -HUGE(1_INT32), TypeInt32 = 1
INTEGER(INT16), PARAMETER :: MinInt16 = -HUGE(1_INT16), TypeInt16 = 1
INTEGER(INT8), PARAMETER :: MinInt8 = -HUGE(1_INT8), TypeInt8 = 1
#ifdef USE_Int64
INTEGER(DIP), PARAMETER :: MinInt = MinInt64
INTEGER(I4B), PARAMETER :: MinI4B = MinInt64
#else
INTEGER(DIP), PARAMETER :: MinInt = MinInt32
INTEGER(I4B), PARAMETER :: MinI4B = MinInt32
#endif
INTEGER(DIP), PARAMETER :: TypeInt = 1
INTEGER(DIP), PARAMETER :: TypeIntI4B = 1
INTEGER(INT64), PARAMETER :: MaxInt64 = HUGE(1_INT64)
INTEGER(INT32), PARAMETER :: MaxInt32 = HUGE(1_INT32)
INTEGER(INT16), PARAMETER :: MaxInt16 = HUGE(1_INT16)
INTEGER(INT8), PARAMETER :: MaxInt8 = HUGE(1_INT8)
#ifdef USE_Int64
INTEGER(DIP), PARAMETER :: MaxI4B = MaxInt64 !default
INTEGER(DIP), PARAMETER :: MaxInt = MaxInt64 !default
#else
INTEGER(DIP), PARAMETER :: MaxI4B = MaxInt32 !default
INTEGER(DIP), PARAMETER :: MaxInt = MaxInt32 !default
#endif
! Real smallest (representable) values
REAL(REAL128), PARAMETER :: smallReal128 = TINY(1._REAL128)
REAL(REAL64), PARAMETER :: smallReal64 = TINY(1._REAL64)
REAL(REAL32), PARAMETER :: smallReal32 = TINY(1._REAL32)
#ifdef USE_Real64
REAL(Float), PARAMETER :: smallFloat = smallReal64
REAL(Float), PARAMETER :: smallReal = smallReal64
REAL(Float), PARAMETER :: smallDFP = smallReal64
#else
REAL(Float), PARAMETER :: smallFloat = smallReal32
REAL(Float), PARAMETER :: smallReal = smallReal32
REAL(Float), PARAMETER :: smallDFP = smallReal32
#endif
! Smallest REAL representable difference by the running calculator
REAL(REAL128), PARAMETER :: ZeroReal128 = &
  & NEAREST(1._REAL128, 1._REAL128) - NEAREST(1._REAL128, -1._REAL128)
REAL(REAL64), PARAMETER :: ZeroReal64 = &
  & NEAREST(1._REAL64, 1._REAL64) - NEAREST(1._REAL64, -1._REAL64)
REAL(REAL32), PARAMETER :: ZeroReal32 = &
  & NEAREST(1._REAL32, 1._REAL32) - NEAREST(1._REAL32, -1._REAL32)
#ifdef USE_Real64
REAL(Float), PARAMETER :: Zero = ZeroReal64
#else
REAL(Float), PARAMETER :: Zero = ZeroReal32
#endif
! Bits/bytes memory requirements
#ifdef USE_Real128
INTEGER(INT16), PARAMETER :: BIReal128 = STORAGE_SIZE(MaxReal128)
#else
INTEGER(INT16), PARAMETER :: BIReal128 = STORAGE_SIZE(MaxReal64)
#endif
INTEGER(INT8), PARAMETER :: BIReal64 = STORAGE_SIZE(MaxReal64)
INTEGER(INT8), PARAMETER :: BIReal32 = STORAGE_SIZE(MaxReal32)
#ifdef USE_Real64
INTEGER(INT8), PARAMETER :: BIFloat = BIReal64 !default in bits
INTEGER(INT8), PARAMETER :: BIReal = BIReal64 !default in bits
INTEGER(INT8), PARAMETER :: BIDFP = BIReal64 !default in bytes
#else
INTEGER(INT8), PARAMETER :: BIFloat = BIReal32 !default in bits
INTEGER(INT8), PARAMETER :: BIReal = BIReal32 !default in bits
INTEGER(INT8), PARAMETER :: BIDFP = BIReal32 !default in bytes
#endif
INTEGER(INT16), PARAMETER :: BYReal128 = BIReal128 / 8_INT16
INTEGER(INT8), PARAMETER :: BYReal64 = BIReal64 / 8_INT16
INTEGER(INT8), PARAMETER :: BYReal32 = BIReal32 / 8_INT16
#ifdef USE_Real64
INTEGER(INT8), PARAMETER :: BYFloat = BYReal64
INTEGER(INT8), PARAMETER :: BYReal = BYReal64 !default
INTEGER(INT8), PARAMETER :: BYDFP = BYReal64 !default
#else
INTEGER(INT8), PARAMETER :: BYFloat = BYReal32
INTEGER(INT8), PARAMETER :: BYReal = BYReal32 !default
INTEGER(INT8), PARAMETER :: BYDFP = BYReal32 !default
#endif
INTEGER(INT64), PARAMETER :: BIInt64 = BIT_SIZE(MaxInt64)
INTEGER(INT32), PARAMETER :: BIInt32 = BIT_SIZE(MaxInt32)
INTEGER(INT16), PARAMETER :: BIInt16 = BIT_SIZE(MaxInt16)
INTEGER(INT8), PARAMETER :: BIInt8 = BIT_SIZE(MaxInt8)
INTEGER(DIP), PARAMETER :: BIInt = BIT_SIZE(MaxInt) !default in bits
INTEGER(DIP), PARAMETER :: BII4B = BIT_SIZE(MaxInt) !default in bits
INTEGER(INT64), PARAMETER :: BYInt64 = BIT_SIZE(MaxInt64) / 8_INT64
INTEGER(INT32), PARAMETER :: BYInt32 = BIT_SIZE(MaxInt32) / 8_INT32
INTEGER(INT16), PARAMETER :: BYInt16 = BIT_SIZE(MaxInt16) / 8_INT16
INTEGER(INT8), PARAMETER :: BYInt8 = BIT_SIZE(MaxInt8) / 8_INT8
INTEGER(DIP), PARAMETER :: BYInt = BIT_SIZE(MaxInt) / 8_DIP !default in bytes
INTEGER(DIP), PARAMETER :: BYI4B = BIT_SIZE(MaxInt) / 8_DIP ! default in bytes
REAL(DFP), PARAMETER :: Pi = 3.14159265359_DFP
REAL(DFP), PARAMETER :: Eye3(3, 3) = RESHAPE( &
  & [1.0_DFP, 0.0_DFP, 0.0_DFP, &
  & 0.0_DFP, 1.0_DFP, 0.0_DFP, &
  & 0.0_DFP, 0.0_DFP, 1.0_DFP], [3, 3])
REAL(DFP), PARAMETER :: Eye2(2, 2) = RESHAPE( &
  & [1.0_DFP, 0.0_DFP, 0.0_DFP, 1.0_DFP], [2, 2])
! Parameters for iteration data
INTEGER(I4B), PARAMETER :: RelativeConvergence = 1
INTEGER(I4B), PARAMETER :: AbsoluteConvergence = 2
INTEGER(I4B), PARAMETER :: ConvergenceInRes = 1
INTEGER(I4B), PARAMETER :: ConvergenceInSol = 2
INTEGER(I4B), PARAMETER :: ConvergenceInResSol = 3
INTEGER(I4B), PARAMETER :: ConvergenceInSolRes = 3
INTEGER(I4B), PARAMETER :: NormL1 = 1
INTEGER(I4B), PARAMETER :: NormL2 = 2
INTEGER(I4B), PARAMETER :: NormInfinity = 3
!!
!! Type of polynomial for scale interpolation
!!
INTEGER(I4B), PARAMETER :: Monomial = 0
INTEGER(I4B), PARAMETER :: LagrangePolynomial = 1
INTEGER(I4B), PARAMETER :: Lagrange = LagrangePolynomial
INTEGER(I4B), PARAMETER :: SerendipityPolynomial = 2
INTEGER(I4B), PARAMETER :: Serendipity = SerendipityPolynomial
INTEGER(I4B), PARAMETER :: HeirarchicalPolynomial = 3
INTEGER(I4B), PARAMETER :: Heirarchical = HeirarchicalPolynomial
INTEGER(I4B), PARAMETER :: HierarchicalPolynomial = 3
INTEGER(I4B), PARAMETER :: Hierarchical = HierarchicalPolynomial
INTEGER(I4B), PARAMETER :: HeirarchyPolynomial = 3
INTEGER(I4B), PARAMETER :: Heirarchy = HeirarchyPolynomial
INTEGER(I4B), PARAMETER :: HierarchyPolynomial = 3
INTEGER(I4B), PARAMETER :: Hierarchy = HierarchyPolynomial
INTEGER(I4B), PARAMETER :: Jacobi = 4
INTEGER(I4B), PARAMETER :: Ultraspherical = 5
INTEGER(I4B), PARAMETER :: Legendre = 6
INTEGER(I4B), PARAMETER :: Chebyshev = 7
INTEGER(I4B), PARAMETER :: Lobatto = 8
INTEGER(I4B), PARAMETER :: Orthogonal = 9
INTEGER(I4B), PARAMETER :: OrthogonalPolynomial = Orthogonal
INTEGER(I4B), PARAMETER :: UnscaledLobatto = 10
INTEGER(I4B), PARAMETER :: HermitPolynomial = 11
!!
!! Quadrature types
!!
INTEGER(I4B), PARAMETER :: Equidistance = 1
INTEGER(I4B), PARAMETER :: Gauss = 2
INTEGER(I4B), PARAMETER :: GaussRadau = 3
INTEGER(I4B), PARAMETER :: GaussRadauLeft = 4
INTEGER(I4B), PARAMETER :: GaussRadauRight = 5
INTEGER(I4B), PARAMETER :: GaussLobatto = 6
!!
INTEGER(I4B), PARAMETER :: GaussLegendre = 7
INTEGER(I4B), PARAMETER :: GaussLegendreLobatto = 8
INTEGER(I4B), PARAMETER :: GaussLegendreRadau = 9
INTEGER(I4B), PARAMETER :: GaussLegendreRadauLeft = 10
INTEGER(I4B), PARAMETER :: GaussLegendreRadauRight = 11
!!
INTEGER(I4B), PARAMETER :: GaussChebyshev = 12
INTEGER(I4B), PARAMETER :: GaussChebyshevRadau = 13
INTEGER(I4B), PARAMETER :: GaussChebyshevRadauLeft = 14
INTEGER(I4B), PARAMETER :: GaussChebyshevRadauRight = 15
INTEGER(I4B), PARAMETER :: GaussChebyshevLobatto = 16
!!
INTEGER(I4B), PARAMETER :: GaussJacobi = 17
INTEGER(I4B), PARAMETER :: GaussJacobiRadau = 18
INTEGER(I4B), PARAMETER :: GaussJacobiRadauLeft = 19
INTEGER(I4B), PARAMETER :: GaussJacobiRadauRight = 20
INTEGER(I4B), PARAMETER :: GaussJacobiLobatto = 21
!!
INTEGER(I4B), PARAMETER :: GaussUltraspherical = 22
INTEGER(I4B), PARAMETER :: GaussUltrasphericalRadau = 23
INTEGER(I4B), PARAMETER :: GaussUltrasphericalRadauLeft = 24
INTEGER(I4B), PARAMETER :: GaussUltrasphericalRadauRight = 25
INTEGER(I4B), PARAMETER :: GaussUltrasphericalLobatto = 26
!!
!! Type of quadrature points
!!
INTEGER(I4B), PARAMETER :: GaussQP = Gauss
INTEGER(I4B), PARAMETER :: GaussLegendreQP = GaussLegendre
INTEGER(I4B), PARAMETER :: GaussRadauQP = GaussRadau
INTEGER(I4B), PARAMETER :: GaussRadauLeftQP = GaussRadauLeft
INTEGER(I4B), PARAMETER :: GaussRadauRightQP = GaussRadauRight
INTEGER(I4B), PARAMETER :: GaussLobattoQP = GaussLobatto
INTEGER(I4B), PARAMETER :: GaussChebyshevQP = GaussChebyshev
!!
INTEGER(I4B), PARAMETER :: ChenBabuska = 22 !! for triangle nodes
INTEGER(I4B), PARAMETER :: Hesthaven = 23 !! for triangle nodes
INTEGER(I4B), PARAMETER :: Feket = 24 !! for triangle nodes
!!
INTEGER(I4B), PARAMETER :: BlythPozLegendre = 25 !! for triangle
INTEGER(I4B), PARAMETER :: BlythPozChebyshev = 26 !! for triangle
!!
INTEGER(I4B), PARAMETER :: IsaacLegendre = 27 !! for triangle
INTEGER(I4B), PARAMETER :: IsaacChebyshev = 28 !! for triangle
!!
!! Type of Lagrange Interpolation Points
!!
INTEGER(I4B), PARAMETER :: EquidistanceLIP = Equidistance
INTEGER(I4B), PARAMETER :: GaussLobattoLIP = GaussLobatto
INTEGER(I4B), PARAMETER :: GaussLegendreLIP = GaussLegendre
INTEGER(I4B), PARAMETER :: ChebyshevLIP = Chebyshev
!!
!! Types of Element domain
!!
INTEGER(I4B), PARAMETER :: Line = 1
!! order 1
INTEGER(I4B), PARAMETER :: Line2 = 1
!! order 1
INTEGER(I4B), PARAMETER :: Line3 = 8
!! order 2
INTEGER(I4B), PARAMETER :: Line4 = 26
!! order 3
INTEGER(I4B), PARAMETER :: Line5 = 27
! order 4
INTEGER(I4B), PARAMETER :: Line6 = 28
!! order 5
!! Line7 onwards numbering starts from 2801, 2802, and so on...
INTEGER(I4B), PARAMETER :: Triangle = 2
INTEGER(I4B), PARAMETER :: Triangle3 = 2
INTEGER(I4B), PARAMETER :: Triangle6 = 9
INTEGER(I4B), PARAMETER :: Triangle9 = 20
INTEGER(I4B), PARAMETER :: Triangle10 = 21
INTEGER(I4B), PARAMETER :: Triangle12 = 22
INTEGER(I4B), PARAMETER :: Triangle15a = 23
INTEGER(I4B), PARAMETER :: Triangle15b = 24
INTEGER(I4B), PARAMETER :: Triangle15 = 24
INTEGER(I4B), PARAMETER :: Triangle21 = 25
INTEGER(I4B), PARAMETER :: Quadrangle = 3
!! order = 1
INTEGER(I4B), PARAMETER :: Quadrangle4 = 3
!! order = 1
INTEGER(I4B), PARAMETER :: Quadrangle9 = 10
!! order = 2
INTEGER(I4B), PARAMETER :: Quadrangle8 = 16
!! order = 2, Serendipity
INTEGER(I4B), PARAMETER :: Quadrangle16 = 160
!! order = 3
!! Forder order 4, 5, and so on, we use 1601, 1602, 1603, etc.
INTEGER(I4B), PARAMETER :: Tetrahedron = 4
INTEGER(I4B), PARAMETER :: Tetrahedron4 = 4
INTEGER(I4B), PARAMETER :: Tetrahedron10 = 11
INTEGER(I4B), PARAMETER :: Tetrahedron20 = 29
INTEGER(I4B), PARAMETER :: Tetrahedron35 = 30
INTEGER(I4B), PARAMETER :: Tetrahedron56 = 31
INTEGER(I4B), PARAMETER :: Hexahedron = 5
INTEGER(I4B), PARAMETER :: Hexahedron8 = 5
INTEGER(I4B), PARAMETER :: Hexahedron27 = 12
INTEGER(I4B), PARAMETER :: Hexahedron20 = 17
INTEGER(I4B), PARAMETER :: Hexahedron64 = 92
INTEGER(I4B), PARAMETER :: Hexahedron125 = 93
INTEGER(I4B), PARAMETER :: Prism = 6
INTEGER(I4B), PARAMETER :: Prism6 = 6
INTEGER(I4B), PARAMETER :: Prism18 = 13
INTEGER(I4B), PARAMETER :: Prism15 = 18
INTEGER(I4B), PARAMETER :: Pyramid = 7
INTEGER(I4B), PARAMETER :: Pyramid5 = 7
INTEGER(I4B), PARAMETER :: Pyramid14 = 14
INTEGER(I4B), PARAMETER :: Pyramid13 = 19
INTEGER(I4B), PARAMETER :: Point = 15
INTEGER(I4B), PARAMETER :: Point1 = 15
! Read material data from ?
INTEGER(I4B), PARAMETER :: PhysicalTag = 1
INTEGER(I4B), PARAMETER :: GeometryTag = 2
! ScalarDOF
INTEGER(I4B), PARAMETER :: ScalarDOF = -1
  !! Following are used in ErrorHandling.F90
INTEGER(I4B), PARAMETER, PUBLIC :: OPT_OPEN = 1
  !! Constant for file open used by fErr
INTEGER(I4B), PARAMETER, PUBLIC :: OPT_READ = 2
  !! Constant for file read used by fErr
INTEGER(I4B), PARAMETER, PUBLIC :: OPT_WRITE = 3
  !! Constant for file write used by fErr
INTEGER(I4B), PARAMETER, PUBLIC :: OPT_CLOSE = 4
  !! Constant for file close used by fErr
INTEGER(I4B), PARAMETER, PUBLIC :: OPT_ALLOC = 1
INTEGER(I4B), PARAMETER, PUBLIC :: OPT_DEALLOC = 2
! for matrix conversion ( dense to dense )
! element matrix storage may differ from global matrix storage format
INTEGER(I4B), PARAMETER, PUBLIC :: DofToNodes = 0
    !! It is used in [[RealVector_]] and [[RealMatrix_]]
INTEGER(I4B), PARAMETER, PUBLIC :: NONE = -1
    !! It is used in [[RealVector_]] and [[RealMatrix_]]
INTEGER(I4B), PARAMETER, PUBLIC :: NodesToDOF = 1
    !! It is used in [[RealVector_]] and [[RealMatrix_]]
INTEGER(I4B), PARAMETER, PUBLIC :: DOF_FMT = 0
INTEGER(I4B), PARAMETER, PUBLIC :: NODES_FMT = 1
INTEGER(I4B), PARAMETER, PUBLIC :: FMT_DOF = 0
INTEGER(I4B), PARAMETER, PUBLIC :: FMT_NODES = 1
INTEGER(I4B), PARAMETER, PUBLIC :: Matrix_ROW = 1
INTEGER(I4B), PARAMETER, PUBLIC :: Matrix_COLUMN = 2
INTEGER(I4B), PARAMETER, PUBLIC :: Matrix_DIAGONAL = 0
INTEGER(I4B), PARAMETER, PUBLIC :: SMALL_MATRIX_ROW = 10
    !! Lenght of small matrix in row dimension
INTEGER(I4B), PARAMETER, PUBLIC :: SMALL_MATRIX_LEN_COL = 10
    !! Length of small matrix in column dimension
INTEGER(I4B), PARAMETER, PUBLIC :: SMALL_VECTOR_LEN = 100
    !! Length of small vector
INTEGER(I4B), PARAMETER, PUBLIC :: OMP_THREADS_FORKED = 1
INTEGER(I4B), PARAMETER, PUBLIC :: OMP_THREADS_JOINED = 2
! Related to tensors
INTEGER(I4B), PARAMETER, PUBLIC :: SymTensor = 1
INTEGER(I4B), PARAMETER, PUBLIC :: SkewSymTensor = -1
INTEGER(I4B), PARAMETER, PUBLIC :: GeneralTensor = 0
INTEGER(I4B), PARAMETER, PUBLIC :: StressTypeVoigt = 1
INTEGER(I4B), PARAMETER, PUBLIC :: StrainTypeVoigt = -1
INTEGER(I4B), PARAMETER, PUBLIC :: WithSpectral = 1
INTEGER(I4B), PARAMETER, PUBLIC :: WithoutSpectral = -1
INTEGER(I4B), PARAMETER, PUBLIC :: SineLode = 1
INTEGER(I4B), PARAMETER, PUBLIC :: CosineLode = 0
! Related to vectors, matrices, and linear solver
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_CG = 1
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_BCG = 2
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_BICG = 2
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_CGS = 3
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_BCGSTAB = 4
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_BICGSTAB = 4
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_BCGSTABL = 5
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_BICGSTABL = 5
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_GPBICG = 6
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_TFQMR = 7
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_OMN = 8
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_FOM = 8
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_ORTHOMIN = 8
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_GMRES = 9
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_GMR = 9
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_JACOBI = 10
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_GS = 11
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_SOR = 12
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_BICGSAFE = 13
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_CR = 14
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_BICR = 15
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_CRS = 16
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_BICRSTAB = 17
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_GPBICR = 18
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_BICRSAFE = 19
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_FGMRES = 20
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_IDRS = 21
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_IDR1 = 22
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_MINRES = 23
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_COCG = 24
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_COCR = 25
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_CGNR = 26
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_CGN = 26
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_DBCG = 27
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_DBICG = 27
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_DQGMRES = 28
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_SUPERLU = 29
! Precondition sides
INTEGER(I4B), PARAMETER :: NoPrecond = 0
INTEGER(I4B), PARAMETER :: PrecondLeft = 1
INTEGER(I4B), PARAMETER :: PrecondRight = 2
INTEGER(I4B), PARAMETER, PUBLIC :: NO_PRECONDITION = NoPrecond
INTEGER(I4B), PARAMETER, PUBLIC :: LEFT_PRECONDITION = 1
INTEGER(I4B), PARAMETER, PUBLIC :: RIGHT_PRECONDITION = 2
INTEGER(I4B), PARAMETER, PUBLIC :: LEFT_RIGHT_PRECONDITION = 3
INTEGER(I4B), PARAMETER, PUBLIC :: PRECOND_NONE = NoPrecond
INTEGER(I4B), PARAMETER, PUBLIC :: PRECOND_JACOBI = 1
INTEGER(I4B), PARAMETER, PUBLIC :: PRECOND_ILU = 2
INTEGER(I4B), PARAMETER, PUBLIC :: PRECOND_SSOR = 3
INTEGER(I4B), PARAMETER, PUBLIC :: PRECOND_HYBRID = 4
INTEGER(I4B), PARAMETER, PUBLIC :: PRECOND_IS = 5
INTEGER(I4B), PARAMETER, PUBLIC :: PRECOND_SAINV = 6
INTEGER(I4B), PARAMETER, PUBLIC :: PRECOND_SAAMG = 7
INTEGER(I4B), PARAMETER, PUBLIC :: PRECOND_ILUC = 8
INTEGER(I4B), PARAMETER, PUBLIC :: PRECOND_ADDS = 9
INTEGER(I4B), PARAMETER, PUBLIC :: PRECOND_ILUTP = 10
INTEGER(I4B), PARAMETER, PUBLIC :: PRECOND_ILUD = 11
INTEGER(I4B), PARAMETER, PUBLIC :: PRECOND_ILUDP = 12
INTEGER(I4B), PARAMETER, PUBLIC :: PRECOND_ILU0 = 13
INTEGER(I4B), PARAMETER, PUBLIC :: PRECOND_ILUK = 14
INTEGER(I4B), PARAMETER, PUBLIC :: PRECOND_ILUT = 15
! Linear solver/ linear algebra engines
INTEGER(I4B), PARAMETER, PUBLIC :: NATIVE_SERIAL = 1
INTEGER(I4B), PARAMETER, PUBLIC :: NATIVE_OMP = 2
INTEGER(I4B), PARAMETER, PUBLIC :: NATIVE_MPI = 3
INTEGER(I4B), PARAMETER, PUBLIC :: PETSC = 4
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_SERIAL = 5
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_OMP = 6
INTEGER(I4B), PARAMETER, PUBLIC :: LIS_MPI = 7
! Constraint type
INTEGER(I4B), PARAMETER :: StrongBC = 1
INTEGER(I4B), PARAMETER :: NitscheBC = 2
INTEGER(I4B), PARAMETER :: LagrangeMultiplierBC = 3
INTEGER(I4B), PARAMETER :: PenaltyBC = 4
INTEGER(I4B), PARAMETER :: AugmentedBC = 5
! Symmetric and Skewsymmertic Nitsche Formulation
INTEGER(I4B), PARAMETER :: SkewSymNitsch = 1, SymNitsche = 2
CHARACTER(*), PARAMETER :: CHAR_BLANK = " "
    !! Character representing a space symbol
CHARACTER(*), PARAMETER :: CHAR_BANG = "!"
    !! Character representing a comment symbol
CHARACTER(*), PARAMETER :: CHAR_DOT = "."
    !! Character representing a period
CHARACTER(*), PARAMETER :: CHAR_FSLASH = "/"
    !! Character representing a forward slash
CHARACTER(*), PARAMETER :: CHAR_BSLASH = ACHAR(92)
    !! Character representing a backward slash
CHARACTER(*), PARAMETER :: CHAR_COLON = ":"
    !! Character representing a colon
#ifdef WIN32
CHARACTER(*), PARAMETER :: CHAR_SLASH = CHAR_BSLASH
    !! This is needed for doxygen to parse correctly
    !! The slash symbol used by the file system
    !! (BLASH for Windows, FSLASH for everything else)
#else
CHARACTER(*), PARAMETER :: CHAR_SLASH = CHAR_FSLASH
    !! The slash symbol used by the file system
    !! (BLASH for Windows, FSLASH for everything else)
#endif
CHARACTER(1), PUBLIC, PARAMETER :: CHAR_SPACE = ' '
    !! Character constant for a single space
CHARACTER(1), PUBLIC, PARAMETER :: CHAR_CR = CHAR(13)
    !! Character constant for a carraige return
CHARACTER(1), PUBLIC, PARAMETER :: CHAR_LF = CHAR(10)
    !! Character constant for a line feed
CHARACTER(2), PUBLIC, PARAMETER :: CHAR_LF2 = char_lf//char_lf
    !! Character constant for a line feed
CHARACTER(3), PUBLIC, PARAMETER :: CHAR_LF3 = char_lf2//char_lf
    !! Character constant for a line feed
CHARACTER(1), PUBLIC, PARAMETER :: CHAR_TAB = CHAR(9)

INTEGER(I4B), PARAMETER, PUBLIC :: Constant = 1
INTEGER(I4B), PARAMETER, PUBLIC :: Space = 2
INTEGER(I4B), PARAMETER, PUBLIC :: Time = 3
INTEGER(I4B), PARAMETER, PUBLIC :: SpaceTime = 4
INTEGER(I4B), PARAMETER, PUBLIC :: SolutionDependent = 5
INTEGER(I4B), PARAMETER, PUBLIC :: RandomSpace = 6
!>
INTEGER(I4B), PARAMETER, PUBLIC :: Scalar = 1
INTEGER(I4B), PARAMETER, PUBLIC :: Vector = 2
INTEGER(I4B), PARAMETER, PUBLIC :: Matrix = 3
INTEGER(I4B), PARAMETER, PUBLIC :: Nodal = 1
INTEGER(I4B), PARAMETER, PUBLIC :: Quadrature = 2

INTEGER(I4B), PARAMETER, PUBLIC :: MAX_CHUNK_SIZE = 1024

END MODULE GlobalData
