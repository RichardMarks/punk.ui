package punk.ui 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author AClockWorkLemon
	 */
	public class Punk9Slice 
	{
		protected var _skin:Class;
		
		protected var _topLeft:Image;
		protected var _topCenter:Image;
		protected var _topRight:Image;
		protected var _centerLeft:Image;
		protected var _centerCenter:Image;
		protected var _centerRight:Image;
		protected var _bottomLeft:Image;
		protected var _bottomCenter:Image;
		protected var _bottomRight:Image;
		
		protected var _bitmap:BitmapData;
		protected var _image:Image;
		
		protected var _xScale:Number;
		protected var _yScale:Number;
		
		protected var _gridSize:Number;
		
		protected var width:Number;
		protected var height:Number;
		
		/**
		 * Constructor. Initiates the Punk9Slice
		 * @param	width		Initial Width of the 9slice
		 * @param	height		Initial Height of the 9slice
		 * @param	clipRect	Rectangle of the area on the skin to use
		 * @param	gridSize	Grid spacing to use when chopping
		 * @param	skin		optional custom skin
		 */
		public function Punk9Slice(width:Number, height:Number, clipRect:Rectangle = null, gridSize:Number = 0, skin:Class = null)
		{
			_gridSize = gridSize;
			_skin = skin;
			this.width = width;
			this.height = height;
			
			if (clipRect == null) clipRect = new Rectangle(0, 0, 1, 1);
			
			_topLeft = new Image(_skin, new Rectangle(clipRect.x, clipRect.y, gridSize, gridSize));
			_topCenter = new Image(_skin, new Rectangle(clipRect.x + _gridSize, clipRect.y, gridSize, gridSize));
			_topRight = new Image(_skin, new Rectangle(clipRect.x + _gridSize * 2, clipRect.y, gridSize, gridSize));
			_centerLeft = new Image(_skin, new Rectangle(clipRect.x, clipRect.y + _gridSize, gridSize, gridSize));
			_centerCenter = new Image(_skin, new Rectangle(clipRect.x + _gridSize, clipRect.y + _gridSize, gridSize, gridSize));
			_centerRight = new Image(_skin, new Rectangle(clipRect.x + _gridSize * 2, clipRect.y + _gridSize, gridSize, gridSize));
			_bottomLeft = new Image(_skin, new Rectangle(clipRect.x, clipRect.y + _gridSize * 2, gridSize, gridSize));
			_bottomCenter = new Image(_skin, new Rectangle(clipRect.x + _gridSize, clipRect.y + _gridSize * 2, gridSize, gridSize));
			_bottomRight = new Image(_skin, new Rectangle(clipRect.x + _gridSize * 2, clipRect.y + _gridSize * 2, gridSize, gridSize));
		}
		
		/**
		 * Updates the Image. Make sure to set graphic = output image afterwards.
		 * @param	width	New width
		 * @param	height	New height
		 * @return
		 */
		public function update9Slice(width:Number, height:Number):Image
		{
			this.width = width;
			this.height = height;
			
			if (this.width < _gridSize * 2) this.width = _gridSize * 2;
			if (this.height < _gridSize * 2) this.height = _gridSize * 2;
			
			_xScale = (this.width - _gridSize * 2) / _gridSize;
			_yScale = (this.height - _gridSize * 2) / _gridSize;
			
			_topCenter.scaleX = _xScale;
			_centerLeft.scaleY = _yScale;
			_centerCenter.scaleX = _xScale;
			_centerCenter.scaleY = _yScale;
			_centerRight.scaleY = _yScale;
			_bottomCenter.scaleX = _xScale;
			
			_topCenter.x = _gridSize /2;
			_topRight.x = (_gridSize + (_xScale * _gridSize)) /2;
			_centerLeft.y = _gridSize /2;
			_centerCenter.x = _gridSize /2;
			_centerCenter.y = _gridSize /2;
			_centerRight.x = (_gridSize + (_xScale * _gridSize))/2;
			_centerRight.y = _gridSize /2;
			_bottomLeft.y =  (_gridSize + (_yScale * _gridSize))/2;
			_bottomCenter.x = _gridSize /2;
			_bottomCenter.y = (_gridSize + (_yScale * _gridSize))/2;
			_bottomRight.x = (_gridSize + (_xScale * _gridSize))/2;
			_bottomRight.y = (_gridSize + (_yScale * _gridSize))/2;
			
			_bitmap = new BitmapData(this.width,this.height);
			
			_topLeft.render(_bitmap, new Point(_topLeft.x, _topLeft.y), FP.camera);
			_topCenter.render(_bitmap, new Point(_topCenter.x, _topCenter.y), FP.camera);
			_topRight.render(_bitmap, new Point(_topRight.x, _topRight.y), FP.camera);
			_centerLeft.render(_bitmap, new Point(_centerLeft.x, _centerLeft.y), FP.camera);
			_centerCenter.render(_bitmap, new Point(_centerCenter.x, _centerCenter.y), FP.camera);
			_centerRight.render(_bitmap, new Point(_centerRight.x, _centerRight.y), FP.camera);
			_bottomLeft.render(_bitmap, new Point(_bottomLeft.x, _bottomLeft.y), FP.camera);
			_bottomCenter.render(_bitmap, new Point(_bottomCenter.x, _bottomCenter.y), FP.camera);
			_bottomRight.render(_bitmap, new Point(_bottomRight.x, _bottomRight.y), FP.camera);
			
			_image = new Image(_bitmap);
			return _image;
		}
		
	}

}