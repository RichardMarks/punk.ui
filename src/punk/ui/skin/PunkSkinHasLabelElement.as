package punk.ui.skin
{
	/**
	 * "Base class for every skin element that has a label
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