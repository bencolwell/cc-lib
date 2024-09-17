package cc.util {
    
    import flash.utils.ByteArray;
    
    public class JsonHelper {
        
        public static function loadEmbedded(Embedded:Class):Object {
            var bytes:ByteArray = new Embedded() as ByteArray;
            return JSON.parse(bytes.readUTFBytes(bytes.length));
        }
        
        public static function parseString(text:String):Object {
            return JSON.parse(text);
        }
        
        public static function serializeObject(obj:Object, pattern:Array = null, space:int = 4):String {
            return JSON.stringify(obj, pattern, space);
        }
        
    }
    
}
