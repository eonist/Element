import Cocoa

class Element: FlippedView,IElement {
    var style:IStyle = Style.clear
    var skinState:String = SkinStates.none
    //let theLayer:CALayer
    init(_ width: Int = 100, _ height: Int = 40){
        let frame = NSRect(x: 0, y: 0, width: width, height: height)
        super.init(frame: frame)
        
        //self.layer = CALayer() // Set view to be layer-hosting:
        //self.wantsLayer = true//need for the updateLayer method to be called internally, if set to true the drawRect call wont be called
        //needsDisplay = true
        //layerContentsRedrawPolicy = NSViewLayerContentsRedrawPolicy.OnSetNeedsDisplay //// :TODO: whats this?
        //layerWithColor()
        //test()
        //layerWithGradient()
        
        
        
        
        
        
       
        
        
    }
    /*
    * Called on init if wantsUpdateLayer is true
    */
    override func drawLayer(layer: CALayer, inContext ctx: CGContext) {
        Swift.print("drawLayer")
    }
    override func updateLayer() {
        
        //layerWithColor()
        //layerWithGradient()
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
        //l.backgroundColor = NSColorParser.cgColor(NSColor.greenColor())
        layer!.backgroundColor = CGColorCreateGenericRGB(1.0, 0.0, 0.0, 1.0)
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
    func test(){
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
      
        let roundRect = CALayer()
        gradient.colors = [NSColor.redColor().CGColor,NSColor.greenColor().CGColor]
        
        roundRect.frame = self.bounds
        roundRect.cornerRadius = 6.0
        roundRect.masksToBounds = true
        roundRect.addSublayer(gradient)
        self.layer!.insertSublayer(roundRect,atIndex:0)
       
    }
    /**
    *
    */
    func layerWithGradient(){
        Swift.print("layerWithGradient")
        //let l:CALayer = CALayer()
        
        let gradientLayer = CAGradientLayer()
        //layer!.addSublayer(gradientLayer)
        //layer!.insertSublayer(gradientLayer, atIndex: 0)
        //self.sendSubviewToBack(gradientLayer)
        Swift.print("self.bounds")
        Swift.print(self.bounds)
        gradientLayer.frame = CGRect(x: 64, y: 64, width: 160, height: 160)
        //gradientLayer.frame = self.bounds
        
        gradientLayer.colors = [
        ColorParser.nsColor(209.0, 0.0,  0.0).CGColor,
        ColorParser.nsColor(255.0,  102.0,  34.0).CGColor,
        ColorParser.nsColor(255.0, 218.0,  33.0).CGColor,
        ColorParser.nsColor(51.0, 221.0,  0.0).CGColor,
        ColorParser.nsColor(17.0,  51.0,  204.0).CGColor,
        ColorParser.nsColor(34.0,  0.0,  102.0).CGColor,
        ColorParser.nsColor(51.0,  0.0,  68.0).CGColor]

        //gradientLayer.colors = [NSColor.redColor().CGColor,NSColor.greenColor().CGColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        /*
        gradientLayer.startPoint = CGPointZero;
        gradientLayer.endPoint = CGPointMake(1, 1);
        
        */
        //gradientLayer.locations = [NSNumber(double: 0.0),NSNumber(double: 0.7)]
        
        
        
        //continue here, something is missing
        
        
        
        
        layer!.addSublayer(gradientLayer)
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
    /*
    * CAShapeLayer doesnt supoprt gradient, but might do with: CGContextDrawRadialGradient
    */
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
    
    
    override func drawRect(rect: NSRect) {
        Swift.print("drawRect")
        super.drawRect(rect)
        //drawGradientRect(rect)
        drawRadialGradientCircle(rect)
        //drawShapes(rect)
        
        //resolveSkin()
    }
    /**
    * draws many shapes (works)
    */
    func drawShapes(dirtyRect: NSRect){
        Swift.print(String(dirtyRect))
        let bPath:NSBezierPath = NSBezierPath(rect: dirtyRect)
        Swift.print(bPath)
        let fillColor = NSColor(red: 0.5, green: 0.0, blue: 0.5, alpha: 1.0)
        fillColor.set()
        bPath.fill()
        
        let borderColor = NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        borderColor.set()
        bPath.lineWidth = 12.0
        bPath.stroke()
        
        let circleFillColor = NSColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
        let circleRect = NSMakeRect(dirtyRect.size.width/4, dirtyRect.size.height/4, dirtyRect.size.width/2, dirtyRect.size.height/2)
        let cPath: NSBezierPath = NSBezierPath(ovalInRect: circleRect)
        circleFillColor.set()
        cPath.fill()
    }
    /**
    * Todo try to style two things above the other. If this isnt possible pursue the Layer idea
    */
    func drawGradientRect(rect: NSRect){
        // Defining the shape
        let drawingRect = CGRectInset(rect,rect.size.width * 0.1,rect.size.height * 0.1);
        let cornerRadius : CGFloat = 20
        let bezierPath = NSBezierPath(roundedRect: drawingRect,xRadius: cornerRadius,yRadius: cornerRadius)
        // Define the gradient
        let startColor = NSColor.blackColor()
        let endColor = NSColor.whiteColor()
        let gradient = NSGradient(startingColor:startColor, endingColor:endColor)
        // Draw the gradient in the path
        gradient!.drawInBezierPath(bezierPath, angle: 90)
    }
    /**
    *
    */
    func drawRadialGradientCircle(rect:NSRect){
        let bounds = self.bounds
        let aGradient:NSGradient = NSGradient(startingColor: NSColor.yellowColor(), endingColor: NSColor.redColor())!
        
        let centerPoint:NSPoint = NSMakePoint(NSMidX(bounds), NSMidY(bounds))
        let otherPoint:NSPoint = NSMakePoint(centerPoint.x + 60.0, centerPoint.y + 60.0)
        let firstRadius:CGFloat = min( ((bounds.size.width/2.0) - 2.0),((bounds.size.height/2.0) - 2.0) )
        aGradient.drawFromCenter(centerPoint, radius:firstRadius, toCenter: otherPoint, radius: 2.0, options: 0/*NSGradientDrawingOptions*/)
    
        
    }
    
    /**
    * for caLayers i think
    */
    func layerWidthRadialGradient(rect:CGRect){
       
            //CGContextRef context = UIGraphicsGetCurrentContext();
            
        /*
        size_t gradLocationsNum = 2;
        CGFloat gradLocations[2] = {0.0f, 1.0f};
        CGFloat gradColors[8] = {0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.5f};
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, gradColors, gradLocations, gradLocationsNum);
        CGColorSpaceRelease(colorSpace);
        
        CGPoint gradCenter= CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        float gradRadius = MIN(self.bounds.size.width , self.bounds.size.height) ;
        
        CGContextDrawRadialGradient (context, gradient, gradCenter, 0, gradCenter, gradRadius, kCGGradientDrawsAfterEndLocation);
        
        CGGradientRelease(gradient);
        */
        
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

class GradientCALAyer:CALayer{
    var origin: CGPoint?
    var radius: CGFloat?
    var locations: [CGFloat]?
    var colors: [CGColor]?
    
    override func drawInContext(ctx: CGContext) {
        super.drawInContext(ctx)
        if let colors = self.colors {
            if let locations = self.locations {
                if let origin = self.origin {
                    if let radius = self.radius {
                        var colorSpace: CGColorSpaceRef?
                        
                        var components = [CGFloat]()
                        for i in 0 ..< colors.count {
                            let colorRef = colors[i]
                            let colorComponents = CGColorGetComponents(colorRef)
                            let numComponents = CGColorGetNumberOfComponents(colorRef)
                            if colorSpace == nil {
                                colorSpace = CGColorGetColorSpace(colorRef)
                            }
                            for j in 0 ..< numComponents {
                                //let componentIndex: Int = numComponents * i + j
                                let component = colorComponents[j]
                                components.append(component)
                            }
                        }
                        
                        if let colorSpace = colorSpace {
                            let gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, locations.count)
                            CGContextDrawRadialGradient(ctx, gradient, origin, CGFloat(0), origin, radius, CGGradientDrawingOptions.DrawsAfterEndLocation)
                        }
                    }
                }
            }
        }
        
    }
}

