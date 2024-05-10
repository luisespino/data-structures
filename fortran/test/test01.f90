module m
	implicit none
		
	type tnode
		integer :: i
		character :: c
		integer :: f
		type(tnode), pointer :: left => null()
		type(tnode), pointer :: right => null()
	end type tnode
	
	type lnode
		type(tnode), pointer :: root => null()
		type(lnode), pointer :: next => null()
	end type lnode
	
	type list
		type(lnode), pointer :: head => null()
	contains
		procedure :: init
		procedure :: lineup
		procedure :: print_list
		procedure :: create
		procedure :: print_code
		procedure :: print_code_rec
		procedure :: traversal
	end type list
	
contains

subroutine init(this, input, num)
	class(list), intent(inout) :: this
	character(len=:), allocatable, intent(in) :: input
	integer, intent(inout) :: num(128)
	type(lnode), pointer :: tmp
	integer :: i
	do i = 1, len(input)
        	num(ichar(input(i:i))) = num(ichar(input(i:i))) + 1
    	end do
    	do i = ichar('~'), ichar(' '), -1  
    		if (num(i) > 0) then
    			allocate(tmp)
    			allocate(tmp%root)
    			allocate(tmp%next)
    			tmp%root%i = i
    			tmp%root%c = ''
    			tmp%root%f = num(i)
    			tmp%root%left => null()
    			tmp%root%right => null()
    			tmp%next => this%head
    			this%head => tmp
        	end if
    	end do
end subroutine init

subroutine lineup(this)
    	class(list), intent(inout) :: this
    	type(lnode), pointer :: current, next_node
    	type(tnode), pointer :: temp
    	logical :: swapped
    	integer :: size, i

    	current => this%head
    	size = 0
    	do while (associated(current))
        	size = size + 1
        	current => current%next
    	end do

    	if (size <= 1) return
    
    	swapped = .true.
    	do i = 1, size - 1
        	current => this%head
        	next_node => current%next
        	swapped = .false.
        	do while (associated(next_node))
            		if (current%root%f > next_node%root%f) then
                		temp => current%root
                		current%root => next_node%root
                		next_node%root => temp
                		swapped = .true.
            		end if
            		current => next_node
            		next_node => next_node%next
        	end do
        	if (.not. swapped) exit 
    	end do
end subroutine lineup

subroutine print_list(this)
    	class(list), intent(in) :: this
    	type(lnode), pointer :: tmp
    
    	tmp => this%head
    	do while (associated(tmp))
        	print "( A1, ' : ', I2)", char(tmp%root%i), tmp%root%f
        	tmp => tmp%next
    	end do
end subroutine print_list

subroutine create(this)
	class(list), intent(inout) :: this
	type(tnode), pointer :: left, right
	type(lnode), pointer :: tmp
	do while(associated(this%head%next))
		left => this%head%root
		left%c = '0'
		this%head => this%head%next
		right => this%head%root
		right%c = '1'
		this%head => this%head%next
		allocate(tmp)
		allocate(tmp%root)
		allocate(tmp%next)
		tmp%root%i = 0
		tmp%root%c = ''
		tmp%root%f = left%f + right%f
		tmp%root%left => left
		tmp%root%right => right
		tmp%next => this%head
		this%head => tmp
		call this%lineup()
	end do
end subroutine create

subroutine print_code(this, num)
	class(list), intent(inout) :: this
	integer, intent(in) :: num(128)
	character(len=:), allocatable :: code
	integer :: i
	do i = ichar(' '), ichar('~')  
    		if (num(i) > 0) then
    			code = ""
    			call this%print_code_rec(this%head%root, i, code)
    			print "( A1, ' : ', A8)", char(i), code
    		end if
    	end do	
end subroutine print_code

recursive subroutine print_code_rec(this, root, i, code)
    	class(list), intent(inout) :: this
    	type(tnode), pointer, intent(in) :: root
    	integer, intent(in) :: i
    	character(len=:), allocatable, intent(inout) :: code
    	character(len=:), allocatable :: test
    
    	if (associated(root)) then
        	if (root%i == i) then
            		code = root%c 
            		return
        	end if        
        	test = code
        	if (associated(root%left)) then
            		call this%print_code_rec(root%left, i, code)
            		if (len(code)>0) code = root%c // code
        	end if     
		if (test == code) then
        		if (associated(root%right)) then
            			call this%print_code_rec(root%right, i, code)
            			if (len(code)>0) code = root%c // code
        		end if
        	end if
    	end if
end subroutine print_code_rec

recursive subroutine traversal(this, root)
	class(list), intent(inout) :: this
	type(tnode), pointer, intent(in) :: root
	if (associated(root)) then
		print "( I2, ' : ', I2, ' : ', A1)", root%i, root%f, root%c
		call this%traversal(root%left)
		call this%traversal(root%right)
	endif
end subroutine traversal

end module m

program p
	use m
	implicit none
	
	integer :: num(128), i
	character(len=:), allocatable :: input
	type(list) :: l
	
	input = "AABCBCBDEBBA"
	num = 0
	print *, "*** INPUT ***"
	call l%init(input, num)
	call l%print_list()
	print *, "*** LINEUP ***"
	call l%lineup()
	call l%print_list()
	print *, "*** CODE ***"
	call l%create()
	call l%print_code(num)
	print *, "*** TRAVERSAL ***"
	call l%traversal(l%head%root)
	
end program p
