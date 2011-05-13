package punk.ui.skins
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	import punk.ui.skin.ButtonSkin;
	import punk.ui.skin.LabelSkin;
	import punk.ui.skin.PunkSkin;
	import punk.ui.skin.SkinImage;
	import punk.ui.skin.SkinWithLabel;
	import punk.ui.skin.ToggleButtonSkin;
	import punk.ui.skin.WindowSkin;
	
	public class YellowAfterlife extends PunkSkin
	{
		[Embed(source="yellowafterlife.png")] protected const I:Class;
		
		public function YellowAfterlife(roundedButtons:Boolean = true, passwordField:int = 2, textArea:int = 0, textField:int = 1, windowCaption:int = 0, windowBody:int = 0)
		{
			super();
			
			passwordField = FP.clamp(passwordField, 0, 2);
			textArea = FP.clamp(textArea, 0, 2);
			textField = FP.clamp(textField, 0, 2);
			windowCaption = FP.clamp(windowCaption, 0, 2);
			windowBody = FP.clamp(windowBody, 0, 2);
			
			var by:int = roundedButtons ? 16 : 0;
			punkButton = new ButtonSkin(gy(0, by), gy(16, by), gy(32, by), gy(16, by), {color: 0xFF3366, size: 16});
			
			punkToggleButton = new ToggleButtonSkin(gn(0, 64), gn(16, 64), gn(32, 64), gn(16, 64), gn(0, 80), gn(16, 80), gn(32, 80), gn(16, 80), {color: 0xFF3366, size: 16, x: 16});
			punkRadioButton = new ToggleButtonSkin(gn(0, 96), gn(16, 96), gn(32, 96), gn(16, 96), gn(0, 112), gn(16, 112), gn(32, 112), gn(16, 112), {color: 0xFF3366, size: 16, x: 16});
			
			punkLabel = new SkinWithLabel({color: 0xFF3366, size: 16});
			punkTextArea = new LabelSkin({color: 0xFF3366, size: 16}, gy(64 + (16 * textArea), 0));
			punkTextField = new LabelSkin({color: 0xFF3366, size: 16}, gy(64 + (16 * textField), 16));
			punkPasswordField = new LabelSkin({color: 0xFF3366, size: 16}, gy(16 * passwordField, 48));
			
			punkWindow = new WindowSkin(gy(64 + (16 * windowCaption), 33, 16, 15), gy(64 + (16 * windowBody), 47, 16, 17), {color: 0xFF3366, size: 16, x: 2, y: -1});
		}
		
		protected function gy(x:int, y:int, w:int=16, h:int=16):SkinImage
		{
			return new SkinImage(gi(x, y, w, h), true, 4, 4, 4, 4);
		}
		
		protected function gn(x:int, y:int, w:int=16, h:int=16):SkinImage
		{
			return new SkinImage(gi(x, y, w, h), false);
		}
		
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