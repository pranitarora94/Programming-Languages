package matrixmult is
	size: constant integer:= 10;
	type Matrix is array(1 .. size, 1 .. size) of Integer;
 	procedure matmult(A : in Matrix; B : in Matrix; C : out Matrix);
end;
