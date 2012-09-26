package 
{
	import com.stefanolepera.underwatershooter.core.Game;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import starling.core.Starling;
	
	/**
	 * Document Class
	 * 
	 * @author Stefano Le Pera
	 * @version 1.0 - 08/08/2012
	 */
	[SWF(frameRate="60", width="800", height="600", backgroundColor="0xFFFFFF")]
	public class UnderWaterShooter extends Sprite 
	{
		/**
		 * Constructor
		 */
		public function UnderWaterShooter():void 
		{
			if (stage) 
				init();
			else 
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		/**
		 * init method
		 * 
		 * @param	e Event type
		 */
		private function init(e:Event = null):void 
		{
			if (e) 
				removeEventListener(Event.ADDED_TO_STAGE, init);
				
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			initGame();
		}
		
		/**
		 * initialize starling framework
		 */
		private function initGame():void
		{	
			var starling:Starling = new Starling(Game, stage);
			starling.antiAliasing = 1;
			starling.start();
			starling.stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
		}
		
		/**
		 * check if GPU acceleration is enabled
		 * @param	e Event type
		 */
		private function onContextCreated(e:Event):void
		{
            if (Starling.context.driverInfo.toLowerCase().indexOf("software") != -1) {
                Starling.current.nativeStage.frameRate = 30;
            }
			else {
                Starling.current.nativeStage.frameRate = 60;
            }
        }
		
	}
	
}