import Cocoa
/**
 * // :TODO: shouldnt this class extend Stepper?
 */
class LeverStepper : Element{
    var value:CGFloat;
    var maxVal:CGFloat
    var minVal:CGFloat
    var	increment:CGFloat;/*The amount of incrementation for each stepping*/
    var decimals:Int;/*decimal places*/
    var onMouseDownMouseY:CGFloat = CGFloat.NaN
    var onMouseDownValue:CGFloat = CGFloat.NaN
    var leverHeight:CGFloat;// :TODO: write a description about this value
    var leverRange : CGFloat;
    var globalMouseMovedHandeler:AnyObject?//rename to leftMouseDraggedEventListener or draggedEventListner maybe? //fix typo
    var plusButton:Button?
    var minusButton:Button?
    init(_ width: CGFloat, _ height: CGFloat, _ value:CGFloat = 0, _ increment:CGFloat = 1, _ min:CGFloat = CGFloat.min , _ max:CGFloat = CGFloat.max, _ decimals:Int = 0, _ leverRange:CGFloat = 100, _ leverHeight:CGFloat = 200, _ parent: IElement? = nil, _ id: String? = nil) {
        self.value = value;
        self.minVal = min;
        self.maxVal = max;
        self.increment = increment;
        self.decimals = decimals;
        self.leverHeight = leverHeight;// :TODO: rename to something less ambiguous
        self.leverRange = leverRange;
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        super.resolveSkin();
        plusButton = addSubView(Button(height,height,self,"plus"))
        minusButton = addSubView(Button(height,height,self, "minus"))
    }
    func onPlusButtonDown() {
        //Swift.print("onPlusButtonDown")
        onMouseDownMouseY  = plusButton!.localPos().y
        onMouseDownValue = self.value;
        globalMouseMovedHandeler = NSEvent.addLocalMonitorForEventsMatchingMask([.LeftMouseDraggedMask], handler:onPlusButtonMove )//we add a global mouse move event listener
    }
    func onMinusButtonDown() {
        Swift.print("onMinusButtonDown()")
        onMouseDownMouseY  = minusButton!.localPos().y
        //Swift.print("onMinusButtonDown onMouseDownMouseY: " + "\(onMouseDownMouseY)")
        onMouseDownValue = value
        globalMouseMovedHandeler = NSEvent.addLocalMonitorForEventsMatchingMask([.LeftMouseDraggedMask], handler:onMinusButtonMove )//we add a global mouse move event listener
    }
    func onPlusButtonUpInside() {
        //Swift.print("onPlusButtonUpInside")
        let val:CGFloat = NumberModifier.increment(value, increment);
        value = NumberParser.minMax(val, minVal, maxVal);// :TODO: dont set the value
        self.event!(StepperEvent(StepperEvent.change,value,self,self))
    }
    func onMinusButtonUpInside() {
        //Swift.print("onMinusButtonUpInside")
        let val:CGFloat = NumberModifier.decrement(value, increment);
        value = NumberParser.minMax(val, minVal, maxVal);
        self.event!(StepperEvent(StepperEvent.change,self.value,self,self))
    }
    func onButtonUp(){
        Swift.print("onButtonUp()")
        if(globalMouseMovedHandeler != nil){NSEvent.removeMonitor(globalMouseMovedHandeler!)}//we remove a global mouse move event listener
    }
    func onPlusButtonMove(event:NSEvent)-> NSEvent?{//wuic
        return onButtonMove(event,plusButton!)
    }
    func onMinusButtonMove(event:NSEvent)-> NSEvent?{
        return onButtonMove(event,minusButton!)
    }
    func onButtonMove(event:NSEvent,_ button:Button)-> NSEvent?{
        //Swift.print("onButtonMove")
        var leaverPos:CGFloat = -button.localPos().y + onMouseDownMouseY;
        leaverPos = NumberParser.minMax(leaverPos, -leverHeight, leverHeight);
        let multiplier:CGFloat = leaverPos / leverHeight
        let leverValue:CGFloat = leverRange * multiplier;/*the lever value fluctuates, sometimes with decimals so we round it*/
        var val:CGFloat =  onMouseDownValue + leverValue;
        val = NumberParser.minMax(val, minVal, maxVal);/*cap the value from min to max*/
        val = NumberModifier.toFixed(val,decimals)/*the value must have no more than the value of the _decimals*/
        value = val
        //Swift.print("value: " + "\(value)")
        self.event!(StepperEvent(StepperEvent.change,self.value,self,self))
        return event/*this return is required when you listen to the global mouse move event*/
    }
    /**
     *
     */
    override func onEvent(event: Event) {
        //Swift.print("onEvent() event: " + "\(event)")
        if(event.origin === plusButton && event.type == ButtonEvent.down){onPlusButtonDown()}
        else if(event.origin === minusButton && event.type == ButtonEvent.down){onMinusButtonDown()}
        else if(event.origin === plusButton && event.type == ButtonEvent.upInside){onPlusButtonUpInside()}
        else if(event.origin === minusButton && event.type == ButtonEvent.upInside){onMinusButtonUpInside()}
        //else if(event.origin === plusButton && event.type == ButtonEvent.upOutside){onPlusButtonUpOutside()}
        //else if(event.origin === minusButton && event.type == ButtonEvent.upOutside){onMinusButtonUpOutside()}
        else if(event.origin === minusButton && event.type == ButtonEvent.up){onButtonUp()}
        super.onEvent(event)
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