package punk.ui
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextLineMetrics;
	
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	
	/**
	 * Used for drawing text using embedded fonts.
	 */
	public class PunkText extends Image
	{
		/**
		 * The font to assign to new Text objects.
		 */
		public static var font:String = "default";
		
		/**
		 * The font size to assign to new Text objects.
		 */
		public static var size:uint = 16;
		
		/**
		 * The alignment to assign to new Text objects.
		 */
		public static var align:String = "left";
		
		/**
		 * The wordWrap property to assign to new Text objects.
		 */
		public static var wordWrap:Boolean = false;
		
		/**
		 * The resizable property to assign to new Text objects.
		 */
		public static var resizable:Boolean = true;
		
		/**
		 * If the text field can automatically resize if its contents grow.
		 */
		public var resizable:Boolean;
		
		/**
		 * Outline color
		 */
		public var outlineColor:uint = 0x000000;
		
		/**
		 * Outline strength
		 */
		public var outlineStrength:uint = 0;
		
		/**
		 * Constructor.
		 * @param	text		Text to display.
		 * @param	x		X offset.
		 * @param	y		Y offset.
		 * @param	options		An object containing key/value pairs of the following optional parameters:
		 * 						font		Font family.
		 * 						size		Font size.
		 * 						align		Alignment ("left", "center", "right" or "justify").
		 * 						wordWrap	Automatic word wrapping.
		 * 						resizable	If the text field can automatically resize if its contents grow.
		 * 						width		Initial buffer width.
		 * 						height		Initial buffer height.
		 * 						color		Text color.
		 * 						alpha		Text alpha.
		 * 						angle		Rotation angle (see Image.angle).
		 * 						blend		Blend mode (see Image.blend).
		 * 						visible		Visibility (see Graphic.visible).
		 * 						scrollX		See Graphic.scrollX.
		 * 						scrollY		See Graphic.scrollY.
		 * 						relative	See Graphic.relative.
		 * 						outlineColor
		 * 						outlineStrength
		 *				For backwards compatibility, if options is a Number, it will determine the initial buffer width.
		 * @param	h		Deprecated. For backwards compatibility: if set and there is no options.height parameter set, will determine the initial buffer height.
		 */
		public function PunkText(text:String, x:Number = 0, y:Number = 0, options:Object = null, h:Number = 0)
		{
			_font = PunkText.font;
			_size = PunkText.size;
			_align = PunkText.align;
			_wordWrap = PunkText.wordWrap;
			resizable = PunkText.resizable;
			var width:uint = 0;
			var height:uint = h;
			
			if (options)
			{
				if (options is Number) // Backwards compatibility: options parameter has replaced width
				{
					width = Number(options);
					options = null;
				}
				else
				{
					if (options.hasOwnProperty("color")) _color = options.color;
					if (options.hasOwnProperty("font")) _font = options.font;
					if (options.hasOwnProperty("size")) _size = options.size;
					if (options.hasOwnProperty("align")) _align = options.align;
					if (options.hasOwnProperty("wordWrap")) _wordWrap = options.wordWrap;
					if (options.hasOwnProperty("resizable")) resizable = options.resizable;
					if (options.hasOwnProperty("width")) width = options.width;
					if (options.hasOwnProperty("height")) height = options.height;
					if (options.hasOwnProperty("outlineColor")) outlineColor = options.outlineColor;
					if (options.hasOwnProperty("outlineStrength")) outlineStrength = options.outlineStrength;
				}
			}
			
			_field.embedFonts = true;
			_field.wordWrap = _wordWrap;
			_form = new TextFormat(_font, _size, _color);
			_form.align = _align;
			_field.defaultTextFormat = _form;
			_field.text = _text = text;
			_width = width || _field.textWidth + 4;
			_height = height || _field.textHeight + 4;
			_source = new BitmapData(_width, _height, true, 0);
			_outlineFilter = new GlowFilter(outlineColor, 1, outlineStrength, outlineStrength, outlineStrength * 4);
			super(_source);
			updateTextBuffer();
			this.x = x;
			this.y = y;
			
			if (options)
			{
				for (var property:String in options) {
					if (hasOwnProperty(property)) {
						this[property] = options[property];
					}
				}
			}
		}
		
		/** Updates the text buffer, which is the source for the image buffer. */
		public function updateTextBuffer():void
		{
			_field.width = _width;
			_textWidth = _field.textWidth + 4;
			_textHeight = _field.textHeight + 4;
			
			_field.filters = [];
			if(outlineStrength > 0)
			{
				_outlineFilter.blurX = _outlineFilter.blurY = outlineStrength;
				_outlineFilter.strength = outlineStrength * 4;
				_outlineFilter.color = outlineColor;
				_field.filters = [_outlineFilter];
			}
			
			if (resizable && (_textWidth > _width || _textHeight > _height))
			{
				if (_width < _textWidth) _width = _textWidth;
				if (_height < _textHeight) _height = _textHeight;
			}
			
			if (_width > _source.width || _height > _source.height)
			{
				_source = new BitmapData(
					Math.max(_width, _source.width),
					Math.max(_height, _source.height),
					true, 0);
				
				_sourceRect = _source.rect;
				createBuffer();
			}
			else
			{
				_source.fillRect(_sourceRect, 0);
			}
			
			_field.width = _width;
			_field.height = _height;
			
			var offsetRequired: Boolean = false;
			
			for (var i: int = 0; i < _field.numLines; i++) {
				var tlm: TextLineMetrics = _field.getLineMetrics(i);
				var remainder: Number = tlm.x % 1;
				if (remainder > 0.1 && remainder < 0.9) {
					offsetRequired = true;
					break;
				}
			}
			
			if (offsetRequired) {
				for (i = 0; i < _field.numLines; i++) {
					tlm = _field.getLineMetrics(i);
					remainder = tlm.x % 1;
					_field.x = -remainder;
					
					FP.rect.x = 0;
					FP.rect.y = 2 + tlm.height * i;
					FP.rect.width = _width;
					FP.rect.height = tlm.height;
					
					_source.draw(_field, _field.transform.matrix, null, null, FP.rect);
				}
			} else {
				_source.draw(_field);
			}
			
			super.updateBuffer();
		}
		
		/**
		 * Applies a custom color to a range of characters. Will be overriden if color, font, size or align are updated after calling this.
		 *  
		 * @param color			The new color you want
		 * @param beginIndex	Optional; an integer that specifies the zero-based index position specifying the 
		 * 						first character of the desired range of text.
		 * @param endIndex		Optional; an integer that specifies the first character after the desired text span.
		 * 
		 */		
		public function setColorRegion(color:uint, beginIndex:int = -1, endIndex:int = -1):void
		{
			_field.setTextFormat(new TextFormat(null, null, color), beginIndex, endIndex);
			updateTextBuffer();
		}
		
		/**
		 * Applies a custom font to a range of characters. Will be overriden if color, font, size or align are updated after calling this.
		 *  
		 * @param font			The new font you want
		 * @param beginIndex	Optional; an integer that specifies the zero-based index position specifying the 
		 * 						first character of the desired range of text.
		 * @param endIndex		Optional; an integer that specifies the first character after the desired text span.
		 * 
		 */		
		public function setFontRegion(font:String, beginIndex:int = -1, endIndex:int = -1):void
		{
			_field.setTextFormat(new TextFormat(font, null, null), beginIndex, endIndex);
		}
		
		/**
		 * Applies a custom size to a range of characters. Will be overriden if color, font, size or align are updated after calling this.
		 *  
		 * @param size			The new size you want
		 * @param beginIndex	Optional; an integer that specifies the zero-based index position specifying the 
		 * 						first character of the desired range of text.
		 * @param endIndex		Optional; an integer that specifies the first character after the desired text span.
		 * 
		 */		
		public function setSizeRegion(size:int, beginIndex:int = -1, endIndex:int = -1):void
		{
			_field.setTextFormat(new TextFormat(null, size, null), beginIndex, endIndex);
		}
		
		/** @private Centers the Text's originX/Y to its center. */
		override public function centerOrigin():void 
		{
			originX = _width / 2;
			originY = _height / 2;
		}
		
		/**
		 * Text string.
		 */
		public function get text():String { return _field.text; }
		public function set text(value:String):void
		{
			_text = _field.text;
			if (_text == value) return;
			_field.text = _text = value;
			updateTextBuffer();
		}
		
		override public function get color():uint { return _color; }
		override public function set color(value:uint):void
		{
			if(_color == value) return;
			_form.color = _color = value;
			_field.setTextFormat(_form);
			updateTextBuffer();
		}
		
		/**
		 * Font family. Will override individual set fonts when updated.
		 */
		public function get font():String { return _font; }
		public function set font(value:String):void
		{
			if (_font == value) return;
			_form.font = _font = value;
			_field.setTextFormat(_form);
			updateTextBuffer();
		}
		
		/**
		 * Font size. Will override individual set sizes when updated.
		 */
		public function get size():uint { return _size; }
		public function set size(value:uint):void
		{
			if (_size == value) return;
			_form.size = _size = value;
			_field.setTextFormat(_form);
			updateTextBuffer();
		}
		
		/**
		 * Alignment ("left", "center", "right" or "justify").
		 */
		public function get align():String { return _align; }
		public function set align(value:String):void
		{
			if (_align == value) return;
			_form.align = _align = value;
			_field.setTextFormat(_form);
			updateTextBuffer();
		}
		
		/**
		 * Automatic word wrapping.
		 */
		public function get wordWrap():Boolean { return _wordWrap; }
		public function set wordWrap(value:Boolean):void
		{
			if (_wordWrap == value) return;
			_field.wordWrap = _wordWrap = value;
			updateTextBuffer();
		}
		
		/**
		 * Width of the text image.
		 */
		override public function get width():uint { return _width; }
		public function set width(value:uint):void
		{
			if (_width == value) return;
			_width = value;
			updateTextBuffer();
		}
		
		/**
		 * Height of the text image.
		 */
		override public function get height():uint { return _height; }
		public function set height(value:uint):void
		{
			if (_height == value) return;
			_height = value;
			updateTextBuffer();
		}
		
		/**
		 * The type of anti-aliasing used for this text field. Use flash.text.AntiAliasType constants for this property.
		 * You can control this setting only if the font is embedded. You can use "normal" and "advanced"
		 */		
		public function get antiAliasType():String{ return _antiAliasType; }
		public function set antiAliasType(value:String):void
		{
			if(_antiAliasType == value) return;
			_field.antiAliasType = _antiAliasType = value;
			updateTextBuffer();
		}
		
		/**
		 * Specifies whether the text field is a password text field. If the value of this property is true,
		 * the text field is treated as a password text field and hides the input characters using asterisks
		 * instead of the actual characters. If false, the text field is not treated as a password text field.
		 * When password mode is enabled, the Cut and Copy commands and their corresponding keyboard shortcuts
		 * will not function. This security mechanism prevents an unscrupulous user from using the shortcuts to 
		 * discover a password on an unattended computer.
		 */		
		public function get displayAsPassword():Boolean{ return _displayAsPassword; }
		public function set displayAsPassword(value:Boolean):void
		{
			if(_displayAsPassword == value) return;
			_field.displayAsPassword = _displayAsPassword = value;
			updateTextBuffer();
		}
		
		/**
		 * The maximum number of characters that the text field can contain, as entered by a user.
		 * A script can insert more text than maxChars allows; the maxChars property indicates only how much
		 * text a user can enter. If the value of this property is 0, a user can enter an unlimited amount of text.
		 */		
		public function get maxChars():int{ return _maxChars; }
		public function set maxChars(value:int):void
		{
			if(_maxChars == value) return;
			_field.maxChars = _maxChars = value;
			updateTextBuffer();
		}
		
		/**
		 * The maximum value of scrollH.
		 */		
		public function get maxScrollH():int{ return _field.maxScrollH; }
		
		/**
		 * The maximum value of scrollV.
		 */		
		public function get maxScrollV():int{ return _field.maxScrollV; }
		
		/**
		 * Indicates whether the text field is a multiline text field. If the value is true, the text field is multiline;
		 * if the value is false, the text field is a single-line text field.
		 */		
		public function get multiline():Boolean{ return _multiline; }
		public function set multiline(value:Boolean):void
		{
			if(_multiline == value) return;
			_field.multiline = _multiline = value;
			updateTextBuffer();
		}
		
		/**
		 * Indicates the set of characters that a user can enter into the text field. If the value of the restrict property is null,
		 * you can enter any character. If the value of the restrict property is an empty string, you cannot enter any character.
		 * If the value of the restrict property is a string of characters, you can enter only characters in the string into the text field.
		 * The string is scanned from left to right. You can specify a range by using the hyphen (-) character.
		 * This only restricts user interaction; a script may put any text into the text field.
		 * 
		 * <p>If the string begins with a caret (^) character, all characters are initially accepted and succeeding characters in the string
		 * are excluded from the set of accepted characters. If the string does not begin with a caret (^) character, no characters are
		 * initially accepted and succeeding characters in the string are included in the set of accepted characters.</p>
		 */		
		public function get restrict():String{ return _restrict; }
		public function set restrict(value:String):void
		{
			if(_restrict == value) return;
			_field.restrict = _restrict = value;
			updateTextBuffer();
		}
		
		/**
		 * A Boolean value that indicates whether the text field is selectable. The value true indicates that the text is selectable.
		 * The selectable property controls whether a text field is selectable, not whether a text field is editable. A dynamic text
		 * field can be selectable even if it is not editable. If a dynamic text field is not selectable, the user cannot select its text.
		 * 
		 * <p>If selectable is set to false, the text in the text field does not respond to selection commands from the mouse or keyboard,
		 * and the text cannot be copied with the Copy command. If selectable is set to true, the text in the text field can be selected with
		 * the mouse or keyboard, and the text can be copied with the Copy command. You can select text this way even if the text field is a
		 * dynamic text field instead of an input text field.</p>
		 */		
		public function get selectable():Boolean{ return _selectable; }
		public function set selectable(value:Boolean):void
		{
			if(_selectable == value) return;
			_field.selectable = _selectable = value;
			updateTextBuffer();
		}
		
		/**
		 * The current horizontal scrolling position. If the scrollH property is 0, the text is not horizontally scrolled.
		 * This property value is an integer that represents the horizontal position in pixels.
		 * 
		 * <p>The units of horizontal scrolling are pixels, whereas the units of vertical scrolling are lines. Horizontal scrolling
		 * is measured in pixels because most fonts you typically use are proportionally spaced; that is, the characters can have different
		 * widths. Flash Player performs vertical scrolling by line because users usually want to see a complete line of text rather than a
		 * partial line. Even if a line uses multiple fonts, the height of the line adjusts to fit the largest font in use.</p>
		 */		
		public function get scrollH():int{ return _scrollH; }
		public function set scrollH(value:int):void
		{
			if(_scrollH == value) return;
			_field.scrollH = _scrollH = value;
			updateTextBuffer();
		}
		
		/**
		 * The vertical position of text in a text field. The scrollV property is useful for directing users to a specific paragraph in a
		 * long passage, or creating scrolling text fields.
		 * 
		 * <p>The units of vertical scrolling are lines, whereas the units of horizontal scrolling are pixels. If the first line displayed
		 * is the first line in the text field, scrollV is set to 1 (not 0). Horizontal scrolling is measured in pixels because most fonts
		 * are proportionally spaced; that is, the characters can have different widths. Flash performs vertical scrolling by line because
		 * users usually want to see a complete line of text rather than a partial line. Even if there are multiple fonts on a line,
		 * the height of the line adjusts to fit the largest font in use.
		 */		
		public function get scrollV():int{ return _scrollV; }
		public function set scrollV(value:int):void
		{
			if(_scrollV == value) return;
			_field.scrollV = _scrollV = value;
			updateTextBuffer();
		}
		
		/**
		 * The type of the text field. Either one of the following TextFieldType constants: TextFieldType.DYNAMIC, which specifies a
		 * dynamic text field, which a user cannot edit, or TextFieldType.INPUT, which specifies an input text field, which a user can edit.
		 */		
		public function get type():String{ return _type; }
		public function set type(value:String):void
		{
			if(_type == value) return;
			_field.type = _type = value;
			updateTextBuffer();
		}
		
		/**
		 * The scaled width of the text image.
		 */
		override public function get scaledWidth():uint { return _width * scaleX * scale; }
		
		/**
		 * The scaled height of the text image.
		 */
		override public function get scaledHeight():uint { return _height * scaleY * scale; }
		
		/**
		 * Width of the text within the image.
		 */
		public function get textWidth():uint { return _textWidth; }
		
		/**
		 * Height of the text within the image.
		 */
		public function get textHeight():uint { return _textHeight; }
		
		// Text information.
		/** @private */ internal var _field:TextField = new TextField;
		/** @private */ private var _width:uint;
		/** @private */ private var _height:uint;
		/** @private */ private var _textWidth:uint;
		/** @private */ private var _textHeight:uint;
		/** @private */ private var _form:TextFormat;
		/** @private */ private var _text:String;
		/** @private */ private var _font:String;
		/** @private */ private var _size:uint;
		/** @private */ private var _align:String;
		/** @private */ private var _wordWrap:Boolean;
		/** @private */ private var _antiAliasType:String;
		/** @private */ private var _displayAsPassword:Boolean
		/** @private */ private var _maxChars:int;
		/** @private */ private var _multiline:Boolean;
		/** @private */ private var _restrict:String;
		/** @private */ private var _selectable:Boolean;
		/** @private */ private var _scrollH:int;
		/** @private */ private var _scrollV:int;
		/** @private */ private var _type:String;
		/** @private */ private var _color:uint = 0xFFFFFF;
		
		/** @private */ private var _outlineFilter:GlowFilter;
		
		// Reference the Text class so we can access its embedded font
		private static var textRef:Text;
	}
}
