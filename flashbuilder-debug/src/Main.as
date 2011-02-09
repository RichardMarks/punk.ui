package
{	
	import net.flashpunk.Engine;
	import net.flashpunk.FP;

	[SWF(width="640", height="480", backgroundColor="#000000")]
	public class Main extends Engine
	{
		public function Main()
		{
			super(640, 480);
			FP.world = new Test1;
		}
	}
}