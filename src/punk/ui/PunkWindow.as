package punk.ui
{
	import net.flashpunk.Graphic;
	import net.flashpunk.utils.Input;
	
	public class PunkWindow extends PunkPanel
	{
		protected var dragging:Boolean = false;
		protected var mouseOffsetX:Number = 0;
		protected var mouseOffsetY:Number = 0;
		
		public function PunkWindow(x:Number=0, y:Number=0, width:int=20, height:int=20, background:Graphic=null)
		{
			super(x, y, width, height, background);
		}
		
		override public function update():void
		{
			super.update();
			
			if(Input.mousePressed && PunkUI.mouseIsOver(this))
			{
				dragging = true;
				mouseOffsetX = x - world.mouseX;
				mouseOffsetY = y - world.mouseY;
				if(world) world.bringToFront(this);
			}
			
			if(dragging)
			{
				x = mouseOffsetX + world.mouseX;
				y = mouseOffsetY + world.mouseY;
			}
			
			if(Input.mouseReleased) dragging = false;
		}
	}
}