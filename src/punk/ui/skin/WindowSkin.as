package punk.ui.skin
{
	public class WindowSkin extends SkinWithLabel
	{
		public var bar:SkinImage;
		public var body:SkinImage;
		
		public function WindowSkin(bar:SkinImage=null, body:SkinImage=null, textProperties:Object=null)
		{
			super(textProperties);
			
			this.bar = bar;
			this.body = body;
		}
	}
}