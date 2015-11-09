import Foundation
/*
 * // :TODO: impliment margin padding ?!? maybe not
 * // :TODO: Try to impliment Rect3 into Element2 and do tests
 * // :TODO: add example in the javadoc
 */
class Rect : Graphic{
    var width:Int;
    var height:Int;
    override init(_ fillStyle:IFillStyle? = nil, _ lineStyle:ILineStyle? = nil){
        super.init(fillStyle, lineStyle )
        self.width = width;
        self.height = height;
        fill();
        line();
    }
    func fill() {
      beginFill();
      drawFill();
      endFill();
    }
    func beginFill() {
      if(fillStyle != nil && fillStyle.color != NSColor.clearColor() {
         //beginFill drawing;/*Updates only if fillStyle is of class FillStyle*/
      }
    }
    /**
     * // :TODO: does this function need arguments?
     */
    func applyLineStyle(graphics:Graphics,lineStyle:ILineStyle) {
      if(lineStyle != nil) {
         //apply lineStyle here /*updates only if lineStyle of class LineStyle*/
      }
    }
    func drawFill() {
      //do fill drawing here
    }
    func drawLine() {
      if(lineStyle != nil){
          //do line drawing here, keep in mind line mask
      }
    }
    func endFill(){
      //print("Rect3.endFill");
      fillShape.graphics.endFill();
    }
    func setSize(width:Number,height:Number) {
      self.width = width;
      self.height = height;
      fill();
      line();
    }
}
