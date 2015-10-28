import Foundation
class Section:FlippedView/*:Element*/ {//Unlike Container, section can have a style applied
    init(_ width:Int = 100, _ height:Int = 100) {
        let frame = NSRect(x: 0, y: 0, width: width, height: height)
        super.init(frame: frame)
    }
    /*
    * Required by super class
    */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    *  This class exists because one shouldnt use the Element class as a holder of content
    */
    /*
    override init(_ width: Int, _ height: Int/*, _ style: IGraphicStyle*/) {
        super.init(width, height/*, style*/)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    */
   
}