package punk.ui
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.tweens.misc.MultiVarTween;
	import net.flashpunk.utils.Ease;
	
	import punk.ui.skin.PunkSkin;

	public class PunkPanel extends PunkUIComponent
	{
		public var graphiclist:Graphiclist;
		
		protected var buffer:BitmapData;
		protected var bounds:Rectangle;
		
		protected var _children:Vector.<PunkUIComponent> = new Vector.<PunkUIComponent>;
		protected var _count:int = 0;
		
		protected var oldX:Number = 0;
		protected var oldY:Number = 0;
		
		protected var _oldScrollX:Number = 0;
		protected var _oldScrollY:Number = 0;
		protected var _targetX:Number = 0;
		protected var _targetY:Number = 0;
		protected var _t:Number = 0;
		internal var _scrollX:Number = 0;
		internal var _scrollY:Number = 0;
		
		public function PunkPanel(x:Number=0, y:Number=0, width:int=20, height:int=20, skin:PunkSkin=null)
		{
			if(width < 1) width = 1;
			if(height < 1) height = 1;
			
			super(x, y, width, height, skin);
			
			oldX = x;
			oldY = y;
			
			buffer = new BitmapData(FP.width, FP.height, true, 0x00000000);
			bounds = new Rectangle(0, 0, width, height);
			
			graphic = graphiclist = new Graphiclist;
		}
		
		public function add(uiComponent:PunkUIComponent):PunkUIComponent
		{
			if(uiComponent is PunkPanel)
			{
				trace("PunkPanels can't contain other PunkPanels at the moment.");
				FP.log("PunkPanels can't contain other PunkPanels at the moment.");
				return uiComponent;
			}
			
			if(uiComponent._panel) return uiComponent;
			_children[_count++] = uiComponent;
			uiComponent._panel = this;
			uiComponent.x += x + _scrollX;
			uiComponent.y += y + _scrollY;
			uiComponent.added();
			return uiComponent;
		}
		
		public function remove(uiComponent:PunkUIComponent):PunkUIComponent
		{
			var index:int = _children.indexOf(uiComponent);
			if(index < 0) return uiComponent;
			_children.splice(index, 1);
			uiComponent.renderTarget = null;
			uiComponent.removed();
			uiComponent._panel = null;
			return uiComponent;
		}
		
		override public function update():void
		{
			super.update();
			
			var uiComponent:PunkUIComponent;
			for each(uiComponent in _children)
			{
				if(!uiComponent.active) continue;
				
				uiComponent.updateTweens();
				uiComponent.update();
				if(uiComponent.graphic && uiComponent.graphic.active) uiComponent.graphic.update();
			}
			
			if(_targetX != _scrollX || _targetY != scrollY)
			{
				var d:Number = FP.distance(_targetX, _targetY, _scrollX, _scrollY);
				var s:Number = d / _t;
				
				point.x = _targetX - _scrollX;
				point.y = _targetY - _scrollY;
				point.normalize(s);
				_scrollX += point.x;
				_scrollY += point.y;
			}
			
			bounds.width = width;
			bounds.height = height;
		}
		
		override public function render():void
		{
			super.render();
			
			buffer.fillRect(FP.bounds, 0x00000000);
			
			if(oldX != x || oldY != y || _oldScrollX != _scrollX || _oldScrollY != _scrollY)
			{
				for each(uiComponent in _children)
				{
					uiComponent.x += (x - oldX) + (_scrollX - _oldScrollX);
					uiComponent.y += (y - oldY) + (_scrollY - _oldScrollY);
				}
				
				oldX = x;
				oldY = y;
				
				_oldScrollX = _scrollX;
				_oldScrollY = _scrollY;
			}
			
			for each(var uiComponent:PunkUIComponent in _children)
			{
				if(!uiComponent.visible) continue;
				
				if(uiComponent._camera) uiComponent._camera.x = uiComponent._camera.y = 0;
				else uiComponent._camera = new Point;
				
				uiComponent.renderTarget = buffer;
				uiComponent.render();
			}
			
			FP.point.x = relativeX - FP.camera.x;
			FP.point.y = relativeY - FP.camera.y;
			
			bounds.x = x;
			bounds.y = y;
			
			var t:BitmapData = renderTarget ? renderTarget : FP.buffer;
			t.copyPixels(buffer, bounds, FP.point);
		}
		
		public function scrollTo(x:Number, y:Number, ease:Number = 1):void
		{
			_targetX = x;
			_targetY = y;
			_t = ease < 1 ? 1 : ease;
		}
		
		public function get scrollX():Number
		{
			return _scrollX;
		}
		
		public function get scrollY():Number
		{
			return _scrollY;
		}
		
		override public function addGraphic(graphic:Graphic):Graphic
		{
			return graphiclist.add(graphic);
		}
		
		public function removeGraphic(graphic:Graphic):Graphic
		{
			return graphiclist.remove(graphic);
		}
		
		public function get children():Vector.<PunkUIComponent>
		{
			return _children;
		}
		
		public function get count():int
		{
			return _count
		}
		
		public function addList(...list):void
		{
			var e:PunkUIComponent;
			if (list[0] is Array || list[0] is Vector.<*>)
			{
				for each (e in list[0]) add(e);
				return;
			}
			for each (e in list) add(e);
		}
		
		public function removeList(...list):void
		{
			var e:PunkUIComponent;
			if (list[0] is Array || list[0] is Vector.<*>)
			{
				for each (e in list[0]) remove(e);
				return;
			}
			for each (e in list) remove(e);
		}
		
		public function removeAll():void
		{
			for each(var e:PunkUIComponent in children)
			{
				remove(e);
			}
		}
		
		override public function added():void
		{
			super.added();
			
			for each(var e:PunkUIComponent in children)
			{
				e.added();
			}
		}
		
		override public function removed():void
		{
			super.removed();
			
			for each(var e:PunkUIComponent in children)
			{
				e.removed();
			}
		}
		
		internal function get mouseX():int{ return _panel ? _panel.mouseX : world.mouseX; }
		internal function get mouseY():int{ return _panel ? _panel.mouseY : world.mouseY; }
		
		internal function frontCollidePoint(x:Number, y:Number):PunkUIComponent
		{
			var i:int = _children.length-1;
			var c:PunkUIComponent;
			for(;i > -1; --i)
			{
				c = _children[i];
				if(c.collidePoint(c.x, c.y, x, y)) return c;
			}
			return null;
		}
		
		private static var point:Point = new Point;
	}
}