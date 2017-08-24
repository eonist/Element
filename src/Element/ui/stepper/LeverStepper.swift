import Cocoa
@testable import Utils
/**
 * TODO: ⚠️️ Shouldn't this class extend Stepper? 👈
 * TODO: make things private, and maybe remove some methods
 * TODO: ⚠️️ Rename leverHeight to something less ambiguous
 * PARAM: Decimal places
 * PARAM: increment: The amount of incrementation for each stepping
 */
class LeverStepper:Element{
    lazy var plusButton:Button = createPlusButton()
    lazy var minusButton:Button = createMinusButton()
    var onMouseDownMouseY:CGFloat = CGFloat.nan
    var onMouseDownValue:CGFloat = CGFloat.nan
    var leftMouseDraggedEventListener:Any?
    var initData:InitData
    init(initData:InitData = defaultData, size:CGSize = CGSize(NaN,NaN),id:String? = nil){
        self.initData = initData
        super.init(size:size,id:id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        _ = plusButton/*Inits the UI element*/
        _ = minusButton/*Inits the UI element*/
    }
    func onPlusButtonDown() {
        onMouseDownMouseY = plusButton.localPos().y
        onMouseDownValue = initData.value
        NSEvent.addMonitor(&self.leftMouseDraggedEventListener,.leftMouseDragged,self.onPlusButtonMove)
    }
    func onMinusButtonDown() {
        onMouseDownMouseY  = minusButton.localPos().y
        onMouseDownValue = initData.value
        NSEvent.addMonitor(&self.leftMouseDraggedEventListener,.leftMouseDragged,self.onMinusButtonMove)
    }
    func onPlusButtonUpInside() {
        let val:CGFloat = CGFloatModifier.increment(initData.value, initData.increment);
        initData.value = NumberParser.minMax(val, initData.min, initData.max);// :TODO: Don't set the value
        self.event!(StepperEvent(StepperEvent.change,initData.value,self,self))
    }
    func onMinusButtonUpInside() {
        let val:CGFloat = CGFloatModifier.decrement(initData.value, initData.increment);
        initData.value = NumberParser.minMax(val, initData.min, initData.max);
        self.event!(StepperEvent(StepperEvent.change,self.initData.value,self,self))
    }
    func onButtonUp(){
        NSEvent.removeMonitor(&self.leftMouseDraggedEventListener)/*We remove a global mouse move event listener*/
    }
    func onPlusButtonMove(event:NSEvent)-> Void{
        _ = onButtonMove(event,plusButton)
    }
    func onMinusButtonMove(event:NSEvent)-> Void{
         _ = onButtonMove(event,minusButton)
    }
    func onButtonMove(_ event:NSEvent,_ button:Button)-> NSEvent{
        let leaverPos:CGFloat = {
            let leaverPos = -button.localPos().y + onMouseDownMouseY
            return NumberParser.minMax(leaverPos, -initData.leverHeight, initData.leverHeight)
        }()
        let multiplier:CGFloat = leaverPos / initData.leverHeight
        let leverValue:CGFloat = initData.leverRange * multiplier/*The lever value fluctuates, sometimes with decimals so we round it*/
        let val:CGFloat = {
            let a = onMouseDownValue + leverValue
            let b = NumberParser.minMax(a, initData.min, initData.max)/*Cap the value from min to max*/
            return CGFloatModifier.toFixed(b,initData.decimals)/*The value must have no more than the value of the _decimals*/
        }()
        initData.value = val
        self.event!(StepperEvent(StepperEvent.change,self.initData.value,self,self))//probably use the onEvent here not the event
        return event/*this return is required when you listen to the global mouse move event*/
    }
    /**
     * Event handler
     */
    override func onEvent(_ event:Event) {
        if let event:ButtonEvent = event as? ButtonEvent {
            switch event {
                case _ where event.assert(.down,plusButton) : onPlusButtonDown()
                case _ where event.assert(.down,minusButton) : onMinusButtonDown()
                case _ where event.assert(.upInside,plusButton) : onPlusButtonUpInside()
                case _ where event.assert(.upInside,minusButton) : onMinusButtonUpInside()
                case _ where event.assert(.up,minusButton) : onButtonUp()
                case _ where event.assert(.up,plusButton) : onButtonUp()
                default:break;
            }
        }
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
    //DEP
    init(_ width: CGFloat, _ height: CGFloat, _ value:CGFloat = 0, _ increment:CGFloat = 1, _ min:CGFloat = Int.min.cgFloat , _ max:CGFloat = Int.max.cgFloat, _ decimals:Int = 0, _ leverRange:CGFloat = 100, _ leverHeight:CGFloat = 200, _ parent: ElementKind? = nil, _ id: String? = nil) {
        self.initData.value = value
        self.initData.min = min
        self.initData.max = max
        self.initData.increment = increment
        self.initData.decimals = decimals
        self.initData.leverHeight = leverHeight
        self.initData.leverRange = leverRange
        super.init(width, height, parent, id)
    }
}
extension LeverStepper{
    static let defaultData:InitData = (value:0, increment:1, min:Int.min.cgFloat , max:Int.max.cgFloat, decimals:0, leverRange:100, leverHeight:200)
    typealias InitData = (value:CGFloat,increment:CGFloat,min:CGFloat,max:CGFloat,decimals:Int,leverRange:CGFloat,leverHeight:CGFloat)
    func createPlusButton() -> Button{
        return self.addSubView(Button(self.skinSize.h,self.skinSize.h,self,"plus"))
    }
    func createMinusButton() -> Button{
        return self.addSubView(Button(self.skinSize.h,self.skinSize.h,self, "minus"))
    }
}
