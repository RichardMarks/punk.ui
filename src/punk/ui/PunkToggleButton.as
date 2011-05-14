package punk.ui
{
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	
	import punk.ui.skin.PunkSkin;
	import punk.ui.skin.PunkSkinToggleButtonElement;
	
	public class PunkToggleButton extends PunkButton
	{
		public var on:Boolean;
		
		public var normalOnGraphic:Graphic = new Graphic;
		public var mousedOnGraphic:Graphic = new Graphic;
		public var pressedOnGraphic:Graphic = new Graphic;
		public var inactiveOnGraphic:Graphic = new Graphic;
		
		public function PunkToggleButton(x:Number=0, y:Number=0, width:int=1, height:int=1, on:Boolean=false, text:String="Button",
										 onReleased:Function=null, hotkey:int=0, skin:PunkSkin=null, active:Boolean=true)
		{
			super(x, y, width, height, text, onReleased, hotkey, skin, active);
			
			this.on = on;
		}
		
		override protected function setupSkin(skin:PunkSkin):void
		{
			if(!skin.punkToggleButton) return;
			
			setUpButtonSkin(skin.punkToggleButton);
			setUpToggleButtonSkin(skin.punkToggleButton);
		}
		
		protected function setUpToggleButtonSkin(skin:PunkSkinToggleButtonElement):void
		{
			if(!skin) return;
			
			this.normalOnGraphic = getSkinImage(skin.normalOn);
			var mousedGraphic:Image = getSkinImage(skin.mousedOn);
			this.mousedOnGraphic = mousedGraphic ? mousedGraphic : normalOnGraphic;
			var pressedGraphic:Image = getSkinImage(skin.pressedOn);
			this.pressedOnGraphic = pressedGraphic ? pressedGraphic : normalOnGraphic;
			var inactiveGraphic:Image = getSkinImage(skin.inactiveOn);
			this.inactiveOnGraphic = inactiveGraphic ? inactiveGraphic : normalOnGraphic;
			
			var labelProperties:Object = skin.labelProperties;
			if(!labelProperties) labelProperties = new Object;
			label = new PunkText(textString, 0, 0, skin.labelProperties);
			if(!labelProperties.hasOwnProperty("width")) label.width = width;
			if(!skin.labelProperties.hasOwnProperty("y"))
			{
				label.y = (height >> 1) - (label.textHeight >> 1);
			}
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