package punk.ui 
{
	/**
	 * ...
	 * @author Thomas King
	 */
	public class PunkLabel extends PunkUIComponent
	{
		internal var punkText:PunkText;
		
		public function PunkLabel(text:String = "", x:Number = 0, y:Number = 0, width:int = 1, height:int = 1) 
		{
			super(x, y, width, height);
			punkText = new PunkText(text, 0, 0);
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