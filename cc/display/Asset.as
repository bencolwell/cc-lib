package cc.display {
    
    public class Asset {
        
        private var _classRefs:Vector.<Class>;
        
        public function Asset(
                              classRefs:Vector.<Class>
                              ) {
            
            _classRefs = classRefs;
            
        }
        
        public function get classRefs():Vector.<Class> {
            return _classRefs;
        }
        
        public function get totalFrames():int {
            return _classRefs.length;
        }
        
    }
    
}
