package punk.ui
{
	import punk.ui.skin.PunkSkin;
	
	public class PunkConfirmation extends PunkAlert
	{
		public var cancelButton:PunkButton;
		
		public var onCancel:Function = null;
		
		public function PunkConfirmation(x:Number=0, y:Number=0, width:Number=200, height:Number=100, caption:String="", messageString:String="", onOk:Function=null, onCancel:Function=null, okLabel:String="Ok", cancelLabel:String="Cancel", draggable:Boolean=true, skin:PunkSkin=null)
		{
			super(x, y, width, height, caption, messageString, okLabel, onOk, draggable, skin);
			
			this.onCancel = onCancel;
			
			okButton.relativeX = 5;
			add(cancelButton = new PunkButton(width - 79, this.height - originY - 25, 74, 20, cancelLabel, clickCancel));
		}
		
		protected function clickCancel():void
		{
			close();
			if(onCancel != null) onCancel();
		}
	}
}