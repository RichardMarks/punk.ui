package punk.ui 
{
	/**
	 * ...
	 * @author Thomas King
	 */
	public class PunkTextField extends PunkTextArea
	{
		
		public function PunkTextField(text:String = "", x:Number = 0, y:Number = 0, width:int = 0) 
		{
			super(text, x, y, width ? width : 240, 18);
			punkText._field.multiline = false;
			punkText._field.wordWrap = false;
		}
		
	}

}