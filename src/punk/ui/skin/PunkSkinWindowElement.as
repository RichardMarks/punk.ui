package punk.ui.skin
{
	public class PunkSkinWindowElement extends PunkSkinHasLabelElement
	{
		public var bar:PunkSkinImage;
		public var body:PunkSkinImage;
		
		public function PunkSkinWindowElement(bar:PunkSkinImage=null, body:PunkSkinImage=null, labelProperties:Object=null)
		{
			super(labelProperties);
			
			this.bar = bar;
			this.body = body;
		}
	}
}