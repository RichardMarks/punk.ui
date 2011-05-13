package punk.ui.skin
{
	public class PunkSkinLabelElement extends PunkSkinHasLabelElement
	{
		public var background:PunkSkinImage;
		
		public function PunkSkinLabelElement(labelProperties:Object=null, background:PunkSkinImage=null)
		{
			super(labelProperties);
			
			this.background = background;
		}
	}
}