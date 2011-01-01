package punk.ui
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	/**
	 * @author PigMess
	 */

	public class PunkLabel extends PunkUIComponent
	{	
		public static var size:Object = 12;
		public static var color:uint = 0xff33cc;
		public static var backgroundColor:uint = 0x202020;
		
		public function PunkLabel(text:String = "", x:Number = 0, y:Number = 0, width:int = 1, height:int = 1) {
			super(x, y, width, height);
			
			_textField = new TextField();
			_textField.selectable = false;
			_textField.defaultTextFormat = new TextFormat("default", size, color);
			_textField.text = text;
			_textField.width = width + 4 as Number;
			_textField.height = height + 4 as Number;
			_textField.background = true;
			_textField.backgroundColor = backgroundColor;
			_textField.maxChars = 0;
			_textField.useRichTextClipboard = true;
			_textField.wordWrap = true;
			_textField.multiline = true;
			_textField.x = x;
			_textField.y = y;
			
			_textBuffer = new BitmapData(_textField.width, _textField.height);
			this.graphic = new Image(_textBuffer);
		}
		
		override public function added():void {
			FP.stage.addChild(_textField);
		}
		
		override public function removed():void {
			FP.stage.removeChild(_textField);
		}
		
		override public function render():void {
			
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
		
		public function set background(value:Boolean):void {
			_textField.background = value;
		}

		protected var _textField:TextField;
		protected var _textBuffer:BitmapData;
	}
}
