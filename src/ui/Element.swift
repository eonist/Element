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
    override func drawLayer(layer: CALayer, inContext ctx: CGContext) {
        Swift.print("drawLayer")
    }
    override func updateLayer() {
        
        //layerWithColor()
        layerWithGradient()
        //makeLineLayer(l,CGPoint(x: 10,y: 10),CGPoint(x: 100,y: 100))
        //addSubLayer()
        //resolveSkin()//extension method that draws the graphics
    }
    /**
    *
    */
    func layerWithColor(){
        let l:CALayer = layer!
        //layer!.frame = CGRectInset(l.frame, 5, 5);
        l.backgroundColor = NSColorParser.cgColor(NSColor.greenColor())
        //l.backgroundColor = UIColor.blueColor().CGColor
        l.borderWidth = 4
        l.cornerRadius = 8
        
        l.borderColor = NSColorParser.cgColor(NSColor.redColor())
        
        //l.borderColor = UIColor.redColor().CGColor
        
        l.shadowOpacity = 0.7
        l.shadowOffset = CGSizeMake(0, 3);
        l.shadowRadius = 5.0;
        l.shadowColor = NSColorParser.cgColor(NSColor.grayColor())
        l.shadowOpacity = 0.8;
    }
    /**
    *
    */
    func layerWithGradient(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.frame.bounds
        gradientLayer.colors = [cgColorForRed(209.0, green: 0.0, blue: 0.0),
            cgColorForRed(255.0, green: 102.0, blue: 34.0),
            cgColorForRed(255.0, green: 218.0, blue: 33.0),
            cgColorForRed(51.0, green: 221.0, blue: 0.0),
            cgColorForRed(17.0, green: 51.0, blue: 204.0),
            cgColorForRed(34.0, green: 0.0, blue: 102.0),
            cgColorForRed(51.0, green: 0.0, blue: 68.0)]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        someView.layer.addSublayer(gradientLayer)
        
        func cgColorForRed(red: CGFloat, green: CGFloat, blue: CGFloat) -> AnyObject {
            return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0).CGColor as AnyObject
        }
    }
    /**
    *
    */
    func addSubLayer(){
        let sublayer = CALayer()
        sublayer.backgroundColor = NSColor.orangeColor().CGColor
        sublayer.shadowOffset = CGSizeMake(0, 3);
        sublayer.shadowRadius = 5.0;
        sublayer.shadowColor = NSColor.blackColor().CGColor
        sublayer.shadowOpacity = 0.8
        sublayer.frame = CGRectMake(30, 30, 128, 192);
        layer!.addSublayer(sublayer)
    }
    func makeLineLayer(layer:CALayer,_ a:CGPoint,_ b:CGPoint){
        let line = CAShapeLayer(layer: layer)//CAShapeLayer *line = [CAShapeLayer layer];
        let linePath = NSBezierPath()
        linePath.moveToPoint(a)
        linePath.lineToPoint(b)
        
        line.path = NSBezierPathParser.cgPath(linePath)
        
        line.fillColor = nil;
        line.opacity = 1.0;
        line.strokeColor = NSColor.redColor().CGColor
        
        layer.addSublayer(line)
        
        
        /*
        [linePath moveToPoint: pointA];
        [linePath addLineToPoint:pointB];
        
        
        */
    }
    
    
    /*
    * Note: if you overide drawRect then update layers wont work
    */
    
    /*
    override func drawRect(rect: NSRect) {
    super.drawRect(rect)
    resolveSkin()
    }
    */
    
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
        
        var styleComposition:IStyle = Style("styleComp")
        
        Swift.print("styleComposition")
        Swift.print(StyleManager.styles.count)
        for style in StyleManager.styles{//loop through styles
            //Swift.print("style.selector.element: " + style.selector.element)
            if(style.selector.element == classType){ //if style.selector == classType
                Swift.print("  element match found")
                for state in style.selector.states{//loop style.selector.states
                    if(state == skinState){//if state == any of the current states TODO: figure out how the statemaschine works and impliment that
                        Swift.print("    state match found")
                        StyleModifier.combine(&styleComposition, style)//gracefully append this style to styleComposition, forced overwrite
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
        
  
        
        let pathRect = NSInsetRect((self as! NSView).bounds, 22, 21);
        let path:NSBezierPath = GraphicsModifier.drawRoundRect(pathRect, 10, 10)//draw graphic
        //let path = GraphicsModifier.drawRect(pathRect)
        GraphicModifier.applyProperties(path, styleComposition, styleComposition,skinState)//apply style
        GraphicModifier.stylize(path)//realize style on the graphic

        Swift.print("end of call")
        
    }
}