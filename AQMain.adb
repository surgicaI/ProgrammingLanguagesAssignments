with text_io; -- always need these two lines for reading and printing
use text_io;
with AdaptiveQuad;

procedure AQMain is

package int_io is new integer_io(integer);
use int_io;
package Float_Text_IO is new Text_IO.Float_IO(Float);
use Float_Text_IO;

Epsilon : Float := 0.000001 ;
integralResult : Float ;

function MyF(num: in Float) return Float is
	result: Float ;
	begin 
		--ToDo for Sin X^2
		-- Also types should be Floats
		result := num * num ;
		return result ;
	end MyF ;

package floatAdaptiveQuad is new AdaptiveQuad(MyF);

begin
  integralResult := floatAdaptiveQuad.AQuad(0.0,100.0,Epsilon);
  Put(Item => integralResult);
  New_Line;

end AQMain;