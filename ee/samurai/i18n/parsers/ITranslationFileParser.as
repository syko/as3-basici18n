package ee.samurai.i18n.parsers {
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Andrin Riiet
	 */
	public interface ITranslationFileParser {
		function parse(contents:String):Object;
	}
	
}