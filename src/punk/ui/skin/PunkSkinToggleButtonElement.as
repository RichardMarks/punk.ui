package punk.ui.skin
{
	/**
	 * Base classed used to create a custom toggle button skin
	 */
	public class PunkSkinToggleButtonElement extends PunkSkinButtonElement
	{
		/**
		 * Image used when the toggle button is in its normal toggled state
		 */
		public var normalOn:PunkSkinImage;
		/**
		 * Image used when the toggle button is in its mouse over toggled state
		 */
		public var mousedOn:PunkSkinImage;
		/**
		 * Image used when the toggle button is in its mouse pressed toggled state
		 */
		public var pressedOn:PunkSkinImage;
		/**
		 * Image used when the toggle button is in its inactive toggled state
		 */
		public var inactiveOn:PunkSkinImage;
		
		/**
		 * Constructor.
		 * @param	normal Normal state image
		 * @param	moused Mouse over state image
		 * @param	pressed Mouse pressed image
		 * @param	inactive Inactive state image
		 * @param	normalOn Normal toggled image
		 * @param	mousedOn Mouse over toggled image
		 * @param	pressedOn Mouse pressed toggled image
		 * @param	inactiveOn Inactive toggled image
		 * @param	labelProperties optional properties for the label
		 */
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