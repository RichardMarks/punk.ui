package punk.ui
{
	import flash.geom.Point;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.text.engine.ElementFormat;
	import net.flashpunk.Graphic;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	/**
	 * @author	AClockWorkLemon (Saxon Landers)
	 * 			contact at info.clockworkgames@gmail.com
	 */
	public class PunkPanel extends Punk9SliceComponent
	{
		
		protected var children:Vector.<Entity> = new Vector.<Entity>()
		
		/**
		 * A panel to hold components
		 * @param	x		x position of the element on screen
		 * @param	y		y position of the element on screen
		 * @param	width	width of the element
		 * @param	height	height of the element
		 * @param	skin	if specified, sets a custom skin of this object
		 */
		public function PunkPanel(x:Number = 0, y:Number = 0, width:Number = 48, height:Number = 48, skin:Class = null)
		{
			super(x,y, width, height, new Rectangle(48, 0, 48, 48), 16, skin);
			
		}
		
		/**
		 * Adds an Entity to the PunkPanel
		 * @param	toAdd		The object to add
		 * @param	x			The x Position to place the object RELATIVE to the Panel's x Position
		 * @param	y			The y Position to place the object RELATIVE to the Panel's y Position
		 * @param	layer		The z depth of the object. (The higher, the closer to the top)
		 * @return				A reference to the Entity
		 */
		public function add(toAdd:*, x:Number = 0, y:Number = 0, layer:int = 0):Entity
		{
			var e:Entity;
			
			if (toAdd is Entity) { e = toAdd; }
			else if (toAdd is Graphic) { e = new Entity(0, 0, toAdd); }
			else throw new Error(toAdd + " is not a supported class type")
			
			e.x = this.x + x;
			e.y = this.y + y;
			
			e.layer = this.layer - layer;
			children.push(e);
			
			if (this.world == FP.world) { FP.world.add(e); }
			
			return e;
		}
		
		/**
		 * Removes an object from the PunkPanel
		 * @param	toRemove	The Entity to remove
		 */
		public function remove(toRemove:Entity):void
		{
			for (var i:int = 0; i < children.length; i++ )
			{
				if (children[i] == toRemove) { if (FP.world == toRemove.world) { FP.world.remove(toRemove); } children.splice(i, 1); }
			}
		}
		
		override public function added():void 
		{
			for each (var child:Entity in children) { FP.world.add(child); }
		}
		
		override public function removed():void 
		{
			for each (var child:Entity in children) { if (FP.world == child.world) { FP.world.remove(child); } }
		}
		
		//Helper functions
		
		/**
		 * Please make sure to read this documentation in full.
		 * Setting this to a number will edit the x of the panel.
		 * Setting it to an object will change child x values.
		 * To set it to an object, make it equal { add key/var pairs here }
		 * keys:
		 * 		child:	The entity to check/set. if none is specified, reads/checks the panel.
		 * 		x:	Number to set the child's x to
		 * 		get:	Pass a Number variable to this for it to set it to the specified child's x value.
		 */
		public function set relativeX(value:*):void
		{
			if (value is Number)
			{
				// set this object's x
				this.x = Number(value);
			}
			else if (value is Object)
			{
				// inline getter
				if (value.hasOwnProperty("get"))
				{
					if (value.hasOwnProperty("child"))
					{
						var index:Number = children.indexOf(value.child);
						if (childIndex < 0)
						{
							throw new Error("specified child not found on this panel object");
						}
						value.get = Number(children[childIndex].x);
						return;
					}
					
					value.get = Number(this.x);
					return;
				}
				
				
				// ensure the x property exists
				if (!value.hasOwnProperty("x"))
				{
					throw new Error("Missing x property in layer configuration object!");
				}
				
				// changing a child x?
				if (value.hasOwnProperty("child"))
				{
					var childIndex:Number = children.indexOf(value.child);
					if (childIndex < 0)
					{
						throw new Error("specified child not found on this panel object");
					}
					children[childIndex].x = this.x + value.x;
					return;
				}
				
				// no child specified, set this object's x value
				this.x = Number(value.x);
			}
			else throw new Error("Invalid parameter type");
		}
		
		/**
		 * Please make sure to read this documentation in full.
		 * Setting this to a number will edit the y of the panel.
		 * Setting it to an object will change child y values.
		 * To set it to an object, make it equal { add key/var pairs here }
		 * keys:
		 * 		child:	The entity to check/set. if none is specified, reads/checks the panel.
		 * 		y:	Number to set the child's y to
		 * 		get:	Pass a Number variable to this for it to set it to the specified child's x value.
		 */
		public function set relativeY(value:*):void
		{
			if (value is Number)
			{
				// set this object's y
				this.y = Number(value);
			}
			else if (value is Object)
			{
				// inline getter
				if (value.hasOwnProperty("get"))
				{
					if (value.hasOwnProperty("child"))
					{
						var index:Number = children.indexOf(value.child);
						if (childIndex < 0)
						{
							throw new Error("specified child not found on this panel object");
						}
						value.get = Number(children[childIndex].y);
						return;
					}
					
					value.get = Number(this.y);
					return;
				}
				
				
				// ensure the y property exists
				if (!value.hasOwnProperty("y"))
				{
					throw new Error("Missing x property in layer configuration object!");
				}
				
				// changing a child y?
				if (value.hasOwnProperty("child"))
				{
					var childIndex:Number = children.indexOf(value.child);
					if (childIndex < 0)
					{
						throw new Error("specified child not found on this panel object");
					}
					children[childIndex].y = this.y + value.y;
					return;
				}
				
				// no child specified, set this object's y value
				this.y = Number(value.y);
			}
			else throw new Error("Invalid parameter type");
		}
		
		
		
		/**
		 * Please make sure to read this documentation in full.
		 * Setting this to a number will edit the layer of the panel.
		 * Setting it to an object will change child layers.
		 * To set it to an object, make it equal { add key/var pairs here }
		 * keys:
		 * 		child:	The entity to check/set. if none is specified, reads/checks the panel.
		 * 		layer:	Number to set the child's layer to
		 * 		get:	Pass a Number variable to this for it to set it to the specified child's layer.
		 */
		public function set Layer(value:*):void
		{
			if (value is Number)
			{
				// set this object's layer
				this.layer = Number(value);
			}
			else if (value is Object)
			{
				// inline getter
				if (value.hasOwnProperty("get"))
				{
					if (value.hasOwnProperty("child"))
					{
						var index:Number = children.indexOf(value.child);
						if (childIndex < 0)
						{
							throw new Error("specified child not found on this panel object");
						}
						value.get = Number(children[childIndex].layer);
						return;
					}
					
					value.get = Number(this.layer);
					return;
				}
				
				
				// ensure the layer property exists
				if (!value.hasOwnProperty("layer"))
				{
					throw new Error("Missing layer property in layer configuration object!");
				}
				
				// changing a child layer?
				if (value.hasOwnProperty("child"))
				{
					var childIndex:Number = children.indexOf(value.child);
					if (childIndex < 0)
					{
						throw new Error("specified child not found on this panel object");
					}
					children[childIndex].layer = this.layer - value.layer;
					return;
				}
				
				// no child specified, set this object's layer
				this.layer = Number(value.layer);
			}
			else throw new Error("Invalid parameter type");
		}
		
		/**
		 * Hides specified objects in the panel
		 * @param	...objs		Objects to hide
		 */
		public function hide(...objs):void
		{
			var a:* = (objs.length == 1 && (objs[0] is Array || objs[0] is Vector.<*>)) ? objs[0] : objs;
			
			for (var i:Number; i < a.length; i++)
			{
				var index:int = children.indexOf(a[i]);
				if (index < 0)
				{
					throw new Error("Child '"+a[i]+"'not found in panel.");
				}
				children[index].visible = false
			}
		}
		
		/**
		 * Shows specified objects in the panel
		 * @param	...objs		Objects to show
		 */
		public function show(...objs):void
		{
			var a:* = (objs.length == 1 && (objs[0] is Array || objs[0] is Vector.<*>)) ? objs[0] : objs;
			
			for (var i:Number; i < a.length; i++)
			{
				var index:int = children.indexOf(a[i]);
				if (index < 0)
				{
					throw new Error("Child '"+a[i]+"'not found in panel.");
				}
				children[index].visible = true
			}
		}
	}
}