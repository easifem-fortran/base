module h5fortran
!! HDF5 object-oriented polymorphic interface
use, intrinsic :: iso_c_binding, only : c_ptr, c_loc
use, intrinsic :: iso_fortran_env, only : real32, real64, int64, int32, stderr=>error_unit
use hdf5, only : HID_T, SIZE_T, HSIZE_T, H5F_ACC_RDONLY_F, H5F_ACC_RDWR_F, H5F_ACC_TRUNC_F, &
  H5S_ALL_F, H5S_SELECT_SET_F, &
  H5T_NATIVE_DOUBLE, H5T_NATIVE_REAL, H5T_NATIVE_INTEGER, H5T_NATIVE_CHARACTER, &
  h5open_f, h5close_f, &
  h5dopen_f, h5dclose_f, h5dget_space_f, &
  h5gcreate_f, h5gclose_f, &
  h5fopen_f, h5fcreate_f, h5fclose_f, &
  h5lexists_f, &
  h5sclose_f, h5sselect_hyperslab_f, h5screate_simple_f, &
  h5get_libversion_f, h5eset_auto_f
use h5lt, only : h5ltget_dataset_ndims_f, h5ltget_dataset_info_f

use string_utils, only : toLower, strip_trailing_null, truncate_string_null

implicit none (type, external)
private
public :: hdf5_file, toLower, hdf_shape_check, hdf_get_slice, hdf_wrapup, hsize_t, strip_trailing_null, truncate_string_null, &
  check, h5write, h5read, h5exist

!> Workaround for Intel 19.1 / 2020 bug with /stand:f18
!> error #6410: This name has not been declared as an array or a function.   [RANK]
intrinsic :: rank

!> main type

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

type :: hdf5_file

character(:),allocatable  :: filename
integer(HID_T) :: lid=0, &   !< location ID
                  gid, &    !< group ID
                  glid   !< group location ID

integer :: comp_lvl = 0 !< compression level (1-9)  0: disable compression
logical :: verbose=.true., debug=.false.
integer :: libversion(3)  !< major, minor, rel

contains
!> initialize HDF5 file
procedure, public :: initialize => hdf_initialize, finalize => hdf_finalize, &
  write_group, writeattr, readattr => read_attr, &
  open => hdf_open_group, close => hdf_close_group, &
  shape => hdf_get_shape, layout => hdf_get_layout, chunks => hdf_get_chunk, &
  exist => hdf_check_exist, exists => hdf_check_exist, &
  is_contig => hdf_is_contig, is_chunked => hdf_is_chunked

!> write group or dataset integer/real
generic, public   :: write => &
  & hdf_write_scalar, hdf_write_1d, hdf_write_2d, hdf_write_3d, &
  & hdf_write_4d, hdf_write_5d, hdf_write_6d, hdf_write_7d

!> read dataset integer/real
generic, public   :: read => &
hdf_read_scalar, hdf_read_1d, hdf_read_2d, hdf_read_3d, &
  hdf_read_4d,hdf_read_5d, hdf_read_6d, hdf_read_7d

!> private methods
procedure,private :: hdf_write_scalar, hdf_write_1d, hdf_write_2d, hdf_write_3d, &
  hdf_write_4d, hdf_write_5d, hdf_write_6d, hdf_write_7d, &
hdf_read_scalar, hdf_read_1d, hdf_read_2d, hdf_read_3d, &
  hdf_read_4d, hdf_read_5d, hdf_read_6d, hdf_read_7d

end type hdf5_file

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

interface h5write
  procedure lt0write, lt1write, lt2write, lt3write, lt4write, lt5write, lt6write, lt7write
end interface h5write

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

interface h5read
  procedure lt0read, lt1read, lt2read, lt3read, lt4read, lt5read, lt6read, lt7read
end interface h5read

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

!> Submodules
interface

module logical function h5exist(filename, dname)
character(*), intent(in) :: filename, dname
end function h5exist

