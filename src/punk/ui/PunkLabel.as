package punk.ui 
{
	import punk.ui.skin.PunkSkin;
	
	/**
	 * A basic label component
	 */
	public class PunkLabel extends PunkUIComponent
	{
		/**
		 * The label's text wrapped as an Image
		 */
		public var punkText:PunkText;
		
		/**
		 * The label's text
		 */
		protected var textString:String;
		
		/**
		 * Constructor
		 * @param	text the text to display
		 * @param	x X-Coordinate for the component
		 * @param	y Y-Coordinate for the component
		 * @param	width Width of the component
		 * @param	height Height of the component
		 * @param	skin Skin to use when rendering the component
		 */
		public function PunkLabel(text:String = "", x:Number = 0, y:Number = 0, width:int = 1, height:int = 1, skin:PunkSkin = null) 
		{
			textString = text;
			
			super(x, y, width, height, skin);
		}
		
		/**
		 * Additional setup steps for this component
		 * @param	skin Skin to use when rendering the component
		 */
		override protected function setupSkin(skin:PunkSkin):void
		{
			if(!skin.punkLabel) return;
			
			punkText = new PunkText(textString, 0, 0, skin.punkLabel.labelProperties);
			graphic = punkText;
		}
		
		/**
		 * Text string.
		 */
		public function get text():String { return punkText.text; }
		public function set text(value:String):void
		{
			punkText.text = value;
		}
		
		/**
		 * Font family.
		 */
		public function get font():String { return punkText.font; }
		public function set font(value:String):void
		{
			punkText.font = value;
		}
		
		/**
		 * Font size.
		 */
		public function get size():uint { return punkText.size; }
		public function set size(value:uint):void
		{
			punkText.size = value;
		}
		
		/**
		 * Alignment ("left", "center" or "right").
		 * Only relevant if text spans multiple lines.
		 */
		public function get align():String { return punkText.align; }
		public function set align(value:String):void
		{
			punkText.align = value;
		}
		
		/**
		 * Automatic word wrapping.
		 */
		public function get wordWrap():Boolean { return punkText.wordWrap; }
		public function set wordWrap(value:Boolean):void
		{
			punkText.wordWrap = value;
		}
	}
}