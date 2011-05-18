package punk.ui
{
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	
	import punk.ui.skin.PunkSkin;
	import punk.ui.skin.PunkSkinToggleButtonElement;
	
	/**
	 * A toggle button component
	 */
	public class PunkToggleButton extends PunkButton
	{
		/**
		 * Boolean value indicating if the button has been toggled
		 */
		public var on:Boolean;
		
		/**
		 * Graphic of the button when it's active, toggled, and it's not being pressed and the mouse is outside of it.
		 */	
		public var normalOnGraphic:Graphic = new Graphic;
		/**
		 * Graphic of the button when the mouse hovers over the component, and it is active and toggled.
		 */	
		public var mousedOnGraphic:Graphic = new Graphic;
		/**
		 * Graphic of the button when the mouse is pressing it, it's active and toggled.
		 */	
		public var pressedOnGraphic:Graphic = new Graphic;
		/**
		 * Graphic of the button when inactive and toggled
		 */
		public var inactiveOnGraphic:Graphic = new Graphic;
		
		/**
		 * Constructor.
		 * @param	x X-Coordinate of the component
		 * @param	y Y-Coordinate of the component
		 * @param	width Width of the component
		 * @param	height Height of the Component
		 * @param	on If button is toggled on
		 * @param	text label for the component
		 * @param	onReleased Function called when the mouse is released
		 * @param	hotkey Hotkey used to trigger the component
		 * @param	skin Skin to use when rendering the component
		 * @param	active If the component is active
		 */
		public function PunkToggleButton(x:Number=0, y:Number=0, width:int=1, height:int=1, on:Boolean=false, text:String="Button",
										 onReleased:Function=null, hotkey:int=0, skin:PunkSkin=null, active:Boolean=true)
		{
			super(x, y, width, height, text, onReleased, hotkey, skin, active);
			
			this.on = on;
		}
		
		/**
		 * Additional setup steps for this component
		 * @param	skin Skin to use when rendering the component
		 */
		override protected function setupSkin(skin:PunkSkin):void
		{
			if(!skin.punkToggleButton) return;
			
			setUpButtonSkin(skin.punkToggleButton);
			setUpToggleButtonSkin(skin.punkToggleButton);
		}
		
		/**
		 * Additional setup steps for the component's toggle button skin
		 * @param	skin Skin to use when rendering the component
		 */
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
		
		/**
		 * @private
		 */
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
		
		/**
		 * @private
		 */
		override protected function pressedCallback():void
		{
			isPressed = true;
			if(onPressed != null) onPressed(on);
		}
		
		/**
		 * @private
		 */
		override protected function releasedCallback():void
		{
			isPressed = false;
			on = !on;
			if(onReleased != null) onReleased(on);
		}
		
		/**
		 * @private
		 */
		override protected function enterCallback():void
		{
			isMoused = true;
			if(onEnter != null) onEnter(on);
		}
		
		/**
		 * @private
		 */
		override protected function exitCallback():void
		{
			isMoused = false;
			if(onExit != null) onExit(on);
		}
	}
}