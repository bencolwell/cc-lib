package cc.util {
    
    import flash.display.Stage;
    import flash.display.StageDisplayState;
    import flash.geom.Rectangle;
    
    public class FullscreenHelper {
        
        private static var _instance:FullscreenHelper;
        
        private var _isFullscreen:Boolean = false;
        
        public function FullscreenHelper(
                                         enforcer:SingletonEnforcer
                                         ) {
            if (enforcer == null) {
                throw new Error("FullscreenHelper is a singleton class, use getInstance() instead.");
            }
        }
        
        public static function getInstance():FullscreenHelper {
            if (_instance == null) _instance = new FullscreenHelper(new SingletonEnforcer());
            return _instance;
        }
        
        public function get isFullscreen():Boolean {
            return _isFullscreen;
        }
        
        public function setFullscreen(stage:Stage, fullscreen:Boolean, allowKeyboardInput:Boolean = false, useHardwareScaling:Boolean = false):void {
            
            _isFullscreen = fullscreen;
            
            if (fullscreen) {
                if (useHardwareScaling) {
                    stage.fullScreenSourceRect = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);  // use for hardware scaling only
                }
                if (allowKeyboardInput) {
                    stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;  // accepts keyboard input while in fullscreen
                } else {
                    stage.displayState = StageDisplayState.FULL_SCREEN;
                }
            } else {
                stage.displayState = StageDisplayState.NORMAL;
            }
            
        }
        
    }
    
}

internal class SingletonEnforcer { };
