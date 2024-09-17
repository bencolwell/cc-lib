package cc.data {
    
    public class ObjectPool {
        
        private var _poolSize:int;
        private var _pool:Vector.<IPoolable>;
        private var _ObjectType:Class;
        private var _initCallback:Function;
        
        public function ObjectPool(
                                   poolSize:int,
                                   ObjectType:Class,
                                   initCallback:Function = null
                                   ) {
            
            _poolSize = poolSize;
            _ObjectType = ObjectType;
            _initCallback = initCallback;
            
            _pool = new Vector.<IPoolable>();
            for (var i:int = 0; i < _poolSize; i++) {
                var instance:IPoolable = new _ObjectType() as IPoolable;
                _pool.push(instance);
                instance.returnedToPool();
            }
            
        }
        
        public function init():void {
            for (var i:int = 0; i < _pool.length; i++) {
                if (_initCallback != null) {
                    _initCallback(_pool[i] as _ObjectType);
                }
            }
        }
        
        public function get poolSize():int {
            return _poolSize;
        }
        
        public function get objects():Vector.<IPoolable> {
            return _pool;
        }
        
        public function getPooled():IPoolable {
            
            for (var i:int = 0; i < _pool.length; i++) {
                if (_pool[i].isPooled) {
                    _pool[i].removedFromPool();
                    return _pool[i];
                }
            }
            
            trace("Not enough objects of type " + _ObjectType + " in ObjectPool");
            
            var instance:IPoolable = new _ObjectType() as IPoolable;
            if (_initCallback != null) {
                _initCallback(instance as _ObjectType);
            }
            _poolSize++;
            _pool.push(instance);
            instance.removedFromPool();
            return instance;
            
        }
        
        public function returnToPool(obj:IPoolable):void {
            obj.returnedToPool();
        }
        
    }
    
}
