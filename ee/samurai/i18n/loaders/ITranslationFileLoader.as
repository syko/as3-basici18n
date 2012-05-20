package ee.samurai.i18n.loaders {
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author Andrin Riiet
	 */
	public interface ITranslationFileLoader extends IEventDispatcher {
		function loadTranslations(lang:String):void;
	}
	
}