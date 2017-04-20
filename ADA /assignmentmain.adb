with text_io;
with MatrixMult;

use text_io;

procedure AssignmentMain is
	package Int_Io is new Integer_Io(Integer);
	use Int_Io;
	k: integer;
	A: MatrixMult.Matrix;
	B: MatrixMult.Matrix;
	C: MatrixMult.Matrix;
	task Reader1 is 
		entry Start;
	end;

	task Reader2 is
		entry Proceed;
	end;

	task Multiply is 
		entry Ready;
	end;

	task Printer is
		entry PrintReady;
	end;
	
	task body Reader1 is
	begin
		accept Start;		
		for i in 1 .. MatrixMult.SIZE loop
			for j in 1 .. MatrixMult.SIZE loop
				get(k);
				--k := 1;
				A(i,j) := k;
			end loop;
		end loop;
		Reader2.Proceed;
	end;
	
	task body Reader2 is
	begin
		accept Proceed;
		for i in 1 .. MatrixMult.SIZE loop
			for j in 1 .. MatrixMult.SIZE loop
				--k := 1;			
				get(k);
				B(i,j) := k;
			end loop;
		end loop;
		Multiply.Ready;
	end;
	
	task body Multiply is 
	begin
		accept Ready;
		matrixmult.matmult(A, B, C);
		Printer.PrintReady;
	end;

	task body Printer is
		res : integer :=0;
	begin
		accept PrintReady;
		for i in 1 .. MatrixMult.SIZE loop
			for j in 1 .. MatrixMult.SIZE loop
				res := C(i,j);
				put(res);
			end loop;
			new_line;
		end loop;
	end;

begin
	Reader1.Start;
end;
