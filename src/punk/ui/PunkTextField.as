package punk.ui 
{
	import punk.ui.skin.PunkSkin;
	
	/**
	 * A TextField component
	 */
	public class PunkTextField extends PunkTextArea
	{
		
		/**
		 * Constructor
		 * @param	text the String of text to display
		 * @param	x X-Coordinate of the component
		 * @param	y Y-Coordinate of the component
		 * @param	width Width of the component
		 * @param	skin Skin to use when rendering the component
		 */
		public function PunkTextField(text:String = "", x:Number = 0, y:Number = 0, width:int = 0, skin:PunkSkin=null) 
		{
			super(text, x, y, width ? width : 240, 20, skin);
			punkText._field.multiline = false;
			punkText._field.wordWrap = false;
		}
		
		/**
		 * Additional setup steps for this component
		 * @param	skin Skin to use when rendering the component
		 */
		override protected function setupSkin(skin:PunkSkin):void
		{
			if(!skin.punkTextField) return;
			
			punkText = new PunkText(textString, 0, 0, skin.punkTextField.labelProperties);
			graphic = getSkinImage(skin.punkTextField.background);
		}
	}

}