with text_io; -- always need these two lines for reading and printing
use text_io;
with AdaptiveQuad;
with Ada.Numerics.Generic_Elementary_Functions;

procedure AQMain is

	package Float_Text_IO is new Text_IO.Float_IO(Float);
	use Float_Text_IO;
	package Value_Functions is new Ada.Numerics.Generic_Elementary_Functions (Float);
	use Value_Functions;

	--Epsilon and MyF definitions START
	Epsilon : Float := 0.000001;
	--Number of inputs
	Size : Integer := 5;

	function MyF(num: in Float) return Float is
		result: Float ;
		begin 
			result := Sin(X => (num * num)) ;
			return result ;
	end MyF ;
	--Epsilon and MyF definitions END

	--Generic package updated with MyFunction
	package floatAdaptiveQuad is new AdaptiveQuad(MyF);

	--Task Type to compute area 
	task type ComputeAreaTaskType is
	    entry Start(a,b:Float);
	end ComputeAreaTaskType;

	-- Task to print results
	Task PrintResultTask is
		entry printResult(startVal,endVal,integralResult:Float);
	end PrintResultTask;

	-- task to print result
	task ReadPairsTask is 
	end ReadPairsTask;

	--Task Body
	task body ComputeAreaTaskType is 
		startVal, endVal,integralResult : Float;
	begin
	    accept Start(a,b:Float) do
	    	startVal := a ;
			endVal := b ;
		end Start;
			integralResult := floatAdaptiveQuad.AQuad(startVal,endVal,Epsilon);
			PrintResultTask.printResult(startVal, endVal,integralResult);

	end ComputeAreaTaskType;

	Task body PrintResultTask is

		begin
			for Index in 1..Size loop
				accept printResult(startVal,endVal,integralResult: Float) do
					Put(Float'Image(startVal) & " " & Float'Image(endVal) & " Result:");
					Put(Item => integralResult);
					New_Line;
				end printResult;
			end loop;

	end PrintResultTask;

	-- creating 5 separate tasks for computing area
	mComputeAreaTasks: array(1..Size) of ComputeAreaTaskType ;

	--Task Body for Read Pairs
	task body ReadPairsTask is 
		startVal, endVal : Float;
	begin
    	for Index in 1..Size loop
			get(startVal);
			get(endVal);
			mComputeAreaTasks(Index).Start(startVal, endVal);
		end loop;

	end ReadPairsTask;

	begin
	Null;

end AQMain;