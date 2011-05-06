package punk.ui
{
	import net.flashpunk.Graphic;
	
	public class PunkToggleButton extends PunkButton
	{
		public var on:Boolean;
		
		public var normalOnGraphic:Graphic = new Graphic;
		public var mousedOnGraphic:Graphic = new Graphic;
		public var pressedOnGraphic:Graphic = new Graphic;
		public var inactiveOnGraphic:Graphic = new Graphic;
		
		public function PunkToggleButton(x:Number=0, y:Number=0, width:int=1, height:int=1, on:Boolean=false, text:String="Button",
										 onReleased:Function=null, normalGraphic:Graphic=null, mousedGraphic:Graphic=null,
										 pressedGraphic:Graphic=null, inactiveGraphic:Graphic=null, normalOnGraphic:Graphic=null,
										 mousedOnGraphic:Graphic=null, pressedOnGraphic:Graphic=null, inactiveOnGraphic:Graphic=null,
										 hotkey:int=0, labelProperties:Object=null, active:Boolean=true)
		{
			super(x, y, width, height, text, onReleased, normalGraphic, mousedGraphic, pressedGraphic, inactiveGraphic, hotkey, labelProperties, active);
			
			this.on = on;
			
			this.normalOnGraphic = normalOnGraphic;
			this.mousedOnGraphic = mousedOnGraphic ? mousedOnGraphic : normalOnGraphic;
			this.pressedOnGraphic = pressedOnGraphic ? pressedOnGraphic : normalOnGraphic;
			this.inactiveOnGraphic = inactiveOnGraphic ? inactiveOnGraphic : normalOnGraphic;
		}
		
		override public function render():void
		{
			if(active)
			{
				switch(_currentGraphic)
				{
					case 0:
						renderGraphic(on ? normalOnGraphic : normalGraphic);
						break;
					case 1:
						renderGraphic(on ? mousedOnGraphic : mousedGraphic);
						break;
					case 2:
						renderGraphic(on ? pressedOnGraphic : pressedGraphic);
						break;
				}
			}
			else
			{
				renderGraphic(on ? inactiveOnGraphic : inactiveGraphic);
			}
			
			renderGraphic(label);
		}
		
		override protected function pressedCallback():void
		{
			isPressed = true;
			if(onPressed != null) onPressed(on);
		}
		
		override protected function releasedCallback():void
		{
			isPressed = false;
			on = !on;
			if(onReleased != null) onReleased(on);
		}
		
		override protected function enterCallback():void
		{
			isMoused = true;
			if(onEnter != null) onEnter(on);
		}
		
		override protected function exitCallback():void
		{
			isMoused = false;
			if(onExit != null) onExit(on);
		}
	}
}