! SHA256
! Author: Mikael Leetmaa 2014 under zlib License
! Modifications: Luis Espino 2024

module sha256_module
	use iso_c_binding
  	implicit none  	
contains

function sha256(str)
	character(len=64) :: sha256
      	character(len=*), intent(in) :: str
      	sha256 = sha256b(str, 1)
end function sha256

function dirty_sha256(str)
      	character(len=64) :: dirty_sha256
      	character(len=*), intent(in) :: str
      	dirty_sha256 = sha256b(str, 0)
end function dirty_sha256

function sha256b(str, swap)
      	character(len=64) :: sha256b
      	character(len=*), intent(in) :: str
      	integer, intent(in) :: swap
      	integer(kind=c_int64_t) :: length
      	integer(kind=c_int32_t) :: temp1, temp2, i
      	integer :: break, pos0
      	integer(kind=c_int32_t) :: h0_ref(8), k0_ref(64)
      	integer(kind=c_int32_t) :: h0(8), k0(64), a0(8), w0(64)
      	data (h0_ref(i),i=1,8)/&
           & z'6a09e667', z'bb67ae85', z'3c6ef372', z'a54ff53a', z'510e527f', z'9b05688c', z'1f83d9ab', z'5be0cd19'/
      	data (k0_ref(i), i=1,64)/&
           & z'428a2f98', z'71374491', z'b5c0fbcf', z'e9b5dba5', z'3956c25b', z'59f111f1', z'923f82a4', z'ab1c5ed5',&
           & z'd807aa98', z'12835b01', z'243185be', z'550c7dc3', z'72be5d74', z'80deb1fe', z'9bdc06a7', z'c19bf174',&
           & z'e49b69c1', z'efbe4786', z'0fc19dc6', z'240ca1cc', z'2de92c6f', z'4a7484aa', z'5cb0a9dc', z'76f988da',&
           & z'983e5152', z'a831c66d', z'b00327c8', z'bf597fc7', z'c6e00bf3', z'd5a79147', z'06ca6351', z'14292967',&
           & z'27b70a85', z'2e1b2138', z'4d2c6dfc', z'53380d13', z'650a7354', z'766a0abb', z'81c2c92e', z'92722c85',&
           & z'a2bfe8a1', z'a81a664b', z'c24b8b70', z'c76c51a3', z'd192e819', z'd6990624', z'f40e3585', z'106aa070',&
           & z'19a4c116', z'1e376c08', z'2748774c', z'34b0bcb5', z'391c0cb3', z'4ed8aa4a', z'5b9cca4f', z'682e6ff3',&
           & z'748f82ee', z'78a5636f', z'84c87814', z'8cc70208', z'90befffa', z'a4506ceb', z'bef9a3f7', z'c67178f2'/
      	h0 = h0_ref
      	k0 = k0_ref
      	break = 0
      	pos0 = 1
      	length = len(trim(str))
      	do while (break .ne. 1)
         	call consume_chunk(str, length, w0(1:16), pos0, break, swap)
		do i=17,64
            		w0(i) = ms1(w0(i-2)) + w0(i-16) + ms0(w0(i-15)) + w0(i-7)
         	end do
         	a0 = h0
         	do i=1,64
            		temp1 = a0(8) + cs1(a0(5)) + ch(a0(5),a0(6),a0(7)) + k0(i) + w0(i)
            		temp2 = cs0(a0(1)) + maj(a0(1),a0(2),a0(3))
            		a0(8) = a0(7)
            		a0(7) = a0(6)
            		a0(6) = a0(5)
            		a0(5) = a0(4) + temp1
            		a0(4) = a0(3)
            		a0(3) = a0(2)
            		a0(2) = a0(1)
            		a0(1) = temp1 + temp2
		end do
        	h0 = h0 + a0
      	end do
      	write(sha256b,'(8z8.8)') h0(1), h0(2), h0(3), h0(4), h0(5), h0(6), h0(7), h0(8)
end function sha256b

function swap32(inp)
      	integer(kind=c_int32_t) :: swap32
      	integer(kind=c_int32_t), intent(in)  :: inp
      	call mvbits(inp, 24, 8, swap32,  0)
      	call mvbits(inp, 16, 8, swap32,  8)
      	call mvbits(inp,  8, 8, swap32, 16)
      	call mvbits(inp,  0, 8, swap32, 24)
end function swap32

function swap64(inp)
      	integer(kind=c_int64_t) :: swap64
      	integer(kind=c_int64_t), intent(in)  :: inp
      	call mvbits(inp, 56, 8, swap64,  0)
      	call mvbits(inp, 48, 8, swap64,  8)
      	call mvbits(inp, 40, 8, swap64, 16)
      	call mvbits(inp, 32, 8, swap64, 24)
      	call mvbits(inp, 24, 8, swap64, 32)
      	call mvbits(inp, 16, 8, swap64, 40)
      	call mvbits(inp,  8, 8, swap64, 48)
      	call mvbits(inp,  0, 8, swap64, 56)
end function swap64

