package punk.ui
{
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	
	import punk.ui.skin.PunkSkinButtonElement;
	import punk.ui.skin.PunkSkin;
	import punk.ui.skin.PunkSkinImage;

	/**
	 * A button component.
	 */
	public class PunkButton extends PunkUIComponent
	{	
		/**
		 * Function called when the button is pressed. 
		 */		
		public var onPressed:Function = null;
		
		/**
		 * Function called when the button is released
		 */
		public var onReleased:Function = null;
		
		/**
		 * Function called when the mouse first hovers over the button
		 */
		public var onEnter:Function = null;
		
		/**
		 * Function called when the mouse first stops hovering over the button
		 */
		public var onExit:Function = null;
		
		/**
		 * Is the button pressed
		 */
		public var isPressed:Boolean = false;
		
		/**
		 * Is the button activated via the mouse
		 */
		public var isMoused:Boolean = false;
		
		/**
		 * Is the button activated via the keyboard
		 */
		protected var isKeyed:Boolean = false;
		
		/**
		 * Graphic of the button when it's active and it's not being pressed and the mouse is outside of it.
		 */	
		public var normalGraphic:Graphic = new Graphic;
		/**
		 * Graphic of the button when the mouse overs it and it's active.
		 */		
		public var mousedGraphic:Graphic = new Graphic;
		/**
		 * Graphic of the button when the mouse is pressing it and it's active.
		 */		
		public var pressedGraphic:Graphic = new Graphic;
		/**
		 * Graphic of the button when inactive.
		 */
		public var inactiveGraphic:Graphic = new Graphic;
		
		/**
		 * Hotkey used to trigger this component
		 */
		public var hotkey:int = 0;
		
		/**
		 * The button's label 
		 */		
		public var label:PunkText;
		
		/**
		 * Text string for this component
		 */
		protected var textString:String = "";
		
		/**
		 * Has the component been inititalized
		 */
		protected var initialised:Boolean = false;
		
		/**
		 * Constructor
		 *  
		 * @param x					The x coordinate of the button
		 * @param y					The y coordinate of the button
		 * @param width				The width of the button
		 * @param height			The height of the button
		 * @param text				The text of the button's label
		 * @param onReleased		What to do when the button is clicked.
		 * @param hotkey            Hotkey the trigger the component
		 * @param skin              The skin to use when rendering the component
		 * @param active			If the button should be active
		 */		
		public function PunkButton(x:Number=0, y:Number=0, width:int=1, height:int=1, text:String="Button", onReleased:Function=null, hotkey:int=0, skin:PunkSkin = null,
								   active:Boolean=true) {
			this.textString = text;
			
			super(x, y, width, height, skin);
			
			this.onReleased = onReleased;
			
			this.hotkey = hotkey;
			
			this.active = active;
		}
		
		/**
		 * Additional setup steps for this component
		 * @param	skin Skin to use when rendering the component
		 */
		override protected function setupSkin(skin:PunkSkin):void
		{
			if(!skin.punkButton) return;
			
			setUpButtonSkin(skin.punkButton);
			
			var labelProperties:Object = skin.punkButton.labelProperties;
			if(!labelProperties) labelProperties = new Object;
			label = new PunkText(textString, 0, 0, labelProperties);
			if(!labelProperties.hasOwnProperty("align")) label.align = "center";
			if(!labelProperties.hasOwnProperty("width")) label.width = width;
			if(!labelProperties.hasOwnProperty("y"))
			{
				label.y = (height >> 1) - (label.textHeight >> 1);
			}
		}
		
		/**
		 * Additional setup specifically for the button's graphical states
		 * @param	skin Skin to use when rendering the component
		 */
		protected function setUpButtonSkin(skin:PunkSkinButtonElement):void
		{
			if(!skin) return;
			
			this.normalGraphic = getSkinImage(skin.normal);
			var mousedGraphic:Image = getSkinImage(skin.moused);
			this.mousedGraphic = mousedGraphic ? mousedGraphic : normalGraphic;
			var pressedGraphic:Image = getSkinImage(skin.pressed);
			this.pressedGraphic = pressedGraphic ? pressedGraphic : normalGraphic;
			var inactiveGraphic:Image = getSkinImage(skin.inactive);
			this.inactiveGraphic = inactiveGraphic ? inactiveGraphic : normalGraphic;
		}
		
		/**
		 * Setup the different callbacks that this component uses
		 * @param	onReleased Function called when mouse is release
		 * @param	onPressed Function called when mouse is pressed
		 * @param	onEnter Function called when the mouse first hovers over the button
		 * @param	onExit Function called when the mouse stoppes hovering over the button
		 */
		public function setCallbacks(onReleased:Function=null, onPressed:Function=null, onEnter:Function=null, onExit:Function=null):void
		{
			this.onReleased = onReleased;
			this.onPressed = onPressed;
			this.onEnter = onEnter;
			this.onExit = onExit;
		}
		
		/**
		 * @private 
		 */
		override public function update():void{
			super.update();
			
			if(!initialised)
			{
				if(FP.stage) {
					FP.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
					FP.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false, 0, true);
					initialised = true;
				}
			}
			
			if(hotkey != 0)
			{
				if(!isPressed && Input.pressed(hotkey))
				{
					isKeyed = true;
					pressedCallback();
				}
				if(isKeyed && Input.released(hotkey)) 
				{
					isKeyed = false;
					if(isPressed) releasedCallback();
				}
			}
			
			if(PunkUI.mouseIsOver(this, true))
			{
				if(!isMoused) enterCallback();
				_currentGraphic = 1;
			}
			else
			{
				if(isMoused) exitCallback();
				_currentGraphic = 0;
			}
			
			if(isPressed) _currentGraphic = 2;
		}
		
		/**
		 * @private
		 */
		override public function render():void {
			if(active)
			{
				switch(_currentGraphic)
				{
					case 0:
						renderGraphic(normalGraphic);
						break;
					case 1:
						renderGraphic(mousedGraphic);
						break;
					case 2:
						renderGraphic(pressedGraphic);
						break;
				}
			}
			else
			{
				renderGraphic(inactiveGraphic);
			}
			
			renderGraphic(label);
		}
		
		/**
		 * helper function to ensure the validity of a call to fire the onPressed function
		 */
		protected function pressedCallback():void
		{
			isPressed = true;
			if(onPressed != null) onPressed();
		}
		
		/**
		 * helper function to ensure the validity of a call to fire the onRelease function
		 */
		protected function releasedCallback():void
		{
			isPressed = false;
			if(onReleased != null) onReleased();
		}
		
		/**
		 * helper function to ensure the validity of a call to fire the onEnter function
		 */
		protected function enterCallback():void
		{
			isMoused = true;
			if(onEnter != null) onEnter();
		}
		
		/**
		 * helper function to ensure the validity of a call to fire the onExit function
		 */
		protected function exitCallback():void
		{
			isMoused = false;
			if(onExit != null) onExit();
		}
		
		/**
		 * @private
		 */		
		protected function onMouseDown(e:MouseEvent = null):void {
			if(!active || !Input.mousePressed || isPressed) return;
			if(isMoused) pressedCallback();
		}
		
		/**
		 * @private
		 */		
		protected function onMouseUp(e:MouseEvent = null):void {
			if(!active || !Input.mouseReleased || !isPressed) return;
			if(isPressed) isPressed = false;
			if(isMoused) releasedCallback();
		}
		
		/**
		 * @private
		 */
		override public function added():void {
			super.added();
			
			initialised = false;
			
			if(FP.stage) {
				FP.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
				FP.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false, 0, true);
				initialised = true;
			}
		}
		
		/**
		 * @private
		 */
		override public function removed():void {
			super.removed();
			
			if(FP.stage) {
				FP.stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				FP.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			}
		}
		
		protected var _currentGraphic:int = 0;
	}
}