module subroutine lt0write(filename, dname, value, ierr)
character(*), intent(in) :: filename, dname
class(*), intent(in) :: value
integer, intent(out), optional :: ierr
end subroutine lt0write

module subroutine lt1write(filename, dname, value, ierr)
character(*), intent(in) :: filename, dname
class(*), intent(in) :: value(:)
integer, intent(out), optional :: ierr
end subroutine lt1write

module subroutine lt2write(filename, dname, value, ierr)
character(*), intent(in) :: filename, dname
class(*), intent(in) :: value(:,:)
integer, intent(out), optional :: ierr
end subroutine lt2write

module subroutine lt3write(filename, dname, value, ierr)
character(*), intent(in) :: filename, dname
class(*), intent(in) :: value(:,:,:)
integer, intent(out), optional :: ierr
end subroutine lt3write

module subroutine lt4write(filename, dname, value, ierr)
character(*), intent(in) :: filename, dname
class(*), intent(in) :: value(:,:,:,:)
integer, intent(out), optional :: ierr
end subroutine lt4write

module subroutine lt5write(filename, dname, value, ierr)
character(*), intent(in) :: filename, dname
class(*), intent(in) :: value(:,:,:,:,:)
integer, intent(out), optional :: ierr
end subroutine lt5write

module subroutine lt6write(filename, dname, value, ierr)
character(*), intent(in) :: filename, dname
class(*), intent(in) :: value(:,:,:,:,:,:)
integer, intent(out), optional :: ierr
end subroutine lt6write

module subroutine lt7write(filename, dname, value, ierr)
character(*), intent(in) :: filename, dname
class(*), intent(in) :: value(:,:,:,:,:,:,:)
integer, intent(out), optional :: ierr
end subroutine lt7write

module subroutine lt0read(filename, dname, value, ierr)
character(*), intent(in) :: filename, dname
class(*), intent(out) :: value
integer, intent(out), optional :: ierr
end subroutine lt0read

module subroutine lt1read(filename, dname, value, ierr)
character(*), intent(in) :: filename, dname
class(*), intent(out) :: value(:)
integer, intent(out), optional :: ierr
end subroutine lt1read

module subroutine lt2read(filename, dname, value, ierr)
character(*), intent(in) :: filename, dname
class(*), intent(out) :: value(:,:)
integer, intent(out), optional :: ierr
end subroutine lt2read

module subroutine lt3read(filename, dname, value, ierr)
character(*), intent(in) :: filename, dname
class(*), intent(out) :: value(:,:,:)
integer, intent(out), optional :: ierr
end subroutine lt3read

module subroutine lt4read(filename, dname, value, ierr)
character(*), intent(in) :: filename, dname
class(*), intent(out) :: value(:,:,:,:)
integer, intent(out), optional :: ierr
end subroutine lt4read

module subroutine lt5read(filename, dname, value, ierr)
character(*), intent(in) :: filename, dname
class(*), intent(out) :: value(:,:,:,:,:)
integer, intent(out), optional :: ierr
end subroutine lt5read

module subroutine lt6read(filename, dname, value, ierr)
character(*), intent(in) :: filename, dname
class(*), intent(out) :: value(:,:,:,:,:,:)
integer, intent(out), optional :: ierr
end subroutine lt6read

module subroutine lt7read(filename, dname, value, ierr)
character(*), intent(in) :: filename, dname
class(*), intent(out) :: value(:,:,:,:,:,:,:)
integer, intent(out), optional :: ierr
end subroutine lt7read

!----------------------------------------------------------------------------
!                                                               write@writer
!----------------------------------------------------------------------------

!> authors: Dr. Vikas Sharma
!
! This subroutine writes the scalar data which can be
! - Real64
! - Real32
! - Int32
! - String
! It is implemented in `writer` submodule

module subroutine hdf_write_scalar(self,dname,value, ierr)
  class(hdf5_file), intent(inout) :: self
  character(*), intent(in) :: dname
  class(*), intent(in) :: value
  integer, intent(out), optional :: ierr
