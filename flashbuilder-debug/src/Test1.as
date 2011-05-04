package
{
	import net.flashpunk.FP;
	import net.flashpunk.World;
	
	import punk.ui.PunkButton;
	import punk.ui.PunkLabel;
	import punk.ui.PunkPanel;
	import punk.ui.PunkPassword;
	import punk.ui.PunkTextArea;
	import punk.ui.PunkTextField;
	
	public class Test1 extends World
	{
		public function Test1()
		{
			super();
			
			FP.console.enable();
			
			var button:PunkButton = new PunkButton(10, 10, 100, 50);
			button.onPressed = onPressed;
			button.onReleased = onReleased;
			button.onEnter = onEnter;
			button.onExit = onExit;
			add(button);
		}
		
		public function onPressed():void
		{
			FP.log("onPressed");
		}
		
		public function onReleased():void
		{
			FP.log("onReleased");
		}
		
		public function onEnter():void
		{
			FP.log("onEnter");
		}
		
		public function onExit():void
		{
			FP.log("onExit");
		}
	}
}