package punk.ui.skins
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	import punk.ui.skin.PunkSkinButtonElement;
	import punk.ui.skin.PunkSkinLabelElement;
	import punk.ui.skin.PunkSkin;
	import punk.ui.skin.PunkSkinImage;
	import punk.ui.skin.PunkSkinHasLabelElement;
	import punk.ui.skin.PunkSkinToggleButtonElement;
	import punk.ui.skin.PunkSkinWindowElement;
	
	/**
	 * Yellow After Life skin definition
	 */
	public class YellowAfterlife extends PunkSkin
	{
		/**
		 * The asset to use for the skin images
		 */
		[Embed(source="yellowafterlife.png")] protected const I:Class;
		
		/**
		 * Constructor.
		 * @param	roundedButtons If using rounded buttons
		 * @param	passwordField defines which image style is used for the Password Field
		 * @param	textArea defines which image style is used for the Text Area
		 * @param	textField defines which image style is used for the Text Field
		 * @param	windowCaption defines which image style is used for the Window Caption
		 * @param	windowBody defines which image style is used for the Window Body
		 */
		public function YellowAfterlife(roundedButtons:Boolean = true, passwordField:int = 2, textArea:int = 0, textField:int = 1, windowCaption:int = 0, windowBody:int = 0)
		{
			super();
			
			passwordField = FP.clamp(passwordField, 0, 2);
			textArea = FP.clamp(textArea, 0, 2);
			textField = FP.clamp(textField, 0, 2);
			windowCaption = FP.clamp(windowCaption, 0, 2);
			windowBody = FP.clamp(windowBody, 0, 2);
			
			var by:int = roundedButtons ? 16 : 0;
			punkButton = new PunkSkinButtonElement(gy(0, by), gy(16, by), gy(32, by), gy(16, by), {color: 0xFF3366, size: 16});
			
			punkToggleButton = new PunkSkinToggleButtonElement(gn(0, 64), gn(16, 64), gn(32, 64), gn(16, 64), gn(0, 80), gn(16, 80), gn(32, 80), gn(16, 80), {color: 0xFF3366, size: 16, x: 16});
			punkRadioButton = new PunkSkinToggleButtonElement(gn(0, 96), gn(16, 96), gn(32, 96), gn(16, 96), gn(0, 112), gn(16, 112), gn(32, 112), gn(16, 112), {color: 0xFF3366, size: 16, x: 16});
			
			punkLabel = new PunkSkinHasLabelElement({color: 0xFF3366, size: 16});
			punkTextArea = new PunkSkinLabelElement({color: 0xFF3366, size: 16}, gy(64 + (16 * textArea), 0));
			punkTextField = new PunkSkinLabelElement({color: 0xFF3366, size: 16}, gy(64 + (16 * textField), 16));
			punkPasswordField = new PunkSkinLabelElement({color: 0xFF3366, size: 16}, gy(16 * passwordField, 48));
			
			punkWindow = new PunkSkinWindowElement(gy(64 + (16 * windowCaption), 33, 16, 15), gy(64 + (16 * windowBody), 47, 16, 17), {color: 0xFF3366, size: 16, x: 2, y: -1});
		}
		
		/**
		 * Returns the portion of the skin image as a PunkSkinImage object in a 9-Slice format
		 * @param	x X-Coordinate for the image offset
		 * @param	y Y-Coordinate for the image offset
		 * @param	w Width of the image sub-section
		 * @param	h Height of the image sub-section
		 * @return PunkSkinImage for the image sub-section requested in 9-Slice format
		 */
		protected function gy(x:int, y:int, w:int=16, h:int=16):PunkSkinImage
		{
			return new PunkSkinImage(gi(x, y, w, h), true, 4, 4, 4, 4);
		}
		
		/**
		 * Returns the portion of the skin image as a PunkSkinImage object in a non 9-Sliced format
		 * @param	x X-Coordinate for the image offset
		 * @param	y Y-Coordinate for the image offset
		 * @param	w Width of the image sub-section
		 * @param	h Height of the image sub-section
		 * @return PunkSkinImage for the image sub-section requested in a non 9-Sliced format
		 */
		protected function gn(x:int, y:int, w:int=16, h:int=16):PunkSkinImage
		{
			return new PunkSkinImage(gi(x, y, w, h), false);
		}
		
		/**
		 * Returns the portion of the skin image requested as a BitmapData object
		 * @param	x X-Coordinate for the image offset
		 * @param	y Y-Coordinate for the image offset
		 * @param	w Width of the image sub-section
		 * @param	h Height of the image sub-section
		 * @return BitmapData for the image sub-section requested
		 */
		protected function gi(x:int, y:int, w:int=16, h:int=16):BitmapData
		{
			_r.x = x;
			_r.y = y;
			_r.width = w;
			_r.height = h;
			
			var b:BitmapData = new BitmapData(w, h, true, 0);
			b.copyPixels(FP.getBitmap(I), _r, FP.zero, null, null, true);
			return b;
		}
		
		private var _r:Rectangle = new Rectangle;
	}
}