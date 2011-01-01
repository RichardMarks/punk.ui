package punk.ui
{
	import flash.events.*;
	import flash.text.*;
	
	import net.flashpunk.FP;
	
	/**
	 * @author PigMess
	 */

	public class PunkTextArea extends PunkLabel
	{
		public function PunkTextArea(x:Number = 0, y:Number = 0, width:uint = 1, height:uint = 1) {
			super("", x, y, width, height);
			
			this._textField.type = TextFieldType.INPUT;
			this._textField.useRichTextClipboard = false;
			this._textField.mouseEnabled = true;
			this._textField.mouseWheelEnabled = true;
			this._textField.selectable = true;
		}
	}
}
