package ee.samurai.i18n.parsers {
	import flash.events.Event;
	/**
	 * ...
	 * @author Andrin Riiet
	 */
	public class PropertiesParser implements ITranslationFileParser {
		
		public function PropertiesParser() {
			
		}
		
		/* INTERFACE ee.samurai.i18n.parsers.ITranslationFileParser */
		
		public function parse(contents:String):Object {
			
			// TODO: Support full .properties syntax
			
			var result:Object = { };
			
			var lines:Array = contents.split("\n");
			
			for each(var line:String in lines) {
				
				// FIXME: support escaping of '=' in language files
				var l:Array = line.split(" = ");
				
				if (l.length != 2) continue; // Ignore invalid lines
				
				result[ l[0].replace(/^\s+|\s+$/, '').replace(/\\n/g, '\n') ] = l[1].replace(/^\s+|\s+$/, '').replace(/\\n/g, '\n');
				
			}
			
			return result;
			
		}
		
	}

}