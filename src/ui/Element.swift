import Cocoa

class Element: FlippedView,IElement {
    var style:IStyle = Style.clear
    var skinState:String = SkinStates.none
    init(_ width: Int = 100, _ height: Int = 40){
        let frame = NSRect(x: 0, y: 0, width: width, height: height)
        super.init(frame: frame)
    }
    /*
    * Called on init if wantsUpdateLayer is true
    */
    override func drawLayer(layer: CALayer, inContext ctx: CGContext) {
        Swift.print("drawLayer")
    }
    /*
     * Note: if you overide drawRect then update layers wont work
     */
    override func drawRect(rect: NSRect) {
        Swift.print("drawRect")
        super.drawRect(rect)
        resolveSkin()
        
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
        let classType:String = getClassType()//gets the classtype from the component
        Swift.print("classType: " + classType)
       // style = StyleManager.getStyle(classType)!//sets the style to the element
        

         //TODO: toggle between rect and roundRect based on the style
        
        
        //continue here: make the styleresolver and start testing with skins etc. 
        //the bellow code is basically a lite version of StyleResolver.style()
        
        
        var styleComposition:IStyle = Style("styleComp")
        
        Swift.print("styleComposition")
        Swift.print(StyleManager.styles.count)
        for style in StyleManager.styles{//loop through styles
            //Swift.print("style.selector.element: " + style.selector.element)
            for selector in style.selectors{
                if(selector.element == classType){ //if style.selector == classType
                    Swift.print("  element match found")
                    for state in selector.states{//loop style.selector.states
                        if(state == skinState){//if state == any of the current states TODO: figure out how the statemaschine works and impliment that
                            Swift.print("    state match found")
                            StyleModifier.combine(&styleComposition, style)//gracefully append this style to styleComposition, forced overwrite
                        }
                    }
                }
            }
            
        }
        
        Swift.print("styleComposition.styleProperties.count: " + "\(styleComposition.styleProperties.count)")
        StyleParser.describe(styleComposition)
        
        
        
        //this is how you seperate the states with a space. 
            //basicalley create an array of states from  a space seperated string TODO: check Button on how it composes the state
            //from here: ElementParser.selectors(element):
            //selector.states = (e.skin != null ? e.skin.state : e.getSkinState()).match(/\b\w+\b/g);/*Matches words with spaces between them*/
        
  
        
        let graphics:Graphics = Graphics()
        
        let path:CGPath = CGPathParser.rect(bounds.width,bounds.height)//Shapes
        //CGPathModifier.translate(&path,20,20)//Transformations
        
        //let path = GraphicsModifier.drawRect(pathRect)
        GraphicModifier.applyProperties(path, graphics, styleComposition, styleComposition,skinState)//apply style
        GraphicModifier.stylize(path,graphics)//realize style on the graphic

        Swift.print("end of call")
        
    }
}


/*
override func updateLayer() {
Swift.print("updateLayer")
//resolveSkin()//extension method that draws the graphics
}
*/
//self.layer = CALayer() // Set view to be layer-hosting:
//self.wantsLayer = true//need for the updateLayer method to be called internally, if set to true the drawRect call wont be called
//needsDisplay = true
//layerContentsRedrawPolicy = NSViewLayerContentsRedrawPolicy.OnSetNeedsDisplay //// :TODO: whats this?

//let theLayer:CALayer