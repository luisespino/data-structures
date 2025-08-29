module merklemodule
	implicit none

	integer :: uid = 1
	
	type datanode
		integer :: uid
		character(len = :), allocatable :: value
		type(datanode), pointer :: next => null()
	end type datanode
	
	type hashnode
		integer :: uid
		character(len = :), allocatable :: hash
		type(hashnode), pointer :: left => null()
		type(hashnode), pointer :: right => null()
		type(datanode), pointer :: dataref => null()
	end type hashnode
	
	type merkle
		type(hashnode), pointer :: tophash => null()
		type(datanode), pointer :: datahead => null()
		type(datanode), pointer :: datacoil => null()
		character (len = :), allocatable :: dot
		integer :: pos = 0
		contains
		procedure :: add
		procedure :: generate
		procedure :: createtree
		procedure :: genhash
		procedure :: datablock
		procedure :: datablocklen
		procedure :: xor8
		procedure :: show
		procedure :: showhash
		procedure :: dotgen
		procedure :: dotgenrec
	end type merkle

contains

subroutine add(this, value)
	class(merkle), intent(inout) :: this
	character(len = :), allocatable, intent(in) :: value
	type(datanode), pointer :: tmp
	allocate(tmp)
	allocate(tmp%value, source = value)
	tmp%uid = uid
	uid = uid + 1
	if (associated(this%datahead)) then
		this%datacoil%next => tmp
		this%datacoil => tmp
	else
		this%datahead => tmp
		this%datacoil => tmp
	end if
end subroutine add

subroutine generate(this)
	class(merkle), intent(inout) :: this
	integer :: expo = 1, i, pow
	character(len=:), allocatable :: value
	value = "empty"
	do while (2 ** expo < this%datablocklen())
		expo = expo + 1
	end do
	pow = 2 ** expo
	this%pos = pow
	i = this%datablocklen()
	do while (i < pow)
		call this%add(value)
		i = i + 1
	end do
	allocate(this%tophash)
	call this%createtree(this%tophash, expo)
	call this%genhash(this%tophash, pow)
end subroutine generate

recursive subroutine createtree(this, node, expo)
	class(merkle), intent(inout) :: this
	type(hashnode), pointer, intent(inout) :: node
	integer, intent(in) :: expo
	node%uid = uid
	uid = uid + 1
	if (expo > 0) then
		allocate(node%left)
		allocate(node%right)
		call this%createtree(node%left, expo - 1)
		call this%createtree(node%right, expo - 1)
	end if
end subroutine createtree

recursive subroutine genhash(this, node, pow)
	class(merkle), intent(inout) :: this
	type(hashnode), pointer, intent(inout) :: node
	integer, intent(in) :: pow
	integer :: tmp
	type(datanode), pointer :: link
	character(len = :), allocatable :: hash
	if (associated(node)) then
		call this%genhash(node%left, pow)
		call this%genhash(node%right, pow)
		if(.not. associated(node%left) .and. .not. associated(node%right)) then
			tmp = pow - this%pos
			node%dataref => this%datablock(tmp)
			this%pos = this%pos - 1
			hash = node%dataref%value
			node%hash = this%xor8(hash)
		else
			hash = adjustl(node%left%hash(1:len(node%left%hash)/2))//adjustl(node%right%hash(1:len(node%right%hash)/2))
			node%hash = this%xor8(hash)
		end if
	end if
end subroutine genhash

function datablock(this, pos) result(node)
	class(merkle), intent(inout) :: this
	integer, intent(inout) :: pos
	type(datanode), pointer :: node
	node => this%datahead
	do while (associated(node))
		if (pos == 0) then
			return
		end if
		pos = pos - 1
		node => node%next
	end do
end function datablock

function datablocklen(this) result(res)
	class(merkle), intent(inout) :: this
	type(datanode), pointer :: tmp
	integer :: res
	res = 0
	tmp => this%datahead
	do while (associated(tmp))
		res = res + 1
		tmp => tmp%next
	end do
