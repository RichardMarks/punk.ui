package punk.ui.skin
{
	/**
	 * Base class that is extended when creating a new skin for Punk.UI
	 */
	public class PunkSkin
	{
		/**
		 * Reference to the Button skin
		 */
		public var punkButton:PunkSkinButtonElement;
		/**
		 * Reference to the Toggle Button skin
		 */
		public var punkToggleButton:PunkSkinToggleButtonElement;
		/**
		 * Reference to the Radio Button skin
		 */
		public var punkRadioButton:PunkSkinToggleButtonElement;
		
		/**
		 * Reference to the Label skin
		 */
		public var punkLabel:PunkSkinHasLabelElement;
		/**
		 * Reference to the TextArea skin
		 */
		public var punkTextArea:PunkSkinLabelElement;
		/**
		 * Reference to the TextField skin
		 */
		public var punkTextField:PunkSkinLabelElement;
		/**
		 * Reference to the PasswordField skin
		 */
		public var punkPasswordField:PunkSkinLabelElement;
		
		/**
		 * Reference to the Window skin
		 */
		public var punkWindow:PunkSkinWindowElement;
		
		/**
		 * Constructor.  This class should be extended in order to create a custom skin.
		 */
		public function PunkSkin()
		{
		}
	}
}