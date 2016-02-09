import Cocoa
/**
 * // :TODO: shouldnt this class extend Stepper?
 */
class LeverStepper : Element{
    private var maxVal:CGFloat = CGFloat.max
    private var minVal:CGFloat = CGFloat.min
    private var value:CGFloat;
    private var	increment:CGFloat;/*The amount of incrementation for each stepping*/
    private var decimals:Int;/*decimal places*/
    private var text:String;
    private var onMouseDownMouseY:CGFloat;
    private var onMouseDownValue:CGFloat;
    private var leverHeight:CGFloat;// :TODO: write a description about this value
    private var leverRange : CGFloat;
    var globalMouseMovedHandeler:AnyObject?//rename to leftMouseDraggedEventListener or draggedEventListner maybe? //fix typo
    var plusButton:Button?
    var minusButton:Button?
    override init(_ width: CGFloat, _ height: CGFloat, _ parent: IElement? = nil, _ id: String? = nil) {
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        super.resolveSkin();
        plusButton = addSubView(Button(height,height,self,"plus")) as? Button;
        minusButton = addSubView(Button(height,height,self, "minus")) as? Button;
    }
    
    func onPlusButtonDown() {
        onMouseDownMouseY  = plusButton!.localPos().y
        onMouseDownValue = self.value;
        globalMouseMovedHandeler = NSEvent.addLocalMonitorForEventsMatchingMask([.LeftMouseDraggedMask], handler:onButtonMove )//we add a global mouse move event listener
    }
    func onMinusButtonDown() {
        onMouseDownMouseY  = minusButton!.localPos().y
        onMouseDownValue = value

        globalMouseMovedHandeler = NSEvent.addLocalMonitorForEventsMatchingMask([.LeftMouseDraggedMask], handler:onButtonMove )//we add a global mouse move event listener
    }
    func onPlusButtonUpInside() {
        let val:CGFloat = NumberModifier.increment(value, increment);
        value = NumberParser.minMax(val, minVal, maxVal);// :TODO: dont set the value
        self.event!(StepperEvent(StepperEvent.change,value,self))
    }
    func onMinusButtonUpInside() {
        let val:CGFloat = NumberModifier.decrement(value, increment);
        value = NumberParser.minMax(val, minVal, maxVal);
        self.event!(StepperEvent(StepperEvent.change,self.value,self))
    }
    func onButtonUp(){
        if(globalMouseMovedHandeler != nil){NSEvent.removeMonitor(globalMouseMovedHandeler!)}//we remove a global mouse move event listener
    }
    func onButtonMove(event:NSEvent)-> NSEvent?{
        var leaverPos:CGFloat = - minusButton.mouseY + onMouseDownMouseY;
        leaverPos = NumberParser.minMax(leaverPos, - leverHeight, leverHeight);
        var multiplier:CGFloat = leaverPos / leverHeight;
        var leaverValue:CGFloat =leverRange * multiplier;/*the lever value fluctuates, sometimes with decimals so we round it*/
        var value:CGFloat =  onMouseDownValue + leaverValue;
        value = NumberParser.minMax(value, min, max);/*cap the value from min to max*/
        
        //the bellow line needs some work:
        
        value = CGFloat(value.toFixed(decimals));/*the value must have no more than the value of the _decimals*/
        self.value = value;
        //send event ->  StepperEvent(StepperEvent.CHANGE,self.value)
    }
    /*
     *
     */
    override func onEvent(event: Event) {
        if(event.origin === plusButton && event.type == ButtonEvent.down){onPlusButtonDown()}
        else if(event.origin === minusButton && event.type == ButtonEvent.down){onMinusButtonDown()}
        else if(event.origin === plusButton && event.type == ButtonEvent.upInside){onPlusButtonUpInside()}
        else if(event.origin === minusButton && event.type == ButtonEvent.upInside){onMinusButtonUpInside()}
        else if(event.origin === plusButton && event.type == ButtonEvent.upOutside){onPlusButtonUpOutside()}
        else if(event.origin === minusButton && event.type == ButtonEvent.upOutside){onMinusButtonUpOutside()}
        else if(event.origin === minusButton && event.type == ButtonEvent.up){onButtonUp()}
    }
    /**
     * Returns "Stepper"
     * @Note This function is used to find the correct class type when synthezing the element stack
     */
    override func getClassType() -> String {
        return String(Stepper)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}