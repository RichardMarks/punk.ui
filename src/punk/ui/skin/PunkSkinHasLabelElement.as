package punk.ui.skin
{
	/**
	 * Base class used to create a label element
	 */
	public class PunkSkinHasLabelElement extends PunkSkinElement
	{
		/**
		 * Contains properties defining the label
		 */
		public var labelProperties:Object;
		
		/**
		 * Constructor.
		 * @param	labelProperties optional properties for a label
		 */
		public function PunkSkinHasLabelElement(labelProperties:Object = null)
		{
			this.labelProperties = labelProperties;
		}
	}
}