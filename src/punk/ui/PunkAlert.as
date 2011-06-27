package punk.ui
{
	import punk.ui.skin.PunkSkin;
	
	public class PunkAlert extends PunkWindow
	{
		public var message:PunkText;
		
		public var onClose:Function;
		
		public function PunkAlert(x:Number=0, y:Number=0, width:Number = 200, height:Number = 100, caption:String="", messageString:String="", okLabel:String="Ok", onClose:Function = null, draggable:Boolean=true, skin:PunkSkin=null)
		{
			super(x, y, width, height, caption, draggable, skin);
			
			this.onClose = onClose;
			
			message = new PunkText(messageString, 0, 0, _labelProperties);
			addGraphic(message);
			
			add(new PunkButton((width * 0.5) - 50, this.height - originY - 25, 100, 20, okLabel, close));
		}
		
		/**
		 * Closes this PunkAlert
		 */		
		public function close():void
		{
			if(world) world.remove(this);
			else if(_panel) _panel.remove(this);
			
			if(onClose != null) onClose();
		}
		
		/**
		 * Additional setup steps for this component
		 * @param	skin Skin to use when rendering the component
		 */
		override protected function setupSkin(skin:PunkSkin):void
		{
			super.setupSkin(skin);
			
			_labelProperties = skin.punkLabel.labelProperties;
			if(!_labelProperties) _labelProperties = new Object;
			_labelProperties = mergeDefault({width: width, wordWrap: true, resizable: false, align: "center"}, _labelProperties);
		}
		
		private var _labelProperties:Object;
	}
}