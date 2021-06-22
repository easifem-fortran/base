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

!> authors: Vikas Sharma, Ph. D.
! date: 	4 March 2021
! summary: This submodule contains implementation of construction methods [[keyvalue_]]

SUBMODULE( KeyValue_Method ) Constructor
USE BaseMethod
IMPLICIT NONE

CONTAINS
!----------------------------------------------------------------------------
!                                                                   Initiate
!----------------------------------------------------------------------------

MODULE PROCEDURE Initiate1
  Obj%DataType = Real_Rank_0
  Obj%Key = Key
  Obj%Value = RESHAPE( [Value], [1,1] )
END PROCEDURE Initiate1

!----------------------------------------------------------------------------
!                                                                   Initiate
!----------------------------------------------------------------------------

MODULE PROCEDURE Initiate2
  Obj%DataType = Real_Rank_0
  Obj%Key = Key
  Obj%Value = RESHAPE( [Value], [1,1] )
END PROCEDURE Initiate2

!----------------------------------------------------------------------------
!                                                                   Initiate
!----------------------------------------------------------------------------

MODULE PROCEDURE Initiate3
  Obj%DataType =  Real_Rank_1
  Obj%Key = Key
  Obj%Value = RESHAPE( Value, [SIZE( Value ), 1] )
END PROCEDURE Initiate3

!----------------------------------------------------------------------------
!                                                                   Initiate
!----------------------------------------------------------------------------

MODULE PROCEDURE Initiate4
  Obj%DataType = Real_Rank_1
  Obj%Key = Key
  Obj%Value = RESHAPE( Value, [SIZE( Value ), 1] )
END PROCEDURE Initiate4

!----------------------------------------------------------------------------
!                                                                   Initiate
!----------------------------------------------------------------------------

MODULE PROCEDURE Initiate5
  Obj%DataType = Real_Rank_2
  Obj%Key = Key
  Obj%Value = Value
END PROCEDURE Initiate5

!----------------------------------------------------------------------------
!                                                                   Initiate
!----------------------------------------------------------------------------

MODULE PROCEDURE Initiate6
  Obj%DataType = Real_Rank_2
  Obj%Key = Key
  Obj%Value = Value
END PROCEDURE Initiate6

!----------------------------------------------------------------------------
!                                                                   Initiate
!----------------------------------------------------------------------------

MODULE PROCEDURE Initiate7
  Obj%DataType = Int_Rank_0
  Obj%Key = Key
  Obj%Value = RESHAPE( [Value], [1,1] )
END PROCEDURE Initiate7

!----------------------------------------------------------------------------
!                                                                   Initiate
!----------------------------------------------------------------------------

MODULE PROCEDURE Initiate8
  Obj%DataType = Int_Rank_0
  Obj%Key = Key
  Obj%Value = REAL( RESHAPE( [Value], [1,1] ), DFP )
END PROCEDURE Initiate8

!----------------------------------------------------------------------------
!                                                                   Initiate
!----------------------------------------------------------------------------

MODULE PROCEDURE Initiate9
  Obj%DataType = Int_Rank_1
  Obj%Key = Key
  Obj%Value = REAL( RESHAPE( Value, [SIZE( Value ), 1 ] ), DFP )
END PROCEDURE Initiate9

!----------------------------------------------------------------------------
!                                                                   Initiate
!----------------------------------------------------------------------------

MODULE PROCEDURE Initiate10
  Obj%DataType = Int_Rank_1
  Obj%Key = Key
  Obj%Value = REAL( RESHAPE( Value, [SIZE( Value ), 1 ] ), DFP )
END PROCEDURE Initiate10

!----------------------------------------------------------------------------
!                                                                   Initiate
!----------------------------------------------------------------------------

MODULE PROCEDURE Initiate11
  Obj%DataType = Int_Rank_2
  Obj%Key = Key
  Obj%Value = REAL( Value, DFP )
END PROCEDURE Initiate11

!----------------------------------------------------------------------------
!                                                                   Initiate
!----------------------------------------------------------------------------

MODULE PROCEDURE Initiate12
  Obj%DataType = Int_Rank_2
  Obj%Key = Key
  Obj%Value = REAL( Value, DFP )
END PROCEDURE Initiate12

