package punk.ui
{
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.utils.Input;

	/**
	 * @author Rolpege
	 * @coauthor PigMess
	 */
	
	public class PunkButton extends PunkUIComponent
	{	
		/**
		 * This function will be called when the button is pressed. 
		 */		
		public var callback:Function = null;
		/**
		 * This function will be called when the mouse overs the button. 
		 */		
		public var overCall:Function = null;
		/** 
		 * @private
		 */
		protected var overCalled:Boolean = false;
		
		/**
		 * Graphic of the button when active and not pressed nor overed.
		 */	
		public var normal:Graphic = new Graphic;
		/**
		 * Graphic of the button when the mouse overs it and it's active.
		 */		
		public var hover:Graphic = new Graphic;
		/**
		 * Graphic of the button when the mouse is pressing it and it's active.
		 */		
		public var down:Graphic = new Graphic;
		/**
		 * Graphic of the button when inactive.
		 * 
		 */
		public var inactive:Graphic = new Graphic;
		
		/**
		 * The button's label 
		 */		
		public var label:PunkLabel;
		
		/**
		 * Constructor.
		 *  
		 * @param x			X coordinate of the button.
		 * @param y			Y coordinate of the button.
		 * @param width		Width of the button's hitbox.
		 * @param height	Height of the button's hitbox.
		 * @param text		Text of the button
		 * @param callback	The function that will be called when the button is pressed.
		 * @param active	Whether the button is active or not.
		 */
		public function PunkButton(x:Number=0, y:Number=0, width:int=1, height:int=1, text:String="Button", callback:Function=null, active:Boolean=true)
		{
			super(x, y, width, height);
			setHitbox(width, height);
			//HERE GETTING GRAPHICS FROM IMAGE
			this.callback = callback;
			label = new PunkLabel(x, y, width, height);
			label.text = text;
			label.color = 0x000000;
			label.background = false;
			active ? this.graphic = normal : this.graphic = inactive;
		}
		
		/**
		 * @private 
		 */
		override public function update():void
		{
			if(this.graphic != inactive) {
				super.update();
				
				if(collidePoint(x, y, Input.mouseX, Input.mouseY))
				{
					if(Input.mouseDown)
					{
						this.graphic = down;
					}
					else
					{
						this.graphic = hover;
						
						if(!overCalled)
						{
							if(overCall != null) overCall();
							overCalled = true;
						}
					}
				}
				else
				{
					this.graphic = normal;
					overCalled = false;
				}
			}
			
			label.update();
		}
		
		public function onMouseUp(e:MouseEvent = null):void {
			if(this.graphic == inactive || !Input.mouseReleased || (callback == null)) return;
			if(this.collidePoint(this.x, this.y, Input.mouseX, Input.mouseY)) callback();
		}
		
		/**
		 * @private
		 */
		override public function added():void {
			super.added();
			
			label.added();
			
			if(FP.stage) {
				FP.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			}
		}
		
		/**
		 * @private
		 */
		override public function removed():void {
			super.removed();
			
			label.removed();
			
			if(FP.stage) {
				FP.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			}
		}
	}
}
