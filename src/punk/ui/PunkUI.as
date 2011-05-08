package punk.ui
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;

	public final class PunkUI
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
		public static function mouseIsOver(component:PunkUIComponent, onlyOnTop:Boolean = true, screenMouse:Boolean = false):Boolean
		{
			var w:* = component.world ? component.world : component._panel;
			var mx:Number = w.mouseX;
			var my:Number = w.mouseY;
			if(screenMouse)
			{
				mx = Input.mouseX;
				my = Input.mouseY;
			}
			var x:Number = component.x;
			var y:Number = component.y;
			
			var collide:Boolean = false;
			
			if(!onlyOnTop) collide = component.collidePoint(x, y, mx, my);
			else collide = w.frontCollidePoint(mx, my) == component;
			
			if(component._panel) collide = collide && component._panel.collidePoint(component._panel.x, component._panel.y, mx, my);
			
			return collide;
		}
	}
}