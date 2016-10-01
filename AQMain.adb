with text_io; -- always need these two lines for reading and printing
use text_io;
with AdaptiveQuad;
with Ada.Numerics.Generic_Elementary_Functions;

procedure AQMain is

package Float_Text_IO is new Text_IO.Float_IO(Float);
use Float_Text_IO;
package Value_Functions is new Ada.Numerics.Generic_Elementary_Functions (Float);
use Value_Functions;

Epsilon : Float := 0.000001;
integralResult,startVal, endVal : Float ;

function MyF(num: in Float) return Float is
	result: Float ;
	begin 
		result := Sin(X => (num * num)) ;
		return result ;
	end MyF ;

package floatAdaptiveQuad is new AdaptiveQuad(MyF);

begin
	Put("Enter two numbers:");
	New_Line;
	get(startVal);
	get(endVal);
	integralResult := floatAdaptiveQuad.AQuad(startVal,endVal,Epsilon);
	Put(Item => integralResult);
	New_Line;

end AQMain;