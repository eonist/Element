import Cocoa

class Element: FlippedView,IElement {
    var style:IStyle = Style.clear
    var skinState:String = SkinStates.none
    init(_ width: Int = 100, _ height: Int = 40){
        let frame = NSRect(x: 0, y: 0, width: width, height: height)
        super.init(frame: frame)
        self.wantsLayer = true//need for the updateLayer method to be called internally
    }
    /*
    * Called on init if wantsUpdateLayer is true
    */
    /*
    override func updateLayer() {
        resolveSkin()//extension method that draws the graphics
    }
    */
    /*
    * Note: if you overide drawRect then update layers wont work
    */
    override func drawRect(rect: NSRect) {
        super.drawRect(rect)
       resolveSkin()
    }
    /*
    * Temp until you can access syle from an extension
    */
    func setStyle(style:IStyle){
        self.style = style
    }
    /**
    * Returns the class type of the Class instance
    * @Note if a class subclasses Element that sub-class will be the class type
    * @Note override this function in the first subClass and that subclass will be the class type for other sub-classes
    */
    func getClassType()->String{
        return String(Element)
    }
    /*
    * Required by NSView
    */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension IElement {
    /*
    * Draws the graphics
    * NOTE: this method is embedded in an extension so that class one can add functionality to Classes that cant extend Element (like NSButton)
    */
    func resolveSkin() {
        Swift.print("resolveSkin: " + "\(String(self))")
        //print("Obj name: " + "\((self as! NSObject).className)")
        //print("Obj name: " + "\(String(self))")
        let classType:String = getClassType()
        Swift.print("classType: " + classType)
        setStyle(StyleManager.getStyle(classType)!)
       
        /*
        switch skinState{
            case SkinStates.none:
                Swift.print("none")
            case SkinStates.down:
                Swift.print("down")
            default:
                break;
        }
        */
        
        
        
       
        
        
        //continue here: add gradient, shape etc
        
        
        
        let pathRect = NSInsetRect((self as! NSView).bounds, 2, 21);
        
        let path:NSBezierPath = GraphicsModifier.drawRoundRect(pathRect, 10, 10)
        
        path.lineWidth = 4
        
        GraphicModifier.applyProperties(path, style, style,skinState)
        
        //nsFillColor.setFill();
        //nsLineColor.setStroke();
        
        path.fill()
        path.stroke()
        
        /*
        NSColor.greenColor().setFill()
        
        let path = NSBezierPath(rect: (self as! NSView).bounds)
        path.fill()
        
        */
    }
}