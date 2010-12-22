package punk.ui
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import net.flashpunk.graphics.Image;

	/**
	 * @author PigMess
	 * Basic text display label component
	 */
	public class PunkLabel extends PunkUIComponent
	{	
		/**
		 * class constructor
		 * @param x - position of the component on the X axis
		 * @param y - position of the component on the Y axis
		 * @param width - width of the component
		 * @param height - height of the component
		 * @param text - text to be displayed
		 */
		public function PunkLabel(x:Number = 0, y:Number = 0, width:uint = 1, height:uint = 1, text:String = "Type your text here.") {
			super(x, y, width, height);
			
			_textField = new TextField();
			_textField.defaultTextFormat = new TextFormat("Courier", 12, 0xb8b8b8);
			_textField.text = text;
			_textField.width = width as Number;
			_textField.height = height as Number;
			_textField.background = true;
			_textField.backgroundColor = 0x202020;
			_textField.maxChars = 0;
			_textField.multiline = true;
			_textField.useRichTextClipboard = true;
			_textField.wordWrap = true;
			_textField.mouseEnabled = true;
			
			_textBuffer = new BitmapData(_textField.width, _textField.height);
			_textImage = new Image(_textBuffer);
			_textImage.x = x;
			_textImage.y = y;

			updateBuffer();
		}
		
		// commented out by RichardMarks - nothing to update, so why override?
		/*
		override public function update():void {
			
		}*/
		
		/**
		 * renders the component to the specified target bitmap
		 * @param target - the bitmap on which to render the component
		 * @param point - point at which to offset the component
		 * @param camera - pass flashpunk's FP.camera here
		 */
		override public function render(target:BitmapData, point:Point, camera:Point):void {
			_textImage.render(target, point, camera);
		}
		
		/** updates the label's rendered buffer - do no need to normally call this function 
		 * as the .text property calls this function 
		 */
		public function updateBuffer(clearBefore:Boolean = false):void {
			_textBuffer.fillRect(_textImage.clipRect, _textField.backgroundColor);
			_textBuffer.draw(_textField);
			_textImage.updateBuffer(clearBefore);
		}
		
		/** @return the text that is displayed on the label */
		public function get text():String {
			return _textField.text;
		}
		
		/** sets the text to be displayed */
		public function set text(value:String):void {
			_textField.text = value;
			updateBuffer();
		}
		
		/** @return the color of the text */
		public function get color():uint {
			return _textField.textColor;
		}
		
		/** sets the color of the text */
		public function set color(value:uint):void {
			_textField.textColor = value;
			updateBuffer();
		}
		
		/** @return the background color */
		public function get backgroundColor():uint {
			return _textField.backgroundColor;
		}
		
		/** sets the background color */
		public function set backgroundColor(value:uint):void {
			_textField.backgroundColor = value;
			updateBuffer();
		}
		
		/** @return the number of characters in the label */
		public function get length():int {
			return _textField.length;
		}
		
		/** @return the size of the text */
		public function get size():Object {
			return _textField.defaultTextFormat.size;
		}
		
		/** sets the size of the text */
		public function set size(value:Object):void {
			_textField.defaultTextFormat.size = value;
		}
		
		/** @return the font that will be used */
		public function get font():String {
			return _textField.defaultTextFormat.font;
		}
		
		/** sets the font to use */
		public function set font(value:String):void {
			_textField.defaultTextFormat.font = value;
		}

		protected var _textField:TextField;
		protected var _textImage:Image;
		protected var _textBuffer:BitmapData;
	}
}