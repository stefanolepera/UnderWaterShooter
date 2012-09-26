package com.stefanolepera.underwatershooter.screens
{
	import com.stefanolepera.underwatershooter.events.NavigationEvent;
	import com.stefanolepera.underwatershooter.services.FishProvider;
	import com.stefanolepera.underwatershooter.services.GameManager;
	import com.stefanolepera.underwatershooter.services.SoundManager;
	import com.stefanolepera.underwatershooter.utils.GameState;
	import com.stefanolepera.underwatershooter.view.Bullet;
	import com.stefanolepera.underwatershooter.view.Fish;
	import com.stefanolepera.underwatershooter.view.GameBackground;
	import com.stefanolepera.underwatershooter.view.Diver;
	import com.stefanolepera.underwatershooter.view.ScoreTooltip;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.deg2rad;
	
	/**
	 * InGame Class.
	 * This class represent the gaming screen. Contains all the game logic
	 * 
	 * @author Stefano Le Pera
	 * @version 1.0 - 09/08/2012
	 */
	public class InGame extends Sprite
	{
		private var startButton:Button;
		private var bg:GameBackground;
		private var diver:Diver;
		
		private var gameState:String;
		private var hitFish:Number = 0;
		
		private const LIMIT_LEFT:int = 100;
		private const GAME_DURATION:int = 60;
		private const BULLET_SPEED:int = 10;
		private const BG_SPEED:int = 10;
		
		private var score:int = 0;
		private var gameTime:int;
		private var scoreText:TextField;
		private var timeText:TextField;
		
		private var gameArea:Rectangle;
		
		private var touch:Touch;
		private var touchX:Number;
		private var touchY:Number;
		
		private var provider:FishProvider;
		private var totalFishes:int = 0;
		
		private var scoreTooltip:ScoreTooltip;
		
		private var bulletToAnimate:Vector.<Bullet>;
		private var fishToAnimate:Vector.<Fish>;
		
		/**
		 * Constructor
		 */
		public function InGame()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		/**
		 * init method
		 * @param	e Event type
		 */
		private function init(e:Event):void
		{
			e.target.removeEventListener(e.type, arguments.callee);
			trace("InGame!");
			
			provider = new FishProvider(Assets.getConfig());
			totalFishes = provider.getTotalFishes();
			GameManager.getInstance().fishProvider = provider;
			
			drawGame();
		}
		
		/**
		 * create all images
		 */
		private function drawGame():void
		{
			bg = new GameBackground();
			addChild(bg);
			
			diver = new Diver();
			diver.x = stage.stageWidth >> 1;
			diver.y = stage.stageHeight >> 1;
			addChild(diver);
			
			startButton = new Button(Assets.getAtlas().getTexture("startButton"));
			startButton.x = (stage.stageWidth - startButton.width) >> 1;
			startButton.y = (stage.stageHeight - startButton.height) >> 1;
			addChild(startButton);
			
			drawText();
			
			gameArea = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight - 50);
		}
		
		/**
		 * create the score and time textField
		 */
		private function drawText():void 
		{
			scoreText = new TextField(300, 50, "SCORE: 0", "MyFont", 24, 0xFFFFFF);
			scoreText.x = 550;
			scoreText.y = 0;
			addChild(scoreText);
			
			timeText = new TextField(300, 50, "TIME: 60", "MyFont", 24, 0xFFFFFF);
			timeText.x = 550;
			timeText.y = 30;
			addChild(timeText);
		}
		
		/**
		 * idle the screen
		 */
		public function idle():void
		{
			visible = false;
		}
		
		/**
		 * tween the hero inside the screen and initialize the core variables
		 */
		public function initialize():void
		{
			visible = true;
			
			diver.x = - stage.stageWidth;
			diver.y = stage.stageHeight >> 1;
			
			gameState = GameState.IDLE;
			
			hitFish = 0;
			
			bg.speed = 0;
			score = 0;
			
			gameTime = GAME_DURATION;
			
			fishToAnimate = new Vector.<Fish>();
			bulletToAnimate = new Vector.<Bullet>();
			
			startButton.visible = true;
			startButton.addEventListener(Event.TRIGGERED, onStartButtonClick);
		}
		
		/**
		 * the timer that manage che game duration
		 */
		private function startTimer():void 
		{
			var timer:Timer = new Timer(1000, GAME_DURATION);
			timer.addEventListener(TimerEvent.TIMER, updateTimer);
			timer.start();
		}
		
		/**
		 * update the textfield and check if the game is over
		 * @param	e TimerEvent type
		 */
		private function updateTimer(e:TimerEvent):void
		{
			gameTime --;
			timeText.text = "TIME: " + gameTime;
			
			initFish();
			
			if (gameTime == 0)
				endGame();
		}
		
		/**
		 * start the game
		 * @param	e Event type
		 */
		private function onStartButtonClick(e:Event):void
		{
			startButton.visible = false;
			startButton.removeEventListener(Event.TRIGGERED, onStartButtonClick);
			
			launchDiver();
			startTimer();
		}
		
		/**
		 * initialize the core listeners
		 */
		private function launchDiver():void
		{
			addEventListener(TouchEvent.TOUCH, onTouch);
			addEventListener(Event.ENTER_FRAME, onGameTick);
		}
		
		/**
		 * capture the movements and mouse clicks.
		 * on move the hero go up and down, on click the hero fire a bullet
		 * @param	e TouchEvent type
		 */
		private function onTouch(e:TouchEvent):void
		{
			try {
				touch = e.getTouch(stage);
				
				touchX = touch.globalX;
				touchY = touch.globalY;
				
				if (touch.phase == TouchPhase.BEGAN) {
					createBullet();
				}
			}
			catch (e:Error) { };	
		}
		
		/**
		 * check the game state.
		 * in idle state, tween the hero inside the screen.
		 * in play state move the hero, check if there is a collision and call the core methods of the game
		 * @param	e Event type
		 */
		private function onGameTick(e:Event):void
		{
			switch (gameState)
			{
				case GameState.IDLE:
					
					if (diver.x < LIMIT_LEFT) {
						diver.x += (LIMIT_LEFT - diver.x + 10) * 0.05;
						diver.y = stage.stageHeight >> 1;
					}
					else {
						gameState = GameState.PLAY;
					}
					
					break;
					
				case GameState.PLAY:
					
					if (hitFish <= 0) {
						diver.y -= (diver.y - touchY) * 0.1;
						
						if (-(diver.y - touchY) < 150 && -(diver.y - touchY) > -150) {
							diver.rotation = deg2rad(-(diver.y - touchY) * 0.2);
						}
						
						if (diver.y > gameArea.bottom - (diver.height >> 1)) {
							diver.y = gameArea.bottom - (diver.height >> 1);
							diver.rotation = deg2rad(0);
						}
						
						if (diver.y < gameArea.top + (diver.height >> 1)) {
							diver.y = gameArea.top + (diver.height >> 1);
							diver.rotation = deg2rad(0);
						}
					}
					else {
						hitFish--;
						cameraShake();
					}
					
					bg.speed = BG_SPEED;
					
					animateFish();
					animateBullet();
					
					break;
					
				case GameState.OVER:
					break;
			}
		}
		
		/**
		 * update the game score
		 * @param	newScore int type
		 */
		private function updateScore(newScore:int):void
		{
			scoreText.text = "SCORE: " + newScore;
			GameManager.getInstance().score = newScore;
		}
		
		/**
		 * create a new bullet
		 */
		private function createBullet():void 
		{
			if (gameState == GameState.PLAY) {
				var bullet:Bullet = new Bullet();
				bullet.x = diver.x + (diver.width >> 1);
				bullet.y = diver.y + 10;
				addChild(bullet);
				
				bulletToAnimate.push(bullet);
				
				SoundManager.getInstance().play(SoundManager.HARPOON);
			}
		}
		
		/**
		 * animate the bullet and check its position
		 */
		private function animateBullet():void
		{
			var bulletToTrack:Bullet;
			
			if (bulletToAnimate.length) {
				for (var i:uint = 0; i < bulletToAnimate.length; i++) {
					
					bulletToTrack = bulletToAnimate[i];
					bulletToTrack.x += BULLET_SPEED;
					
					if (bulletToTrack.x > (stage.stageWidth + 50)) {
						bulletToAnimate.splice(i, 1);
						removeChild(bulletToTrack);
					}
				}
			}
		}
		
		/**
		 * simulate a shake effects
		 */
		private function cameraShake():void
		{
			SoundManager.getInstance().play(SoundManager.SHAKE);
			
			if (hitFish > 0) {
				this.x = int(Math.random() * hitFish);
				this.y = int(Math.random() * hitFish);
			}
			else if (x != 0) {
				this.x = 0;
				this.y = 0;
			}
		}
		
		/**
		 * randomly create a new fish
		 */
		private function initFish():void
		{
			var randomCount:Number = Math.random();
			
			if (randomCount > 0.4)
				createFish(Math.ceil(Math.random() * totalFishes));
				
		}
		
		/**
		 * create random new fish
		 * @param	id Number type
		 */
		private function createFish(id:Number):void
		{
			var fish:Fish = new Fish(id, provider.getFishByID(id).score, provider.getFishByID(id).speed);
			fish.x = stage.stageWidth;
			fish.y = Math.random() * (gameArea.bottom - 100) + 50;
			addChild(fish);
			
			fishToAnimate.push(fish);
		}
		
		/**
		 * animate the fish, manage the collision with hero and bullet object, create tooltip object to display the fish score
		 */
		private function animateFish():void
		{
			var fishToTrack:Fish;
			
			if (fishToAnimate.length) {
				for (var i:uint = 0; i < fishToAnimate.length; i++) {
					fishToTrack = fishToAnimate[i];
					
					if (fishToTrack.alreadyHit == false && fishToTrack.bounds.intersects(diver.bounds)) {
						fishToTrack.alreadyHit = true;
						fishToTrack.rotation = deg2rad(70);
						hitFish = 30;
						
						score -= fishToTrack.score;
						updateScore(score);
						
						scoreTooltip = new ScoreTooltip(-fishToTrack.score);
						scoreTooltip.x = fishToTrack.x;
						scoreTooltip.y = fishToTrack.y;
						addChild(scoreTooltip);
					}
					
					fishToTrack.x -= fishToTrack.speed;
					
					if (fishToTrack.x < -fishToTrack.width || gameState == GameState.OVER) {
						fishToAnimate.splice(i, 1);
						removeChild(fishToTrack);
					}
					
					if (bulletToAnimate.length) {
						for (var j:int = 0; j < bulletToAnimate.length; j++) {
							if (fishToTrack.alreadyHit == false && fishToTrack.bounds.intersects(bulletToAnimate[j].bounds)) {
								fishToTrack.alreadyHit = true;
								fishToTrack.rotation = deg2rad(70);
								score += fishToTrack.score;
								updateScore(score);
								
								GameManager.getInstance().addFish(fishToTrack.id);
								SoundManager.getInstance().play(SoundManager.HIT);
								
								scoreTooltip = new ScoreTooltip(fishToTrack.score);
								scoreTooltip.x = fishToTrack.x;
								scoreTooltip.y = fishToTrack.y;
								addChild(scoreTooltip);
								
								fishToAnimate.splice(i, 1);
								removeChild(fishToTrack);
								
								removeChild(bulletToAnimate[j]);
								bulletToAnimate.splice(j, 1);
							}
						}
					}
				}
			}
		}
		
		/**
		 * reset all the game's variables and dispatch an event to call the GameOver screen
		 */
		private function endGame():void 
		{
			trace("ENDGAME!");
			gameState = GameState.OVER;
			
			scoreText.text = "SCORE: 0";
			timeText.text = "TIME: 60";
			
			while (fishToAnimate.length)
				removeChild(fishToAnimate.shift());
				
			while (bulletToAnimate.length)
				removeChild(bulletToAnimate.shift());
				
			removeEventListener(TouchEvent.TOUCH, onTouch);
			removeEventListener(Event.ENTER_FRAME, onGameTick);
			
			dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, "over", true));
		}
		
	}
	
}