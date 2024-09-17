package cc.display {
    
    import flash.display.BitmapData;
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;
    
    public class VectorHelper {
        
        public static function getBounds(target:DisplayObjectContainer, angles:uint = 1, totalFrames:uint = 1):Rectangle {
            var container:Sprite = new Sprite();
            var outline:Shape = new Shape();
            container.addChild(target);
            for (var i:int = 0; i < angles; ++i) {
                if (target is MovieClip) {
                    TimelineHelper.stopAllTimelinesAt(target, 1);
                }
                target.rotation = i * (360 / angles);
                for (var j:int = 0; j < totalFrames; ++j) {
                    var frameBounds:Rectangle = container.getBounds(target);
                    outline.graphics.beginFill(0, 1);
                    outline.graphics.drawRect(frameBounds.x, frameBounds.y, frameBounds.width, frameBounds.height);
                    outline.graphics.endFill();
                    if (target is MovieClip) {
                        TimelineHelper.advanceAllTimelines(target);
                    }
                }
            }
            container.removeChild(target);
            container.addChild(outline);
            var bounds:Rectangle = new Rectangle();
            bounds.width = Math.ceil(container.width);
            bounds.height = Math.ceil(container.height);
            var outlineBounds:Rectangle = container.getBounds(outline);
            bounds.x = outlineBounds.x;
            bounds.y = outlineBounds.y;
            return bounds;
        }
        
        public static function rasterizeMovieClip(target:MovieClip, bounds:Rectangle, angles:uint = 1, scale:Number = 1.0):Vector.<Vector.<BitmapData>> {
            var angleFrames:Vector.<Vector.<BitmapData>> = new Vector.<Vector.<BitmapData>>(angles);
            var matrix:Matrix = new Matrix();
            var container:Sprite = new Sprite();
            bounds.x *= scale;
            bounds.y *= scale;
            bounds.width *= scale;
            bounds.height *= scale;
            bounds.x = Math.floor(bounds.x);
            bounds.y = Math.floor(bounds.y);
            bounds.width = Math.ceil(bounds.width);
            bounds.height = Math.ceil(bounds.height);
            matrix.scale(scale, scale);
            matrix.tx = -bounds.x;
            matrix.ty = -bounds.y;
            container.addChild(target);
            for (var i:int = 0; i < angles; ++i) {
                TimelineHelper.stopAllTimelinesAt(target, 1);
                target.rotation = i * (360 / angles);
                var frames:Vector.<BitmapData> = new Vector.<BitmapData>(target.totalFrames);
                for (var j:int = 0; j < target.totalFrames; ++j) {
                    var bitmap:BitmapData = new BitmapData(bounds.width, bounds.height, true, 0);
                    bitmap.draw(container, matrix, null, null, null, true);
                    frames[j] = bitmap;
                    TimelineHelper.advanceAllTimelines(target);
                }
                angleFrames[i] = frames;
            }
            container.removeChild(target);
            return angleFrames;
        }
        
        public static function rasterizeSprite(target:Sprite, bounds:Rectangle, angles:uint = 1, scale:Number = 1.0):Vector.<BitmapData> {
            var frames:Vector.<BitmapData> = new Vector.<BitmapData>(angles);
            var matrix:Matrix = new Matrix();
            var container:Sprite = new Sprite();
            bounds.x *= scale;
            bounds.y *= scale;
            bounds.width *= scale;
            bounds.height *= scale;
            bounds.x = Math.floor(bounds.x);
            bounds.y = Math.floor(bounds.y);
            bounds.width = Math.ceil(bounds.width);
            bounds.height = Math.ceil(bounds.height);
            matrix.scale(scale, scale);
            matrix.tx = -bounds.x;
            matrix.ty = -bounds.y;
            container.addChild(target);
            for (var i:int = 0; i < angles; ++i) {
                target.rotation = i * (360 / angles);
                var bitmap:BitmapData = new BitmapData(bounds.width, bounds.height, true, 0);
                bitmap.draw(container, matrix, null, null, null, true);
                frames[i] = bitmap;
            }
            container.removeChild(target);
            return frames;
        }
        
        public static function rasterizeSpriteSequence(sequence:Vector.<Sprite>, bounds:Rectangle, angles:uint = 1, scale:Number = 1.0):Vector.<Vector.<BitmapData>> {
            var angleFrames:Vector.<Vector.<BitmapData>> = new Vector.<Vector.<BitmapData>>(angles);
            var matrix:Matrix = new Matrix();
            var container:Sprite = new Sprite();
            bounds.x *= scale;
            bounds.y *= scale;
            bounds.width *= scale;
            bounds.height *= scale;
            bounds.x = Math.floor(bounds.x);
            bounds.y = Math.floor(bounds.y);
            bounds.width = Math.ceil(bounds.width);
            bounds.height = Math.ceil(bounds.height);
            matrix.scale(scale, scale);
            matrix.tx = -bounds.x;
            matrix.ty = -bounds.y;
            for (var i:int = 0; i < angles; ++i) {
                var frames:Vector.<BitmapData> = new Vector.<BitmapData>(sequence.length);
                for (var j:int = 0; j < sequence.length; ++j) {
                    container.addChild(sequence[j]);
                    sequence[j].rotation = i * (360 / angles);
                    var bitmap:BitmapData = new BitmapData(bounds.width, bounds.height, true, 0);
                    bitmap.draw(container, matrix, null, null, null, true);
                    frames[j] = bitmap;
                    container.removeChild(sequence[j]);
                }
                angleFrames[i] = frames;
            }
            return angleFrames;
        }
        
    }
    
}
