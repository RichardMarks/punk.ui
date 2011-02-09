package
{
	import net.flashpunk.World;
	
	import punk.ui.PunkLabel;
	import punk.ui.PunkPanel;
	
	public class Test1 extends World
	{
		public function Test1()
		{
			super();
			
			var label:PunkLabel = new PunkLabel("Testing");
			add(label);
			
			var panel:PunkPanel = new PunkPanel(0, 30);
			add(panel);
		}
	}
}