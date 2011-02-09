package punk.ui
{
	import net.flashpunk.Entity;
	
	/**
	 * @author PigMess
	 * @author AClockWorkLemon
	 * @author Rolpege
	 */
	
	public class PunkUIComponent extends Entity
	{
		[Embed(source = 'defaultSkin.gif')] protected var _defaultSkin:Class;
		
		/** class constructor
		 * @param x - position of the component on the X axis
		 * @param y - position of the component on the Y axis
		 * @param width - width of the component
		 * @param height - height of the component
		 */
		public function PunkUIComponent(x:Number = 0, y:Number = 0, width:int = 1, height:int = 1, skin:Class = null) {
			super(x, y);
			this.width = width;
			this.height = height;
			_skin = skin || _defaultSkin;
		}
		
		protected var _skin:Class;
	}
}
