package cc.display {
    
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    
    public class TimelineHelper {
        
        public static function getTotalFrames(clip:DisplayObjectContainer):int {
            
            var totalFrames:int = 1;
            if (clip is MovieClip) {
                totalFrames = MovieClip(clip).totalFrames;
            }
            for (var i:int = 0; i < clip.numChildren; ++i) {
                var nextChild:DisplayObjectContainer = clip.getChildAt(i) as DisplayObjectContainer;
                if (null != nextChild) {
                    var frames:int = getTotalFrames(nextChild);
                    totalFrames = Math.max(frames, totalFrames);
                }
            }
            return totalFrames;
        }
        
        public static function advanceAllTimelines(clip:DisplayObjectContainer):void {
            
            if (clip is MovieClip) {
                if (MovieClip(clip).totalFrames == MovieClip(clip).currentFrame) {
                    MovieClip(clip).gotoAndStop(1);
                } else {
                    MovieClip(clip).nextFrame();
                }
            }
            for (var i:int = 0; i < clip.numChildren; ++i) {
                var nextChild:DisplayObjectContainer = clip.getChildAt(i) as DisplayObjectContainer;
                if (null != nextChild) {
                    advanceAllTimelines(nextChild);
                }
            }
            
        }
        
        public static function rewindAllTimelines(clip:DisplayObjectContainer):void {
            
            if (clip is MovieClip) {
                if (MovieClip(clip).currentFrame == 1) {
                    MovieClip(clip).gotoAndStop(MovieClip(clip).totalFrames);
                } else {
                    MovieClip(clip).prevFrame();
                }
            }
            for (var i:int = 0; i < clip.numChildren; ++i) {
                var nextChild:DisplayObjectContainer = clip.getChildAt(i) as DisplayObjectContainer;
                if (null != nextChild) {
                    rewindAllTimelines(nextChild);
                }
            }
            
        }
        
        public static function stopAllTimelinesAt(clip:DisplayObjectContainer, frame:uint = 1):void {
            
            if (clip is MovieClip) {
                MovieClip(clip).gotoAndStop(frame);
            }
            for (var i:int = 0; i < clip.numChildren; ++i) {
                var nextChild:DisplayObjectContainer = clip.getChildAt(i) as DisplayObjectContainer;
                if (null != nextChild) {
                    stopAllTimelinesAt(nextChild, frame);
                }
            }
            
        }
        
        public static function playAllTimelinesFrom(clip:DisplayObjectContainer, frame:uint = 1):void {
            
            if (clip is MovieClip) {
                MovieClip(clip).gotoAndPlay(frame);
            }
            for (var i:int = 0; i < clip.numChildren; ++i) {
                var nextChild:DisplayObjectContainer = clip.getChildAt(i) as DisplayObjectContainer;
                if (null != nextChild) {
                    playAllTimelinesFrom(nextChild, frame);
                }
            }
        }
        
        public static function stopAllTimelines(clip:DisplayObjectContainer):void {
            
            if (clip is MovieClip) {
                MovieClip(clip).stop();
            }
            for (var i:int = 0; i < clip.numChildren; ++i) {
                var nextChild:DisplayObjectContainer = clip.getChildAt(i) as DisplayObjectContainer;
                if (null != nextChild) {
                    stopAllTimelines(nextChild);
                }
            }
            
        }
        
        public static function playAllTimelines(clip:DisplayObjectContainer):void {
            
            if (clip is MovieClip) {
                MovieClip(clip).play();
            }
            for (var i:int = 0; i < clip.numChildren; ++i) {
                var nextChild:DisplayObjectContainer = clip.getChildAt(i) as DisplayObjectContainer;
                if (null != nextChild) {
                    playAllTimelines(nextChild);
                }
            }
        }
        
    }
}
