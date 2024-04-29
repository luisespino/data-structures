! Longest Path
! Uniform cost variant for maximization
! Requirements: be a directional graph and
!               not have cycles.
! 		(Directed Acyclic Graph DAG)

program longest_path_main
	implicit none
    	call uniform_cost(1, 6)
    
contains

function successors(node) result(suc)
	integer, intent(in), dimension(2) :: node
    	integer, dimension(:, :), allocatable :: suc
    	if (node(1) == 1) then
        	suc = reshape([2, 3, node(2)+5, node(2)+3],[2,2])
    	elseif (node(1) == 2) then
        	suc = reshape([4, node(2)+3], [1, 2])
    	elseif (node(1) == 3) then
        	suc = reshape([4, 5, node(2)+2, node(2)+2], [2, 2])
    	elseif (node(1) == 4) then
        	suc = reshape([6, node(2)+4], [1, 2])
    	elseif (node(1) == 5) then
        	suc = reshape([6, node(2)+9], [1, 2])
   	else
        	allocate(suc(0,0))
    	endif
end function successors
    
subroutine uniform_cost(start_node, end_node)
        integer, intent(in) :: start_node, end_node
        integer, dimension(:,:), allocatable :: list, temp
        integer, dimension(2) :: current_node
        integer :: n, i, longest, path, path_count
        n = 1
        longest = 0
        path = 0
        path_count = 0
        list = reshape([[start_node, 0]], [1, 2])
        write(*, '(A, I0, A, I0)') "***** Longest path: begin=", &
        start_node, " end=", end_node
        
        do while (n > 0)
            	current_node(1) = list(1, 1)
            	current_node(2) = list(1, 2)
            	list = list(2:, :)
            	write(*, '(A, 2I3,A)', advance='no') "- pop(", &
            	current_node(:)," ) "
            
            	if (current_node(1) == end_node) then
            		path_count = path_count + 1
            		if (current_node(2) > longest) then
            			longest = current_node(2)
            			path = path_count
            		endif
                	write(*, '(A,I1)', advance='no') &
                		"FOUND path #", path_count
            	endif
            
            	temp = successors(current_node)
            	if (ANY(temp /= 0)) then
            		write(*, '(A)', advance='no') "succesors: ["
            		do i = 1, size(temp, 1)
    				write(*, '(2I3A)', advance='no') temp(i, :), ","
			end do
           		write(*, '(A)', advance='no') " ]"
 
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
        write (*, '(A,I1,A,I2)') "** The longest path found is #", path," with longest value ", longest
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
            		if (matrix(j, 2) < matrix(j+1, 2)) then
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

end program longest_path_main
