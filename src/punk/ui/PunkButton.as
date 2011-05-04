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
		 * The button's label 
		 */		
		public var label:PunkLabel;
		
		/**
		 * Constructor.
		 *  
		 * @param x			X coordinate of the button.
		 * @param y			Y coordinate of the button.
		 * @param width		Width of the button's hitbox.
		 * @param height	Height of the button's hitbox.
		 * @param text		Text of the button
		 * @param callback	The function that will be called when the button is pressed.
		 * @param active	Whether the button is active or not.
		 */
		public function PunkButton(x:Number=0, y:Number=0, width:int=1, height:int=1, text:String="Button",
								   onReleased:Function=null, active:Boolean=true, skin:Class=null) {
			super(x, y, width, height, skin);
			
			normalGraphic = Image.createRect(width, height, 0xFFFFFF);
			mousedGraphic = Image.createRect(width, height, 0xCCCCCC);
			pressedGraphic = Image.createRect(width, height, 0x999999);
			inactiveGraphic = Image.createRect(width, height, 0x666666);
			
			this.onReleased = onReleased;
			
			label = new PunkLabel(text, x, y, width, height);
			label.color = 0x000000;
			label.background = false;
			
			this.active = active;
		}
		
		/**
		 * @private 
		 */
		override public function update():void{
			super.update();
			
			if(collidePoint(this.x, this.y, Input.mouseX, Input.mouseY))
			{
				if(Input.mouseDown) _currentGraphic = 2;
				else
				{
					if(!isMoused) enterCallback();
					_currentGraphic = 1;
				}
			}
			else
			{
				if(isMoused) exitCallback();
				_currentGraphic = 0;
			}
			
			label.update();
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
			
			label.render();
		}
		
		protected function pressedCallback():void
		{
			if(onPressed != null) onPressed();
			isPressed = true;
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
			if(!active || !Input.mousePressed) return;
			if(this.collidePoint(this.x, this.y, Input.mouseX, Input.mouseY)) pressedCallback();
		}
		
		/**
		 * @private
		 */		
		protected function onMouseUp(e:MouseEvent = null):void {
			if(!active || !Input.mouseReleased) return;
			if(this.collidePoint(this.x, this.y, Input.mouseX, Input.mouseY)) releasedCallback();
		}
		
		/**
		 * @private
		 */
		override public function added():void {
			super.added();
			
			label.added();
			
			if(FP.stage) {
				FP.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
				FP.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false, 0, true);
			}
		}
		
		/**
		 * @private
		 */
		override public function removed():void {
			super.removed();
			
			label.removed();
			
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
				graphic.render(renderTarget ? renderTarget : FP.buffer, _point, FP.camera);
			}
		}
		
		protected var _currentGraphic:int = 0;
		protected var _point:Point = new Point;
	}
}
