package ee.samurai.i18n {
	import ee.samurai.i18n.events.I18nEvent;
	import ee.samurai.i18n.events.TranslationFileLoaderEvent;
	import ee.samurai.i18n.loaders.ITranslationFileLoader;
	import ee.samurai.i18n.loaders.PropertiesLoader;
	import ee.samurai.i18n.parsers.ITranslationFileParser;
	import ee.samurai.i18n.parsers.PropertiesParser;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Andrin Riiet
	 */
	public class I18n extends EventDispatcher {
		
		protected var loader_cache:Object = [];
		
		// Dictionary in the form {'en': {'foo': 'foo_en', ...}, ...}
		protected var DICTIONARY:Object = {}
		
		/*
		 * The active language
		 */
		public var lang:String = null;
		
		/*
		 * The language to set on load complete.
		 * This is used if setLangauge initiates the loading
		 */
		protected var next_language:String = null;
		
		/*
		 * The string to replace invalid translations with. null for "leave as is"
		 */
		public var REPLACE_INVALID:String = null;
		
		protected var loader:ITranslationFileLoader = new PropertiesLoader();
		protected var parser:ITranslationFileParser = new PropertiesParser();
		
		public function I18n(lang:String, replace_invalid:String=null, loader:ITranslationFileLoader=null, parser:ITranslationFileParser=null) {
			
			this.lang = lang;
			this.REPLACE_INVALID = replace_invalid;
			
			if (loader) this.loader = loader;
			if (parser) this.parser = parser;
			
			this.loader.addEventListener(TranslationFileLoaderEvent.COMPLETE, load_success);
			this.loader.addEventListener(TranslationFileLoaderEvent.ERROR, load_error);
			this.loader.addEventListener(TranslationFileLoaderEvent.PROGRESS, load_progress);
			
		}
		
		public function setLanguage(lang:String):void {
			if (DICTIONARY[lang] != null) {
				// Change language, dispatch event
				this.lang = lang;
				next_language = null;
				dispatchEvent(new I18nEvent(I18nEvent.LANGUAGE_CHANGE, lang));
			} else {
				// Attempt load, change after load
				next_language = lang;
				loadLanguage(lang);
			}
		}
		
		/*
		 * Translates the string. Assumes the language is loaded.
		 */
		public function _(str:String):String {
			var str_clean = str.replace(/^\s+|\s+$/g, '');
			if (!DICTIONARY[lang] || !DICTIONARY[lang][str_clean]) {
				return REPLACE_INVALID!=null ? REPLACE_INVALID : str;
			} else {
				return DICTIONARY[lang][str_clean];
			}
		}
		
		public function loadLanguage(lang:String):void {
			
			loader.loadTranslations(lang);
			
			dispatchEvent(new I18nEvent(I18nEvent.LOAD_START, lang, loader));
			
		}
		
		protected function load_success(e:TranslationFileLoaderEvent):void {
			
			DICTIONARY[e.lang] = parser.parse(e.data);
			
			dispatchEvent(new I18nEvent(I18nEvent.LOAD_COMPLETE, e.lang, e.loader));
			
			// If language loaded using setLanguage, set it
			if (next_language == e.lang) {
				setLanguage(e.lang);
			}
			
		}
		
		protected function load_error(e:TranslationFileLoaderEvent):void {
			
			// If language loaded using setLanguage, flag it as non-existent and set the language regardless
			
			DICTIONARY[e.lang] = { }
			
			dispatchEvent(new I18nEvent(I18nEvent.LOAD_ERROR, e.lang, e.loader));
			
			if (next_language == e.lang) {
				setLanguage(e.lang);
			}
			
		}
		
		protected function load_progress(e:TranslationFileLoaderEvent):void {
			dispatchEvent(new I18nEvent(I18nEvent.LOAD_PROGRESS, e.lang, e.loader));
		}
		
	}

}