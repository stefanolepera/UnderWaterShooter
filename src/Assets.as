package  
{
	import flash.display.Bitmap;
	import flash.media.Sound;
	import flash.utils.Dictionary;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	/**
	 * Assets Class, embed all the graphics
	 * @author Stefano Le Pera
	 * @version 1.0 - 10/08/2012
	 */
	public class Assets 
	{
		private static var gameTextures:Dictionary = new Dictionary();
		private static var gameTextureAtlas:TextureAtlas;
		
		[Embed(source="../assets/menu_bg.jpg")]
		public static const BgMenu:Class;
		
		[Embed(source="../assets/bgLayer_1.jpg")]
		public static const BgLayer_1:Class;
		
		[Embed(source="../assets/underwaterSpritesheet.png")]
		public static const AtlasTextureGame:Class;
		
		[Embed(source="../assets/underwaterSpritesheet.xml", mimeType="application/octet-stream")]
		public static const AtlasXmlGame:Class;
		
		[Embed(source="../assets/gameConfig.xml", mimeType="application/octet-stream")]
		public static const GameConfig:Class;
		
		[Embed(source="../assets/font/FORTE.TTF", fontFamily="myFont", embedAsCFF="false")]
		public static var MyFont:Class;
		
		// ----- sounds ------ //
		[Embed(source="../assets/sounds/splash.mp3")]
		public static const SoundSplash:Class;
		
		[Embed(source="../assets/sounds/harpoon.mp3")]
		public static const SoundHarpoon:Class;
		
		[Embed(source="../assets/sounds/shake.mp3")]
		public static const SoundShake:Class;
		
		[Embed(source="../assets/sounds/hit.mp3")]
		public static const SoundHit:Class;
		
		// ----- particle ------ //
		[Embed(source="../assets/particles/texture.png")]
		public static const ParticleTexture:Class;
		
		[Embed(source="../assets/particles/particle.pex", mimeType="application/octet-stream")]
		public static const ParticleXML:Class;
		
		/**
		 * Constructor
		 */
		public function Assets()
		{
			throw new Error("Assets class is a static container only");
		}
		
		/**
		 * return the TextureAtlas
		 * @return TextureAtlas type
		 */
		public static function getAtlas():TextureAtlas
		{
			if (gameTextureAtlas == null) {
				var texture:Texture = getTexture("AtlasTextureGame");
				var xml:XML = XML(new AtlasXmlGame());
				gameTextureAtlas = new TextureAtlas(texture, xml);
			}
			
			return gameTextureAtlas;
		}
		
		/**
		 * return the specific Texture from the TextureAtlas
		 * @param	name String type
		 * @return Texture type
		 */
		public static function getTexture(name:String):Texture
		{
			if (gameTextures[name] == undefined) {
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			
			return gameTextures[name];
		}
		
		/////////////////////////////////////////////
		////////// GETTERS & SETTERS ///////////////
		///////////////////////////////////////////
		public static function getConfig():XML {
			return XML(new GameConfig());
		}
		
		public static function getSoundSplash():Sound {
			return Sound(new SoundSplash());
		}
		
		public static function getSoundHarpoon():Sound {
			return Sound(new SoundHarpoon());
		}
		
		public static function getSoundShake():Sound {
			return Sound(new SoundShake());
		}
		
		public static function getSoundHit():Sound {
			return Sound(new SoundHit());
		}
		
		public static function getParticleTexture():Texture {
			return Texture.fromBitmap(new ParticleTexture());
		}
		
		public static function getParticleXML():XML {
			return XML(new ParticleXML());
		}
		
	}

}