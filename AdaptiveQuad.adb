with text_io;
use text_io;
package body AdaptiveQuad is
   
   function AQuad(x,y,epsi: Float) return Float is

   		function simpsons_rule(x,y: Float) return Float is
   			h3 :Float ;
   			z: Float ;
   			begin
   				z:= (x+y)/2.0;
   				h3 := abs ((y-x) / 6.0);
				return h3*(F(x) + 4.0*F(z) + F(y));
   		end simpsons_rule;

	   	function recursive_asr(a,b,eps,whole: Float) return Float is
	    	--Recursive implementation of adaptive Simpson's rule

	    	c,left,right,leftResult,rightResult: Float;

			task type AdaptiveQuadTaskType is
			    entry SetValue(startVal,endVal,epsVal,wholeVal: Float);
			    entry GetValue(resultVal: out Float);
			end AdaptiveQuadTaskType;

			task body AdaptiveQuadTaskType is 
			    mResult,start_x,end_y,eps,whole : Float;
			begin
				Put("Task");
			    accept SetValue(startVal,endVal,epsVal,wholeVal: Float) do
			    	start_x := startVal;
			    	end_y := endVal;
			    	eps := epsVal;
			    	whole := wholeVal;
				end SetValue;
			    if(start_x /= end_y) then
			    	mResult := recursive_asr(start_x,end_y,eps,whole);
			      
			    	accept GetValue(resultVal: out Float) do
			    		resultVal := mResult;
				end GetValue;
			    end if;
			end AdaptiveQuadTaskType;

			leftSubtask, rightSubTask : AdaptiveQuadTaskType;

	    	begin
	    		c := (a+b) / 2.0;
	    		left := simpsons_rule(a,c);
	    		right := simpsons_rule(c,b);
	    		if (abs(left + right - whole) <= 15.0 * eps) then
	    			leftSubtask.SetValue(-1.0,-1.0,eps/2.0,left);
					rightSubtask.SetValue(-1.0,-1.0,eps/2.0,right);
	        		return left + right + (left + right - whole)/15.0 ;
				end if;
				leftSubtask.SetValue(a,c,eps/2.0,left);
				rightSubtask.SetValue(c,b,eps/2.0,right);
				leftSubtask.getValue(leftResult);
				rightSubtask.getValue(rightResult);
				return leftResult + rightResult;
	    		--return recursive_asr(a,c,eps/2.0,left) + recursive_asr(c,b,eps/2.0,right);
	    end recursive_asr;

	begin
	   		return recursive_asr(x,y,epsi,simpsons_rule(x,y));
	end AQuad;
   
end AdaptiveQuad;