end subroutine hdf_write_scalar

!----------------------------------------------------------------------------
!                                                               Write@Writer
!----------------------------------------------------------------------------

!> authors: Dr. Vikas Sharma
!
! This subroutine writes the 1D data which can be of following types
! - Real64
! - Real32
! - Int32
! - String
! It is implemented in `writer` submodule

module subroutine hdf_write_1d(self,dname,value, ierr)
  class(hdf5_file), intent(inout) :: self
  character(*), intent(in) :: dname
  class(*), intent(in) :: value(:)
  integer, intent(out), optional :: ierr
end subroutine hdf_write_1d

!----------------------------------------------------------------------------
!                                                               Write@writer
!----------------------------------------------------------------------------

module subroutine hdf_write_2d(self,dname,value, ierr, chunk_size)
  class(hdf5_file), intent(inout) :: self
  character(*), intent(in) :: dname
  class(*), intent(in) :: value(:,:)
  integer, intent(in), optional :: chunk_size(rank(value))
  integer, intent(out), optional :: ierr
end subroutine hdf_write_2d

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

module subroutine hdf_write_3d(self,dname,value, ierr, chunk_size)
  class(hdf5_file), intent(inout) :: self
  character(*), intent(in) :: dname
  class(*), intent(in) :: value(:,:,:)
  integer, intent(in), optional :: chunk_size(rank(value))
  integer, intent(out), optional :: ierr
end subroutine hdf_write_3d

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

module subroutine hdf_write_4d(self,dname,value, ierr, chunk_size)
  class(hdf5_file), intent(inout) :: self
  character(*), intent(in) :: dname
  class(*), intent(in) :: value(:,:,:,:)
  integer, intent(in), optional :: chunk_size(rank(value))
  integer, intent(out), optional :: ierr
end subroutine hdf_write_4d

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

module subroutine hdf_write_5d(self,dname,value, ierr, chunk_size)
  class(hdf5_file), intent(inout) :: self
  character(*), intent(in) :: dname
  class(*), intent(in) :: value(:,:,:,:,:)
  integer, intent(in), optional :: chunk_size(rank(value))
  integer, intent(out), optional :: ierr
end subroutine hdf_write_5d

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

module subroutine hdf_write_6d(self,dname,value, ierr, chunk_size)
  class(hdf5_file), intent(inout) :: self
  character(*), intent(in) :: dname
  class(*), intent(in) :: value(:,:,:,:,:,:)
  integer, intent(in), optional :: chunk_size(rank(value))
  integer, intent(out), optional :: ierr
end subroutine hdf_write_6d

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

module subroutine hdf_write_7d(self,dname,value, ierr, chunk_size)
  class(hdf5_file), intent(inout) :: self
  character(*), intent(in) :: dname
  class(*), intent(in) :: value(:,:,:,:,:,:,:)
  integer, intent(in), optional :: chunk_size(rank(value))
  integer, intent(out), optional :: ierr
end subroutine hdf_write_7d

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

module subroutine hdf_get_shape(self, dname, dims, ierr)
  class(hdf5_file), intent(in) :: self
  character(*), intent(in) :: dname
  integer(HSIZE_T), intent(out), allocatable :: dims(:)
  integer, intent(out), optional :: ierr
end subroutine hdf_get_shape

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

module integer function hdf_get_layout(self, dname) result(layout)
  !! H5D_CONTIGUOUS_F, H5D_CHUNKED_F, H5D_VIRTUAL_F, H5D_COMPACT_F
  class(hdf5_file), intent(in) :: self
  character(*), intent(in) :: dname
end function hdf_get_layout

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

module subroutine hdf_get_chunk(self, dname, chunk_size)
  class(hdf5_file), intent(in) :: self
  character(*), intent(in) :: dname
  integer(hsize_t), intent(out) :: chunk_size(:)
