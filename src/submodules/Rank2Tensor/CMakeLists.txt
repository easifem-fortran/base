# This file is a part of easifem-base
# (c) 2021, Vikas Sharma, Ph.D.
# All right reserved
#
# log
# 4/03/2021 this file was created
#-----------------------------------------------------------------------

SET(src_path "${CMAKE_CURRENT_LIST_DIR}/src/")
TARGET_SOURCES(
  ${PROJECT_NAME} PRIVATE
  ${src_path}/Rank2Tensor_Method@ConstructorMethods.F90
  ${src_path}/Rank2Tensor_Method@IOMethods.F90
  ${src_path}/Rank2Tensor_Method@ContractionMethods.F90
  ${src_path}/Rank2Tensor_Method@InvarMethods.F90
  ${src_path}/Rank2Tensor_Method@OperatorMethods.F90
  ${src_path}/Rank2Tensor_Method@PullbackMethods.F90
  ${src_path}/Rank2Tensor_Method@PushForwardMethods.F90
)
