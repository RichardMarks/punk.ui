package punk.ui 
{
	import punk.ui.skin.PunkSkin;
	
	public class PunkTextField extends PunkTextArea
	{
		
		public function PunkTextField(text:String = "", x:Number = 0, y:Number = 0, width:int = 0, skin:PunkSkin=null) 
		{
			super(text, x, y, width ? width : 240, 20, skin);
			punkText._field.multiline = false;
			punkText._field.wordWrap = false;
		}
		
		override protected function setupSkin(skin:PunkSkin):void
		{
			if(!skin.punkTextField) return;
			
			punkText = new PunkText(textString, 0, 0, skin.punkTextField.labelProperties);
			graphic = getSkinImage(skin.punkTextField.background);
		}
	}

}