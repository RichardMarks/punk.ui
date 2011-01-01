package punk.ui
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import net.flashpunk.graphics.Image;
	
	/**
	 * @author PigMess
	 */

	public class PunkTextField extends PunkTextArea
	{	
		public function PunkTextField(x:Number = 0, y:Number = 0, width:uint = 1, height:uint = 1) {
			super(x, y, width, height);
			this._textField.multiline = false;
			_textField.wordWrap = false;
		}
	}
