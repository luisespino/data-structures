module listdef
	implicit none
	type :: node
		integer :: value
		type(node), pointer :: next
	end type

	type :: linkedlist
		type(node), pointer :: head => null()
		contains
		procedure :: add
		procedure :: show
	end type

contains
subroutine add(this, value)
	class(linkedlist), intent(inout) :: this
	integer, intent(in) :: value
	type(node), pointer :: tmp
	allocate(tmp)
	tmp%value = value
	tmp%next => this%head
	this%head => tmp
end subroutine add

subroutine show(this)
	class(linkedlist), intent(inout) :: this
	type(node), pointer :: tmp 
	tmp => this%head
	do
		if( .not. associated(tmp)) then
			exit
		end if
		print *, tmp%value
		tmp => tmp%next
	end do
end subroutine show

end module listdef
