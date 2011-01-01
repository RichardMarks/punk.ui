package punk.ui
{
	import flash.geom.Point;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.text.engine.ElementFormat;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	
	/**
	 * @author	AClockWorkLemon (Saxon Landers)
	 * 			contact at info.clockworkgames@gmail.com
	 */
	public class PunkPanel extends Punk9SliceComponent
	{
		
		protected var objects:Array = new Array();
		
		/**
		 * A panel to hold components
		 * @param	x		x position of the element on screen
		 * @param	y		y position of the element on screen
		 * @param	width	width of the element
		 * @param	height	height of the element
		 * @param	skin	if specified, sets a custom skin of this object
		 */
		public function PunkPanel(x:Number = 0, y:Number = 0, width:Number = 48, height:Number = 48, skin:Class = null)
		{
			super(x,y, width, height, new Rectangle(48, 0, 48, 48), 16, skin);
			
		}
		
		override public function render():void 
		{
			super.render();
			
			for (var a:int = 0; a <= objects.length; a++)
			{
				if (objects[a])
				{
					for (var b:int = 0; b <= objects[a].length; b++)
					{
						if (objects[a][b]) objects[a][b].render();
					}
				}
			}
			
		}
		
		override public function update():void 
		{
			super.update();
			
			for (var a:int = 0; a <= objects.length; a++)
			{
				if (objects[a])
				{
					for (var b:int = 0; b <= objects[a].length; b++)
					{
						if (objects[a][b]) objects[a][b].update();
					}
				}
			}
			
		}
		
		/**
		 * Adds an Image to the PunkPanel
		 * @param	toAdd		The object to add
		 * @param	x			The x Position to place the object RELATIVE to the Panel's x Position
		 * @param	y			The y Position to place the object RELATIVE to the Panel's y Position
		 * @param	layer		The z depth of the object. (The higher, the closer to the top)
		 */
		public function add(toAdd:*, x:Number = 0, y:Number = 0, layer:int = 0):void
		{
			if (layer < 0) layer = 0;
			if (!objects[layer]) objects[layer] = new Array;
			
			toAdd.x = this.x + x;
			toAdd.y = this.y + y;
			
			objects[layer].push(toAdd);
		}
		
		/**
		 * Removes a previously added object from the panel.
		 * @param	toRemove	The object to remove
		 */
		public function remove(toRemove:*):void
		{
			for (var a:int = 0; a <= objects.length; a++)
			{
				if (objects[a])
				{
					for (var b:int = 0; b <= objects[a].length; b++)
					{
						if (objects[a][b] == toRemove) objects[a][b] = null
					}
				}
			}
		}
		
	}
}