!----------------------------------------------------------------------------
!                                                                   Initiate
!----------------------------------------------------------------------------

MODULE PROCEDURE Initiate13
  Obj%DataType = Obj2%DataType
  Obj%Key = Obj2%Key
  IF( ALLOCATED( Obj2%Value ) ) THEN
    Obj%Value = Obj2%Value
  END IF
END PROCEDURE Initiate13

!----------------------------------------------------------------------------
!                                                                 KeyValue
!----------------------------------------------------------------------------

MODULE PROCEDURE Constructor1
  CALL Initiate( Ans, Key, Value )
END PROCEDURE Constructor1

!----------------------------------------------------------------------------
!                                                                 KeyValue
!----------------------------------------------------------------------------

MODULE PROCEDURE Constructor2
  CALL Initiate( Ans, Key, Value )
END PROCEDURE Constructor2

!----------------------------------------------------------------------------
!                                                                 KeyValue
!----------------------------------------------------------------------------

MODULE PROCEDURE Constructor3
  CALL Initiate( Ans, Key, Value )
END PROCEDURE Constructor3

!----------------------------------------------------------------------------
!                                                                 KeyValue
!----------------------------------------------------------------------------

MODULE PROCEDURE Constructor4
  CALL Initiate( Ans, Key, Value )
END PROCEDURE Constructor4

!----------------------------------------------------------------------------
!                                                                 KeyValue
!----------------------------------------------------------------------------

MODULE PROCEDURE Constructor5
  CALL Initiate( Ans, Key, Value )
END PROCEDURE Constructor5

!----------------------------------------------------------------------------
!                                                                 KeyValue
!----------------------------------------------------------------------------

MODULE PROCEDURE Constructor6
  CALL Initiate( Ans, Key, Value )
END PROCEDURE Constructor6

!----------------------------------------------------------------------------
!                                                                 KeyValue
!----------------------------------------------------------------------------

MODULE PROCEDURE Constructor7
  CALL Initiate( Ans, Key, Value )
END PROCEDURE Constructor7

!----------------------------------------------------------------------------
!                                                                 KeyValue
!----------------------------------------------------------------------------

MODULE PROCEDURE Constructor8
  CALL Initiate( Ans, Key, Value )
END PROCEDURE Constructor8

!----------------------------------------------------------------------------
!                                                                 KeyValue
!----------------------------------------------------------------------------

MODULE PROCEDURE Constructor9
  CALL Initiate( Ans, Key, Value )
END PROCEDURE Constructor9

!----------------------------------------------------------------------------
!                                                                 KeyValue
!----------------------------------------------------------------------------

MODULE PROCEDURE Constructor10
  CALL  Initiate(Ans,  Key, Value )
END PROCEDURE Constructor10

!----------------------------------------------------------------------------
!                                                                 KeyValue
!----------------------------------------------------------------------------

MODULE PROCEDURE Constructor11
  CALL  Initiate(Ans,  Key, Value )
END PROCEDURE Constructor11

!----------------------------------------------------------------------------
!                                                                 KeyValue
!----------------------------------------------------------------------------

MODULE PROCEDURE Constructor12
  CALL  Initiate(Ans,  Key, Value )
END PROCEDURE Constructor12

!----------------------------------------------------------------------------
!                                                                   Display
!----------------------------------------------------------------------------

