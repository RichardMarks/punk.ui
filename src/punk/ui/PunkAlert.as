package punk.ui
{
	import punk.ui.skin.PunkSkin;
	
	public class PunkAlert extends PunkWindow
	{
		/**
		 * The message PunkText label. 
		 */		
		public var message:PunkText;
		/**
		 * The Ok button. 
		 */		
		public var okButton:PunkButton;
		
		/**
		 * Callback for the ok button. 
		 */		
		public var onOk:Function;
		
		/**
		 * Create a new Alert 
		 * @param x					X position of the alert
		 * @param y					Y position of the alert
		 * @param width				Width of the alert. Defaults to 200.
		 * @param height			Height of the alert. Defaults to 100.
		 * @param caption			Caption title of the alert.
		 * @param messageString		Message of the alert.
		 * @param okLabel			The label for the ok button. Defaults to Ok.
		 * @param onOk				The callback for the ok button.
		 * @param draggable			Whether the PunkAlert is draggable or not.
		 * @param skin				Custom skin.
		 * 
		 */		
		public function PunkAlert(x:Number=0, y:Number=0, width:Number = 200, height:Number = 100, caption:String="", messageString:String="", okLabel:String="Ok", onOk:Function = null, draggable:Boolean=true, skin:PunkSkin=null)
		{
			super(x, y, width, height, caption, draggable, skin);
			
			this.onOk = onOk;
			
			message = new PunkText(messageString, 0, 0, _labelProperties);
			addGraphic(message);
			
			add(okButton = new PunkButton((width * 0.5) - 37, this.height - originY - 25, 74, 20, okLabel, clickOk));
		}
		
		/**
		 * Closes this PunkAlert
		 */		
		public function close():void
		{
			if(world) world.remove(this);
			else if(_panel) _panel.remove(this);
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
		
		protected function clickOk():void
		{
			close();
			if(onOk != null) onOk();
		}
		
		private var _labelProperties:Object;
	}
}