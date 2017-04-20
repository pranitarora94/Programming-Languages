package body matrixmult is
	type myArr is array(1 .. size) of Integer;
	taskNum : integer := 1;
	procedure MatMult(A : in Matrix; B : in Matrix; C : out Matrix) is
		task type CalcElem is
			entry Go(X:Matrix; Y:Matrix; r : integer; c : integer);
		end;

		task body CalcElem is
 			Row: Matrix;
    			Col: Matrix;
   			rowInd: integer;
    			colInd: integer;
    			Sum: Integer := 0;
    		begin
    			accept Go(X:Matrix; Y:Matrix; r : integer; c : integer) do   
	    			Row := X;
	       			Col := Y;             
	       			rowInd := r;
	       			ColInd := c;
	    		end Go;
			for Ind in 1 .. SIZE loop
				Sum := Sum + Row(rowInd, Ind) * Col(Ind, colInd);
  			end loop;
  			C(rowInd,ColInd) := Sum;
  		end;
		type taskPool is array (Positive range 1 .. SIZE*SIZE) of CalcElem;
		MyTask : taskPool;
	begin
		
  		for i in 1 .. size loop
  			for j in 1 .. size loop
				taskNum := (i-1)*10 + j;
				MyTask(taskNum).Go(A , B , i , j);
  			end loop;
  		end loop;
	end MatMult;
end;
