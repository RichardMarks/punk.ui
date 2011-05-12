package punk.ui.skin
{
	public class ButtonSkin extends SkinWithLabel
	{
		public var normal:SkinImage;
		public var moused:SkinImage;
		public var pressed:SkinImage;
		public var inactive:SkinImage;
		
		public function ButtonSkin(normal:SkinImage=null, moused:SkinImage=null, pressed:SkinImage=null, inactive:SkinImage=null, textProperties:Object=null)
		{
			super(textProperties);
			
			this.normal = normal;
			this.moused = moused;
			this.pressed = pressed;
			this.inactive = inactive;
		}
	}
}