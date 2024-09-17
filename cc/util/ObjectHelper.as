package cc.util {
    
    import flash.utils.ByteArray;
    
    public class ObjectHelper {
        
        public static function clone(source:Object):* {
            var byteArray:ByteArray = new ByteArray();
            byteArray.writeObject(source);
            byteArray.position = 0;
            return byteArray.readObject();
        }
        
    }
    
}
