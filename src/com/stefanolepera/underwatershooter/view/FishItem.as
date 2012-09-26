package com.stefanolepera.underwatershooter.view 
{
	import starling.events.Event;
	import starling.text.TextField;
	
	/**
	 * FishItem Class, extends Fish class to easy create a fish image
	 * @author Stefano Le Pera
	 * @version 1.0 - 13/08/2012
	 */
	public class FishItem extends Fish
	{
		private var numCaught:int;
		private var numCaughtText:TextField;
		
		/**
		 * Constructor
		 * @param	id int type
		 */
		public function FishItem(id:int)
		{
			super(id)
			_id = id;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		/**
		 * override init method, call the superclass createfish (to create fish image) and call drawText method
		 * @param	e Event type
		 */
		override protected function init(e:Event):void 
		{
			e.target.removeEventListener(e.type, arguments.callee);
			
			super.createFishImage();
			drawText();
		}
		
		/**
		 * create and add the textfield that store the number of fish caught.
		 * move the fish image under the textfield
		 */
		private function drawText():void
		{
			numCaughtText = new TextField(50, 30, "", "MyFont", 24, 0xFFFFFF);
			numCaughtText.x = (fishImage.width - numCaughtText.width) >> 1;
			numCaughtText.y = 0;
			addChild(numCaughtText);
			
			fishImage.y = numCaughtText.y + numCaughtText.height;
		}
		
		/**
		 * set the number of fish caught and update the texfield
		 * @param	value
		 */
		public function setNumCaught(value:int):void
		{
			numCaught = value;
			numCaughtText.text = numCaught.toString();
		}
		
	}

}