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
		public function PunkTextArea(x:Number = 0, y:Number = 0, width:uint = 0, height:uint = 0) {
			super("", x, y, width, height);
			
			this._textField.type = TextFieldType.INPUT;
			this._textField.useRichTextClipboard = false;
			this._textField.mouseEnabled = true;
			this._textField.mouseWheelEnabled = true;
			this._textField.selectable = true;
		}
		
		override public function added():void
		{
			super.added();
			FP.stage.addChild(_textField);
		}
		
		override public function removed():void
		{
			super.removed();
			FP.stage.removeChild(_textField);
		}
	}
}