end subroutine hdf_get_chunk

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

module logical function hdf_check_exist(self, dname) result(exists)
  class(hdf5_file), intent(in) :: self
  character(*), intent(in) :: dname
end function hdf_check_exist

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

module logical function hdf_is_contig(self, dname)
  class(hdf5_file), intent(in) :: self
  character(*), intent(in) :: dname
end function hdf_is_contig

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

module logical function hdf_is_chunked(self, dname)
  class(hdf5_file), intent(in) :: self
  character(*), intent(in) :: dname
end function hdf_is_chunked
end interface

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

interface
module subroutine hdf_read_scalar(self, dname, value, ierr)
  class(hdf5_file), intent(in)     :: self
  character(*), intent(in)         :: dname
  class(*), intent(inout)      :: value
  integer, intent(out), optional :: ierr
end subroutine hdf_read_scalar
end interface

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

interface
module subroutine hdf_read_1d(self, dname, value, ierr, istart, iend, stride)
  class(hdf5_file), intent(in)     :: self
  character(*), intent(in)         :: dname
  class(*), intent(out) :: value(:)
  integer, intent(out), optional :: ierr
  integer, intent(in), optional, dimension(:) :: istart, iend, stride
end subroutine hdf_read_1d
end interface

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

interface
module subroutine hdf_read_2d(self, dname, value, ierr, istart, iend, stride)
  class(hdf5_file), intent(in)     :: self
  character(*), intent(in)         :: dname
  class(*), intent(out) :: value(:,:)
  integer, intent(out), optional :: ierr
  integer, intent(in), optional, dimension(:) :: istart, iend, stride
end subroutine hdf_read_2d
end interface

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

interface
module subroutine hdf_read_3d(self, dname, value, ierr, istart, iend, stride)
  class(hdf5_file), intent(in)     :: self
  character(*), intent(in)         :: dname
  class(*), intent(out) :: value(:,:,:)
  integer, intent(out), optional :: ierr
  integer, intent(in), optional, dimension(:) :: istart, iend, stride
end subroutine hdf_read_3d
end interface

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

interface
module subroutine hdf_read_4d(self, dname, value, ierr, istart, iend, stride)
  class(hdf5_file), intent(in)     :: self
  character(*), intent(in)         :: dname
  class(*), intent(out) :: value(:,:,:,:)
  integer, intent(out), optional :: ierr
  integer, intent(in), optional, dimension(:) :: istart, iend, stride
end subroutine hdf_read_4d
end interface

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

interface
module subroutine hdf_read_5d(self, dname, value, ierr, istart, iend, stride)
  class(hdf5_file), intent(in)     :: self
  character(*), intent(in)         :: dname
  class(*), intent(out) :: value(:,:,:,:,:)
  integer, intent(out), optional :: ierr
  integer, intent(in), optional, dimension(:) :: istart, iend, stride
end subroutine hdf_read_5d
end interface

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

interface
module subroutine hdf_read_6d(self, dname, value, ierr, istart, iend, stride)
  class(hdf5_file), intent(in)     :: self
  character(*), intent(in)         :: dname
  class(*), intent(out) :: value(:,:,:,:,:,:)
  integer, intent(out), optional :: ierr
  integer, intent(in), optional, dimension(:) :: istart, iend, stride
end subroutine hdf_read_6d
end interface

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

interface
module subroutine hdf_read_7d(self, dname, value, ierr, istart, iend, stride)
  class(hdf5_file), intent(in)     :: self
  character(*), intent(in)         :: dname
  class(*), intent(out) :: value(:,:,:,:,:,:,:)
  integer, intent(out), optional :: ierr
  integer, intent(in), optional, dimension(:) :: istart, iend, stride
end subroutine hdf_read_7d
end interface

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

interface
module subroutine hdf_open_group(self, gname, ierr)
  class(hdf5_file), intent(inout) :: self
  character(*), intent(in)        :: gname
  integer, intent(out), optional :: ierr
