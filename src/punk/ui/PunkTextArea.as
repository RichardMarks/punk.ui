package punk.ui 
{
	import flash.display.BitmapData;
	import flash.events.FocusEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.text.TextFieldType;
	
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	import punk.ui.skin.PunkSkin;
	
	public class PunkTextArea extends PunkLabel
	{
		protected var initialised:Boolean = false;
		
		protected var updateTextBuffer:Boolean = false;
		
		public function PunkTextArea(text:String = "", x:Number = 0, y:Number = 0, width:int = 0, height:int = 0, skin:PunkSkin = null) 
		{
			super(text, x, y, width, height, skin);
			punkText._field.selectable = true;
			punkText._field.type = TextFieldType.INPUT;
			punkText._field.multiline = true;
			punkText.width = width ? width : 240;
			punkText.height = height ? height : 36;
			punkText._field.x = x;
			punkText._field.y = y;
			punkText.resizable = false;
			punkText.wordWrap = true;
			punkText._field.alpha = 0;
		}
		
		override protected function setupSkin(skin:PunkSkin):void
		{
			if(!skin.punkTextArea) return;
			
			punkText = new PunkText(textString, 0, 0, skin.punkTextArea.labelProperties);
			graphic = getSkinImage(skin.punkTextArea.background);
		}
		
		override public function update():void 
		{
			super.update();
			
			if(!initialised && FP.stage)
			{
				FP.stage.addChild(punkText._field);
				punkText._field.addEventListener(FocusEvent.FOCUS_IN, onFocusInText, false, 0, true);
				punkText._field.addEventListener(FocusEvent.FOCUS_OUT, onFocusOutText, false, 0, true);
				initialised = true;
			}
			
			punkText._field.x = x - int(FP.camera.x);
			punkText._field.y = y - int(FP.camera.y);
		}
		
		override public function render():void
		{
			super.render();
			
			var bd:BitmapData = (renderTarget ? renderTarget : FP.buffer);
			_point.x = punkText._field.x;
			_point.y = punkText._field.y;
			if(updateTextBuffer)
			{
				punkText.updateTextBuffer();
			}
			punkText.render(bd, _point, FP.zero);
		}
		
		protected function onFocusInText(e:FocusEvent):void
		{
			updateTextBuffer = true;
		}
		
		protected function onFocusOutText(e:FocusEvent):void
		{
			updateTextBuffer = false;
			punkText.updateTextBuffer();
		}
		
		override public function added():void
		{
			super.added();
			
			initialised = false;
			
			if(FP.stage)
			{
				FP.stage.addChild(punkText._field);
				punkText._field.addEventListener(FocusEvent.FOCUS_IN, onFocusInText, false, 0, true);
				punkText._field.addEventListener(FocusEvent.FOCUS_OUT, onFocusOutText, false, 0, true);
				initialised = true;
			}
		}
		
		override public function removed():void 
		{
			super.removed();
			punkText._field.removeEventListener(FocusEvent.FOCUS_IN, onFocusInText);
			punkText._field.removeEventListener(FocusEvent.FOCUS_OUT, onFocusOutText);
			FP.stage.removeChild(punkText._field);
		}
	}
}