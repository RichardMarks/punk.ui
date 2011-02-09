package
{
	import net.flashpunk.World;
	
	import punk.ui.PunkLabel;
	
	public class Test1 extends World
	{
		public function Test1()
		{
			super();
			
			var label:PunkLabel = new PunkLabel("Testing");
			add(label);
		}
	}
}