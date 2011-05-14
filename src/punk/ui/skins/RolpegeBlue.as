package punk.ui.skins
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	import net.flashpunk.FP;
	
	import punk.ui.skin.PunkSkin;
	import punk.ui.skin.PunkSkinButtonElement;
	import punk.ui.skin.PunkSkinHasLabelElement;
	import punk.ui.skin.PunkSkinImage;
	import punk.ui.skin.PunkSkinLabelElement;
	import punk.ui.skin.PunkSkinToggleButtonElement;
	import punk.ui.skin.PunkSkinWindowElement;
	
	/**
	 * Rolpege Blue skin definition
	 */		
	public class RolpegeBlue extends PunkSkin
	{
		/**
		 * The asset to use for the skin image. 
		 */		
		[Embed(source="rolpegeblue.gif")] protected const I:Class;
		
		/**
		 * Constructor. 
		 */		
		public function RolpegeBlue()
		{
			super();
			
			punkButton = new PunkSkinButtonElement(gy(0, 0), gy(20, 0), gy(40, 0), gy(20, 0), {color: 0x000000, size: 16});
			punkToggleButton = new PunkSkinToggleButtonElement(gy(0, 0), gy(20, 0), gy(40, 0), gy(20, 0), gy(0, 20), gy(20, 20), gy(40, 20), gy(20, 20), {color: 0x000000, size: 16, align: "center"});
			punkRadioButton = new PunkSkinToggleButtonElement(gn(0, 40), gn(20, 40), gn(40, 40), gn(20, 40), gn(0, 59), gn(20, 59), gn(40, 59), gn(20, 59), {color: 0x000000, size: 16, x: 22});
			
			punkLabel = new PunkSkinHasLabelElement({color: 0x000000, size: 16});
			punkTextArea = new PunkSkinLabelElement({color: 0x000000, size: 16, x: 4}, gy(40, 80));
			punkTextField = new PunkSkinLabelElement({color: 0x000000, size: 16, x: 4}, gy(40, 80));
			punkPasswordField = new PunkSkinLabelElement({color: 0x000000, size: 16, x: 4}, gy(40, 80));
			
			punkWindow = new PunkSkinWindowElement(gy(0, 79), gy(20, 79), {color: 0x000000, size: 16, x: 3, y: 1});
		}
		
		/**
		 * Returns the portion of the skin image as a PunkSkinImage object in a 9-Slice format
		 * @param	x X-Coordinate for the image offset
		 * @param	y Y-Coordinate for the image offset
		 * @param	w Width of the image sub-section
		 * @param	h Height of the image sub-section
		 * @return PunkSkinImage for the image sub-section requested in 9-Slice format
		 */
		protected function gy(x:int, y:int, w:int=20, h:int=20):PunkSkinImage
		{
			return new PunkSkinImage(gi(x, y, w, h), true, 9, 9, 9, 9);
		}
		
		/**
		 * Returns the portion of the skin image as a PunkSkinImage object in a non 9-Sliced format
		 * @param	x X-Coordinate for the image offset
		 * @param	y Y-Coordinate for the image offset
		 * @param	w Width of the image sub-section
		 * @param	h Height of the image sub-section
		 * @return PunkSkinImage for the image sub-section requested in a non 9-Sliced format
		 */
		protected function gn(x:int, y:int, w:int=20, h:int=20):PunkSkinImage
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
		protected function gi(x:int, y:int, w:int=20, h:int=20):BitmapData
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