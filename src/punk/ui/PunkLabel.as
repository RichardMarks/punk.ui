package punk.ui
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Stamp;
	
	/**
	 * @author PigMess
	 * @author Rolpege
	 */

	public class PunkLabel extends PunkUIComponent
	{	
		public static var size:Object = 12;
		public static var color:uint = 0xff33cc;
		public static var backgroundColor:uint = 0x202020;
		public static var background:Boolean = false;
		
		public function PunkLabel(text:String = "", x:Number = 0, y:Number = 0, width:int = 0, height:int = 0) {
			super(x, y, width, height);
			
			_textField = new TextField();
			_textField.selectable = false;
			_textField.defaultTextFormat = new TextFormat("default", PunkLabel.size, PunkLabel.color);
			_textField.text = text;
			_textField.width = width || _textField.textWidth + 4;
			_textField.height = height || _textField.textHeight + 4;
			_textField.background = true;
			_textField.backgroundColor = PunkLabel.backgroundColor;
			_textField.background = PunkLabel.background
			_textField.maxChars = 0;
			_textField.useRichTextClipboard = true;
			_textField.wordWrap = true;
			_textField.multiline = true;
			_textField.x = x;
			_textField.y = y;
			
			_renderRect = new Rectangle(0, 0, _textField.width, _textField.height);
			_textBuffer = new BitmapData(_textField.width, _textField.height, true, 0x00000000);
			graphic = new Stamp(_textBuffer);
		}
		
		override public function render():void {
			super.render();
			
			_textBuffer.fillRect(_renderRect, _textField.background ? _textField.backgroundColor : 0x00000000);
			_textBuffer.draw(_textField);
		}
		
		public function get text():String {
			return _textField.text;
		}
		
		public function set text(value:String):void {
			_textField.text = value;
		}
		
		public function get color():uint {
			return _textField.textColor;
		}
		
		public function set color(value:uint):void {
			_textField.textColor = value;
		}
		
		public function get backgroundColor():uint {
			return _textField.backgroundColor;
		}
		
		public function set backgroundColor(value:uint):void {
			_textField.backgroundColor = value;
		}
		
		public function get length():int {
			return _textField.length;
		}
		
		public function get size():Object {
			return _textField.defaultTextFormat.size;
		}
		
		public function set size(value:Object):void {
			_textField.defaultTextFormat.size = value;
		}
		
		public function get font():String {
			return _textField.defaultTextFormat.font;
		}
		
		public function set font(value:String):void {
			_textField.defaultTextFormat.font = value;
		}
		
		public function get background():Boolean
		{
			return _textField.background;
		}
		
		public function set background(value:Boolean):void {
			_textField.background = value;
		}

		protected var _textField:TextField;
		protected var _renderRect:Rectangle;
		protected var _textBuffer:BitmapData;
	}
}
