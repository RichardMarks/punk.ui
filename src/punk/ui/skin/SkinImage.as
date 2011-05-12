package punk.ui.skin
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;

	public class SkinImage
	{
		protected var s:BitmapData;
		
		protected var nineSlice:Boolean;
		
		public function SkinImage(source:*, nineSlice:Boolean=true, leftWidth:int = 0, rightWidth:int = 0, topHeight:int = 0, bottomHeight:int = 0)
		{
			if(source is Class)
			{
				s = FP.getBitmap(source);
			}
			else
			{
				s = source;
			}
			
			this.nineSlice = nineSlice;
			
			if(nineSlice)
			{
				topL = new BitmapData(leftWidth, topHeight, true, 0);
				topC = new BitmapData(s.width - leftWidth - rightWidth, topHeight, true, 0);
				topR = new BitmapData(rightWidth, topHeight, true, 0);
				medL = new BitmapData(leftWidth, s.height - topHeight - bottomHeight, true, 0);
				medC = new BitmapData(s.width - leftWidth - rightWidth, s.height - topHeight - bottomHeight, true, 0);
				medR = new BitmapData(rightWidth, s.height - topHeight - bottomHeight, true, 0);
				botL = new BitmapData(leftWidth, bottomHeight, true, 0);
				botC = new BitmapData(s.width - leftWidth - rightWidth, bottomHeight, true, 0);
				botR = new BitmapData(rightWidth, bottomHeight, true, 0);
				
				_rect.width = s.width;
				_rect.height = s.height;
				
				topL.copyPixels(s, _rect, FP.zero, null, null, true);
				_rect.x = leftWidth;
				topC.copyPixels(s, _rect, FP.zero, null, null, true);
				_rect.x  = s.width - rightWidth;
				topR.copyPixels(s, _rect, FP.zero, null, null, true);
				_rect.y = topHeight;
				_rect.x = 0;
				medL.copyPixels(s, _rect, FP.zero, null, null, true);
				_rect.x = leftWidth;
				medC.copyPixels(s, _rect, FP.zero, null, null, true);
				_rect.x = s.width - rightWidth;
				medR.copyPixels(s, _rect, FP.zero, null, null, true);
				_rect.y = s.height - bottomHeight;
				_rect.x = 0;
				botL.copyPixels(s, _rect, FP.zero, null, null, true);
				_rect.x = leftWidth;
				botC.copyPixels(s, _rect, FP.zero, null, null, true);
				_rect.x = s.width - rightWidth;
				botR.copyPixels(s, _rect, FP.zero, null, null, true);
			}
		}
		
		public function getBitmap(width:int, height:int):BitmapData
		{
			if(!nineSlice) return s;
			
			var bd:BitmapData = new BitmapData(width, height, true, 0);
			
			fill(medC, bd, medL.width, topC.height, width - medL.width - medR.width, height - topC.height - botC.height);
			fill(topC, bd, 0, 0, width, topC.height);
			fill(medL, bd, 0, 0, medL.width, height);
			fill(medR, bd, width - medR.width, 0, medR.width, height);
			fill(botC, bd, 0, height - botC.height, width, botC.height);
			
			bitmapOnRect(topL, 0, 0);
			bd.copyPixels(topL, _rect, _point);
			bitmapOnRect(topR, width - topR.width, 0);
			bd.copyPixels(topR, _rect, _point);
			bitmapOnRect(botL, 0, height - botL.height);
			bd.copyPixels(botL, _rect, _point);
			bitmapOnRect(botR, width - botR.width, height - botR.height);
			bd.copyPixels(botR, _rect, _point);
			return bd;
		}
		
		protected function fill(s:BitmapData, d:BitmapData, x:int, y:int, w:int, h:int):void
		{
			_graphics.clear();
			_graphics.beginBitmapFill(s);
			_graphics.drawRect(0, 0, w, h);
			_matrix.tx = x;
			_matrix.ty = y;
			d.draw(FP.sprite, _matrix);
		}
		
		protected function bitmapOnRect(bitmapData:BitmapData, x:int, y:int):void
		{
			_rect.x = 0;
			_rect.y = 0;
			_rect.width = bitmapData.width;
			_rect.height = bitmapData.height;
			_point.x = x;
			_point.y = y;
		}
		
		public function get height():int
		{
			return s.height;
		}
		
		private var topL:BitmapData;
		private var topC:BitmapData;
		private var topR:BitmapData;
		private var medL:BitmapData;
		private var medC:BitmapData;
		private var medR:BitmapData;
		private var botL:BitmapData;
		private var botC:BitmapData;
		private var botR:BitmapData;
		
		private var _graphics:Graphics = FP.sprite.graphics;
		private var _rect:Rectangle = new Rectangle;
		private var _point:Point = new Point;
		private var _matrix:Matrix = new Matrix;
	}
}