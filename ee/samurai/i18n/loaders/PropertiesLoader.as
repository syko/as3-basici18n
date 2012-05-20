package ee.samurai.i18n.loaders {
	import ee.samurai.i18n.events.TranslationFileLoaderEvent;
	import ee.samurai.i18n.loaders.ITranslationFileLoader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Andrin Riiet
	 */
	public class PropertiesLoader extends EventDispatcher implements ITranslationFileLoader {
		
		/*
		 * The directory/domain/path to load the files from.
		 * Make sure there's a trailing slash.
		 */
		public var directory:String = null;
		
		public function PropertiesLoader(directory:String="locale/") {
			this.directory = directory;
		}
		
		/* INTERFACE ee.samurai.i18n.TranslationFileLoader */
		
		public function loadTranslations(lang:String):void {
			
			var request:URLRequest = new URLRequest(directory + lang + '.properties');
			var loader:URLLoader = new URLLoader();
			
			// Attach event handlers using closures to pass lang.
			
			loader.addEventListener(Event.COMPLETE, (function(lang) {
				return function(e:Event) { load_success(e, lang); }
			})(lang));
			loader.addEventListener(IOErrorEvent.IO_ERROR, (function(lang) {
				return function(e:IOErrorEvent) { load_error(e, lang); }
			})(lang));
			loader.addEventListener(ProgressEvent.PROGRESS, (function(lang) {
				return function(e:ProgressEvent) { load_progress(e, lang); }
			})(lang));
			
			loader.load(request);
			
		}
		
		protected function load_success(e:Event, lang:String):void {
			
			dispatchEvent(new TranslationFileLoaderEvent(TranslationFileLoaderEvent.COMPLETE, lang, e.target.data, e.target as URLLoader));
			
		}
		
		protected function load_error(e:Event, lang:String):void {
			
			dispatchEvent(new TranslationFileLoaderEvent(TranslationFileLoaderEvent.ERROR, lang, null, e.target as URLLoader));
			
		}
		
		protected function load_progress(e:ProgressEvent, lang:String):void {
			
			dispatchEvent(new TranslationFileLoaderEvent(TranslationFileLoaderEvent.PROGRESS, lang, null, e.target as URLLoader));
			
		}
	}

}