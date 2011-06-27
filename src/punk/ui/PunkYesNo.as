package punk.ui
{
	import punk.ui.skin.PunkSkin;
	
	public class PunkYesNo extends PunkConfirmation
	{
		public function PunkYesNo(x:Number=0, y:Number=0, width:Number=200, height:Number=100, caption:String="", messageString:String="", onOk:Function=null, onCancel:Function=null, okLabel:String="Yes", cancelLabel:String="No", draggable:Boolean=true, skin:PunkSkin=null)
		{
			super(x, y, width, height, caption, messageString, onOk, onCancel, okLabel, cancelLabel, draggable, skin);
		}
	}
}