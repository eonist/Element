import Cocoa

class Element: FlippedView,IElement {
    var skinState:String = SkinStates.none
    var skin:ISkin?
    var width:Double?
    var height:Double?
    var parent : IElement?
    var id : String?;/*css selector id*/
    var style:IStyle = Style.clear
    
    
    init(_ width: Double = 100, _ height: Double = 40, _ parent:IElement? = nil,_ id:String? = nil){
        Swift.print("Element.init")
        self.width = width;
        self.height = height;
        self.parent = parent;
        self.id = id;
        let frame = NSRect(x: 0, y: 0, width: width, height: height)
        super.init(frame: frame)
        self.wantsLayer = false//this avoids calling drawLayer() and enables drawingRect()
        let context : NSGraphicsContext = NSGraphicsContext.currentContext()
        context.
    }
    /**
     * Note: if you overide drawRect then update layers wont work
     * NOTE: it seems NSViews arent drawn until they are added to a subview. 
     */
    override func drawRect(rect: NSRect) {
        Swift.print("Element.drawRect()")
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
    /**
     * Required by NSView
     */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension IElement {
    /**
     * Draws the graphics
     * TODO: does nsview have a protocol which IElement then can use
     * NOTE: this method is embedded in an extension so that class one can add functionality to Classes that cant extend Element (like NSButton)
     */
    func resolveSkin() {
        //Swift.print("resolveSkin: " + "\(String(self))")
        
        self.skin = SkinResolver.skin(self)
        
                
        
        
        
        
        /*
        
        
        let classType:String = getClassType()//gets the classtype from the component
        Swift.print("classType: " + classType)
       // style = StyleManager.getStyle(classType)!//sets the style to the element
        

         //TODO: toggle between rect and roundRect based on the style
        
        
        //continue here: make the styleresolver and start testing with skins etc. 
        //the bellow code is basically a lite version of StyleResolver.style()
        
        
        let styleComposition = StyleResolver.style(self)
        
        
        
        //this is how you seperate the states with a space. 
            //basicalley create an array of states from  a space seperated string TODO: check Button on how it composes the state
            //from here: ElementParser.selectors(element):
            //selector.states = (e.skin != null ? e.skin.state : e.getSkinState()).match(/\b\w+\b/g);/*Matches words with spaces between them*/
        
  
        
        let graphics:Graphics = Graphics()
        
        let path:CGPath = CGPathParser.rect(bounds.width,bounds.height)//Shapes
        //CGPathModifier.translate(&path,20,20)//Transformations
        
        //let path = GraphicsModifier.drawRect(pathRect)
        GraphicModifier.applyProperties(path, graphics, styleComposition, styleComposition, skinState)//apply style
        GraphicModifier.stylize(path,graphics)//realize style on the graphic

        Swift.print("end of call")
        

        */
    }
    /**
     * @Note this is the function that we need to toggle between css style sheets and have them applied to all Element instances
     * TODO: explain the logic of havong this var in this class and also in the skin class, i think its because you need to access the skinstate before the skin is created or initiated in the element.
     */
    func getSkinState() -> String {// :TODO: the skin should have this state not the element object!!!===???
        return skinState;
    }
    func getParent()->IElement? {// :TODO: beta
        //Swift.print("_parent: " + _parent);
        return self.parent;
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