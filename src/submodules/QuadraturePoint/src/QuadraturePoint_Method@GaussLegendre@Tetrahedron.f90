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

SUBMODULE( QuadraturePoint_Method:GaussLegendre ) Tetrahedron
IMPLICIT NONE
CONTAINS

!----------------------------------------------------------------------------
!                                                                 Tetrahedron
!----------------------------------------------------------------------------

MODULE PROCEDURE getGaussLegendreQPTetrahedron1
  REAL( DFP ), ALLOCATABLE :: Points( :, : )
  SELECT CASE(Order)
    CASE( 0, 1 )
    !1-point
      Points = RESHAPE( [ 0.250000000000000, 0.250000000000000, 0.250000000000000, &
      & 0.166666666666667], [   4 ,    1] )
    CASE( 2 )
    !4-point
      Points = RESHAPE( [ 0.585410196624969, 0.138196601125011, 0.138196601125011, &
        & 0.041666666666667, 0.138196601125011, 0.138196601125011, 0.138196601125011, &
        & 0.041666666666667, 0.138196601125011, 0.138196601125011, 0.585410196624969, &
        & 0.041666666666667, 0.138196601125011, 0.585410196624969, 0.138196601125011, &
        & 0.041666666666667], [   4 ,    4] )
    CASE( 3 )
    !5-point
      Points = RESHAPE( [ 0.250000000000000, 0.250000000000000, 0.250000000000000, &
        & -0.133333333333333, 0.500000000000000, 0.166666666666667, 0.166666666666667, &
        & 0.075000000000000, 0.166666666666667, 0.166666666666667, 0.166666666666667, &
        & 0.075000000000000, 0.166666666666667, 0.166666666666667, 0.500000000000000, &
        & 0.075000000000000, 0.166666666666667, 0.500000000000000, 0.166666666666667, &
        & 0.075000000000000], [   4 ,    5] )
    CASE( 4, 5 )
    !15-point
      Points = RESHAPE( [ 0.250000000000000, 0.250000000000000, 0.250000000000000, &
        & 0.030283678097089, 0.000000000000000, 0.333333333333333, 0.333333333333333, &
        & 0.006026785714286, 0.333333333333333, 0.333333333333333, 0.333333333333333, &
        & 0.006026785714286, 0.333333333333333, 0.333333333333333, 0.000000000000000, &
        & 0.006026785714286, 0.333333333333333, 0.000000000000000, 0.333333333333333, &
        & 0.006026785714286, 0.727272727272727, 0.090909090909091, 0.090909090909091, &
        & 0.011645249086029, 0.090909090909091, 0.090909090909091, 0.090909090909091, &
        & 0.011645249086029, 0.090909090909091, 0.090909090909091, 0.727272727272727, &
        & 0.011645249086029, 0.090909090909091, 0.727272727272727, 0.090909090909091, &
        & 0.011645249086029, 0.433449846426336, 0.066550153573664, 0.066550153573664, &
        & 0.010949141561386, 0.066550153573664, 0.433449846426336, 0.066550153573664, &
        & 0.010949141561386, 0.066550153573664, 0.066550153573664, 0.433449846426336, &
        & 0.010949141561386, 0.066550153573664, 0.433449846426336, 0.433449846426336, &
        & 0.010949141561386, 0.433449846426336, 0.066550153573664, 0.433449846426336, &
        & 0.010949141561386, 0.433449846426336, 0.433449846426336, 0.066550153573664, &
        & 0.010949141561386], [   4 ,   15] )
    CASE( 6 )
    !32-point
      Points = RESHAPE( [ 0.356191386222545, 0.214602871259152, 0.214602871259152, &
        & 0.006653791709695, 0.214602871259152, 0.214602871259152, 0.214602871259152, &
        & 0.006653791709695, 0.214602871259152, 0.214602871259152, 0.356191386222545, &
        & 0.006653791709695, 0.214602871259152, 0.356191386222545, 0.214602871259152, &
        & 0.006653791709695, 0.877978124396166, 0.040673958534611, 0.040673958534611, &
        & 0.001679535175887, 0.040673958534611, 0.040673958534611, 0.040673958534611, &
        & 0.001679535175887, 0.040673958534611, 0.040673958534611, 0.877978124396166, &
        & 0.001679535175887, 0.040673958534611, 0.877978124396166, 0.040673958534611, &
        & 0.001679535175887, 0.032986329573173, 0.322337890142276, 0.322337890142276, &
        & 0.009226196923942, 0.322337890142276, 0.322337890142276, 0.322337890142276, &
        & 0.009226196923942, 0.322337890142276, 0.322337890142276, 0.032986329573173, &
        & 0.009226196923942, 0.322337890142276, 0.032986329573173, 0.322337890142276, &
        & 0.009226196923942, 0.269672331458316, 0.063661001875017, 0.063661001875017, &
        & 0.008035714285714, 0.063661001875017, 0.269672331458316, 0.063661001875017, &
        & 0.008035714285714, 0.063661001875017, 0.063661001875017, 0.269672331458316, &
        & 0.008035714285714, 0.603005664791649, 0.063661001875017, 0.063661001875017, &
        & 0.008035714285714, 0.063661001875017, 0.603005664791649, 0.063661001875017, &
        & 0.008035714285714, 0.063661001875017, 0.063661001875017, 0.603005664791649, &
        & 0.008035714285714, 0.063661001875017, 0.269672331458316, 0.603005664791649, &
        & 0.008035714285714, 0.269672331458316, 0.603005664791649, 0.063661001875017, &
        & 0.008035714285714, 0.603005664791649, 0.063661001875017, 0.269672331458316, &
        & 0.008035714285714, 0.063661001875017, 0.603005664791649, 0.269672331458316, &
        & 0.008035714285714, 0.269672331458316, 0.063661001875017, 0.603005664791649, &
        & 0.008035714285714, 0.603005664791649, 0.269672331458316, 0.063661001875017, &
        & 0.008035714285714], [   4 ,   24] )
    CASE( 7 )
    !31-point
      Points = RESHAPE( [ 0.250000000000000, 0.250000000000000, 0.250000000000000, &
        & 0.018264223466109, 0.765360423009044, 0.078213192330319, 0.078213192330319, &
        & 0.010599941524414, 0.078213192330319, 0.078213192330319, 0.078213192330319, &
        & 0.010599941524414, 0.078213192330319, 0.078213192330319, 0.765360423009044, &
        & 0.010599941524414, 0.078213192330319, 0.765360423009044, 0.078213192330319, &
        & 0.010599941524414, 0.634470350008287, 0.121843216663904, 0.121843216663904, &
        & -0.062517740114330, 0.121843216663904, 0.121843216663904, 0.121843216663904, &
        & -0.062517740114330, 0.121843216663904, 0.121843216663904, 0.634470350008287,&
        & -0.062517740114330, 0.121843216663904, 0.634470350008287, 0.121843216663904, &
        &-0.062517740114330, 0.002382506660738, 0.332539164446421, 0.332539164446421, &
        & 0.004891425263074, 0.332539164446421, 0.332539164446421, 0.332539164446421, &
        & 0.004891425263074, 0.332539164446421, 0.332539164446421, 0.002382506660738, &
        & 0.004891425263074, 0.332539164446421, 0.002382506660738, 0.332539164446421, &
        & 0.004891425263074, 0.000000000000000, 0.500000000000000, 0.500000000000000, &
        & 0.000970017636684, 0.500000000000000, 0.000000000000000, 0.500000000000000, &
        & 0.000970017636684, 0.500000000000000, 0.500000000000000, 0.000000000000000, &
        & 0.000970017636684, 0.500000000000000, 0.000000000000000, 0.000000000000000, &
        & 0.000970017636684, 0.000000000000000, 0.500000000000000, 0.000000000000000, &
        & 0.000970017636684, 0.000000000000000, 0.000000000000000, 0.500000000000000, &
        & 0.000970017636684, 0.200000000000000, 0.100000000000000, 0.100000000000000, &
        & 0.027557319223985, 0.100000000000000, 0.200000000000000, 0.100000000000000, &
        & 0.027557319223985, 0.100000000000000, 0.100000000000000, 0.200000000000000, &
        & 0.027557319223985, 0.600000000000000, 0.100000000000000, 0.100000000000000, &
        & 0.027557319223985, 0.100000000000000, 0.600000000000000, 0.100000000000000, &
        & 0.027557319223985, 0.100000000000000, 0.100000000000000, 0.600000000000000, &
        & 0.027557319223985, 0.100000000000000, 0.200000000000000, 0.600000000000000, &
        & 0.027557319223985, 0.200000000000000, 0.600000000000000, 0.100000000000000, &
        & 0.027557319223985, 0.600000000000000, 0.100000000000000, 0.200000000000000, &
        & 0.027557319223985, 0.100000000000000, 0.600000000000000, 0.200000000000000, &
        & 0.027557319223985, 0.200000000000000, 0.100000000000000, 0.600000000000000, &
        & 0.027557319223985, 0.600000000000000, 0.200000000000000, 0.100000000000000, &
        & 0.027557319223985], [   4 ,   31] )
    CASE( 8 )
    !<- 45 point
      Points = RESHAPE( [ 0.250000000000000, 0.250000000000000, 0.250000000000000, &
        & -0.039327006641293, 0.617587190300083, 0.127470936566639, 0.127470936566639, &
        & 0.004081316059343, 0.127470936566639, 0.127470936566639, 0.127470936566639, &
        & 0.004081316059343, 0.127470936566639, 0.127470936566639, 0.617587190300083, &
        & 0.004081316059343, 0.127470936566639, 0.617587190300083, 0.127470936566639, &
        & 0.004081316059343, 0.903763508822103, 0.032078830392632, 0.032078830392632, &
        & 0.000658086773304, 0.032078830392632, 0.032078830392632, 0.032078830392632, &
        & 0.000658086773304, 0.032078830392632, 0.032078830392632, 0.903763508822103, &
        & 0.000658086773304, 0.032078830392632, 0.903763508822103, 0.032078830392632, &
        & 0.000658086773304, 0.450222904356719, 0.049777095643281, 0.049777095643281, &
        & 0.004384258825123, 0.049777095643281, 0.450222904356719, 0.049777095643281, &
        & 0.004384258825123, 0.049777095643281, 0.049777095643281, 0.450222904356719, &
        & 0.004384258825123, 0.049777095643281, 0.450222904356719, 0.450222904356719, &
        & 0.004384258825123, 0.450222904356719, 0.049777095643281, 0.450222904356719, &
        & 0.004384258825123, 0.450222904356719, 0.450222904356719, 0.049777095643281, &
        & 0.004384258825123, 0.316269552601450, 0.183730447398550, 0.183730447398550, &
        & 0.013830063842510, 0.183730447398550, 0.316269552601450, 0.183730447398550, &
        & 0.013830063842510, 0.183730447398550, 0.183730447398550, 0.316269552601450, &
        & 0.013830063842510, 0.183730447398550, 0.316269552601450, 0.316269552601450, &
        & 0.013830063842510, 0.316269552601450, 0.183730447398550, 0.316269552601450, &
        & 0.013830063842510, 0.316269552601450, 0.316269552601450, 0.183730447398550, &
        & 0.013830063842510, 0.022917787844817, 0.231901089397151, 0.231901089397151, &
        & 0.004240437424684, 0.231901089397151, 0.022917787844817, 0.231901089397151, &
        & 0.004240437424684, 0.231901089397151, 0.231901089397151, 0.022917787844817, &
        & 0.004240437424684, 0.513280033360881, 0.231901089397151, 0.231901089397151, &
        & 0.004240437424684, 0.231901089397151, 0.513280033360881, 0.231901089397151, &
        & 0.004240437424684, 0.231901089397151, 0.231901089397151, 0.513280033360881, &
        & 0.004240437424684, 0.231901089397151, 0.022917787844817, 0.513280033360881, &
        & 0.004240437424684, 0.022917787844817, 0.513280033360881, 0.231901089397151, &
        & 0.004240437424684, 0.513280033360881, 0.231901089397151, 0.022917787844817, &
        & 0.004240437424684, 0.231901089397151, 0.513280033360881, 0.022917787844817, &
        & 0.004240437424684, 0.022917787844817, 0.231901089397151, 0.513280033360881, &
        & 0.004240437424684, 0.513280033360881, 0.022917787844817, 0.231901089397151, &
        & 0.004240437424684, 0.730313427807538, 0.037970048471829, 0.037970048471829, &
        & 0.002238739739614, 0.037970048471829, 0.730313427807538, 0.037970048471829, &
        & 0.002238739739614, 0.037970048471829, 0.037970048471829, 0.730313427807538, &
        & 0.002238739739614, 0.193746475248804, 0.037970048471829, 0.037970048471829, &
        & 0.002238739739614, 0.037970048471829, 0.193746475248804, 0.037970048471829, &
        & 0.002238739739614, 0.037970048471829, 0.037970048471829, 0.193746475248804, &
        & 0.002238739739614, 0.037970048471829, 0.730313427807538, 0.193746475248804, &
        & 0.002238739739614, 0.730313427807538, 0.193746475248804, 0.037970048471829, &
        & 0.002238739739614, 0.193746475248804, 0.037970048471829, 0.730313427807538, &
        & 0.002238739739614, 0.037970048471829, 0.193746475248804, 0.730313427807538, &
        & 0.002238739739614, 0.730313427807538, 0.037970048471829, 0.193746475248804, &
        & 0.002238739739614, 0.193746475248804, 0.730313427807538, 0.037970048471829, &
        & 0.002238739739614], [   4 ,   45] )
  END SELECT
  CALL Initiate( obj, Points )
  DEALLOCATE( Points )
