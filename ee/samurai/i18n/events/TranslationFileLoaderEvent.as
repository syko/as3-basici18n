package ee.samurai.i18n.events {
	import flash.events.Event;
	import flash.net.URLLoader;
	
	/**
	 * ...
	 * @author Andrin Riiet
	 */
	public class TranslationFileLoaderEvent extends Event {
		
		public static const COMPLETE:String = "COMPLETE";
		public static const ERROR:String = "ERROR";
		public static const PROGRESS:String = "PROGRESS";
		
		public var lang:String = null;
		public var data:String = null;
		public var loader:URLLoader = null;
		
		public function TranslationFileLoaderEvent(type:String, lang:String, data:String = null, loader:URLLoader = null, bubbles:Boolean = false, cancelable:Boolean = false) { 
			super(type, bubbles, cancelable);
			this.lang = lang;
			this.data = data;
			this.loader = loader;
		} 
		
		public override function clone():Event { 
			return new TranslationFileLoaderEvent(type, lang, data, loader, bubbles, cancelable);
		} 
		
		public override function toString():String { 
			return formatToString("TranslationFileLoaderEvent", "type", "lang", "data", "loader", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}