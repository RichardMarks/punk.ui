package punk.ui
{
	public class PunkRadioButtonGroup
	{
		public var onChange:Function = null
		
		protected var radioButtons:Vector.<PunkRadioButton> = new Vector.<PunkRadioButton>;	
		
		public function PunkRadioButtonGroup(onChange:Function = null)
		{
			this.onChange = onChange;
		}
		
		internal function add(radioButton:PunkRadioButton):void
		{
			if(radioButtons.indexOf(radioButton) < 0) radioButtons.push(radioButton);
		}
		
		internal function remove(radioButton:PunkRadioButton):void
		{
			var index:int = radioButtons.indexOf(radioButton);
			if(index > -1) radioButtons.splice(index, 1);
		}
		
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