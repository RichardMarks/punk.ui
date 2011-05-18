package punk.ui
{
	/**
	 * Contains and controls a collection of grouped radio buttons.
	 */
	public class PunkRadioButtonGroup
	{
		/**
		 * Function to call when the components state changes
		 */
		public var onChange:Function = null
		
		/**
		 * Vector containing the grouped PunkRadioButtons
		 */
		protected var radioButtons:Vector.<PunkRadioButton> = new Vector.<PunkRadioButton>;	
		
		/**
		 * Constructor
		 * @param	onChange Function to call when the group's state changes
		 */
		public function PunkRadioButtonGroup(onChange:Function = null)
		{
			this.onChange = onChange;
		}
		
		/**
		 * Add a PunkRadioButton to the collection
		 * @param	radioButton PunkRadioButton to add
		 */
		internal function add(radioButton:PunkRadioButton):void
		{
			if(radioButtons.indexOf(radioButton) < 0) radioButtons.push(radioButton);
		}
		
		/**
		 * Remove a PunkRadioButton from the collection
		 * @param	radioButton PunkRadioButton to remove
		 */
		internal function remove(radioButton:PunkRadioButton):void
		{
			var index:int = radioButtons.indexOf(radioButton);
			if(index > -1) radioButtons.splice(index, 1);
		}
		
		/**
		 * Set a the target radio button to the on state; all others to the off state.
		 * @param	radioButton PunkRadioButton to turn on
		 */
		internal function toggleOn(radioButton:PunkRadioButton):void
		{
			if(radioButton.on) return;
			
			for each(var b:PunkRadioButton in radioButtons)
			{
				if(b == radioButton)
				{
					b.toggle(true);
				}
				else
				{
					if(b.on) b.toggle(false);
				}
			}
			
			if(onChange != null) onChange(radioButton.id);
		}
	}
}