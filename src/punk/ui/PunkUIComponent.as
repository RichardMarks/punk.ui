package punk.ui
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	
	import punk.ui.skin.PunkSkin;
	import punk.ui.skin.PunkSkinImage;
	
	/**
	 * Base class for all Punk.UI components
	 */
	public class PunkUIComponent extends Entity
	{		
		/**
		 * Constructor
		 * @param	x X-Coordinate to place the component
		 * @param	y Y-Coordinate to place the component
		 * @param	width Width of the component
		 * @param	height Height of the component
		 * @param	skin Skin to style this component with
		 */
		public function PunkUIComponent(x:Number = 0, y:Number = 0, width:int = 1, height:int = 1, skin:PunkSkin = null)
		{
			super(x, y);
			this.width = width;
			this.height = height;
			
			var s:PunkSkin = skin ? skin : PunkUI.skin;
			if(s) setupSkin(s);
		}
		
		/**
		 * Override this, called by components extending this class to do skin specific setup
		 * @param	skin the PunkSkin to use for custom skin setup
		 */
		
		protected function setupSkin(skin:PunkSkin):void
		{
			
		}
		
		/**
		 * Returns the FlashPunk Image representation of a PunkSkinImage, cropped to the supplied width and height, if available
		 * @param	skinImage the PunkSkinImage to convert to a FlashPunk Image
		 * @param	width Width of the image section to return
		 * @param	height Height of the image section to return
		 * @return FlashPunk Image copy of the PunkSkinImage or null if no skin image is supplied.
		 */
		protected function getSkinImage(skinImage:PunkSkinImage, width:int=0, height:int=0):Image
		{
			if(!skinImage) return null;
			var b:BitmapData = skinImage.getBitmap(width ? width : this.width, height ? height : this.height);
			return (b ? new Image(b) : null);
		}
		
		/**
		 * Relative X-Coordinate for the component
		 */
		public function get relativeX():Number
		{
			if(_panel) return x - _panel.x - _panel.scrollX;
			return x;
		}
		
		/**
		 * relative Y-Coordinate for the component
		 */
		public function get relativeY():Number
		{
			if(_panel) return y - _panel.y - _panel.scrollY;
			return y;
		}
		
		/**
		 * Relative X-Coordinate for the component
		 */
		public function set relativeX(value:Number):void
		{
			if(_panel) x = value + _panel.x + _panel.scrollX;
			else x = value;
		}
		
		/**
		 * Relative Y-Coordinate for the component
		 */
		public function set relativeY(value:Number):void
		{
			if(_panel) y = value + _panel.y + _panel.scrollY;
			else y = value;
		}
		
		/**
		 * Cause the supplied Graphic to be rendered
		 * @param	graphic the Graphic to render
		 */
		protected function renderGraphic(graphic:Graphic):void
		{
			if(graphic && graphic.visible)
			{
				if (graphic.relative)
				{
					_point.x = x;
					_point.y = y;
				}
				else _point.x = _point.y = 0;
				graphic.render(renderTarget ? renderTarget : FP.buffer, _point, _camera ? _camera : FP.camera);
			}
		}
		
		internal var _camera:Point;
		protected var _point:Point = new Point;
		internal var _panel:PunkPanel;
	}
}
