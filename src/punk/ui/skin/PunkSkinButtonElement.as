package punk.ui.skin
{
	public class PunkSkinButtonElement extends PunkSkinHasLabelElement
	{
		public var normal:PunkSkinImage;
		public var moused:PunkSkinImage;
		public var pressed:PunkSkinImage;
		public var inactive:PunkSkinImage;
		
		public function PunkSkinButtonElement(normal:PunkSkinImage=null, moused:PunkSkinImage=null, pressed:PunkSkinImage=null, inactive:PunkSkinImage=null, textProperties:Object=null)
		{
			super(textProperties);
			
			this.normal = normal;
			this.moused = moused;
			this.pressed = pressed;
			this.inactive = inactive;
		}
	}
}