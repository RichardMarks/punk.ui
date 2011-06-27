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

	/**
	 * A panel component. This component can contain other PunkUIComponents.
	 */
	public class PunkPanel extends PunkUIComponent
	{
		
		/**
		 * A graphic list which can be used to add graphical components to the panel.
		 */
		public var graphiclist:Graphiclist;
		
		/**
		 * Render buffer for this component
		 */
		protected var buffer:BitmapData;
		/**
		 * Pointer to the clipping mask used in the rendering process
		 */
		protected var bounds:Rectangle;
		
		/**
		 * Container for all child elements of the panel
		 */
		protected var _children:Vector.<PunkUIComponent> = new Vector.<PunkUIComponent>;
		/**
		 * Count of child elements
		 */
		protected var _count:int = 0;
		
		/**
		 * Stores the previous X-Coordinate for use when updating positions of child components.
		 */
		protected var oldX:Number = 0;
		/**
		 * Stores the previous Y-Coordinate for use when updating the positions of child components.
		 */
		protected var oldY:Number = 0;
		
		/**
		 * Stores the previous X-Scroll offset for use when updating the position of child components.
		 */
		protected var _oldScrollX:Number = 0;
		/**
		 * Stores the previous Y-Scroll offset for use when updating the position of child components.
		 */
		protected var _oldScrollY:Number = 0;
		
		/**
		 * X-Scroll offset for scrolling content.
		 */
		public var scrollX:Number = 0;
		/**
		 * Y-Scroll offset for scrolling content.
		 */
		public var scrollY:Number = 0;
		
		/**
		 * Constructor.
		 * @param	x X-Coordinate for the component
		 * @param	y Y-Coordinate for the component
		 * @param	width Width of the component
		 * @param	height Height of the component
		 * @param	skin Skin to use when rendering the component
		 */
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
		
		/**
		 * Add a PunkUIComponent to the panel.
		 * @param	uiComponent Punk UI component to add
		 * @return  PunkUIComponent that was added
		 */
		public function add(uiComponent:PunkUIComponent):PunkUIComponent
		{
			/* 
			if(uiComponent is PunkPanel)
			{
				trace("PunkPanels can't contain other PunkPanels at the moment.");
				FP.log("PunkPanels can't contain other PunkPanels at the moment.");
				return uiComponent;
			}
			
			if(uiComponent._panel) return uiComponent;
			*/
			
			_children[_count++] = uiComponent;
			uiComponent._panel = this;
			uiComponent.x += x + scrollX;
			uiComponent.y += y + scrollY;
			uiComponent.added();
			return uiComponent;
		}
		
		/**
		 * Remove a PunkUIComponent from the panel.
		 * @param	uiComponent PunkUIComponent to remove
		 * @return  the PunkUIComponent that was removed
		 */
		public function remove(uiComponent:PunkUIComponent):PunkUIComponent
		{
			var index:int = _children.indexOf(uiComponent);
			if(index < 0) return uiComponent;
			_children.splice(index, 1);
			--_count;
			uiComponent.renderTarget = null;
			uiComponent.removed();
			uiComponent._panel = null;
			return uiComponent;
		}
		
		/**
		 * @private
		 */
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
			
			bounds.width = width;
			bounds.height = height;
			
			
			if(oldX != x || oldY != y || _oldScrollX != scrollX || _oldScrollY != scrollY)
			{
				for each(uiComponent in _children)
				{
					uiComponent.x += (x - oldX) + (scrollX - _oldScrollX);
					uiComponent.y += (y - oldY) + (scrollY - _oldScrollY);
				}
				
				oldX = x;
				oldY = y;
				
				_oldScrollX = scrollX;
				_oldScrollY = scrollY;
			}
			
		}
		
		/**
		 * @private
		 */
		override public function render():void
		{
			super.render();
			
			buffer.fillRect(FP.bounds, 0x00000000);
			
			for each(var uiComponent:PunkUIComponent in _children)
			{
				if(!uiComponent.visible) continue;
				
				if(uiComponent._camera) uiComponent._camera.x = uiComponent._camera.y = 0;
				else uiComponent._camera = new Point;
				
				uiComponent.renderTarget = buffer;
				uiComponent.render();
			}
			
			if (_panel == null) {
				// Scroll top level panels
				FP.point.x = x - FP.camera.x;
				FP.point.y = y - FP.camera.y;
			} else {
				// Do not scroll nested panels
				FP.point.x = x;
				FP.point.y = y;
			}
			
			bounds.x = x;
			bounds.y = y;
			
			var t:BitmapData = renderTarget ? renderTarget : FP.buffer;
			t.copyPixels(buffer, bounds, FP.point);
		}
		
		/**
		 * Scroll the panel to a location, with easing.
		 * @param	x X-Coordinate to scroll to
		 * @param	y Y-Coordinate to scroll to
		 */
		public function scrollTo(x:Number, y:Number):void
		{
			scrollX = x;
			scrollY = y;
		}
		
		/**
		 * Add a Graphic to the panel
		 * @param	graphic Graphic to add
		 * @return the Graphic added to the panel
		 */
		override public function addGraphic(graphic:Graphic):Graphic
		{
			return graphiclist.add(graphic);
		}
		
		/**
		 * Remove a Graphic from the panel
		 * @param	graphic Graphic to remove
		 * @return the Graphic removed from the panel
		 */
		public function removeGraphic(graphic:Graphic):Graphic
		{
			return graphiclist.remove(graphic);
		}
		
		/**
		 * Return the vector containing all child PunkUIComponents
		 */
		public function get children():Vector.<PunkUIComponent>
		{
			return _children;
		}
		
		/**
		 * Count of all child PunkUIComponents in the panel
		 */
		public function get count():int
		{
			return _count
		}
		
		/**
		 * Add a list of PunkUIComponents to the panel
		 * @param	...list the list of PunkUIComponents to add
		 */
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
		
		/**
		 * Remove a list of PunkUIComponents from the panel
		 * @param	...list the list of PunkUIComponents to remove
		 */
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
		
		/**
		 * Remove every PunkUIComponent from the panel
		 */
		public function removeAll():void
		{
			for each(var e:PunkUIComponent in children)
			{
				remove(e);
			}
		}
		
		/**
		 * @private
		 */
		override public function added():void
		{
			super.added();
			
			for each(var e:PunkUIComponent in children)
			{
				e.added();
			}
		}
		
		/**
		 * @private
		 */
		override public function removed():void
		{
			super.removed();
			
			for each(var e:PunkUIComponent in children)
			{
				e.removed();
			}
		}

		/**
		 * X-Coordinate of the mouse
		 */
		internal function get mouseX():int
		{
			if(_panel) return _panel.mouseX;
			else if(world) return world.mouseX;
			return 0;
		}
		/**
		 * Y-Coordinate of the mouse
		 */
		internal function get mouseY():int
		{
			if(_panel) return _panel.mouseY;
			else if(world) return world.mouseY;
			return 0;
		}
		
		/**
		 * Return the top most PunkUIComponent of the panel at a given point
		 * @param	x X-Coordinate
		 * @param	y Y-Coordinate
		 * @return  top most PunkUIComponent at the supplied point
		 */
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