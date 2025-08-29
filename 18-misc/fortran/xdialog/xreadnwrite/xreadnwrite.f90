program xreadnwrite
    implicit none
    character(len=100) :: user_input
    integer :: iunit, ios
    logical :: exists

    call system("Xdialog --inputbox 'Enter your name' 8 40 2>/tmp/user_input.txt")

    open(unit=iunit, file='/tmp/user_input.txt', status='old', action='read')

    read(iunit, '(A)', iostat=ios) user_input
    if (ios == -1) then
        print *, "Canceled"
        close(iunit)
        stop
    end if
    close(iunit)

    open(unit=iunit, file="output.txt", status='replace', action='write')
    write(iunit, '(A)') "Your name is: " // trim(adjustl(user_input))
    close(iunit)

    print *, "Your name is: ", user_input

end program xreadnwrite