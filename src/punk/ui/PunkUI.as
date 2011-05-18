package punk.ui
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	
	import punk.ui.skin.PunkSkin;
	import punk.ui.skins.YellowAfterlife;

	public final class PunkUI
	{
		/**
		 * The current version of Punk.UI
		 */
		public static const VERSION:String = "1.0";
		
		/**
		 * The current skin being used by Punk.UI
		 */
		public static var skin:PunkSkin = new YellowAfterlife;
		
		/**
		 * Determines if the mouse cursor is hovering over a PunkUIComponent
		 * @param	component the component to test
		 * @param	onlyOnTop only return true if the component being tested is the top most element
		 * @param	screenMouse If the mouse coordinates system should be relative to the screen
		 * @return Boolean value indicating if the supplied component has the mouse hovering over it
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