END PROCEDURE getGaussLegendreQPTetrahedron1

!----------------------------------------------------------------------------
!                                                                 Tetrahedron
!----------------------------------------------------------------------------

MODULE PROCEDURE getGaussLegendreQPTetrahedron2
  REAL( DFP ), ALLOCATABLE :: Points( :, : )
  SELECT CASE( NIPS( 1 ) )
    CASE( 1 )
      Points = RESHAPE( [ 0.250000000000000, 0.250000000000000, 0.250000000000000, &
      & 0.166666666666667], [   4 ,    1] )
    CASE( 4 )
      Points = RESHAPE( [ 0.585410196624969, 0.138196601125011, 0.138196601125011, &
        & 0.041666666666667, 0.138196601125011, 0.138196601125011, 0.138196601125011, &
        & 0.041666666666667, 0.138196601125011, 0.138196601125011, 0.585410196624969, &
        & 0.041666666666667, 0.138196601125011, 0.585410196624969, 0.138196601125011, &
        & 0.041666666666667], [   4 ,    4] )
    CASE( 5 )
      Points = RESHAPE( [ 0.250000000000000, 0.250000000000000, 0.250000000000000, &
        & -0.133333333333333, 0.500000000000000, 0.166666666666667, 0.166666666666667, &
        & 0.075000000000000, 0.166666666666667, 0.166666666666667, 0.166666666666667, &
        & 0.075000000000000, 0.166666666666667, 0.166666666666667, 0.500000000000000, &
        & 0.075000000000000, 0.166666666666667, 0.500000000000000, 0.166666666666667, &
        & 0.075000000000000], [   4 ,    5] )
    CASE( 10 )
      Points =  RESHAPE( [ 0.568430584196844, 0.143856471934385, 0.143856471934385, &
        & 0.036294178313401, 0.143856471934385, 0.143856471934385, 0.143856471934385, &
        & 0.036294178313401, 0.143856471934385, 0.143856471934385, 0.568430584196844, &
        & 0.036294178313401, 0.143856471934385, 0.568430584196844, 0.143856471934385, &
        & 0.036294178313401, 0.000000000000000, 0.500000000000000, 0.500000000000000, &
        & 0.003581658902177, 0.500000000000000, 0.000000000000000, 0.500000000000000, &
        & 0.003581658902177, 0.500000000000000, 0.500000000000000, 0.000000000000000, &
        & 0.003581658902177, 0.500000000000000, 0.000000000000000, 0.000000000000000, &
        & 0.003581658902177, 0.000000000000000, 0.500000000000000, 0.000000000000000, &
        & 0.003581658902177, 0.000000000000000, 0.000000000000000, 0.500000000000000, &
        & 0.003581658902177], [   4 ,   10] )

    CASE( 11 )
      Points =  RESHAPE( [ 0.250000000000000, 0.250000000000000, 0.250000000000000, &
        & -0.013155555555556, 0.785714285714286, 0.071428571428571, 0.071428571428571, &
        & 0.007622222222222, 0.071428571428571, 0.071428571428571, 0.071428571428571, &
        & 0.007622222222222, 0.071428571428571, 0.071428571428571, 0.785714285714286, &
        & 0.007622222222222, 0.071428571428571, 0.785714285714286, 0.071428571428571, &
        & 0.007622222222222, 0.100596423833201, 0.399403576166799, 0.399403576166799, &
        & 0.024888888888889, 0.399403576166799, 0.100596423833201, 0.399403576166799, &
        & 0.024888888888889, 0.399403576166799, 0.399403576166799, 0.100596423833201, &
        & 0.024888888888889, 0.399403576166799, 0.100596423833201, 0.100596423833201, &
        & 0.024888888888889, 0.100596423833201, 0.399403576166799, 0.100596423833201, &
        & 0.024888888888889, 0.100596423833201, 0.100596423833201, 0.399403576166799, &
        & 0.024888888888889], [   4 ,   11] )

    CASE( 14 )
      Points =  RESHAPE( [ 0.000000000000000, 0.500000000000000, 0.500000000000000, &
        & 0.003174603174603, 0.500000000000000, 0.000000000000000, 0.500000000000000, &
        & 0.003174603174603, 0.500000000000000, 0.500000000000000, 0.000000000000000, &
        & 0.003174603174603, 0.500000000000000, 0.000000000000000, 0.000000000000000, &
        & 0.003174603174603, 0.000000000000000, 0.500000000000000, 0.000000000000000, &
        & 0.003174603174603, 0.000000000000000, 0.000000000000000, 0.500000000000000, &
        & 0.003174603174603, 0.698419704324387, 0.100526765225204, 0.100526765225204, &
        & 0.014764970790497, 0.100526765225204, 0.100526765225204, 0.100526765225204, &
        & 0.014764970790497, 0.100526765225204, 0.100526765225204, 0.698419704324387, &
        & 0.014764970790497, 0.100526765225204, 0.698419704324387, 0.100526765225204, &
        & 0.014764970790497, 0.056881379520423, 0.314372873493192, 0.314372873493192, &
        & 0.022139791114265, 0.314372873493192, 0.314372873493192, 0.314372873493192, &
        & 0.022139791114265, 0.314372873493192, 0.314372873493192, 0.056881379520423, &
        & 0.022139791114265, 0.314372873493192, 0.056881379520423, 0.314372873493192, &
        & 0.022139791114265], [   4 ,   14] )

    CASE( 15 )
      Points =  RESHAPE( [ 0.250000000000000, 0.250000000000000, 0.250000000000000, &
        & 0.030283678097089, 0.000000000000000, 0.333333333333333, 0.333333333333333, &
        & 0.006026785714286, 0.333333333333333, 0.333333333333333, 0.333333333333333, &
        & 0.006026785714286, 0.333333333333333, 0.333333333333333, 0.000000000000000, &
        & 0.006026785714286, 0.333333333333333, 0.000000000000000, 0.333333333333333, &
        & 0.006026785714286, 0.727272727272727, 0.090909090909091, 0.090909090909091, &
        & 0.011645249086029, 0.090909090909091, 0.090909090909091, 0.090909090909091, &
        & 0.011645249086029, 0.090909090909091, 0.090909090909091, 0.727272727272727, &
        & 0.011645249086029, 0.090909090909091, 0.727272727272727, 0.090909090909091, &
        & 0.011645249086029, 0.433449846426336, 0.066550153573664, 0.066550153573664, &
        & 0.010949141561386, 0.066550153573664, 0.433449846426336, 0.066550153573664, &
        & 0.010949141561386, 0.066550153573664, 0.066550153573664, 0.433449846426336, &
        & 0.010949141561386, 0.066550153573664, 0.433449846426336, 0.433449846426336, &
        & 0.010949141561386, 0.433449846426336, 0.066550153573664, 0.433449846426336, &
        & 0.010949141561386, 0.433449846426336, 0.433449846426336, 0.066550153573664, &
        & 0.010949141561386], [   4 ,   15] )

    CASE( 24 )
      Points =  RESHAPE( [ 0.356191386222545, 0.214602871259152, 0.214602871259152, &
        & 0.006653791709695, 0.214602871259152, 0.214602871259152, 0.214602871259152, &
        & 0.006653791709695, 0.214602871259152, 0.214602871259152, 0.356191386222545, &
        & 0.006653791709695, 0.214602871259152, 0.356191386222545, 0.214602871259152, &
        & 0.006653791709695, 0.877978124396166, 0.040673958534611, 0.040673958534611, &
        & 0.001679535175887, 0.040673958534611, 0.040673958534611, 0.040673958534611, &
        & 0.001679535175887, 0.040673958534611, 0.040673958534611, 0.877978124396166, &
        & 0.001679535175887, 0.040673958534611, 0.877978124396166, 0.040673958534611, &
        & 0.001679535175887, 0.032986329573173, 0.322337890142276, 0.322337890142276, &
        & 0.009226196923942, 0.322337890142276, 0.322337890142276, 0.322337890142276, &
        & 0.009226196923942, 0.322337890142276, 0.322337890142276, 0.032986329573173, &
        & 0.009226196923942, 0.322337890142276, 0.032986329573173, 0.322337890142276, &
        & 0.009226196923942, 0.269672331458316, 0.063661001875017, 0.063661001875017, &
        & 0.008035714285714, 0.063661001875017, 0.269672331458316, 0.063661001875017, &
        & 0.008035714285714, 0.063661001875017, 0.063661001875017, 0.269672331458316, &
        & 0.008035714285714, 0.603005664791649, 0.063661001875017, 0.063661001875017, &
        & 0.008035714285714, 0.063661001875017, 0.603005664791649, 0.063661001875017, &
        & 0.008035714285714, 0.063661001875017, 0.063661001875017, 0.603005664791649, &
        & 0.008035714285714, 0.063661001875017, 0.269672331458316, 0.603005664791649, &
        & 0.008035714285714, 0.269672331458316, 0.603005664791649, 0.063661001875017, &
        & 0.008035714285714, 0.603005664791649, 0.063661001875017, 0.269672331458316, &
        & 0.008035714285714, 0.063661001875017, 0.603005664791649, 0.269672331458316, &
        & 0.008035714285714, 0.269672331458316, 0.063661001875017, 0.603005664791649, &
        & 0.008035714285714, 0.603005664791649, 0.269672331458316, 0.063661001875017, &
        & 0.008035714285714], [   4 ,   24] )

    CASE( 31 )
      Points =  RESHAPE( [ 0.250000000000000, 0.250000000000000, 0.250000000000000, &
        & 0.018264223466109, 0.765360423009044, 0.078213192330319, 0.078213192330319, &
        & 0.010599941524414, 0.078213192330319, 0.078213192330319, 0.078213192330319, &
        & 0.010599941524414, 0.078213192330319, 0.078213192330319, 0.765360423009044, &
        & 0.010599941524414, 0.078213192330319, 0.765360423009044, 0.078213192330319, &
        & 0.010599941524414, 0.634470350008287, 0.121843216663904, 0.121843216663904,&
        & -0.062517740114330, 0.121843216663904, 0.121843216663904, 0.121843216663904, &
        & -0.062517740114330, 0.121843216663904, 0.121843216663904, 0.634470350008287, &
        & -0.062517740114330, 0.121843216663904, 0.634470350008287, 0.121843216663904, &
        & -0.062517740114330, 0.002382506660738, 0.332539164446421, 0.332539164446421, &
        & 0.004891425263074, 0.332539164446421, 0.332539164446421, 0.332539164446421, &
        & 0.004891425263074, 0.332539164446421, 0.332539164446421, 0.002382506660738, &
        & 0.004891425263074, 0.332539164446421, 0.002382506660738, 0.332539164446421, &
        & 0.004891425263074, 0.000000000000000, 0.500000000000000, 0.500000000000000, &
        & 0.000970017636684, 0.500000000000000, 0.000000000000000, 0.500000000000000, &
        & 0.000970017636684, 0.500000000000000, 0.500000000000000, 0.000000000000000, &
        & 0.000970017636684, 0.500000000000000, 0.000000000000000, 0.000000000000000, &
        & 0.000970017636684, 0.000000000000000, 0.500000000000000, 0.000000000000000, &
        & 0.000970017636684, 0.000000000000000, 0.000000000000000, 0.500000000000000, &
        & 0.000970017636684, 0.200000000000000, 0.100000000000000, 0.100000000000000, &
        & 0.027557319223985, 0.100000000000000, 0.200000000000000, 0.100000000000000, &
        & 0.027557319223985, 0.100000000000000, 0.100000000000000, 0.200000000000000, &
        & 0.027557319223985, 0.600000000000000, 0.100000000000000, 0.100000000000000, &
        & 0.027557319223985, 0.100000000000000, 0.600000000000000, 0.100000000000000, &
        & 0.027557319223985, 0.100000000000000, 0.100000000000000, 0.600000000000000, &
        & 0.027557319223985, 0.100000000000000, 0.200000000000000, 0.600000000000000, &
        & 0.027557319223985, 0.200000000000000, 0.600000000000000, 0.100000000000000, &
        & 0.027557319223985, 0.600000000000000, 0.100000000000000, 0.200000000000000, &
        & 0.027557319223985, 0.100000000000000, 0.600000000000000, 0.200000000000000, &
        & 0.027557319223985, 0.200000000000000, 0.100000000000000, 0.600000000000000, &
        & 0.027557319223985, 0.600000000000000, 0.200000000000000, 0.100000000000000, &
        & 0.027557319223985], [   4 ,   31] )

    CASE( 45 )
      Points =  RESHAPE( [ 0.250000000000000, 0.250000000000000, 0.250000000000000, &
        & -0.039327006641293, 0.617587190300083, 0.127470936566639, 0.127470936566639, &
        & 0.004081316059343, 0.127470936566639, 0.127470936566639, 0.127470936566639, &
        & 0.004081316059343, 0.127470936566639, 0.127470936566639, 0.617587190300083, &
        & 0.004081316059343, 0.127470936566639, 0.617587190300083, 0.127470936566639, &
        & 0.004081316059343, 0.903763508822103, 0.032078830392632, 0.032078830392632, &
        & 0.000658086773304, 0.032078830392632, 0.032078830392632, 0.032078830392632, &
        & 0.000658086773304, 0.032078830392632, 0.032078830392632, 0.903763508822103, &
        & 0.000658086773304, 0.032078830392632, 0.903763508822103, 0.032078830392632, &
        & 0.000658086773304, 0.450222904356719, 0.049777095643281, 0.049777095643281, &
        & 0.004384258825123, 0.049777095643281, 0.450222904356719, 0.049777095643281, &
        & 0.004384258825123, 0.049777095643281, 0.049777095643281, 0.450222904356719, &
        & 0.004384258825123, 0.049777095643281, 0.450222904356719, 0.450222904356719, &
        & 0.004384258825123, 0.450222904356719, 0.049777095643281, 0.450222904356719, &
        & 0.004384258825123, 0.450222904356719, 0.450222904356719, 0.049777095643281, &
        & 0.004384258825123, 0.316269552601450, 0.183730447398550, 0.183730447398550, &
        & 0.013830063842510, 0.183730447398550, 0.316269552601450, 0.183730447398550, &
        & 0.013830063842510, 0.183730447398550, 0.183730447398550, 0.316269552601450, &
        & 0.013830063842510, 0.183730447398550, 0.316269552601450, 0.316269552601450, &
        & 0.013830063842510, 0.316269552601450, 0.183730447398550, 0.316269552601450, &
        & 0.013830063842510, 0.316269552601450, 0.316269552601450, 0.183730447398550, &
        & 0.013830063842510, 0.022917787844817, 0.231901089397151, 0.231901089397151, &
        & 0.004240437424684, 0.231901089397151, 0.022917787844817, 0.231901089397151, &
        & 0.004240437424684, 0.231901089397151, 0.231901089397151, 0.022917787844817, &
        & 0.004240437424684, 0.513280033360881, 0.231901089397151, 0.231901089397151, &
        & 0.004240437424684, 0.231901089397151, 0.513280033360881, 0.231901089397151, &
        & 0.004240437424684, 0.231901089397151, 0.231901089397151, 0.513280033360881, &
        & 0.004240437424684, 0.231901089397151, 0.022917787844817, 0.513280033360881, &
        & 0.004240437424684, 0.022917787844817, 0.513280033360881, 0.231901089397151, &
        & 0.004240437424684, 0.513280033360881, 0.231901089397151, 0.022917787844817, &
        & 0.004240437424684, 0.231901089397151, 0.513280033360881, 0.022917787844817, &
        & 0.004240437424684, 0.022917787844817, 0.231901089397151, 0.513280033360881, &
        & 0.004240437424684, 0.513280033360881, 0.022917787844817, 0.231901089397151, &
        & 0.004240437424684, 0.730313427807538, 0.037970048471829, 0.037970048471829, &
        & 0.002238739739614, 0.037970048471829, 0.730313427807538, 0.037970048471829, &
        & 0.002238739739614, 0.037970048471829, 0.037970048471829, 0.730313427807538, &
        & 0.002238739739614, 0.193746475248804, 0.037970048471829, 0.037970048471829, &
        & 0.002238739739614, 0.037970048471829, 0.193746475248804, 0.037970048471829, &
        & 0.002238739739614, 0.037970048471829, 0.037970048471829, 0.193746475248804, &
        & 0.002238739739614, 0.037970048471829, 0.730313427807538, 0.193746475248804, &
        & 0.002238739739614, 0.730313427807538, 0.193746475248804, 0.037970048471829, &
        & 0.002238739739614, 0.193746475248804, 0.037970048471829, 0.730313427807538, &
        & 0.002238739739614, 0.037970048471829, 0.193746475248804, 0.730313427807538, &
        & 0.002238739739614, 0.730313427807538, 0.037970048471829, 0.193746475248804, &
        & 0.002238739739614, 0.193746475248804, 0.730313427807538, 0.037970048471829, &
        & 0.002238739739614], [   4 ,   45] )
  END SELECT

  CALL Initiate( obj, Points )
  DEALLOCATE( Points )
END PROCEDURE getGaussLegendreQPTetrahedron2

END SUBMODULE