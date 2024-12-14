module parser
    implicit none

    type :: attr
        character(len=:), allocatable :: in
        character(len=:), allocatable :: out
    end type attr

contains

function parse(str) result(res)
    character(len=:), intent(in), allocatable :: str
    type(attr) :: tmp
    character(len=:), allocatable :: res
    tmp%in = str
    tmp%out = ""
    tmp = s(tmp)
    res = tmp%out
end function parse

! s = e
recursive function s(tmp) result(res)
    type(attr), intent(in) :: tmp
    type(attr) :: res
    res = e(tmp)
end function s

! e = t '+' e 
!   / t
recursive function e(tmp) result(res)
    type(attr), intent(in) :: tmp
    type(attr) :: t1, e1, res
    integer :: tn, en, i, len
    character(10) :: str
    t1 = t(tmp)
    if (t1%in(1:1) == '+') then
        t1%in = t1%in(2:)
        e1 = e(t1)
        res%in = e1%in
        tn = iachar(t1%out(1:1)) - ichar('0')
        en = iachar(e1%out(1:1)) - ichar('0')
        i = tn + en
        len = 0
        do while (i /= 0)
            len = len + 1
            str(len:len) = achar(modulo(i, 10) + ichar('0'))
            i = i / 10
        end do
        str = adjustl(str(1:len))        
        res%out = str
        return
    end if
    res = t(tmp)
end function e

! t = f '*' t
!   / f
recursive function t(tmp) result(res)
    type(attr), intent(in) :: tmp
    type(attr) :: f1, t1, res
    integer :: fn, tn, i, len
    character(10) :: str
    f1 = f(tmp)
    if (f1%in(1:1) == '*') then
        f1%in = f1%in(2:)
        t1 = t(f1)
        res%in = t1%in
        fn = iachar(f1%out(1:1)) - ichar('0')
        tn = iachar(t1%out(1:1)) - ichar('0')
        i = fn * tn
        len = 0
        do while (i /= 0)
            len = len + 1
            str(len:len) = achar(modulo(i, 10) + ichar('0'))
            i = i / 10
        end do
        str = adjustl(str(1:len))        
        res%out = str
        return
    end if
    res = f(tmp)
end function t

! f = [0..9]
recursive function f(tmp) result(res)
    type(attr), intent(in) :: tmp
    type(attr) :: f1, res
    integer :: num
    f1%in = tmp%in
    f1%out = tmp%out
    if (f1%in(1:1) >= '0' .and. f1%in(1:1) <= '9') then
        res%out = f1%in(1:1)
        f1%in = f1%in(2:)
        res%in = f1%in
        return
    end if
end function f

end module parser

program main
    use parser
    implicit none
    character(len=:), allocatable :: in, out


    ! Ciclo para ingresar varias expresiones
    do
        allocate(character(len=100) :: in)
        ! Solicitar al usuario que ingrese una expresión
        print *, "Ingrese una expresión (o 'exit' para terminar):"
        
        read (*,*) in

        ! Si el usuario ingresa 'exit', terminar el ciclo
        if (in == 'exit') then
            print *, "Saliendo del programa..."
            exit
        end if

        ! Llamar a la función parse con la expresión ingresada
        out = parse(in)

        ! Imprimir el resultado
        print *, "Resultado: ", out
        deallocate(in, out)
    end do
    
end program main

