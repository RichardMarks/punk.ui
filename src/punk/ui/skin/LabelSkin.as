package punk.ui.skin
{
	public class LabelSkin extends SkinWithLabel
	{
		public var background:SkinImage;
		
		public function LabelSkin(properties:Object=null, background:SkinImage=null)
		{
			super(properties);
			
			this.background = background;
		}
	}
}