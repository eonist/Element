import Foundation

class ILineStyle{

    var color():NSColor
    function set color(color : Number) : void
    function get alpha():Number
    function set alpha(alpha : Number) : void
    function get thickness():Number
    function set thickness(thickness : Number) : void
    function get pixelHinting():Boolean
    function set pixelHinting(pixelHinting : Boolean) : void
    function get lineScaleMode():String
    function set lineScaleMode(lineScaleMode : String) : void
    function get capStyle():String
    function set capStyle(capStyle : String) : void
    function get jointStyle():String
    function set jointStyle(jointStyle : String) : void
    function get miterLimit():Number
    function set miterLimit(miterLimit : Number) : void
}