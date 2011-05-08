package punk.ui
{
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	
	/**
	 * @author PigMess
	 * @author AClockWorkLemon
	 * @author Rolpege
	 */
	
	public class PunkUIComponent extends Entity
	{		
		/** class constructor
		 * @param x - position of the component on the X axis
		 * @param y - position of the component on the Y axis
		 * @param width - width of the component
		 * @param height - height of the component
		 */
		public function PunkUIComponent(x:Number = 0, y:Number = 0, width:int = 1, height:int = 1)
		{
			super(x, y);
			this.width = width;
			this.height = height;
		}
		
		public function get relativeX():Number
		{
			if(_panel) return x - _panel.x;
			return x;
		}
		
		public function get relativeY():Number
		{
			if(_panel) return y - _panel.y;
			return y;
		}
		
		public function set relativeX(value:Number):void
		{
			if(_panel) x = value + _panel.x;
			else x = value;
		}
		
		public function set relativeY(value:Number):void
		{
			if(_panel) y = value + _panel.y;
			else y = value;
		}
		
		internal var _camera:Point;
		internal var _panel:PunkPanel;
	}
}
