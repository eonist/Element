import Cocoa
@testable import Utils
/**
 * //TODO: shouldn't this class extend Stepper?
 */
class LeverStepper:Element{
    var value:CGFloat
    var maxVal:CGFloat
    var minVal:CGFloat
    var	increment:CGFloat/*The amount of incrementation for each stepping*/
    var decimals:Int/*Decimal places*/
    var onMouseDownMouseY:CGFloat = CGFloat.nan
    var onMouseDownValue:CGFloat = CGFloat.nan
    var leverHeight:CGFloat//TODO: Write a description about this value
    var leverRange:CGFloat
    var leftMouseDraggedEventListener:Any?
    var plusButton:Button?
    var minusButton:Button?
    init(_ width: CGFloat, _ height: CGFloat, _ value:CGFloat = 0, _ increment:CGFloat = 1, _ min:CGFloat = Int.min.cgFloat , _ max:CGFloat = Int.max.cgFloat, _ decimals:Int = 0, _ leverRange:CGFloat = 100, _ leverHeight:CGFloat = 200, _ parent: IElement? = nil, _ id: String? = nil) {
        self.value = value
        self.minVal = min
        self.maxVal = max
        self.increment = increment
        self.decimals = decimals
        self.leverHeight = leverHeight//TODO: Rename to something less ambiguous
        self.leverRange = leverRange
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        plusButton = addSubView(Button(height,height,self,"plus"))
        minusButton = addSubView(Button(height,height,self, "minus"))
    }
    func onPlusButtonDown() {
        //Swift.print("onPlusButtonDown()")
        //Swift.print("globalMouseMovedHandeler: " + "\(globalMouseMovedHandeler)")
        onMouseDownMouseY = plusButton!.localPos().y
        onMouseDownValue = self.value
        if(leftMouseDraggedEventListener == nil) {leftMouseDraggedEventListener = NSEvent.addLocalMonitorForEvents(matching: [.leftMouseDragged], handler: self.onPlusButtonMove)}//we add a global mouse move event listener
        else {fatalError("This shouldn't be possible, if it throws this error then you need to remove he eventListener before you add it")}
    }
    func onMinusButtonDown() {
        //Swift.print("onMinusButtonDown()")
        //Swift.print("globalMouseMovedHandeler: " + "\(globalMouseMovedHandeler)")
        onMouseDownMouseY  = minusButton!.localPos().y
        //Swift.print("onMinusButtonDown onMouseDownMouseY: " + "\(onMouseDownMouseY)")
        onMouseDownValue = value
        if(leftMouseDraggedEventListener == nil) {leftMouseDraggedEventListener = NSEvent.addLocalMonitorForEvents(matching:[.leftMouseDragged], handler:self.onMinusButtonMove ) }//we add a global mouse move event listener
        else {fatalError("This shouldn't be possible, if it throws this error then you need to remove he eventListener before you add it")}
    }
    func onPlusButtonUpInside() {
        //Swift.print("onPlusButtonUpInside")
        let val:CGFloat = CGFloatModifier.increment(value, increment);
        value = NumberParser.minMax(val, minVal, maxVal);// :TODO: Don't set the value
        self.event!(StepperEvent(StepperEvent.change,value,self,self))
    }
    func onMinusButtonUpInside() {
        //Swift.print("onMinusButtonUpInside")
        let val:CGFloat = CGFloatModifier.decrement(value, increment);
        value = NumberParser.minMax(val, minVal, maxVal);
        self.event!(StepperEvent(StepperEvent.change,self.value,self,self))
    }
    func onButtonUp(){
        //Swift.print("LeverStepper.onButtonUp()" + "\(self)")
        //Swift.print("leftMouseDraggedEventListener: " + "\(leftMouseDraggedEventListener)")
        if(leftMouseDraggedEventListener != nil){
            NSEvent.removeMonitor(leftMouseDraggedEventListener!)
            leftMouseDraggedEventListener = nil//<--this part may not be needed
        }/*We remove a global mouse move event listener*/
        //Swift.print("leftMouseDraggedEventListener: " + "\(leftMouseDraggedEventListener)")
    }
    func onPlusButtonMove(event:NSEvent)-> NSEvent?{//wuic
        return onButtonMove(event,plusButton!)
    }
    func onMinusButtonMove(event:NSEvent)-> NSEvent?{
         return onButtonMove(event,minusButton!)
    }
    func onButtonMove(_ event:NSEvent,_ button:Button)-> NSEvent?{
        //Swift.print("onButtonMove")
        var leaverPos:CGFloat = -button.localPos().y + onMouseDownMouseY
        leaverPos = NumberParser.minMax(leaverPos, -leverHeight, leverHeight)
        let multiplier:CGFloat = leaverPos / leverHeight
        let leverValue:CGFloat = leverRange * multiplier/*The lever value fluctuates, sometimes with decimals so we round it*/
        var val:CGFloat = onMouseDownValue + leverValue
        val = NumberParser.minMax(val, minVal, maxVal)/*Cap the value from min to max*/
        val = CGFloatModifier.toFixed(val,decimals)/*The value must have no more than the value of the _decimals*/
        value = val
        //Swift.print("value: " + "\(value)")
        self.event!(StepperEvent(StepperEvent.change,self.value,self,self))//probably use the onEvent here not the event
        return event/*this return is required when you listen to the global mouse move event*/
    }
    /**
     *
     */
    override func onEvent(_ event: Event) {
        //Swift.print("onEvent() event: " + "\(event)")
        if(event.origin === plusButton && event.type == ButtonEvent.down){onPlusButtonDown()}
        else if(event.origin === minusButton && event.type == ButtonEvent.down){onMinusButtonDown()}
        else if(event.origin === plusButton && event.type == ButtonEvent.upInside){onPlusButtonUpInside()}
        else if(event.origin === minusButton && event.type == ButtonEvent.upInside){onMinusButtonUpInside()}
        //else if(event.origin === plusButton && event.type == ButtonEvent.upOutside){onPlusButtonUpOutside()}
        //else if(event.origin === minusButton && event.type == ButtonEvent.upOutside){onMinusButtonUpOutside()}
        else if(event.origin === minusButton && event.type == ButtonEvent.up){onButtonUp()}
        else if(event.origin === plusButton && event.type == ButtonEvent.up){onButtonUp()}
        super.onEvent(event)
    }
    /**
     * Returns "Stepper"
     * NOTE: This function is used to find the correct class type when synthezing the element stack
     */
    override func getClassType() -> String {
        return "\(Stepper.self)"
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
