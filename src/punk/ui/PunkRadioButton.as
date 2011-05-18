package punk.ui
{
	import net.flashpunk.Graphic;
	
	import punk.ui.skin.PunkSkin;
	
	/**
	 * Single radio button component
	 */
	public class PunkRadioButton extends PunkToggleButton
	{
		/**
		 * Function called when this component is modified
		 */
		public var onChange:Function = null;
		
		/**
		 * The group of radior buttons that the component belongs to
		 */
		public var radioButtonGroup:PunkRadioButtonGroup;
		
		/**
		 * Identification String for the component
		 */
		public var id:String;
		
		/**
		 * Constructor
		 * @param	radioButtonGroup The collection of buttons the component belongs in
		 * @param	id identification String of the component
		 * @param	x X-Coordinate of the component
		 * @param	y Y-Coordinate of the component
		 * @param	width Width of the component
		 * @param	height Height of the Component
		 * @param	on If button is toggled on
		 * @param	text label for the component
		 * @param	onChange Function called when the state is changed
		 * @param	hotkey Hotkey used to trigger the component
		 * @param	skin Skin to use when rendering the component
		 * @param	active If the component is active
		 */
		public function PunkRadioButton(radioButtonGroup:PunkRadioButtonGroup, id:String, x:Number=0, y:Number=0, width:int=1, height:int=1, on:Boolean=false, text:String="Radio button", onChange:Function=null, hotkey:int=0, skin:PunkSkin=null, active:Boolean=true)
		{
			super(x, y, width, height, on, text, null, hotkey, skin, active);
			
			this.onChange = onChange;
			this.radioButtonGroup = radioButtonGroup;
			this.id = id;
			
			radioButtonGroup.add(this);
		}
		
		/**
		 * Additional setup steps for this component
		 * @param	skin Skin to use when rendering the component
		 */
		override protected function setupSkin(skin:PunkSkin):void
		{
			if(!skin.punkRadioButton) return;
			
			setUpButtonSkin(skin.punkRadioButton);
			setUpToggleButtonSkin(skin.punkRadioButton);
		}
		
		/**
		 * Clean up this component
		 */
		public function dispose():void
		{
			radioButtonGroup.remove(this);
		}
		
		/**
		 * @private
		 */
		override protected function releasedCallback():void
		{
			isPressed = false;
			radioButtonGroup.toggleOn(this);
			if(onReleased != null) onReleased(on);
		}
		
		/**
		 * Change the state of the component
		 * @param	on If the component should be in the on state
		 */
		internal function toggle(on:Boolean):void
		{
			this.on = on;
			if(onChange != null) onChange(on);
		}
		
		/**
		 * @private
		 */
		override public function removed():void
		{
			super.removed();
			
			dispose();
		}
	}
}