package punk.ui 
{
	import punk.ui.skin.PunkSkin;

	/**
	 * A password field component
	 */
	public class PunkPasswordField extends PunkTextField
	{
		/**
		 * Constructor
		 * @param	x X-Coordinate for the component
		 * @param	y Y-Coordinate for the component
		 * @param	width Width of the component
		 * @param	height Height of the component
		 * @param	skin Skin to use when rendering the component
		 */
		public function PunkPasswordField(x:Number = 0, y:Number = 0, width:int = 0, text:String = "", skin:PunkSkin=null) 
		{
			super(text, x, y, width, skin);
			
			punkText._field.displayAsPassword = true;
		}
		
		/**
		 * Additional setup steps for this component
		 * @param	skin Skin to use when rendering the component
		 */
		override protected function setupSkin(skin:PunkSkin):void
		{
			if(!skin.punkPasswordField) return;
			
			punkText = new PunkText(textString, 0, 0, skin.punkLabel.labelProperties);
			graphic = getSkinImage(skin.punkPasswordField.background);
		}
	}

}