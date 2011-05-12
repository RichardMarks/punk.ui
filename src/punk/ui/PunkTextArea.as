package punk.ui 
{
	import flash.text.TextFieldType;
	
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import punk.ui.skin.PunkSkin;
	
	public class PunkTextArea extends PunkLabel
	{
		protected var initialised:Boolean = false;
		
		public function PunkTextArea(text:String = "", x:Number = 0, y:Number = 0, width:int = 0, height:int = 0, skin:PunkSkin = null) 
		{
			super(text, x, y, width, height, skin);
			if(FP.stage)
			{
				FP.stage.addChild(punkText._field);
				initialised = true;
			}
			punkText._field.selectable = true;
			punkText._field.type = TextFieldType.INPUT;
			punkText._field.wordWrap = true;
			punkText._field.multiline = true;
			punkText._field.width = width ? width : 240;
			punkText._field.height = height ? height : 36;
			punkText._field.x = x;
			punkText._field.y = y;
		}
		
		override protected function setupSkin(skin:PunkSkin):void
		{
			if(!skin.punkTextArea) return;
			
			punkText = new PunkText(textString, 0, 0, skin.punkTextArea.properties);
			graphic = getSkinImage(skin.punkTextArea.background);
		}
		
		override public function update():void 
		{
			super.update();
			
			if(!initialised && FP.stage)
			{
				FP.stage.addChild(punkText._field);
				initialised = true;
			}
			
			punkText._field.x = x - int(FP.camera.x);
			punkText._field.y = y - int(FP.camera.y);
		}
		
		override public function removed():void 
		{
			super.removed();
			FP.stage.removeChild(punkText._field);
		}
	}
}