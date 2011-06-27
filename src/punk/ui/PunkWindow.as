package punk.ui
{
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	
	import punk.ui.skin.PunkSkin;
	
	/**
	 * A window component.
	 */
	public class PunkWindow extends PunkPanel
	{
		/**
		 * If the component is being moved
		 */
		protected var dragging:Boolean = false;
		
		/**
		 * If the component can be dragged by the user using the mouse.
		 */
		public var draggable:Boolean = true;
		
		/**
		 * Offset used to track the Mouse's X-Coordinate
		 */
		protected var mouseOffsetX:Number = 0;
		/**
		 * Offset used to track the Mouse's Y-Coordinate
		 */
		protected var mouseOffsetY:Number = 0;
		
		/**
		 * The component's caption String
		 */
		protected var captionString:String = "";
		
		/**
		 * The graphical representation of its caption String
		 */
		public var caption:PunkText;
		
		/**
		 * Image used for the component's bar
		 */
		protected var bar:Image;
		/**
		 * Image used for the component's backgroun
		 */
		protected var bg:Image;

		/**
		 * Height of the caption bar.
		 */
		protected var barHeight:int;
		
		/**
		 * Constructor
		 * @param	x X-Coordinate of the component
		 * @param	y Y-Coordinate of the component
		 * @param	width Width of the component
		 * @param	height Height of the component
		 * @param	caption String for the component's caption
		 * @param	draggable Whether the component can be dragged by the user using the mouse.
		 * @param	skin Skin to use when rendering the component
		 */
		public function PunkWindow(x:Number=0, y:Number=0, width:int=20, height:int=20, caption:String = "", draggable:Boolean = true, skin:PunkSkin=null)
		{
			captionString = caption;
			super(x, y, width, height, skin);
			
			setHitbox(width, height, 0, barHeight);
			
			this.draggable = draggable;
			
		}
		
		/**
		 * Additional setup steps for this component
		 * @param	skin Skin to use when rendering the component
		 */
		override protected function setupSkin(skin:PunkSkin):void
		{
			if(!skin.punkWindow) return;
			
			barHeight = skin.punkWindow.bar.height;
			caption = new PunkText(captionString, 0, 0, skin.punkWindow.labelProperties);
			caption.y -= barHeight;
			bar = getSkinImage(skin.punkWindow.bar, 0, barHeight);
			bg = getSkinImage(skin.punkWindow.body, 0, height - barHeight);
			bar.y = -barHeight;
		}
		
		/**
		 * @private
		 */
		override public function update():void
		{
			if(draggable)
			{
				if(Input.mousePressed && PunkUI.mouseIsOver(this) && (Input.mouseY + FP.camera.y) < y)
				{
					dragging = true;
					mouseOffsetX = x - (Input.mouseX + FP.camera.x);
					mouseOffsetY = y - (Input.mouseY + FP.camera.y);
					if(world) world.bringToFront(this);
				}
				
				if(dragging)
				{
					x = mouseOffsetX + (Input.mouseX + FP.camera.x);
					y = mouseOffsetY + (Input.mouseY + FP.camera.y);
				}
			
				if(Input.mouseReleased) dragging = false;
			}
			
			super.update();
		}
		
		/**
		 * @private
		 */
		override public function render():void
		{
			renderGraphic(bg);
			renderGraphic(bar);
			renderGraphic(caption);
			
			super.render();
		}
	}
}