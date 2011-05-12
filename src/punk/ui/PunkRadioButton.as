package punk.ui
{
	import net.flashpunk.Graphic;
	
	import punk.ui.skin.PunkSkin;
	
	public class PunkRadioButton extends PunkToggleButton
	{
		public var onChange:Function = null;
		
		public var radioButtonGroup:PunkRadioButtonGroup;
		public var id:String;
		
		public function PunkRadioButton(radioButtonGroup:PunkRadioButtonGroup, id:String, x:Number=0, y:Number=0, width:int=1, height:int=1, on:Boolean=false, text:String="Radio button", onChange:Function=null, hotkey:int=0, skin:PunkSkin=null, active:Boolean=true)
		{
			super(x, y, width, height, on, text, null, hotkey, skin, active);
			
			this.onChange = onChange;
			this.radioButtonGroup = radioButtonGroup;
			this.id = id;
			
			radioButtonGroup.add(this);
		}
		
		override protected function setupSkin(skin:PunkSkin):void
		{
			if(!skin.punkRadioButton) return;
			
			setUpButtonSkin(skin.punkRadioButton);
			setUpToggleButtonSkin(skin.punkRadioButton);
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