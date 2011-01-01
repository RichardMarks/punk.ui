package punk.ui
{
	/**
	 * @author PigMess
	 */
	
	public class PunkPassword extends PunkTextField
	{
		public function PunkPassword(x:Number = 0, y:Number = 0, width:uint = 1, height:uint = 1) {
			super(x, y, width, height);
			this._textField.displayAsPassword = true;
		}
	}
}
