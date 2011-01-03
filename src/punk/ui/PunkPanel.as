package punk.ui
{
	import flash.geom.Point;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.text.engine.ElementFormat;
	import net.flashpunk.Graphic;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	/**
	 * @author	AClockWorkLemon (Saxon Landers)
	 * 			contact at info.clockworkgames@gmail.com
	 */
	public class PunkPanel extends Punk9SliceComponent
	{
		
		protected var children:Vector.<Entity> = new Vector.<Entity>()
		
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
		
		/**
		 * Adds an Entity to the PunkPanel
		 * @param	toAdd		The object to add
		 * @param	x			The x Position to place the object RELATIVE to the Panel's x Position
		 * @param	y			The y Position to place the object RELATIVE to the Panel's y Position
		 * @param	layer		The z depth of the object. (The higher, the closer to the top)
		 * @return				A reference to the Entity
		 */
		public function add(toAdd:*, x:Number = 0, y:Number = 0, layer:int = 0):Entity
		{
			var e:Entity;
			
			if (toAdd is Entity) { e = toAdd; }
			else if (toAdd is Graphic) { e = new Entity(0, 0, toAdd); }
			else throw new Error(toAdd + " is not a supported class type")
			
			e.x = this.x + x;
			e.y = this.y + y;
			
			e.layer = this.layer - layer;
			children.push(e);
			
			if (this.world == FP.world) { FP.world.add(e); }
			
			return e;
		}
		
		/**
		 * Removes an object from the PunkPanel
		 * @param	toRemove	The Entity to remove
		 */
		public function remove(toRemove:Entity):void
		{
			for (var i:int = 0; i < children.length; i++ )
			{
				if (children[i] == toRemove) { if (FP.world == toRemove.world) { FP.world.remove(toRemove); } children.splice(i, 1); }
			}
		}
		
		override public function added():void 
		{
			for each (var child:Entity in children) { FP.world.add(child); }
		}
		
		override public function removed():void 
		{
			for each (var child:Entity in children) { if (FP.world == child.world) { FP.world.remove(child); } }
		}
		
	}
}