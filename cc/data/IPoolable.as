package cc.data {
    
    public interface IPoolable {
        
        function get isPooled():Boolean;
        function removedFromPool():void;
        function returnedToPool():void;
        
    }
    
}
