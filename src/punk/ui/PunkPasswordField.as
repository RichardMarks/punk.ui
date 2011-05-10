package punk.ui 
{
	/**
	 * ...
	 * @author Thomas King
	 */
	public class PunkPasswordField extends PunkTextField
	{
		
		public function PunkPasswordField(text:String = "", x:Number = 0, y:Number = 0, width:int = 0) 
		{
			super(text, x, y, width);
			punkText._field.displayAsPassword = true;
		}
		
	}

}