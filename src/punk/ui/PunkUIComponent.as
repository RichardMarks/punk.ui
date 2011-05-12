package punk.ui
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	
	import punk.ui.skin.PunkSkin;
	import punk.ui.skin.SkinImage;
	
	/**
	 * @author PigMess
	 * @author AClockWorkLemon
	 * @author Rolpege
	 */
	
	public class PunkUIComponent extends Entity
	{		
		/** class constructor
		 * @param x - position of the component on the X axis
		 * @param y - position of the component on the Y axis
		 * @param width - width of the component
		 * @param height - height of the component
		 */
		public function PunkUIComponent(x:Number = 0, y:Number = 0, width:int = 1, height:int = 1, skin:PunkSkin = null)
		{
			super(x, y);
			this.width = width;
			this.height = height;
			
			var s:PunkSkin = skin ? skin : PunkUI.skin;
			if(s) setupSkin(s);
		}
		
		protected function setupSkin(skin:PunkSkin):void
		{
			
		}
		
		protected function getSkinImage(skinImage:SkinImage, width:int=0, height:int=0):Image
		{
			if(!skinImage) return null;
			var b:BitmapData = skinImage.getBitmap(width ? width : this.width, height ? height : this.height);
			return (b ? new Image(b) : null);
		}
		
		public function get relativeX():Number
		{
			if(_panel) return x - _panel.x - _panel._scrollX;
			return x;
		}
		
		public function get relativeY():Number
		{
			if(_panel) return y - _panel.y - _panel._scrollY;
			return y;
		}
		
		public function set relativeX(value:Number):void
		{
			if(_panel) x = value + _panel.x + _panel._scrollX;
			else x = value;
		}
		
		public function set relativeY(value:Number):void
		{
			if(_panel) y = value + _panel.y + _panel._scrollY;
			else y = value;
		}
		
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
