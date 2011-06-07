package punk.ui.skin {
	/**
	 * ...
	 * @author Daniel Kvarfordt
	 */
	public class PunkSkinSliderElement extends PunkSkinElement {
		
		/**
		 * Image used when the slider is in its normal state
		 */
		public var normal:PunkSkinImage;
		/**
		 * Image used when the slider is inactive
		 */
		public var inactive:PunkSkinImage;
		
		/**
		 * Normal handle image
		 */
		public var normalHandle:PunkSkinImage;
		/**
		 * Inactive handle image
		 */
		public var inactiveHandle:PunkSkinImage;
		/**
		 * Moused handle image
		 */
		public var mousedHandle:PunkSkinImage;
		/**
		 * Moused handle image
		 */
		public var pressedHandle:PunkSkinImage;
		
		
		public function PunkSkinSliderElement(normal:PunkSkinImage=null, inactive:PunkSkinImage=null, normalHandle:PunkSkinImage=null, inactiveHandle:PunkSkinImage=null, mousedHandle:PunkSkinImage=null, pressedHandle:PunkSkinImage=null) {
			this.normal = normal;
			this.inactive = inactive;
			this.normalHandle = normalHandle;
			this.inactiveHandle = inactiveHandle;
			this.mousedHandle = mousedHandle;
			this.pressedHandle = pressedHandle;
		}
		
	}

}