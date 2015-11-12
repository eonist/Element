import Cocoa
/*
 * // :TODO: impliment margin padding ?!? maybe not
 * // :TODO: Try to impliment Rect3 into Element2 and do tests
 * // :TODO: add example in the javadoc
 */
class RectGraphic : Graphic,IDecoratable{
    var width:Double;
    var height:Double;
    var decoratable:IDecoratable{return self}
    init(_ width:Double = 100, _ height:Double = 100, _ fillStyle:IFillStyle? = nil, _ lineStyle:ILineStyle? = nil){
        self.width = width;
        self.height = height;
        super.init(fillStyle, lineStyle )
        fill();
        //line();
    }
    func fill() {
        
        beginFill();
        drawFill();
    }
    func line(){
        fatalError("NOT IMPLEMENTED YET")
        //applyLineStyle(self,lineStyle);
        //drawLine();
    }
    func beginFill() {
      if(fillStyle != nil && fillStyle!.color != NSColor.clearColor() ) {
        GraphicModifier.applyProperties(graphics, fillStyle!/*, lineStyle*/)//apply style
      }
    }
    /**
     * // :TODO: does this function need arguments?
     */
    func applyLineStyle(graphics:Graphics,_ lineStyle:ILineStyle) {
      /*
      if(lineStyle != nil) {
         //apply lineStyle here /*updates only if lineStyle of class LineStyle*/
      }
      */
    }
    func drawFill() {
        //do fill drawing here
        path = CGPathParser.rect(CGFloat(width), CGFloat(height))//Shapes
        GraphicModifier.stylize(path,graphics)//realize style on the graphic
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
    func getGraphic()-> Graphic{/*Dont revert to IGraphic here*/
        //fatalError("NOT IMPLEMENTED YET")
        return self
    }
}
