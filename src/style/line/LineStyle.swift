import Cocoa

class LineStyle:ILineStyle {
    var color: NSColor
    var thickness: CGFloat
    var lineCap: CGLineCap
    var lineJoin: CGLineJoin
    var miterLimit: CGFloat
    init(_ thickness:CGFloat = 1,_ color:NSColor = NSColor.blackColor(), _ lineCap:CGLineCap = CGLineCap.Butt, _ lineJoin:CGLineJoin =  CGLineJoin.Miter, _ miterLimit:CGFloat = 10){
        self.thickness = thickness
        self.color = color
        self.lineCap = lineCap
        self.lineJoin = lineJoin
        self.miterLimit = miterLimit
        
        
        //see if you have some method in the old project for copying linestyles
    }
    
}
