package com.stefanolepera.underwatershooter.view 
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.PDParticleSystem;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	/**
	 * ScoreTooltip Class
	 * this class represent the tooltip object
	 * 
	 * @author Stefano Le Pera
	 * @version 1.0 - 13/08/2012
	 */
	public class ScoreTooltip extends Sprite
	{
		private var bg:Image;
		private var tf:TextField;
		private var score:int;
		private var particle:PDParticleSystem;
		
		/**
		 * Constructor
		 * @param	s int type
		 */
		public function ScoreTooltip(s:int) 
		{
			score = s;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		/**
		 * call the startup methods
		 * @param	e Event type
		 */
		private function init(e:Event):void 
		{
			e.target.removeEventListener(e.type, arguments.callee);
			
			draw();
			startTimer();
		}
		
		/**
		 * draw the background shape, create textfield and set the color.
		 * create and start the particle effect
		 */
		private function draw():void 
		{
			var shape:Shape = createShape();
			var canvas:BitmapData = new BitmapData(shape.width, shape.height, true, 0xFF0000);
			canvas.draw(shape);
			
			var texture:Texture = Texture.fromBitmapData(canvas);
			bg = new Image(texture);
			addChild(bg);
			
			if (score > 0) {
				particle = new PDParticleSystem(Assets.getParticleXML(), Assets.getParticleTexture());
				particle.start();
				
				Starling.juggler.add(particle);
				addChild(particle);
				
				particle.emitterX = bg.width >> 1;
				particle.emitterY = 0;
			}
			
			var scoreToDisplay:String = score > 0 ? "+" + score.toString() : score.toString();
			var color:uint = score > 0 ? 0x0099FF : 0xCC0000;
			
			tf = new TextField(50, 30, scoreToDisplay, "MyFont", 24, color);
			addChild(tf);
		}
		
		/**
		 * create a one second timer. When the timer expire, the object will be destroyed
		 */
		private function startTimer():void 
		{
			var timer:Timer = new Timer(1000, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, destroy);
			timer.start();
		}
		
		/**
		 * destroy the object and dispose the particle effect
		 * @param	e TimerEvent type
		 */
		private function destroy(e:TimerEvent):void 
		{
			if (particle) {
				particle.dispose();
				Starling.juggler.remove(particle);
			}
			
			this.removeFromParent(true);
		}
		
		/**
		 * create and return an ellipse shape
		 * @return
		 */
		private function createShape():Shape
		{	
			var s:Shape = new Shape();
			s.graphics.beginFill(0xFFFFFF);
			s.graphics.drawEllipse(0, 0, 50, 30); 
			s.graphics.endFill();
			return s;
		}
		
	}

}