end function datablocklen

function xor8(this, str) result(hash)
	class(merkle), intent(inout) :: this
    	character(len=:), allocatable, intent(in) :: str
    	character(len=8), allocatable :: hash
    	integer :: i, resultbyte
    	character(len=2) :: hexbyte
    	integer :: ascii_code
    	hash = "00000000"
	do i = 1, len(str)
		ascii_code = ichar(str(i:i))
		resultbyte = ieor(ascii_code, 8) 
        	write(hexbyte, '(Z2)') resultbyte
        	hash = trim(hexbyte)//trim(hash)        	
    	end do
end function xor8

subroutine show(this)
	class(merkle), intent(inout) :: this
	type(datanode), pointer :: tmp
	tmp => this%datahead
	do while (associated(tmp))
		print *, tmp%value
		tmp => tmp%next
	end do
end subroutine show

recursive subroutine showhash(this, tmp)
	class(merkle), intent(inout) :: this
	type(hashnode), pointer, intent(in) :: tmp
	!tmp => this%tophash
	if (associated(tmp)) then
		write (*, '(A)', advance='no') " ( "
		write (*, '(A)', advance='no') tmp%hash
		call this%showhash(tmp%left)
		call this%showhash(tmp%right)
		if (associated(tmp%dataref)) then
			write (*, '(A)', advance='no') "->"
			write (*, '(A)', advance='no') tmp%dataref%value
		end if
		write (*, '(A)', advance='no') " ) "
	end if
end subroutine showhash

subroutine dotgen(this, unit_)
   	class(merkle), intent(inout) :: this
    	integer, intent(in) :: unit_
	write(unit_, '(A)') 'graph{'
	call this%dotgenrec(this%tophash, unit_)
	write(unit_, '(A)') '}'
end subroutine dotgen

subroutine dotgenrec(this, tmp, unit_)
   	class(merkle), intent(inout) :: this
 	class(hashnode), intent(in), pointer :: tmp
    	integer, intent(in) :: unit_
	if (.not. associated(tmp)) then
        	return
    	end if
	write (unit_, '(A,I5,A,A,A)') ' ', tmp%uid, ' [label="', tmp%hash, '"];'
	if (associated(tmp%left)) then
        	write (unit_, '(A,I5,A,I5,A)') ' ', tmp%uid, ' -- ', tmp%left%uid, ';'
    	end if
	if (associated(tmp%right)) then
        	write (unit_, '(A,I5,A,I5,A)') ' ', tmp%uid, ' -- ', tmp%right%uid, ';'
    	end if
	call this%dotgenrec(tmp%left, unit_)
    	call this%dotgenrec(tmp%right, unit_)
	if (associated(tmp%dataref)) then
		write (unit_, '(A,I5,A,A,A)') ' ', tmp%dataref%uid, ' [label="', tmp%dataref%value, '" shape=rect];'
		write (unit_, '(A,I5,A,I5,A)') ' ', tmp%uid, ' -- ', tmp%dataref%uid, ';'
    	end if
end subroutine dotgenrec

end module merklemodule


program merkleprogram
	use merklemodule
	implicit none
	
	type(merkle) :: tree
	integer :: unit_
    	character(len=1024) :: filename
	character(len=:), allocatable :: value
    	filename = 'output.dot'
    	open(unit_, file=filename, status='replace')	

	value = "data1"
    	call tree%add(value)
    	value = "data2"
	call tree%add(value)
	value = "data3"
	call tree%add(value)
	!value = "data4"
	!call tree%add(value)
	!value = "data5"
	!call tree%add(value)
	
	call tree%generate()
	call tree%showhash(tree%tophash)
	print *, ""
	
	print *, 'Generating Dot file...'
    	call tree%dotgen(unit_)
    	close(unit_)
	print *, 'Dot file generated:', trim(filename)
	call execute_command_line('dot -Tsvg output.dot > output.svg')
	call execute_command_line('eog output.svg')

end program merkleprogram
