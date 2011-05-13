package punk.ui 
{
	import punk.ui.skin.PunkSkin;

	public class PunkPasswordField extends PunkTextField
	{
		public function PunkPasswordField(x:Number = 0, y:Number = 0, width:int = 0, text:String = "", skin:PunkSkin=null) 
		{
			super(text, x, y, width, skin);
			
			punkText._field.displayAsPassword = true;
		}
		
		override protected function setupSkin(skin:PunkSkin):void
		{
			if(!skin.punkPasswordField) return;
			
			punkText = new PunkText(textString, 0, 0, skin.punkLabel.labelProperties);
			graphic = getSkinImage(skin.punkPasswordField.background);
		}
	}

}