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
    * TODO: does nsview have a protocol which IElement then can use
    * NOTE: this method is embedded in an extension so that class one can add functionality to Classes that cant extend Element (like NSButton)
    */
    func resolveSkin() {
        Swift.print("resolveSkin: " + "\(String(self))")
        let classType:String = getClassType()
        Swift.print("classType: " + classType)
        setStyle(StyleManager.getStyle(classType)!)
       
        //loop through styles
            //if style.selector == classType
                //loop style.selector.states
                    //if state == currentState
                        //figure out how the statemaschine works and impliment that
                        //
        
        
        //TODO: toggle between rect and roundRect based on the style
        
        
        
        //TODO: add gradient to the mix see book
        
        
        
        let pathRect = NSInsetRect((self as! NSView).bounds, 22, 21);
        let path:NSBezierPath = GraphicsModifier.drawRoundRect(pathRect, 10, 10)//draw graphic
        //let path = GraphicsModifier.drawRect(pathRect)
        GraphicModifier.applyProperties(path, style, style,skinState)//apply style
        GraphicModifier.stylize(path)//realize style on the graphic
    
        
    }
}