MODULE PROCEDURE keyvalue_display
  INTEGER( I4B ) :: I
  CHARACTER( LEN = 6 ) :: s

  I = stdout

  IF( PRESENT( UnitNo ) ) I = UnitNo
  SELECT CASE( Obj%DataType )
  CASE( REAL_RANK_0 )
    s = "Rank0"
  CASE( REAL_RANK_1 )
    s = "Rank1"
  CASE( REAL_RANK_2 )
    s = "Rank2"
  CASE( INT_RANK_0 )
    s = "Rank0"
  CASE( INT_RANK_1 )
    s = "Rank1"
  CASE( INT_RANK_2 )
    s = "Rank2"
  END SELECT

  IF( LEN_TRIM( msg ) .NE.  0 ) CALL Display( msg, I )
  IF( ALLOCATED( Obj%Value ) ) THEN
    CALL Display( Obj%Value, &
      & s // " :: " // TRIM( Obj%Key%Raw ) // " :: ", UnitNo = I )
  ELSE
    CALL Display(  s // " :: " // TRIM( Obj%Key%Raw ) // " :: ", UnitNo = I )
  END IF
END PROCEDURE keyvalue_display

!----------------------------------------------------------------------------
!                                                                 Display
!----------------------------------------------------------------------------

MODULE PROCEDURE mp_display
  INTEGER( I4B ) :: n, i, j

  I = stdout
  IF( PRESENT( UnitNo ) ) I = UnitNo
  n = SIZE( obj )
  CALL BlankLines( UnitNo = I )
  DO j = 1, n
    CALL display( obj( j ), msg, UnitNo = I )
    CALL BlankLines( UnitNo = I )
  END DO

END PROCEDURE mp_display

!----------------------------------------------------------------------------
!                                                                      Equal
!----------------------------------------------------------------------------

MODULE PROCEDURE Equal1
  Ans = Obj%Key .EQ. String( Key )
END PROCEDURE Equal1

!----------------------------------------------------------------------------
!                                                                      Equal
!----------------------------------------------------------------------------

MODULE PROCEDURE Equal2
  Ans = Obj%Key .EQ. String( Key )
END PROCEDURE Equal2

!----------------------------------------------------------------------------
!                                                                      Equal
!----------------------------------------------------------------------------

MODULE PROCEDURE Equal3
  Ans = Obj%Key .EQ. Key
END PROCEDURE Equal3

!----------------------------------------------------------------------------
!                                                                      Equal
!----------------------------------------------------------------------------

MODULE PROCEDURE Equal4
  Ans = Obj%Key .EQ. Key
END PROCEDURE Equal4

!----------------------------------------------------------------------------
!                                                             DeallocateData
!----------------------------------------------------------------------------

MODULE PROCEDURE keyvalue_deallocate
  IF(  ALLOCATED( Obj%Value )  ) DEALLOCATE( Obj%Value )
END PROCEDURE keyvalue_deallocate

END SUBMODULE Constructor

! CONTAINS

! !----------------------------------------------------------------------------
! !                                                            KeyValue_Pointer
! !----------------------------------------------------------------------------

! FUNCTION Constructor_1( Key, Value ) RESULT( Ans )
!   CLASS( keyValue_ ), POINTER :: Ans
!   CHARACTER( LEN = * ), INTENT( IN ) :: Key
!   REAL( DFP ), INTENT( IN ) :: Value

!   ALLOCATE( Ans )
!   CALL Initiate( Ans, Key, Value )
! END FUNCTION Constructor_1

! !----------------------------------------------------------------------------
! !                                                            KeyValue_Pointer
! !----------------------------------------------------------------------------

! FUNCTION Constructor_2( Key, Value ) RESULT( Ans )
!   CLASS( keyValue_ ), POINTER :: Ans
!   TYPE( String ), INTENT( IN ) :: Key
!   REAL( DFP ), INTENT( IN ) :: Value

!   ALLOCATE( Ans )
!   CALL Initiate( Ans, Key, Value )
! END FUNCTION Constructor_2

! !----------------------------------------------------------------------------
! !                                                            KeyValue_Pointer
! !----------------------------------------------------------------------------

! FUNCTION Constructor_3( Key, Value ) RESULT( Ans )
!   CLASS( keyValue_ ), POINTER :: Ans
!   CHARACTER( LEN = * ), INTENT( IN ) :: Key
!   REAL( DFP ), INTENT( IN ) :: Value( : )

!   ALLOCATE( Ans )
!   CALL Initiate( Ans, Key, Value )
! END FUNCTION Constructor_3

! !----------------------------------------------------------------------------
! !                                                            KeyValue_Pointer
! !----------------------------------------------------------------------------

! FUNCTION Constructor_4( Key, Value ) RESULT( Ans )
!   CLASS( keyValue_ ), POINTER :: Ans
!   TYPE( String ), INTENT( IN ) :: Key
!   REAL( DFP ), INTENT( IN ) :: Value( : )

!   ALLOCATE( Ans )
!   CALL Initiate( Ans, Key, Value )
! END FUNCTION Constructor_4

! !----------------------------------------------------------------------------
! !                                                            KeyValue_Pointer
! !----------------------------------------------------------------------------

! FUNCTION Constructor_5( Key, Value ) RESULT( Ans )
!   CLASS( keyValue_ ), POINTER :: Ans
!   CHARACTER( LEN = * ), INTENT( IN ) :: Key
!   REAL( DFP ), INTENT( IN ) :: Value( :, : )

!   ALLOCATE( Ans )
!   CALL Initiate( Ans, Key, Value )
! END FUNCTION Constructor_5

! !----------------------------------------------------------------------------
! !                                                            KeyValue_Pointer
! !----------------------------------------------------------------------------

! FUNCTION Constructor_6( Key, Value ) RESULT( Ans )
!   CLASS( keyValue_ ), POINTER :: Ans
!   TYPE( String ), INTENT( IN ) :: Key
!   REAL( DFP ), INTENT( IN ) :: Value( :, : )

!   ALLOCATE( Ans )
!   CALL Initiate( Ans, Key, Value )
! END FUNCTION Constructor_6

! !----------------------------------------------------------------------------
! !                                                            KeyValue_Pointer
! !----------------------------------------------------------------------------

! FUNCTION Constructor_7( Key, Value ) RESULT( Ans )
!   CLASS( keyValue_ ), POINTER :: Ans
!   CHARACTER( LEN = * ), INTENT( IN ) :: Key
!   INTEGER( I4B ), INTENT( IN ) :: Value

!   ALLOCATE( Ans )
!   CALL Initiate( Ans, Key, Value )
! END FUNCTION Constructor_7

! !----------------------------------------------------------------------------
! !                                                            KeyValue_Pointer
! !----------------------------------------------------------------------------

! FUNCTION Constructor_8( Key, Value ) RESULT( Ans )
!   CLASS( keyValue_ ), POINTER :: Ans
!   TYPE( String ), INTENT( IN ) :: Key
!   INTEGER( I4B ), INTENT( IN ) :: Value

!   ALLOCATE( Ans )
!   CALL Initiate( Ans, Key, Value )
! END FUNCTION Constructor_8

! !----------------------------------------------------------------------------
! !                                                            KeyValue_Pointer
! !----------------------------------------------------------------------------

! FUNCTION Constructor_9( Key, Value ) RESULT( Ans )
!   CLASS( keyValue_ ), POINTER :: Ans
!   CHARACTER( LEN = * ), INTENT( IN ) :: Key
!   INTEGER( I4B ), INTENT( IN ) :: Value( : )

!   ALLOCATE( Ans )
!   CALL Initiate( Ans, Key, Value )
! END FUNCTION Constructor_9

! !----------------------------------------------------------------------------
! !                                                            KeyValue_Pointer
! !----------------------------------------------------------------------------

! FUNCTION Constructor_10( Key, Value ) RESULT( Ans )
!   CLASS( keyValue_ ), POINTER :: Ans
!   TYPE( String ), INTENT( IN ) :: Key
!   INTEGER( I4B ), INTENT( IN ) :: Value( : )

!   ALLOCATE( Ans )
!   CALL Initiate( Ans, Key, Value )
! END FUNCTION Constructor_10

! !----------------------------------------------------------------------------
! !                                                            KeyValue_Pointer
! !----------------------------------------------------------------------------

! FUNCTION Constructor_11( Key, Value ) RESULT( Ans )
!   CLASS( keyValue_ ), POINTER :: Ans
!   CHARACTER( LEN = * ), INTENT( IN ) :: Key
!   INTEGER( I4B ), INTENT( IN ) :: Value( :, : )

!   ALLOCATE( Ans )
!   CALL Initiate( Ans, Key, Value )
! END FUNCTION Constructor_11

! !----------------------------------------------------------------------------
! !                                                            KeyValue_Pointer
! !----------------------------------------------------------------------------

! FUNCTION Constructor_12( Key, Value ) RESULT( Ans )
!   CLASS( keyValue_ ), POINTER :: Ans
!   TYPE( String ), INTENT( IN ) :: Key
!   INTEGER( I4B ), INTENT( IN ) :: Value( :, : )

!   ALLOCATE( Ans )
!   CALL Initiate( Ans, Key, Value )
! END FUNCTION Constructor_12