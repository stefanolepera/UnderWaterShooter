package com.stefanolepera.underwatershooter.services 
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	/**
	 * SoundManager Class
	 * A singleton used to manage the game's sounds
	 * 
	 * @author Stefano Le Pera
	 * @version 1.0 - 14/08/2012
	 */
	public class SoundManager 
	{
		private static var _instance:SoundManager = null;
		
		private static var _splashSound:Sound;
		private static var _harpoonSound:Sound;
		private static var _shakeSound:Sound;
		private static var _hitSound:Sound;
		
		private static const _SPLASH:String = "splash";
		private static const _HARPOON:String = "harpoon";
		private static const _SHAKE:String = "shake";
		private static const _HIT:String = "hit";
		
		private static var isShake:Boolean = false;
		
		/**
		 * Constructor
		 */
		public function SoundManager() 
		{
			// void
		}
		
		/**
		 * return an instance of a Singleton
		 * @return SoundManager type
		 */
		public static function getInstance():SoundManager
		{
			if (!_instance)
				_instance = new SoundManager();
				
			return _instance;
		}
		
		/**
		 * initialize the sounds
		 */
		public function initialize():void
		{
			_splashSound = Assets.getSoundSplash();
			_harpoonSound = Assets.getSoundHarpoon();
			_shakeSound = Assets.getSoundShake();
			_hitSound = Assets.getSoundHit();
		}
		
		/**
		 * play the sound by name
		 * @param	soundName String type
		 */
		public function play(soundName:String):void
		{
			var channel:SoundChannel;
			
			switch (soundName)
			{
				case SoundManager.SPLASH:
					channel = _splashSound.play();
					break;
					
				case SoundManager.HARPOON:
					channel = _harpoonSound.play();
					break;
					
				case SoundManager.SHAKE:
					if (!isShake) {
						isShake = true;
						channel = _shakeSound.play();
						channel.addEventListener(Event.SOUND_COMPLETE, onShakeComplete);
					}
					break;
						
				case SoundManager.HIT:
					channel = _hitSound.play();
					break;
			}
		}
		
		/**
		 * when the sound ending, reset isShake to false
		 * @param	e Event type
		 */
		private function onShakeComplete(e:Event):void 
		{
			e.target.removeEventListener(e.type, arguments.callee);
			isShake = false;
		}
		
		/////////////////////////////////////////////
		////////// GETTERS & SETTERS ///////////////
		///////////////////////////////////////////
		public static function get SPLASH():String 
		{
			return _SPLASH;
		}
		
		public static function get HARPOON():String 
		{
			return _HARPOON;
		}
		
		public static function get SHAKE():String 
		{
			return _SHAKE;
		}
		
		public static function get HIT():String 
		{
			return _HIT;
		}
		
	}

}