package punk.ui 
{
	import flash.text.TextFieldType;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	/**
	 * ...
	 * @author Thomas King
	 */
	public class PunkTextArea extends PunkLabel
	{
		public function PunkTextArea(text:String = "", x:Number = 0, y:Number = 0, width:int = 0, height:int = 0) 
		{
			super(text, x, y, width, height);
			FP.stage.addChild(punkText._field);
			graphic = null;
			punkText._field.selectable = true;
			punkText._field.background = true;
			punkText._field.textColor = 0x000000;
			punkText._field.type = TextFieldType.INPUT;
			punkText._field.wordWrap = true;
			punkText._field.width = width ? width : 240;
			punkText._field.height = height ? height : 36;
		}
		
		override public function update():void 
		{
			super.update();
		}
		
		override public function removed():void 
		{
			super.removed();
			FP.stage.removeChild(punkText._field);
		}
	}
}