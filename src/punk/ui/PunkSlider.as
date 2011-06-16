package punk.ui {
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	import punk.ui.skin.PunkSkin;
	
	/**
	 * A slider component
	 */
	public class PunkSlider extends PunkUIComponent {
		
		/**
		 * The minimum dimension of the handle in the sliding direction
		 */
		private static const MIN_HANDLE_SIZE:uint = 16;
		
		/**
		 * Function called when the slider value is changed. 
		 */	
		protected var onChanged:Function = null;
		
		/**
		 * The value of the slider.
		 */
		protected var _value:Number;
		
		protected var minValue:Number;
		protected var maxValue:Number;
		protected var defaultValue:Number;
		protected var integerValue:Boolean;
		protected var horizontal:Boolean;
		protected var handleLength:uint;
		protected var handleWidth:int;
		protected var handleHeight:int;
		
		protected var sliderIsHovered:Boolean = false;
		protected var handleIsHovered:Boolean = false;
		protected var isDragging:Boolean = false;
		protected var initialised:Boolean = false;
		
		protected var slider:Graphic;
		protected var inactiveSlider:Graphic;
		protected var sliderHandle:Graphic;
		protected var mousedSliderHandle:Graphic;
		protected var draggingSliderHandle:Graphic;
		protected var inactiveSliderHandle:Graphic;
		
		/**
		 * Constructor 
		 * @param	x X-coordinate of the component
		 * @param	y Y-coordinate of the component
		 * @param	length Length of the slider in the sliding direction
		 * @param	breadth The breadth of the slider in the non-sliding direction
		 * @param	onChanged Function called when the value changes, signature onChanged(v:Number)
		 * @param	minValue Minimum value of the slider
		 * @param	maxValue Maximum value of the slider
		 * @param	defaultValue Default value of the slider
		 * @param	integerValue If the slider only should take integer values
		 * @param	horizontal If the slider should be slideable horizontally
		 * @param	skin Skin to use when rendering the component
		 * @param	active If the slider should be active
		 */
		public function PunkSlider(	x:Number = 0, y:Number = 0, length:int = 100, breadth:int=16, onChanged:Function = null, minValue:Number = 0, maxValue:Number = 100, 
				defaultValue:Number=0, integerValue:Boolean=true, horizontal:Boolean=true, skin:PunkSkin=null, active:Boolean=true) { 
			
			this.horizontal = horizontal;
			this.handleLength = Math.max(MIN_HANDLE_SIZE, length / (maxValue - minValue + 1));
			
			super(x, y, horizontal ? length : breadth, horizontal ? breadth : length, skin);
			this.onChanged = onChanged;
			this.minValue = minValue;
			this.maxValue = maxValue;
			this.defaultValue = defaultValue;
			this.integerValue = integerValue;
			this.active = active;
			this.value = defaultValue;
			
			isDragging = false;
		}
		
		override protected function setupSkin(skin:PunkSkin):void {
			
			if (!skin.punkSlider) return;
			
			handleWidth = horizontal ? handleLength : width;
			handleHeight = horizontal ? height : handleLength;
			
			slider = getSkinImage(skin.punkSlider.normal);
			inactiveSlider = getSkinImage(skin.punkSlider.inactive);
			sliderHandle = getSkinImage(skin.punkSlider.normalHandle, handleWidth, handleHeight);
			mousedSliderHandle = getSkinImage(skin.punkSlider.mousedHandle, handleWidth, handleHeight);
			draggingSliderHandle = getSkinImage(skin.punkSlider.pressedHandle, handleWidth, handleHeight);
			inactiveSliderHandle = getSkinImage(skin.punkSlider.inactiveHandle, handleWidth, handleHeight);
		}
		
		/**
		 * Setup the function called when the slider value changes.
		 * @param	onChanged the callback function, should have the signature onChanged(value:Number)
		 */
		public function setCallback(onChanged:Function=null):void
		{
			this.onChanged = onChanged;
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
			
			if (horizontal) {
				sliderHandle.x = draggingSliderHandle.x = mousedSliderHandle.x = inactiveSliderHandle.x = (value / maxValue) * (width-handleLength);
				sliderHandle.y = draggingSliderHandle.y = mousedSliderHandle.y = inactiveSliderHandle.y = 0;
			} else {
				sliderHandle.x = draggingSliderHandle.x = mousedSliderHandle.x = inactiveSliderHandle.x = 0;
				sliderHandle.y = draggingSliderHandle.y = mousedSliderHandle.y = inactiveSliderHandle.y = (value / maxValue) * (height-handleLength);
			}
			
			if (PunkUI.mouseIsOver(this, true)) {
				sliderIsHovered = true;
			}
			else {
				sliderIsHovered = false;
			}
			
			if (sliderIsHovered && mouseIsOverHandle()) {
				handleIsHovered = true;
			} else {
				handleIsHovered = false;
			}
			
		}
		
		/**
		 * @private
		 */
		override public function render():void {
			
			
			if (active) {
				
				renderGraphic(slider);
				
				if (isDragging) {
					renderGraphic(draggingSliderHandle);
				} else if (handleIsHovered) {
					renderGraphic(mousedSliderHandle);
				} else {
					renderGraphic(sliderHandle);
				}
				
			}
			else {
				renderGraphic(inactiveSlider);
				renderGraphic(inactiveSliderHandle);
			}
			
		}
		
		protected function onMouseDown(e:MouseEvent = null):void {
			if (!active || !Input.mousePressed) return;
			if(world && world != FP.world)
			{
				removed();
				return;
			}
			if (sliderIsHovered) {
				updateValue();
				if(!isDragging) startDragging();
			}
		}
			
		protected function onMouseUp(e:MouseEvent = null):void {
			if(!active || !Input.mouseReleased) return;
			if(world && world != FP.world)
			{
				removed();
				return;
			}
			if(isDragging) stopDragging();
		}
		
		protected function startDragging():void {
			FP.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove, false, 0, true);
			isDragging = true;
		}
		
		protected function stopDragging():void {
			FP.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			isDragging = false;
		}
		
		protected function onMouseMove(e:MouseEvent = null):void {
			if(world && world != FP.world)
			{
				removed();
				return;
			}
			updateValue();
		}		
		
		/**
		 * Updates the value of the slider according to the mouse position, and calls onChanged if it has changed.
		 */
		protected function updateValue():void {
			var oldValue:Number = _value;
			
			if (horizontal) {
				value = ((Input.mouseX+FP.camera.x - x - (handleLength/2)) / (width - handleLength)) * (maxValue);
			} else {
				value = ((Input.mouseY+FP.camera.y - y - (handleLength/2)) / (height - handleLength)) * (maxValue);
			}
			
			if (oldValue != _value && onChanged is Function) onChanged(_value);
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
				if(isDragging) stopDragging();
				FP.stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				FP.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			}
		}
		
		/**
		 * Helper function to check whether the mouse is over the handle.
		 * @return true if mouse is over handle.
		 */
		protected function mouseIsOverHandle():Boolean {
			if (	Input.mouseX+FP.camera.x > sliderHandle.x+x && Input.mouseX+FP.camera.x < sliderHandle.x+x + handleWidth
				&&	Input.mouseY+FP.camera.y > sliderHandle.y+y && Input.mouseY+FP.camera.y < sliderHandle.y+y + handleHeight)
				return true;
				
			return false;
		}
		
		/**
		 * Set the slider's value. 
		 */
		public function set value(value:Number):void {
			if (integerValue) value = Math.round(value);
			
			if (value < minValue) {
				_value = minValue;
			} else if (value > maxValue) {
				_value = maxValue;
			} else {
				_value = value;
			}
		}
		
		/**
		 * Get the slider's value.
		 */
		public function get value():Number {
			return _value;
		}
	}

}