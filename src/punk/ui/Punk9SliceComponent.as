package punk.ui 
{
	import flash.display.BitmapData;
	import flash.display.GraphicsBitmapFill;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	/**
	 * A Punk.UI component to be used for 9-sliced components.
	 * 
	 * @author	AClockWorkLemon (Saxon Landers)
	 * 			contact at info.clockworkgames@gmail.com
	 */
	public class Punk9SliceComponent extends PunkUIComponent 
	{
		protected var _topLeft:Image;
		protected var _topCenter:Image;
		protected var _topRight:Image;
		protected var _centerLeft:Image;
		protected var _centerCenter:Image;
		protected var _centerRight:Image;
		protected var _bottomLeft:Image;
		protected var _bottomCenter:Image;
		protected var _bottomRight:Image;
		
		protected var _gfxList:Graphiclist;
		
		protected var _xScale:Number;
		protected var _yScale:Number;
		
		protected var _gridSize:Number;
		
		/**
		 * A PunkUIComponent that uses a 9-sliced background.
		 * @param	x			x position on-screen
		 * @param	y			y position on-screen
		 * @param	width		width of the component
		 * @param	height		height of the component
		 * @param	skin		a custom skin file. if not specified, the default skin will be used
		 * @param	clipRect	a clipping rectangle of the area on the skinfile to 9slice
		 * @param	gridSize	the grid to 9slice the clipRect with
		 */
		public function Punk9SliceComponent(x:Number = 0, y:Number = 0, width:Number = 1, height:Number = 1, clipRect:Rectangle = null, gridSize:Number = 0, skin:Class = null)
		{
			super(x, y, width, height, skin);
			
			_gridSize = gridSize;
			
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
			
			_gfxList = new Graphiclist(_topLeft, _topCenter, _topRight, _centerLeft, _centerCenter, _centerRight, _bottomLeft, _bottomCenter, _bottomRight);
			graphic = _gfxList;
			
		}
		
		override public function update():void 
		{
			if (width < _gridSize * 2) width = _gridSize * 2;
			if (height < _gridSize * 2) height = _gridSize * 2;
			
			_xScale = (width - _gridSize * 2) / _gridSize;
			_yScale = (height - _gridSize * 2) / _gridSize;
			
			_topCenter.scaleX = _xScale;
			_centerLeft.scaleY = _yScale;
			_centerCenter.scaleX = _xScale;
			_centerCenter.scaleY = _yScale;
			_centerRight.scaleY = _yScale;
			_bottomCenter.scaleX = _xScale;
			
			_topCenter.x = _gridSize ;
			_topRight.x = _gridSize + (_xScale * _gridSize) ;
			_centerLeft.y = _gridSize ;
			_centerCenter.x = _gridSize ;
			_centerCenter.y = _gridSize ;
			_centerRight.x = _gridSize + (_xScale * _gridSize);
			_centerRight.y = _gridSize ;
			_bottomLeft.y =  _gridSize + (_yScale * _gridSize);
			_bottomCenter.x = _gridSize ;
			_bottomCenter.y = _gridSize + (_yScale * _gridSize);
			_bottomRight.x = _gridSize + (_xScale * _gridSize);
			_bottomRight.y = _gridSize + (_yScale * _gridSize);
			
		}
		
	}

}