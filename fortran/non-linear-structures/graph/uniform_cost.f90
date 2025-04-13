program uniform_cost_main
	implicit none
    	call uniform_cost(1, 6)
    
contains

function successors(node) result(suc)
	integer, intent(in), dimension(2) :: node
    	integer, dimension(:, :), allocatable :: suc
    	if (node(1) == 1) then
        	suc = reshape([2, 3, node(2)+5, node(2)+6],[2,2])
    	elseif (node(1) == 2) then
        	suc = reshape([1, 3, 4, node(2)+5, node(2)+6, &
        	node(2)+3], [3, 2])
    	elseif (node(1) == 3) then
        	suc = reshape([1, 2, 4, 5, node(2)+6, node(2)+6,  &
        	node(2)+5, node(2)+2], [4, 2])
    	elseif (node(1) == 4) then
        	suc = reshape([2, 3, 5, 6, node(2)+3, node(2)+5, &
        	node(2)+3, node(2)+4], [4, 2])
    	elseif (node(1) == 5) then
        	suc = reshape([3, 4, 6, node(2)+2, node(2)+3, &
        	node(2)+1], [3, 2])
   	elseif (node(1) == 6) then
        	suc = reshape([4, 5, node(2)+4, node(2)+1], [2, 2])
    	else
        	suc = 0
    	endif
end function successors
    
subroutine uniform_cost(start_node, end_node)
        integer, intent(in) :: start_node, end_node
        integer, dimension(:,:), allocatable :: list, temp
        integer, dimension(2) :: current_node
        integer :: n, i
        n = 1
        list = reshape([[start_node, 0]], [1, 2])
        write(*, '(A, I0, A, I0)') "***** Uniform Cost: begin=", &
        start_node, " end=", end_node
        
        do while (n > 0)
            	current_node(1) = list(1, 1)
            	current_node(2) = list(1, 2)
            	list = list(2:, :)
            	write(*, '(A, 2I2,A)', advance='no') "- pop(", &
            	current_node(:)," ) "
            
            	if (current_node(1) == end_node) then
                	print *, "FOUND"
                	return
            	endif
            
            	temp = successors(current_node)
            	write(*, '(A)', advance='no') "succesors: ["
            	do i = 1, size(temp, 1)
    			write(*, '(2I3A)', advance='no') temp(i, :), ","
		end do
           	write(*, '(A)', advance='no') " ]"
 
            	if (all(temp /= 0)) then
            		list = concatenate_matrices(list, temp)
	    		call sort(list)
	    	endif
	    
	    	print *, ""            
        	write(*, '(A)', advance='no') " list: ["
		do i = 1, size(list, 1)
    			write(*, '(2I3A)', advance='no') list(i, :), ","
		end do
		write(*, '(A)', advance='no') " ]"
		print *, ""            
            
            	n = size(list, 1)
        enddo
        print *, "NOT FOUND"
end subroutine uniform_cost

function concatenate_matrices(mat1, mat2) result(concatenated)
    	integer, dimension(:, :), intent(in) :: mat1, mat2
    	integer, dimension(:,:), allocatable :: concatenated
    
    	integer :: rows1, cols1, rows2, cols2
    	integer :: i, j
    
    	rows1 = size(mat1, 1)
    	cols1 = size(mat1, 2)
    	rows2 = size(mat2, 1)
    	cols2 = size(mat2, 2)
    
    	allocate(concatenated(rows1 + rows2, cols1))
    
    	do i = 1, rows1
        	do j = 1, cols1
            		concatenated(i, j) = mat1(i, j)
        	end do
    	end do
    
    	do i = 1, rows2
        	do j = 1, cols2
            		concatenated(rows1 + i, j) = mat2(i, j)
        	end do
    	end do
end function concatenate_matrices

subroutine sort(matrix)
    	integer, dimension(:, :), intent(inout) :: matrix
    	integer :: i, j, temp1, temp2
    
    	do i = 1, size(matrix, 1) - 1
        	do j = 1, size(matrix, 1) - i
            		if (matrix(j, 2) > matrix(j+1, 2)) then
                		temp1 = matrix(j, 1)
                		matrix(j, 1) = matrix(j+1, 1)
                		matrix(j+1, 1) = temp1
                
                		temp2 = matrix(j, 2)
                		matrix(j, 2) = matrix(j+1, 2)
                		matrix(j+1, 2) = temp2
            		end if
        	end do
    	end do
end subroutine sort

end program uniform_cost_main
