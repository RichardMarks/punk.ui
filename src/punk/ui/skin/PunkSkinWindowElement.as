package punk.ui.skin
{
	/**
	 * Base class used to create a custom window skin
	 */
	public class PunkSkinWindowElement extends PunkSkinHasLabelElement
	{
		
		/**
		 * Image used for the windows scroll bar
		 */
		public var bar:PunkSkinImage;
		/**
		 * Image used for the body
		 */
		public var body:PunkSkinImage;
		
		/**
		 * Constructur.
		 * @param	bar Image for scroll bar
		 * @param	body Image for the body
		 * @param	labelProperties optional properties for the text in this element
		 */
		public function PunkSkinWindowElement(bar:PunkSkinImage=null, body:PunkSkinImage=null, labelProperties:Object=null)
		{
			super(labelProperties);
			
			this.bar = bar;
			this.body = body;
		}
	}
}