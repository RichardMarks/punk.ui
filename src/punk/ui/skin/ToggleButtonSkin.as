package punk.ui.skin
{
	public class ToggleButtonSkin extends ButtonSkin
	{
		public var normalOn:SkinImage;
		public var mousedOn:SkinImage;
		public var pressedOn:SkinImage;
		public var inactiveOn:SkinImage;
		
		public function ToggleButtonSkin(normal:SkinImage=null, moused:SkinImage=null, pressed:SkinImage=null, inactive:SkinImage=null, normalOn:SkinImage=null, mousedOn:SkinImage=null, pressedOn:SkinImage=null, inactiveOn:SkinImage=null, textProperties:Object=null)
		{
			super(normal, moused, pressed, inactive, textProperties);
			
			this.normalOn = normalOn;
			this.mousedOn = mousedOn;
			this.pressedOn = pressedOn;
			this.inactiveOn = inactiveOn;
		}
	}
}