package punk.ui
{
	import net.flashpunk.Graphic;
	
	/**
	 * @author PigMess 
	 * Base class for all punk.ui components
	 */
	public class PunkUIComponent extends Graphic
	{
		/** class constructor
		 * @param x - position of the component on the X axis
		 * @param y - position of the component on the Y axis
		 * @param width - width of the component
		 * @param height - height of the component
		 */
		public function PunkUIComponent(x:Number = 0, y:Number = 0, width:uint = 1, height:uint = 1) {
			super();
			this.x = x;
			this.y = y;
			_width = width;
			_height = height;
		}
		
		/** sets the width of the component */
		public function set width(width:uint):void {
			_width = width;
		}
		
		/** @return the width of the component */
		public function get width():uint {
			return _width;
		}
		
		/** sets the height of the component */
		public function set height(height:uint):void {
			_height = height;
		}
		
		/** @return the height of the component */
		public function get height():uint {
			return _height;
		}
		
		protected var _width:uint;
		protected var _height:uint;
	}
}