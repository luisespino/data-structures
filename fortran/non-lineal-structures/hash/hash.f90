module hash_module
    	implicit none

	type hash
		integer :: n ! elements
		integer :: m ! size table
		integer :: mini, maxi ! percentages
		integer, dimension(:), allocatable :: h ! table
	contains
		procedure :: init
		procedure :: division
		procedure :: linear
		procedure :: insert
		procedure :: rehashing
		procedure :: show
	end type hash

contains

subroutine init(this, m, mini, maxi)
	class(hash), intent(inout) :: this
        integer, intent(in) :: m, mini, maxi
        this%n = 0
        this%m = m
        this%mini = mini
        this%maxi = maxi
        if (allocated(this%h)) then
        	deallocate(this%h)
        end if
        allocate(this%h(m))
        this%h = -1
end subroutine init

integer function division(this, k)
	class(hash), intent(inout) :: this
        integer, intent(in) :: k
        division = mod(k, this%m)
end function division

integer function linear(this, k)
	class(hash), intent(inout) :: this
        integer, intent(in) :: k
        linear = mod(k + 1, this%m)
end function linear

subroutine insert(this, k)
	class(hash), intent(inout) :: this
        integer, intent(in) :: k
        integer :: i
        i = this%division(k)
        do while (this%h(i) /= -1)
            i = this%linear(i)
        end do
        this%h(i) = k
        this%n = this%n + 1
        call this%rehashing()
end subroutine insert

subroutine rehashing(this)
	class(hash), intent(inout) :: this
        integer :: i, mprev
        integer, dimension(:), allocatable :: temp
        if (this%n * 100 / this%m >= this%maxi) then
        	allocate(temp(this%m))
            	temp = this%h
            	call this%show()
            	mprev = this%m
            	this%m = this%n * 100 / this%mini
            	call this%init(this%m, this%mini, this%maxi)
            	do i = 1, mprev
                	if (temp(i) /= -1) then
                    		call this%insert(temp(i))
                	end if
            	end do
        else
            	call this%show()
        end if
end subroutine rehashing

subroutine show(this)
	class(hash), intent(inout) :: this
        integer :: i
        write (*, '(a)', advance='no') '['
        do i = 1, this%m
        	write (*, '(1I3)', advance='no') this%h(i)
        end do
        write(*, '(A, I0, A)') '] ', (this%n * 100 / this%m), '%'
end subroutine show

end module hash_module

program hash_main
	use hash_module
    	implicit none
    	integer :: m = 5 !size table
    	integer :: mini = 20, maxi = 80 ! min and max percentage
    	type(hash) :: h
    	call h%init(m, mini, maxi)
    	print *, 'Hash table with division method and linear probing'
    	print *, 'Initial size table: ', m
	print *, 'Minimum percentage: ', mini
	print *, 'Maximum percentage: ', maxi
    	call h%insert(5)
    	call h%insert(10)
    	call h%insert(15)
    	call h%insert(20)
    	call h%insert(25)
    	call h%insert(30)
    
end program hash_main
