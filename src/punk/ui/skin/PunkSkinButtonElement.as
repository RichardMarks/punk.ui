package punk.ui.skin
{
	/**
	 * Base class used to create a custom Button skin.
	 */
	public class PunkSkinButtonElement extends PunkSkinHasLabelElement
	{
		/**
		 * Image used when the button is in its normal state
		 */
		public var normal:PunkSkinImage;
		/**
		 * Image used when the button is in its mouse over state
		 */
		public var moused:PunkSkinImage;
		/**
		 * Image used when the button is in its pressed state
		 */
		public var pressed:PunkSkinImage;
		/**
		 * Image used when the button is in its inactive state
		 */
		public var inactive:PunkSkinImage;
		
		/**
		 * Constructor.
		 * @param	normal Normal state image
		 * @param	moused Mouse over state image
		 * @param	pressed Mouse pressed state image
		 * @param	inactive Inactive state image
		 * @param	textProperties Additional arguements defining the text on this button
		 */
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