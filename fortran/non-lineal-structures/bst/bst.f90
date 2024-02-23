program bstree
	use bstdef
	implicit none
	type(bst) :: t	
	integer :: unit
    	character(len=100) :: filename
	filename = 'output.dot'
    	open(unit, file=filename, status='replace')	
	call t%add(25)
	call t%add(10)
	call t%add(35)
	call t%add(5)
	call t%add(20)
	call t%add(30)
	call t%add(40)
	
	print *, 'Preorder:'
	call t%preorder(t%root)
	print *, ''
	print *, 'Inorder:'
	call t%inorder(t%root)
	print *, ''
	print *, 'Postorder:'
	call t%postorder(t%root)
	print *, ''
	
    	print *, 'Generating Dot file...'
    	call t%dotgen(t%root, unit)
    	close(unit)
	print *, 'Dot file generated:', trim(filename)
	call execute_command_line('dot -Tsvg output.dot > output.svg')
	call execute_command_line('eog output.svg')
end program bstree
