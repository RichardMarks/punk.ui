package punk.ui.skin
{
	/**
	 * Base class to used to create a custom Label with background skin
	 */
	public class PunkSkinLabelElement extends PunkSkinHasLabelElement
	{
		/**
		 * background image for the label
		 */
		public var background:PunkSkinImage;
		
		/**
		 * Constructor
		 * @param	labelProperties optional properties for a label
		 * @param	background background image
		 */
		public function PunkSkinLabelElement(labelProperties:Object=null, background:PunkSkinImage=null)
		{
			super(labelProperties);
			
			this.background = background;
		}
	}
}