function swap64a(inp)
      	integer(kind=c_int64_t) :: swap64a
      	integer(kind=c_int64_t), intent(in)  :: inp
      	call mvbits(inp,  0, 8, swap64a, 32)
      	call mvbits(inp,  8, 8, swap64a, 40)
      	call mvbits(inp, 16, 8, swap64a, 48)
      	call mvbits(inp, 24, 8, swap64a, 56)
      	call mvbits(inp, 32, 8, swap64a,  0)
      	call mvbits(inp, 40, 8, swap64a,  8)
      	call mvbits(inp, 48, 8, swap64a, 16)
      	call mvbits(inp, 56, 8, swap64a, 24)
end function swap64a

function ch(a, b, c)
      	integer(kind=c_int32_t) :: ch
      	integer(kind=c_int32_t), intent(in) :: a, b, c
      	ch = ieor(iand(a, b), (iand(not(a), c)))
end function ch

function maj(a, b, c)
      integer(kind=c_int32_t) :: maj
      integer(kind=c_int32_t), intent(in) :: a, b, c
      maj = ieor(iand(a, b), ieor(iand(a, c), iand(b, c)))
end function maj

function cs0(a)
      	integer(kind=c_int32_t) :: cs0
      	integer(kind=c_int32_t), intent(in) :: a
      	cs0 = ieor(ishftc(a, -2), ieor(ishftc(a, -13), ishftc(a, -22)))
end function cs0

function cs1(a)
      	integer(kind=c_int32_t) :: cs1
      	integer(kind=c_int32_t), intent(in) :: a
      	cs1 = ieor(ishftc(a, -6), ieor(ishftc(a, -11), ishftc(a, -25)))
end function cs1

function ms0(a)
      	integer(kind=c_int32_t) :: ms0
      	integer(kind=c_int32_t), intent(in) :: a
      	ms0 = ieor(ishftc(a, -7), ieor(ishftc(a, -18), ishft(a, -3)))
end function ms0

function ms1(a)
      	integer(kind=c_int32_t) :: ms1
      	integer(kind=c_int32_t), intent(in) :: a
      	ms1 = ieor(ishftc(a, -17), ieor(ishftc(a, -19), ishft(a, -10)))
end function ms1

subroutine consume_chunk(str, length, inp, pos0, break, swap)
      	character(len=*), intent(in) :: str
      	integer(kind=c_int64_t), intent(in) :: length
      	integer(kind=c_int32_t), intent(inout) :: inp(*)
      	integer, intent(inout) :: pos0, break
      	integer, intent(in) :: swap
      	character(len=4) :: last_word
      	integer(kind=c_int64_t) :: rest
      	integer(kind=c_int32_t) :: to_pad, leftover, space_left, zero
      	integer(kind=c_int8_t)  :: ipad0, ipad1, i
      	data zero  / b'00000000000000000000000000000000'/
      	data ipad0 / b'00000000' /
      	data ipad1 / b'10000000' /
      	rest = length - pos0 + 1
      	if (rest .ge. 64) then
         	inp(1:16) = transfer(str(pos0:pos0+64-1), inp(1:16))
         	if (swap .eq. 1) then
            		do i=1,16
               			inp(i) = swap32(inp(i))
            		end do
         	end if
         	pos0 = pos0 + 64
      	else
         	space_left = 16
         	leftover   = rest/4
         	if (leftover .gt. 0) then
            		inp(1:leftover) = transfer(str(pos0:pos0+leftover*4-1), inp(1:16))
            		if (swap .eq. 1) then
               			do i=1,leftover
                  			inp(i) = swap32(inp(i))
               			end do
            		end if
            		pos0 = pos0 + leftover*4
            		rest = length - pos0 + 1
            		space_left = space_left - leftover
         	end if

         	if (space_left .gt. 0) then
            		if (break .ne. 2) then
               			if (rest .gt. 0) then
                  			last_word(1:rest) = str(pos0:pos0+rest-1)
                  			pos0 = pos0 + rest
               			end if
               			last_word(rest+1:rest+1) = transfer(ipad1, last_word(1:1))
               			to_pad = 4 - rest - 1
				do i=1,to_pad
                  			last_word(rest+1+i:rest+1+i) = transfer(ipad0, last_word(1:1))
               			end do
               			inp(17-space_left) = transfer(last_word(1:4), inp(1))
               			if (swap .eq. 1) then
                  			inp(17-space_left) = swap32(inp(17-space_left))
               			end if
               			space_left = space_left - 1
               			break = 2
            		end if
            		if (space_left .eq. 1) then
               			inp(16) = zero
               			space_left = 0
            		end if
            		rest = 0
         	end if
         	if ((rest .eq. 0) .and. (space_left .ge. 2)) then
            		do while (space_left .gt. 2)
               			inp(17-space_left) = zero
               			space_left = space_left - 1
            		end do
            		inp(15:16) = transfer(swap64a(length*8), inp(15:16))
            		break = 1
         	end if
      end if
end subroutine consume_chunk

end module sha256_module

program sha256_main
	use sha256_module
    	implicit none
    
    	character(len=256) :: message = "Hello, world!"
    	print *, "Hash of (Hello, world!):"
    	print *, sha256(message)
    
end program sha256_main
