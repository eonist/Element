import Foundation


class GraphicSkinParser{
   static var rect:String = "rect";
   static var gradient:String = "gradient";
   static var icon:String = "icon";// :TODO: rename to asset or svgasset or alike (keep in mind that you will need to support png assets soon enough)
   static var fillet:String = "fillet";// :TODO: rename to ROUNDED?
   static var dropshadow:String = "dropshadow";
    /**
    * Returns a Decoratable instance based on what stylePropertyValues is found in @param skin at @param depth
    */
    public static function configure(skin:ISkin,depth:int):IDecoratable {
    
    }
}