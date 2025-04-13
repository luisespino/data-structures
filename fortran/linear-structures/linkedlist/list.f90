program list
	use listdef
	implicit none
	type(linkedlist) :: l
	integer :: i
	do i = 1, 5, 1
		call l%add(i)
	end do
	call l%show()
end program list
