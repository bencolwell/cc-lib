package cc.display {
    
    import flash.display.BitmapData;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.utils.Dictionary;
    
    /**
     * <code>AssetMap</code> is used to cache visual assets as <code>BitmapData</code> in a central location to allow utilization of the GPU.
     * Vector assets cached with <code>AssetMap</code> are automatically converted to </code>BitmapData</code>.
     * @author  Benjamin Colwell
     */
    public class AssetMap {
        
        private var _assetCache:Dictionary;     // all types are Vector.<Vector.<BitmapData>>
        private var _bounds:Dictionary;         // all types are Vector.<Rectangle>
        private var _registrations:Dictionary;  // all types are Point
        
        public function AssetMap() {
            
            _assetCache = new Dictionary();
            _bounds = new Dictionary();
            _registrations = new Dictionary();
            
        }
        
        /**
         * Rasterizes and caches the single <code>MovieClip</code> class defined by the supplied <code>Asset</code>.
         * @param  asset  An <code>Asset</code> object containing the class reference to be instantiated and cached.
         * @param  registration  Registration point of the final cached asset.
         * @param  angles  Total number of angles to be cached. Expects a value between 1 and 360. A value of 4 caches angles 0, 90, 180, 270.
         * @param  scale  Scale value to be applied during the rasterization process.
         */
        public function cacheMovieClip(asset:Asset, registration:Point, angles:uint = 1, scale:Number = 1.0):void {
            var AssetClass:Class = asset.classRefs[0] as Class;
            var clip:MovieClip = new AssetClass() as MovieClip;
            if (clip is MovieClip) {
                angles = checkAngles(angles);
                var bounds:Rectangle = VectorHelper.getBounds(clip, angles, clip.totalFrames);
                _assetCache[asset] = VectorHelper.rasterizeMovieClip(clip, bounds, angles, scale);
                _bounds[asset] = Vector.<Rectangle>([bounds]);
                scaleRegistration(registration, scale);
                _registrations[asset] = registration;
            } else {
                throw new Error("Attempting to cache asset with wrong type (expects MovieClip)");
            }
        }
        
        /**
         * Rasterizes and caches the single masked <code>MovieClip</code> class defined by the supplied <code>Asset</code>.
         * @param  asset  An <code>Asset</code> object containing the class reference to be instantiated and cached.
         * @param  bounds  The bounds of the mask.
         * @param  registration  Registration point of the final cached asset.
         * @param  scale  Scale value to be applied during the rasterization process.
         */
        public function cacheMaskedMovieClip(asset:Asset, bounds:Rectangle, registration:Point, scale:Number = 1.0):void {
            var AssetClass:Class = asset.classRefs[0] as Class;
            var clip:MovieClip = new AssetClass() as MovieClip;
            if (clip is MovieClip) {
                _assetCache[asset] = VectorHelper.rasterizeMovieClip(clip, bounds, 1, scale);
                _bounds[asset] = Vector.<Rectangle>([bounds]);
                scaleRegistration(registration, scale);
                _registrations[asset] = registration;
            } else {
                throw new Error("Attempting to cache asset with wrong type (expects MovieClip)");
            }
        }
        
        /**
         * Rasterizes and caches the single <code>Sprite</code> class defined by the supplied <code>Asset</code>.
         * @param  asset  An <code>Asset</code> object containing the class reference to be instantiated and cached.
         * @param  registration  Registration point of the final cached asset.
         * @param  angles  Total number of angles to be cached. Expects a value between 1 and 360. A value of 4 caches angles 0, 90, 180, 270.
         * @param  scale  Scale value to be applied during the rasterization process.
         */
        public function cacheSprite(asset:Asset, registration:Point, angles:uint = 1, scale:Number = 1.0):void {
            var AssetClass:Class = asset.classRefs[0] as Class;
            var sprite:Sprite = new AssetClass() as Sprite;
            if (sprite is Sprite) {
                angles = checkAngles(angles);
                var bounds:Rectangle = VectorHelper.getBounds(sprite, angles, 1);
                var frames:Vector.<BitmapData> = VectorHelper.rasterizeSprite(sprite, bounds, angles, scale);
                _assetCache[asset] = Vector.<Vector.<BitmapData>>([frames]);
                _bounds[asset] = Vector.<Rectangle>([bounds]);
                scaleRegistration(registration, scale);
                _registrations[asset] = registration;
            } else {
                throw new Error("Attempting to cache asset with wrong type (expects Sprite)");
            }
        }
        
        /**
         * Rasterizes and caches the single masked <code>Sprite</code> class defined by the supplied <code>Asset</code>.
         * @param  asset  An <code>Asset</code> object containing the class reference to be instantiated and cached.
         * @param  bounds  The bounds of the mask.
         * @param  registration  Registration point of the final cached asset.
         * @param  scale  Scale value to be applied during the rasterization process.
         */
        public function cacheMaskedSprite(asset:Asset, bounds:Rectangle, registration:Point, scale:Number = 1.0):void {
            var AssetClass:Class = asset.classRefs[0] as Class;
            var sprite:Sprite = new AssetClass() as Sprite;
            if (sprite is Sprite) {
                var frames:Vector.<BitmapData> = VectorHelper.rasterizeSprite(sprite, bounds, 1, scale);
                _assetCache[asset] = Vector.<Vector.<BitmapData>>([frames]);
                _bounds[asset] = Vector.<Rectangle>([bounds]);
                scaleRegistration(registration, scale);
                _registrations[asset] = registration;
            } else {
                throw new Error("Attempting to cache asset with wrong type (expects Sprite)");
            }
        }
        
        /**
         * Rasterizes and caches the sequence of <code>Sprite</code> classes defined by the supplied <code>Asset</code>.
         * @param  asset  An <code>Asset</code> object containing the class references to be instantiated and cached.
         * @param  registration  Registration point of the final cached asset.
         * @param  scale  Scale value to be applied during the rasterization process.
         */
        public function cacheSpriteSequence(asset:Asset, registration:Point, scale:Number = 1.0):void {
            var bounds:Vector.<Rectangle> = new Vector.<Rectangle>(asset.totalFrames);
            var frames:Vector.<BitmapData> = new Vector.<BitmapData>(asset.totalFrames);
            for (var i:int = 0; i < asset.totalFrames; ++i) {
                var AssetClass:Class = asset.classRefs[i] as Class;
                var sprite:Sprite = new AssetClass() as Sprite;
                if (sprite is Sprite) {
                    var spriteBounds:Rectangle = VectorHelper.getBounds(sprite);
                    var frame:BitmapData = VectorHelper.rasterizeSprite(sprite, spriteBounds, 1, scale)[0];
                    bounds[i] = spriteBounds;
                    frames[i] = frame;
                }
            }
            _assetCache[asset] = Vector.<Vector.<BitmapData>>([frames]);
            _bounds[asset] = bounds;
            scaleRegistration(registration, scale);
            _registrations[asset] = registration;
        }
        
        /**
         * Caches the sequence of <code>BitmapData</code> classes defined by the supplied <code>Asset</code>.
         * @param  asset  An <code>Asset</code> object containing the class references to be instantiated and cached.
         * @param  registration  Registration point of the final cached asset.
         */
        public function cacheBitmapSequence(asset:Asset, registration:Point, scale:Number = 1.0, smoothing:Boolean = false):void {
            var bounds:Rectangle = new Rectangle();
            var frames:Vector.<BitmapData> = new Vector.<BitmapData>(asset.totalFrames);
            for (var i:int = 0; i < asset.totalFrames; ++i) {
                var AssetClass:Class = asset.classRefs[i] as Class;
                var frame:BitmapData = new AssetClass() as BitmapData;
                if (frame is BitmapData) {
                    var matrix:Matrix = new Matrix();
                    matrix.scale(scale, scale);
                    var scaledFrame:BitmapData = new BitmapData(frame.width * scale, frame.height * scale, true, 0x00000000);
                    scaledFrame.draw(frame, matrix, null, null, null, smoothing);
                    frames[i] = scaledFrame;
                    bounds.width = Math.max(bounds.width, scaledFrame.width);
                    bounds.height = Math.max(bounds.height, scaledFrame.height);
                }
            }
            _assetCache[asset] = Vector.<Vector.<BitmapData>>([frames]);
            _bounds[asset] = Vector.<Rectangle>([bounds]);
            _registrations[asset] = registration;
        }
        
        private function checkAngles(angles:uint):uint {
            if (angles < 1) {
                return 1;
            } else if (angles > 360) {
                return 360;
            }
            return angles;
        }
        
        private function scaleRegistration(registration:Point, scale:Number):void {
            registration.x *= scale;
            registration.y *= scale;
        }
        
        /**
         * Creates a new <code>BitmapSequence</code> object using the cached <code>BitmapData</code>.
         * @param  asset  The <code>Asset</code> object which was previously cached.
         * @param  angleIndex  Index of the desired angle (zero-based).
         * @param  framerate  Framerate for the returned <code>BitmapSequence</code>.
         * @param  callback  Callback method to be passed to the <code>BitmapSequence</code> constructor.
         * @return A new <code>BitmapSequence</code> object which shares the cached <code>BitmapData</code>.
         */
        public function createSequence(asset:Asset, angleIndex:uint = 0, framerate:int = 1, callback:Function = null):BitmapSequence {
            if (angleIndex >= _assetCache[asset].length) angleIndex = 0;
            return new BitmapSequence(_assetCache[asset][angleIndex], _bounds[asset][0], _registrations[asset], framerate, callback);
        }
        
        /**
         * Retrieves the cached <code>Vector</code> of <code>BitmapData</code> objects corresponding to the supplied <code>Asset</code>.
         * @param  asset  The <code>Asset</code> object which was previously cached.
         * @param  angleIndex  Index of the desired angle (zero-based).
         * @return The cached <code>Vector</code> of <code>BitmapData</code> objects.
         */
        public function getFrames(asset:Asset, angleIndex:uint = 0):Vector.<BitmapData> {
            if (angleIndex >= _assetCache[asset].length) angleIndex = 0;
            return _assetCache[asset][angleIndex];
        }
        
        /**
         * Retrieves a single cached <code>BitmapData</code> object.
         * @param  asset  The <code>Asset</code> object which was previously cached.
         * @param  angleIndex  Index of the desired angle (zero-based).
         * @param  frameIndex  Index of the desired frame (zero-based).
         * @return The cached <code>BitmapData</code> object.
         */
        public function getBitmap(asset:Asset, angleIndex:uint = 0, frameIndex:uint = 0):BitmapData {
            if (angleIndex >= _assetCache[asset].length) angleIndex = 0;
            if (frameIndex >= _assetCache[asset][angleIndex].length) frameIndex = 0;
            return _assetCache[asset][angleIndex][frameIndex];
        }
        
        /**
         * Retrieves a single cached <code>Rectangle</code> object representing the bounds of the specified frame.
         * @param  asset  The <code>Asset</code> object which was previously cached.
         * @param  frameIndex  Index of the desired frame (zero-based).
         * @return The cached <code>Rectangle</code> object representing the bounds of the specified frame.
         */
        public function getRect(asset:Asset, frameIndex:uint = 0):Rectangle {
            if (frameIndex >= _bounds[asset].length) frameIndex = 0;
            return _bounds[asset][frameIndex];
        }
        
        /**
         * Retrieves the cached <code>Vector</code> of <code>Rectangle</code> objects representing the bounds for each frame of the supplied <code>Asset</code>.
         * @param  asset  The <code>Asset</code> object which was previously cached.
         * @param  frameIndex  Index of the desired frame (zero-based).
         * @return The cached <code>Vector</code> of <code>Rectangle</code> objects representing the bounds for each frame.
         */
        public function getBounds(asset:Asset):Vector.<Rectangle> {
            return _bounds[asset];
        }
        
        /**
         * Retrieves the cached <code>Point</code> object representing the registration point of the supplied <code>Asset</code>.
         * @param  asset  The <code>Asset</code> object which was previously cached.
         * @return The cached <code>Point</code> object.
         */
        public function getRegistration(asset:Asset):Point {
            return _registrations[asset];
        }
        
    }
    
}
