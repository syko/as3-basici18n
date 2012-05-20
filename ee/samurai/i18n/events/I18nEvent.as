package ee.samurai.i18n.events {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Andrin Riiet
	 */
	public class I18nEvent extends Event {
		
		public static const LANGUAGE_CHANGE:String = "LANGUAGE_CHANGE";
		public static const LOAD_START:String = "LOAD_START";
		public static const LOAD_COMPLETE:String = "LOAD_COMPLETE";
		public static const LOAD_ERROR:String = "LOAD_ERROR";
		public static const LOAD_PROGRESS:String = "LOAD_PROGRESS";
		
		public var lang:String = null;
		public var data:* = null;
		
		public function I18nEvent(type:String, lang:String, data:*=null, bubbles:Boolean = false, cancelable:Boolean = false) { 
			super(type, bubbles, cancelable);
			this.lang = lang;
			this.data = data;
			
		} 
		
		public override function clone():Event { 
			return new I18nEvent(type, lang, data, bubbles, cancelable);
		} 
		
		public override function toString():String { 
			return formatToString("i18nEvent", "lang", "data", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}