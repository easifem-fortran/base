!! conceptual--not tested
submodule (h5fortran:write) writer_ND

implicit none

contains

module procedure hdf_write_8d

integer(HID_T)  :: dtype, sid, did
integer(HSIZE_T) :: dims(rank(value))
integer :: i(rank(value))
TYPE(C_PTR) :: f_ptr

select type (value)
type is (real(real64))
  dims = shape(value)
  dtype = h5kind_to_type(kind(value),H5_REAL_KIND)
  call hdf_setup_write(self,dname,dtype,dims,sid,did, ierr)
  if (ierr /= 0) return
  i = lbound(value)
  f_ptr = c_loc(value(i(1),i(2),i(3),i(4),i(5),i(6),i(7),i(8)))
  call h5dwrite_f(did, dtype, f_ptr, ierr)
type is (real(real32))
  dtype = h5kind_to_type(kind(value),H5_REAL_KIND)
  dims = shape(value)
  call hdf_setup_write(self,dname,dtype,dims,sid,did, ierr)
  if (ierr /= 0) return
  i = lbound(value)
  f_ptr = c_loc(value(i(1),i(2),i(3),i(4),i(5),i(6),i(7),i(8)))
  call h5dwrite_f(did, dtype, f_ptr, ierr)
type is (integer(int32))
  dtype = h5kind_to_type(kind(value),H5_INTEGER_KIND)
  dims = shape(value)
  call hdf_setup_write(self,dname,dtype,dims,sid,did, ierr)
  if (ierr /= 0) return
  i = lbound(value)
  f_ptr = c_loc(value(i(1),i(2),i(3),i(4),i(5),i(6),i(7),i(8)))
  call h5dwrite_f(did, dtype, f_ptr, ierr)
type is (integer(int64))
  dtype = h5kind_to_type(kind(value),H5_INTEGER_KIND)
  dims = shape(value)
  call hdf_setup_write(self,dname,dtype,dims,sid,did, ierr)
  if (ierr /= 0) return
  i = lbound(value)
  f_ptr = c_loc(value(i(1),i(2),i(3),i(4),i(5),i(6),i(7),i(8)))
  call h5dwrite_f(did, dtype, f_ptr, ierr)
class default
  write(stderr,*) 'ERROR: ' // dname // ' datatype is not handled yet by h5fortran.'
  ierr = -1
end select

call hdf_wrapup(did, sid, ierr)
if (check(ierr, 'ERROR: ' // dname // ' write ' // self%filename))  return

end procedure hdf_write_8d

end submodule writer_ND