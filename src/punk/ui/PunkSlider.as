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
		
		private static const HANDLE_WIDTH:uint = 16;
		
		protected var sliderHandle:Graphic;
		protected var inactiveSliderHandle:Graphic;
		
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
		
		protected var isHovered:Boolean = false;
		protected var isDragging:Boolean;
		protected var initialised:Boolean = false;
		
		public function PunkSlider(	x:Number=0, y:Number=0, width:int=100, onChanged:Function=null, 
									minValue:Number=0, maxValue:Number=100, defaultValue:Number=0, integerValue:Boolean=true, skin:PunkSkin=null, active:Boolean=true) { 
			super(x, y, width, HANDLE_WIDTH, skin);
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
			
			if (!skin.punkButton || !skin.punkToggleButton) return;
			
			// Uses button and togglebutton skin at the moment
			graphic = getSkinImage(skin.punkButton.normal);
			sliderHandle = getSkinImage(skin.punkToggleButton.normalOn, HANDLE_WIDTH, HANDLE_WIDTH);
			inactiveSliderHandle = getSkinImage(skin.punkToggleButton.inactive, HANDLE_WIDTH, HANDLE_WIDTH);
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
			
			if(PunkUI.mouseIsOver(this, true)) {
				isHovered = true;
			}
			else {
				isHovered = false;
			}
			
		}
		
		/**
		 * @private
		 */
		override public function render():void {
			
			renderGraphic(graphic);
			
			sliderHandle.x = (value / maxValue) * (width-HANDLE_WIDTH);
			sliderHandle.y = -(HANDLE_WIDTH/2) + height / 2;
			if(active) {
				renderGraphic(sliderHandle);
			}
			else {
				renderGraphic(inactiveSliderHandle);
			}
			
		}
		
		protected function onMouseDown(e:MouseEvent = null):void {
			if (!active || !Input.mousePressed) return;
			if (isHovered) {
				updateValue();
				startDragging();
			}
		}
			
		protected function onMouseUp(e:MouseEvent = null):void {
			if(!active || !Input.mouseReleased) return;
			stopDragging();
		}
		
		protected function startDragging():void {
			FP.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove, false, 0, true);
		}
		
		protected function stopDragging():void {
			FP.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		protected function onMouseMove(e:MouseEvent = null):void {
			updateValue();
		}		
		
		protected function updateValue():void {
			var oldValue:Number = _value;
			value = ((Input.mouseX - x - (HANDLE_WIDTH/2)) / (width - HANDLE_WIDTH)) * (maxValue); //clamped by setter
			if (oldValue != _value) onChanged(_value);
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
		
		/**
		 * Set the sliders value.
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
		 * Get the sliders value.
		 */
		public function get value():Number {
			return _value;
		}
	}

}