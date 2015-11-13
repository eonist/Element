import Cocoa
/*
 * // :TODO: impliment margin padding ?!? maybe not
 * // :TODO: Try to impliment Rect3 into Element2 and do tests
 * // :TODO: add example in the javadoc
 */
class RectGraphic : Decoratable{
    var width:Double;
    var height:Double;
    init(_ width:Double = 100, _ height:Double = 100){
        self.width = width;
        self.height = height;
        super.init(decoratable);
    }
    
    override func drawFill() {
        Swift.print("RectGraphic.drawFill()")
        //do fill drawing here
        getGraphic().path = CGPathParser.rect(CGFloat(width), CGFloat(height))//Shapes
        super.drawFill()
    }
    func drawLine() {
      if(lineStyle != nil){
          //do line drawing here, keep in mind line mask
      }
    }
    func setSize(width:Double,height:Double) {
      self.width = width;
      self.height = height;
      fill();
      line();
    }
    
}
