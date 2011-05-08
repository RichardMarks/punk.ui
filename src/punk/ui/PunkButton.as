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

	/**
	 * @author Rolpege
	 */
	
	public class PunkButton extends PunkUIComponent
	{	
		/**
		 * This function will be called when the button is pressed. 
		 */		
		public var onPressed:Function = null;
		
		public var onReleased:Function = null;
		
		public var onEnter:Function = null;
		
		public var onExit:Function = null;
		
		public var isPressed:Boolean = false;
		
		public var isMoused:Boolean = false;
		
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
		
		public var hotkey:int = 0;
		
		/**
		 * The button's label 
		 */		
		public var label:PunkText;
		
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
		 * @param normalGraphic		Normal graphic.
		 * @param mousedGraphic		Moused graphic. If not set, normalGraphic will be used.
		 * @param pressedGraphic	Pressed graphic. If not set, normalGraphic will be used.
		 * @param inactiveGraphic	Inactive graphic. If not set, normalGraphic will be used.
		 * @param labelProperties	Additional label properties. Default to align center, width of the button and y to the center, considering textHeight
		 * @param active			If the button should be active
		 */		
		public function PunkButton(x:Number=0, y:Number=0, width:int=1, height:int=1, text:String="Button",
								   onReleased:Function=null, normalGraphic:Graphic = null, mousedGraphic:Graphic = null,
								   pressedGraphic:Graphic=null, inactiveGraphic:Graphic = null, hotkey:int=0, labelProperties:Object=null,
								   active:Boolean=true) {
			super(x, y, width, height);
			
			this.normalGraphic = normalGraphic
			this.mousedGraphic = mousedGraphic ? mousedGraphic : normalGraphic;
			this.pressedGraphic = pressedGraphic ? pressedGraphic : normalGraphic;
			this.inactiveGraphic = inactiveGraphic ? inactiveGraphic : inactiveGraphic;
			
			this.onReleased = onReleased;
			
			if(!labelProperties) labelProperties = new Object;
			if(!labelProperties.hasOwnProperty("align")) labelProperties.align = "center";
			if(!labelProperties.hasOwnProperty("width")) labelProperties.width = width;
			label = new PunkText(text, 0, 0, labelProperties);
			if(!labelProperties.hasOwnProperty("y"))
			{
				label.y = (height >> 1) - (label.textHeight >> 1);
			}
			
			this.hotkey = hotkey;
			
			this.active = active;
		}
		
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
		
		protected function pressedCallback():void
		{
			isPressed = true;
			if(onPressed != null) onPressed();
		}
		
		protected function releasedCallback():void
		{
			isPressed = false;
			if(onReleased != null) onReleased();
		}
		
		protected function enterCallback():void
		{
			isMoused = true;
			if(onEnter != null) onEnter();
		}
		
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
		
		protected function renderGraphic(graphic:Graphic):void
		{
			if(graphic && graphic.visible)
			{
				if (graphic.relative)
				{
					_point.x = x;
					_point.y = y;
				}
				else _point.x = _point.y = 0;
				graphic.render(renderTarget ? renderTarget : FP.buffer, _point, _camera ? _camera : FP.camera);
			}
		}
		
		protected var _currentGraphic:int = 0;
		protected static var _point:Point = new Point;
	}
}
