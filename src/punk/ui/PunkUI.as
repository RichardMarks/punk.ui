package punk.ui
{
	import net.flashpunk.Entity;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;

	public class PunkUI
	{
		public static const VERSION:String = "1.0dev";
		
		/**
		 * Is the mouse over an Entity?
		 *  
		 * This additional function is needed on World: https://github.com/RichardMarks/punk.ui/wiki/Additional-function-on-World
		 * 
		 * @param entity		The entity to check if the mouse is over it.
		 * @param onlyOnTop		Only return true if the entity is on top.
		 * @param screenMouse	Use mouse screen coordinates
		 * @return 				If the mouse is over the entity
		 */		
		public static function mouseIsOver(entity:Entity, onlyOnTop:Boolean = true, screenMouse:Boolean = false):Boolean
		{
			if(!entity.world) return false;
			var w:World = entity.world;
			var mx:Number = w.mouseX;
			var my:Number = w.mouseY;
			if(screenMouse)
			{
				mx = Input.mouseX;
				my = Input.mouseY;
			}
			var x:Number = entity.x;
			var y:Number = entity.y;
			
			if(entity.collidePoint(x, y, mx, my))
			{
				if(!onlyOnTop) return true;
				return w.frontCollidePoint(mx, my) == entity;
			}
			return false;
		}
	}
}