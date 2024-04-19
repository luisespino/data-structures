program traversal
	implicit none
	call breadth_traversal(1)
    	call depth_traversal(1)
    	call breadth_search(1, 5) 
    	call depth_search(1, 9)

contains

! return the node successors in hash table style
function successors(node) result(suc)
        integer, intent(in) :: node
        integer, dimension(:), allocatable :: suc
        if (node == 1) then
            	suc = [2, 4, 5]
        elseif (node == 2) then
            	suc = [1, 3, 4, 5, 6]
        elseif (node == 3) then
            	suc = [2, 5, 6]
        elseif (node == 4) then
            	suc = [1, 2, 5, 7, 8]
        elseif (node == 5) then
            	suc = [1, 2, 3, 4, 6, 7, 8, 9]
        elseif (node == 6) then
            	suc = [2, 3, 5, 8, 9]
        elseif (node == 7) then
            	suc = [4, 5, 8]
        elseif (node == 8) then
            	suc = [4, 5, 6, 7, 9]
        elseif (node == 9) then
            	suc = [5, 6, 8]
        else
        	suc = 0
        endif
end function successors

subroutine breadth_traversal(start_node)
        integer, intent(in) :: start_node
        integer, dimension(:), allocatable :: list, temp, visited
        integer :: n = 1, current_node, i
        list = [start_node]
        allocate(visited(0))
        do while (n > 0)
            	current_node = list(1)
            	list = list(2:)
            	visited = [visited, current_node]
		temp = successors(current_node)
            	do i = 1, size(temp)
    			if (all(visited /= temp(i)) &
    				.and. all(list /= temp(i))) then
        			list = [list, temp(i)]
    			endif
		end do
            	n = size(list)
        enddo
        write(*, '(A)', advance='no') "***** Breadth traversal: "
        do i = 1, size(visited)
    		write(*, '(I2)', advance='no') visited(i)
	end do
	print *, ""
end subroutine breadth_traversal

subroutine depth_traversal(start_node)
        integer, intent(in) :: start_node
        integer, dimension(:), allocatable :: list, temp, visited
        integer :: n = 1, current_node, i
        list = [start_node]
        allocate(visited(0))
        do while (n > 0)
            	current_node = list(1)
            	list = list(2:)
            	visited = [visited, current_node]
		temp = successors(current_node)
            	do i = 1, size(temp)
    			if (all(visited /= temp(i)) &
    				.and. all(list /= temp(i))) then
        			list = [temp(i), list]
        			exit
    			endif
		end do
            	n = size(list)
        enddo
        write(*, '(A)', advance='no') "***** Depth traversal: "
        do i = 1, size(visited)
    		write(*, '(I2)', advance='no') visited(i)
	end do
	print *, ""
end subroutine depth_traversal

subroutine breadth_search(start_node, end_node)
        integer, intent(in) :: start_node, end_node
        integer, dimension(:), allocatable :: list, temp
        integer :: n = 1, current_node, i
        list = [start_node]
        write(*, '(A, I0, A, I0)') "***** Breadth First Search: begin=", &
        	start_node, " end=", end_node
	do while (n > 0)
            	current_node = list(1)
            	list = list(2:)
            	write(*, '(A, I0)', advance='no') "pop: ", current_node
		if (current_node == end_node) then
                	print *, "FOUND"
                	return
            	endif
            	temp = successors(current_node)
            	write(*, '(A)', advance='no') " succesors: "
		do i = 1, size(temp)
    			write(*, '(I2)', advance='no') temp(i)
		end do
		print *, ""
		if (all(temp /= 0)) then
                	list = [list, temp]
            	endif
            	n = size(list)
        enddo
        print *, "NOT FOUND"
end subroutine breadth_search
    
subroutine depth_search(start_node, end_node)
        integer, intent(in) :: start_node, end_node
        integer, dimension(:), allocatable :: list, temp
        integer :: n = 1, current_node, i
        list = [start_node]
        write(*, '(A, I0, A, I0, A)') "***** Depth First Search: begin=", &
        	start_node, " end=", end_node, " (reversed list)"
        do while (n > 0)
            	current_node = list(1)
            	list = list(2:)
            	write(*, '(A, I0)', advance='no') "pop: ", current_node
		if (current_node == end_node) then
                	print *, "FOUND"
                	return
            	endif
            	temp = successors(current_node)
            	! reversed list
            	temp = temp(size(temp):1:-1)
            	write(*, '(A)', advance='no') " succesors: "
		do i = 1, size(temp)
    			write(*, '(I2)', advance='no') temp(i)
		end do
		print *, ""
		if (all(temp /= 0)) then
                	list = [temp, list]
            	endif
            	n = size(list)
        enddo
        print *, "NOT FOUND"
end subroutine depth_search    

end program traversal