end subroutine hdf_open_group
end interface

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

interface
module subroutine hdf_close_group(self, ierr)
  class(hdf5_file), intent(inout) :: self
  integer, intent(out), optional :: ierr
end subroutine hdf_close_group
end interface

!----------------------------------------------------------------------------
!                                                            WriteAttr@Write
!----------------------------------------------------------------------------

interface
!! This subroutine writes the attributes

!> authors: Dr. Vikas Sharma
!
! This subroutine writes the attributes

module subroutine writeattr(self,dname,attr,attrval, ierr)
  class(hdf5_file), intent(in) :: self
  character(*), intent(in) :: dname
    !! Name of dataset
  character(*), intent(in) :: attr
    !! Name of attribute
  class(*), intent(in) :: attrval
    !! Value of attribute
  integer, intent(out), optional :: ierr
    !! Error code
end subroutine writeattr
end interface

!----------------------------------------------------------------------------
!                                                               readAttr@Read
!----------------------------------------------------------------------------

INTERFACE
MODULE SUBROUTINE read_attr( self, dname, attr, attrval, ierr )
  CLASS( hdf5_file ), INTENT( IN ) :: self
  CHARACTER(*), INTENT(IN) :: dname
    !! Name of dataset
  CHARACTER(*), INTENT(IN) :: attr
    !! Name of attribute
  class(*), INTENT(inout) :: attrval
    !! Value of attribute
  integer, INTENT(OUT), optional :: ierr
    !! Error code
END SUBROUTINE read_attr
END INTERFACE


contains

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

!> authors: Dr. Vikas Sharma
!
! This subroutine initialize the hdf5 file

