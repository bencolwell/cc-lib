package cc.util {
    
    public class ColorHelper {
        
        private static const HEX_CHARS:Vector.<String> = Vector.<String>(["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"]);
        
        public static function extractRed(color:Number):int {
            return ((color >> 16) & 0xFF);
        }
        
        public static function extractGreen(color:Number):int {
            return ((color >> 8) & 0xFF);
        }
        
        public static function extractBlue(color:Number):int {
            return (color & 0xFF);
        }
        
        public static function rgbToDec(r:int, g:int, b:int):Number {
            return (r << 16) | (g << 8) | b;
        }
        
        /**
         * @return The average of two decimal color values.
         */
        public static function averageOf(colorA:Number, colorB:Number):Number {
            var r:int = (extractRed(colorA) + extractRed(colorB)) / 2;
            var g:int = (extractGreen(colorA) + extractGreen(colorB)) / 2;
            var b:int = (extractBlue(colorA) + extractBlue(colorB)) / 2;
            return rgbToDec(r, g, b);
        }
        
        /**
         * @param  hex  String representing a hexadecimal value, e.g. "FF0000"
         */
        public static function hexToDec(hex:String):Number {
            var r:int = hexToByte(hex.substr(0, 2));
            var g:int = hexToByte(hex.substr(2, 2));
            var b:int = hexToByte(hex.substr(4, 2));
            return rgbToDec(r, g, b);
        }
        
        /**
         * @param  hex  String representing a hexadecimal pair, e.g. "FF"
         * @return A byte value with range 0-255
         */
        public static function hexToByte(hex:String):int {
            return int("0x" + hex);
        }
        
        /**
         * @return String representing the hexadecimal equivalent of the RGB value.
         */
        public static function rgbToHex(r:int, g:int, b:int):String {
            var hex:String = "";
            hex += byteToHex(r);
            hex += byteToHex(g);
            hex += byteToHex(b);
            return hex;
        }
        
        /**
         * @param  byte  A byte value with range 0-255
         * @return String representing a hexadecimal (base 16) pair, e.g. "FF"
         */
        public static function byteToHex(byte:int):String {
            if (byte > 255) {
                byte = 255;
            }
            var l:int = byte / 16;
            var r:int = byte % 16;
            return HEX_CHARS[l].concat(HEX_CHARS[r]);
        }
        
        /**
         * Converts from HSV [h(0-360), s(0-1), v(0-1)] to RGB [r(0-255), g(0-255), b(0-255)]
         */
        public static function hsvToRgb(h:Number, s:Number, v:Number):Array {
    
            var r:Number;
            var g:Number;
            var b:Number;
            var i:Number = Math.floor((h / 60) % 6);
            var f:Number = (h / 60) - i;
            var p:Number = v * (1 - s);
            var q:Number = v * (1 - f * s);
            var t:Number = v * (1 - (1 - f) * s);
            
            switch(i) {
                case 0: r = v; g = t; b = p; break;
                case 1: r = q; g = v; b = p; break;
                case 2: r = p; g = v; b = t; break;
                case 3: r = p; g = q; b = v; break;
                case 4: r = t; g = p; b = v; break;
                case 5: r = v; g = p; b = q; break;
            }
            
            return [realToByte(r), realToByte(g), realToByte(b)];
        }
        
        private static function realToByte(n:Number):int {
            return Math.min(255, Math.round(n * 256));
        }
        
        /**
         * Converts from RGB [r(0-255), g(0-255), b(0-255)] to HSV [h(0-360), s(0-1), v(0-1)]
         */
        public static function rgbToHsv(r:Number, g:Number, b:Number):Array {
            
            r /= 255;
            g /= 255;
            b /= 255;
            
            var min:Number = Math.min(Math.min(r, g), b);
            var max:Number = Math.max(Math.max(r, g), b);
            var delta:Number = max - min;
            var h:Number;
            
            switch(max) {
                case min:
                    h = 0;
                    break;
                case r:
                    h = 60 * (g - b) / delta;
                    if (g < b) {
                        h += 360;
                    }
                    break;
                case g: h = (60 * (b - r) / delta) + 120; break;
                case b: h = (60 * (r - g) / delta) + 240; break;
            }
            
            var s:Number = (max == 0) ? 0 : 1 - (min / max);
            
            return [Math.round(h), s, max];
        }
        
    }
    
}
