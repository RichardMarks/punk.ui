package punk.ui.skin
{
	public class PunkSkinToggleButtonElement extends PunkSkinButtonElement
	{
		public var normalOn:PunkSkinImage;
		public var mousedOn:PunkSkinImage;
		public var pressedOn:PunkSkinImage;
		public var inactiveOn:PunkSkinImage;
		
		public function PunkSkinToggleButtonElement(normal:PunkSkinImage=null, moused:PunkSkinImage=null, pressed:PunkSkinImage=null, inactive:PunkSkinImage=null, normalOn:PunkSkinImage=null, mousedOn:PunkSkinImage=null, pressedOn:PunkSkinImage=null, inactiveOn:PunkSkinImage=null, labelProperties:Object=null)
		{
			super(normal, moused, pressed, inactive, labelProperties);
			
			this.normalOn = normalOn;
			this.mousedOn = mousedOn;
			this.pressedOn = pressedOn;
			this.inactiveOn = inactiveOn;
		}
	}
}