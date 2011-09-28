package punk.ui
{
	import flash.geom.Point;

	/**
	 * A simple grid layout helper. 
	*/
	 public class PunkGrid
	{
		private var _gridPosition:Point;
		private var _currentCellPosition:Point;
		private var _distanceBetweenPoints:Point;
		private var _columns:int;
		
		/**
		 * Constructor
		 * @param	gridPositionX X position of grid in pixels
		 * @param	gridPositionY Y position of grid in pixels
		 * @param	distanceBetweenCellsX X distance between cells
		 * @param	distanceBetweenCellsY Y distance between cells
		 * @param	columns number of cells in each line
		*/
		public function PunkGrid(gridPositionX:Number = 0, gridPositionY:Number =0, distanceBetweenCellsX:Number = 0, distanceBetweenCellsY:Number = 0, cellsPerLine:int = 4)
		{
			_gridPosition = new Point(gridPositionX,gridPositionY);
			_currentCellPosition = new Point();
			_distanceBetweenPoints = new Point(distanceBetweenCellsX,distanceBetweenCellsY);
			_columns = cellsPerLine;
		}
		
		/**
		 * Sets x and y variabels to next cell position
		*/
		public function nextCell():void
		{
			_currentCellPosition.x += 1;
			
			if( _currentCellPosition.x >= _columns )
			{
				_currentCellPosition.x = 0;
				_currentCellPosition.y += 1;
			}
		}
		
		/**
		 * x position of current cell, use nextCell() to go to next one.
		*/
		public function get x():Number
		{
			return _gridPosition.x + _currentCellPosition.x * _distanceBetweenPoints.x;
		}
		
		/**
		 * y position of current cell, use nextCell() to go to next one.
		 */
		public function get y():Number
		{
			return  _gridPosition.y + _currentCellPosition.y * _distanceBetweenPoints.y;
		}
		
		
	}
}