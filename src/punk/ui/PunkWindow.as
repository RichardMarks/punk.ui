package punk.ui
{
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	
	import punk.ui.skin.PunkSkin;
	
	public class PunkWindow extends PunkPanel
	{
		protected var dragging:Boolean = false;
		
		public var draggable:Boolean = true;
		
		protected var mouseOffsetX:Number = 0;
		protected var mouseOffsetY:Number = 0;
		
		protected var captionString:String = "";
		
		public var caption:PunkText;
		protected var bar:Image;
		protected var bg:Image;
		
		public function PunkWindow(x:Number=0, y:Number=0, width:int=20, height:int=20, caption:String = "", draggable:Boolean = true, skin:PunkSkin=null)
		{
			captionString = caption;
			super(x, y, width, height, skin);
			
			this.draggable = draggable;
			
			if(bg) graphiclist.add(bg);
		}
		
		override protected function setupSkin(skin:PunkSkin):void
		{
			if(!skin.punkWindow) return;
			
			caption = new PunkText(captionString, 0, 0, skin.punkWindow.labelProperties);
			var barHeight:int = skin.punkWindow.bar.height;
			bar = getSkinImage(skin.punkWindow.bar, 0, barHeight);
			bg = getSkinImage(skin.punkWindow.body, 0, height - barHeight);
			bg.y = barHeight;
		}
		
		override public function update():void
		{
			super.update();
			
			if(!draggable) return;
			
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
		
		override public function render():void
		{
			super.render();
			
			renderGraphic(bar);
			renderGraphic(caption);
		}
	}
}