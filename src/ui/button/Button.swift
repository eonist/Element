import Cocoa
//can you overide functionality with extension? if so you may be able to do the updateLayer another place for all similar graphic elements
//research the above
class Button: NSButton,IElement{
    var style:IStyle = Style.clear
    var skinState:String = SkinStates.none
    init(_ width: Int = 100, _ height: Int = 40) {
        let frame = NSRect(x: 0, y: 0, width: width, height: height)
        super.init(frame: frame)
        self.wantsLayer = true//need for the updateLayer method to be called internally
        addTrackingRect(self.bounds, owner: self, userData: nil, assumeInside: true)//This enables entered and exited events to fire //let focusTrackingAreaOptions:NSTrackingAreaOptions = [NSTrackingActiveInActiveApp,NSTrackingMouseEnteredAndExited,NSTrackingAssumeInside,NSTrackingInVisibleRect,NSTrackingEnabledDuringMouseDrag]//NSTrackingEnabledDuringMouseDrag to mine to make sure the rollover behaves still when dragging in and out of the area.//TODO: you may need to update trackingarea: - (void)updateTrackingAreas
    }
    
    override func updateLayer() {//called on init if wantsUpdateLayer is true
        let l:CALayer = layer!
        l.backgroundColor = NSColorParser.cgColor(NSColor.greenColor())
        //l.backgroundColor = UIColor.blueColor().CGColor
        l.borderWidth = 4
        l.cornerRadius = 8
        
        l.borderColor = NSColorParser.cgColor(NSColor.redColor())
            
        //l.borderColor = UIColor.redColor().CGColor
        l.shadowOpacity = 0.7
        l.shadowRadius = 10.0
    }
    
    override func drawRect(rect: NSRect) {
        super.drawRect(rect)
        Swift.print("redraw: ")
        if(self.cell!.highlighted){
            Swift.print("pressed state")
            skinState = SkinStates.down
        }else{
            Swift.print("unPressed state")
            skinState = SkinStates.none
        }
        /*These states can be used for toggle buttons*/
        switch self.state {
        case NSOnState :// Draw on state
            Swift.print("on")
        case NSMixedState :// Draw mixed state
            Swift.print("mixed")
        case NSOffState :
            Swift.print("off")
        default:
            break;
            
        }
        resolveSkin()//extension method that draws the graphics
        
    }
    func getClassType()->String{
        return String(Button)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var wantsUpdateLayer:Bool{//enables the call of updateLayer
        return true
    }
    override func mouseEntered( event: NSEvent){
        Swift.print("entered" + "\(self.state)")
        super.mouseEntered(event)
    }
    override func mouseExited(event: NSEvent){
        Swift.print("exited: " + "\(self.state)")
        super.mouseExited(event)
    }
    override func mouseDown(theEvent: NSEvent) {
        Swift.print("mouseDownEvent" )
        super.mouseDown(theEvent)
    }
    override func mouseUp(theEvent: NSEvent) {
        Swift.print("mouseUpEvent")
        super.mouseDown(theEvent)
    }
}