package punk.ui
{
	import net.flashpunk.Graphic;
	
	public class PunkRadioButton extends PunkToggleButton
	{
		public var onChange:Function = null;
		
		public var radioButtonGroup:PunkRadioButtonGroup;
		public var id:String;
		
		public function PunkRadioButton(radioButtonGroup:PunkRadioButtonGroup, id:String, x:Number=0, y:Number=0, width:int=1, height:int=1, on:Boolean=false, text:String="Radio button", onChange:Function=null, normalGraphic:Graphic=null, mousedGraphic:Graphic=null, pressedGraphic:Graphic=null, inactiveGraphic:Graphic=null, normalOnGraphic:Graphic=null, mousedOnGraphic:Graphic=null, pressedOnGraphic:Graphic=null, inactiveOnGraphic:Graphic=null, hotkey:int=0, labelProperties:Object=null, active:Boolean=true)
		{
			super(x, y, width, height, on, text, null, normalGraphic, mousedGraphic, pressedGraphic, inactiveGraphic, normalOnGraphic, mousedOnGraphic, pressedOnGraphic, inactiveOnGraphic, hotkey, labelProperties, active);
			
			this.onChange = onChange;
			this.radioButtonGroup = radioButtonGroup;
			this.id = id;
			
			radioButtonGroup.add(this);
		}
		
		public function dispose():void
		{
			radioButtonGroup.remove(this);
		}
		
		override protected function releasedCallback():void
		{
			isPressed = false;
			radioButtonGroup.toggleOn(this);
			if(onReleased != null) onReleased(on);
		}
		
		internal function toggle(on:Boolean):void
		{
			this.on = on;
			if(onChange != null) onChange(on);
		}
		
		override public function removed():void
		{
			super.removed();
			
			dispose();
		}
	}
}