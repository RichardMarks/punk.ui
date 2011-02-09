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
			
			add(new PunkLabel("Testing"));
			
			var panel:PunkPanel = new PunkPanel(0, 30);
			add(panel);
			panel.add(new PunkLabel("Hello"));
			
			var label:PunkLabel = new PunkLabel("I'm inside the panel");
			label.y = 30;
			panel.add(label);
			label.y = 2;
		}
	}
}