subroutine hdf_initialize(self,filename,ierr, status,action,comp_lvl,&
  & verbose,debug)
  class(hdf5_file), intent(inout)    :: self
  character(*), intent(in)           :: filename
  integer, intent(out), optional :: ierr
  character(*), intent(in), optional :: status
    !! `old`, `new`,
  character(*), intent(in), optional :: action
  integer, intent(in), optional      :: comp_lvl
  logical, intent(in), optional      :: verbose, debug

  character(:), allocatable :: lstatus, laction
  logical :: exists
  integer :: ier

  self%filename = filename

  if (present(comp_lvl)) self%comp_lvl = comp_lvl
  if (present(verbose)) self%verbose = verbose
  if (present(debug)) self%debug = debug

  !> Initialize FORTRAN interface.
  call h5open_f(ier)
  if (check(ier, 'ERROR: HDF5 library initialize')) then
    if (present(ierr)) then
      ierr = ier
      return
    else
      error stop
    endif
  endif

  !> get library version
  call h5get_libversion_f(self%libversion(1), self%libversion(2), self%libversion(3), ier)
  if (self%debug) print '(A,3I3)', 'HDF5 version: ',self%libversion
  if (check(ier, 'ERROR: HDF5 library get version')) then
    if (present(ierr)) then
      ierr = ier
      return
    else
      error stop
    endif
  endif

  if(self%verbose) then
    call h5eset_auto_f(1, ier)
  else
    call h5eset_auto_f(0, ier)
  endif
  if (check(ier, 'ERROR: HDF5 library set traceback')) then
    if (present(ierr)) then
      ierr = ier
      return
    else
      error stop
    endif
  endif

  lstatus = 'unknown'
  if(present(status)) lstatus = toLower(status)

  laction = 'rw'
  if(present(action)) laction = toLower(action)

  select case(lstatus)
  case ('old', 'unknown')
    select case(laction)
      case('read','r')  !< Open an existing file.
        call h5fopen_f(filename,H5F_ACC_RDONLY_F,self%lid,ier)
      case('write','readwrite','w','rw', 'r+', 'append', 'a')
        inquire(file=filename, exist=exists)
        if(lstatus /= 'old' .and. .not.exists) then
          call h5fcreate_f(filename, H5F_ACC_TRUNC_F, self%lid, ier)
        else
          call h5fopen_f(filename, H5F_ACC_RDWR_F, self%lid, ier)
        endif
      case default
        write(stderr,*) 'Unsupported action -> ' // laction
        ier = 128
      endselect
  case('new','replace')
    call h5fcreate_f(filename, H5F_ACC_TRUNC_F, self%lid, ier)
  case default
    write(stderr,*) 'Unsupported status -> '// lstatus
    ier = 128
  end select

  if (present(ierr)) ierr = ier
  if (check(ier, 'ERROR:initialize ' // filename // ' could not be created')) then
    if (present(ierr)) return
    error stop
  endif

end subroutine hdf_initialize

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

!> authors: Dr. Vikas Sharma
!
! This subroutine closes the hdf5 file

subroutine hdf_finalize(self, ierr)

  class(hdf5_file), intent(inout) :: self
  integer, intent(out), optional :: ierr
  integer :: ier

  !> close hdf5 file
  call h5fclose_f(self%lid, ier)
  if (present(ierr)) ierr = ier
  if (check(ier, 'ERROR:finalize: HDF5 file close: ' // self%filename)) then
    if (present(ierr)) return
    error stop
  endif

  !>  Close Fortran interface.
  call h5close_f(ier)
  if (present(ierr)) ierr = ier
  if (check(ier, 'ERROR:finalize: HDF5 library close')) then
    if (present(ierr)) return
    error stop
  endif

  !> sentinel lid
  self%lid = 0

end subroutine hdf_finalize

!----------------------------------------------------------------------------
!                                                                 WriteGroup
!----------------------------------------------------------------------------

!> authors: Dr. Vikas Sharma
!
! This subroutine creates groups
! `gname` should be a relative path to group

subroutine write_group(self, gname, ierr)

  class(hdf5_file), intent(in) :: self
  character(*), intent(in) :: gname    !< relative path to group
  integer, intent(out), optional :: ierr

  integer(HID_T)  :: gid
  integer :: ier

  integer :: sp, ep, sl
  logical :: gexist

  sl = len(gname)
  sp = 1
  ep = 0

  do
    ep = index(gname(sp+1:sl), "/")

    ! no subgroup found
    if (ep == 0) exit

    ! check subgroup exists
    sp = sp + ep
    call h5lexists_f(self%lid, gname(1:sp-1), gexist, ier)
    if (present(ierr)) ierr = ier
    if (check(ier, 'ERROR: did not find group ' // gname // ' in ' // self%filename)) then
        if (present(ierr)) return
        error stop
    endif

    if(.not.gexist) then
      call h5gcreate_f(self%lid, gname(1:sp-1), gid, ier)
      if (present(ierr)) ierr = ier
      if (check(ier, 'ERROR: creating group ' // gname // ' in ' // self%filename)) then
        if (present(ierr)) return
        error stop
      endif

      call h5gclose_f(gid, ier)
      if (present(ierr)) ierr = ier
      if (check(ier, 'ERROR: closing group ' // gname // ' in ' // self%filename)) then
        if (present(ierr)) return
        error stop
      endif
    endif
  end do

end subroutine write_group

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

logical function check(ierr, msg)
  integer, intent(in) :: ierr
  character(*), intent(in) :: msg

  check = ierr /= 0
  if (.not.check) return

  write(stderr, *) msg

end function check

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

subroutine hdf_wrapup(did, sid, ierr)
  integer(HID_T), intent(in) :: sid, did
  integer, intent(out) :: ierr

  if(sid /= 0) then
    call h5sclose_f(sid, ierr)
    if (check(ierr, 'ERROR:h5sclose dataspace')) return
  endif

  call h5dclose_f(did, ierr)
  if (check(ierr, 'ERROR:h5dclose dataset')) return

end subroutine hdf_wrapup

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

subroutine hdf_get_slice(self, dname, did, sid, mem_sid, ierr, i0, i1, i2)
  !! setup array slices for read and write
  class(hdf5_file), intent(in) :: self
  character(*), intent(in) :: dname
  integer(hid_t), intent(out) :: sid, did, mem_sid
  integer, intent(out) :: ierr
  class(*), intent(in), dimension(:) :: i0, i1
  class(*), intent(in), optional, dimension(:) :: i2

  integer(hsize_t), dimension(size(i0)) :: istart, iend, stride, mem_dims
  integer :: mem_rank

  !! istart
  select type (i0)
  type is (integer(int32))
    istart = int(i0, int64)
  type is (integer(hsize_t))
    istart = i0
  class default
    ierr = -1
    write(stderr,*) 'ERROR: wrong integer type for istart: ', dname, self%filename
    return
  end select

  !! iend

  select type (i1)
  type is (integer(int32))
    iend = int(i1, int64)
  type is (integer(hsize_t))
    iend = i1
  class default
    ierr = -1
    write(stderr,*) 'ERROR: wrong integer type for iend: ', dname, self%filename
    return
  end select

  !! stride

  if (present(i2)) then
    select type (i2)
    type is (integer(int32))
      stride = int(i2, int64)
    type is (integer(hsize_t))
      stride = i2
    class default
      ierr = -1
      write(stderr,*) 'ERROR: wrong integer type for stride: ', dname, self%filename
      return
    end select
    if(self%debug) print *,'DEBUG: user-stride:',stride
  else
    stride = 1
    if(self%debug) print *, 'DEBUG: auto-stride',stride
  endif

  !! compensate for 0-based hyperslab vs. 1-based Fortran
  istart = istart - 1

  mem_dims = iend - istart
  mem_rank = size(mem_dims)


  call h5dopen_f(self%lid, dname, did, ierr)

  if(ierr == 0) call h5dget_space_f(did, sid, ierr)

  if(ierr == 0) call h5sselect_hyperslab_f(sid, H5S_SELECT_SET_F, istart, mem_dims, ierr, stride=stride)

  if(ierr == 0) call h5screate_simple_f(mem_rank, mem_dims, mem_sid, ierr)

  if (ierr /= 0) then
    write(stderr,*) 'ERROR:get_slice:', dname, self%filename
    return
  endif

end subroutine hdf_get_slice

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

subroutine hdf_shape_check(self, dname, dims, ierr)
  class(hdf5_file), intent(in) :: self
  character(*), intent(in) :: dname
  integer(HSIZE_T), intent(in) :: dims(:)
  integer, intent(out) :: ierr

  integer(SIZE_T) :: dsize
  integer(HSIZE_T) :: ddims(size(dims))
  integer :: dtype, drank

  if (.not.self%exist(dname)) then
    write(stderr,*) 'ERROR: ' // dname // ' does not exist in ' // self%filename
    ierr = -1
    return
  endif

  !> check for matching rank, else bad reads can occur--doesn't always crash without this check
  call h5ltget_dataset_ndims_f(self%lid, dname, drank, ierr)
  if (check(ierr, 'ERROR: get_dataset_ndim ' // dname // ' read ' // self%filename)) return

  if (drank /= size(dims)) then
    write(stderr,'(A,I6,A,I6)') 'ERROR: rank mismatch ' // dname // ' = ',drank,'  variable rank =', size(dims)
    ierr = -1
    return
  endif

  !> check for matching size, else bad reads can occur.

  call h5ltget_dataset_info_f(self%lid, dname, ddims, dtype, dsize, ierr)
  if (check(ierr, 'ERROR: get_dataset_info ' // dname // ' read ' // self%filename)) return

  if(.not. all(dims == ddims)) then
    write(stderr,*) 'ERROR: shape mismatch ' // dname // ' = ',ddims,'  variable shape =', dims
    ierr = -1
    return
  endif

end subroutine hdf_shape_check

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------
end module h5fortran
