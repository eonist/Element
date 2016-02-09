import Cocoa
/**
 * // :TODO: shouldnt this class extend Stepper?
 */
class LeverStepper : Element{
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
    
    func onPlusButtonDown(event:ButtonEvent) {
        _onMouseDownMouseY  = (event.currentTarget as DisplayObject).mouseY;
        _onMouseDownValue = _value;
        plusButton.stage.addEventListener(ButtonEvent.RELEASE_OUTSIDE, onPlusButtonReleaseOutside);
        plusButton.stage.addEventListener(MouseEvent.MOUSE_MOVE, onButtonMove);
    }
    func onMinusButtonDown(event:ButtonEvent) {
        _onMouseDownMouseY  = (event.currentTarget as DisplayObject).mouseY;
        _onMouseDownValue = _value;
        minusButton.stage.addEventListener(ButtonEvent.RELEASE_OUTSIDE, onMinusButtonReleaseOutside);
        minusButton.stage.addEventListener(MouseEvent.MOUSE_MOVE, onButtonMove);
    }
    func onPlusButtonReleaseOutside(event:ButtonEvent) {
        plusButton.stage.removeEventListener(ButtonEvent.RELEASE_OUTSIDE, onPlusButtonReleaseOutside);
        plusButton.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onButtonMove);
    }
    func onMinusButtonReleaseOutside(event:ButtonEvent) {
        minusButton.stage.removeEventListener(ButtonEvent.RELEASE_OUTSIDE, onMinusButtonReleaseOutside);
        minusButton.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onButtonMove);
    }
    func onPlusButtonRelease(event:ButtonEvent) {
        plusButton.stage.removeEventListener(ButtonEvent.RELEASE_INSIDE, onPlusButtonRelease);
        plusButton.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onButtonMove);
        var value:Number = NumberModifier.increment(_value, _increment);
        _value = NumberParser.minMax(value, _min, _max);// :TODO: dont set the value 
        dispatchEvent(new StepperEvent(StepperEvent.CHANGE,_value));
    }
    func onMinusButtonRelease(event:ButtonEvent):void {
        minusButton.stage.removeEventListener(ButtonEvent.RELEASE_INSIDE, onMinusButtonRelease);
        minusButton.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onButtonMove);
        var value:Number = NumberModifier.decrement(_value, _increment);
        _value = NumberParser.minMax(value, _min, _max);
        dispatchEvent(new StepperEvent(StepperEvent.CHANGE,_value));
    }
    func onButtonMove(event:MouseEvent):void {
        var leaverPos:Number = -_minusButton.mouseY + _onMouseDownMouseY;
        leaverPos = NumberParser.minMax(leaverPos, -_leverHeight, _leverHeight);
        var multiplier:Number = leaverPos / _leverHeight;
        var leaverValue:Number =_leverRange * multiplier;/*the lever value fluctuates, sometimes with decimals so we round it*/
        var value:Number = _onMouseDownValue + leaverValue;
        value = NumberParser.minMax(value, _min, _max);/*cap the value from min to max*/
        value = Number(value.toFixed(_decimals));/*the value must have no more than the value of the _decimals*/
        _value = value;
        dispatchEvent(new StepperEvent(StepperEvent.CHANGE,_value));
    }
    /*
     *
     */
    override func onEvent(event: Event) {
        if(event.origin === plusButton && event.type == ButtonEvent.down){onPlusButtonDown()}
        else if(event.origin === minusButton && event.type == ButtonEvent.down){onMinusButtonDown()}
        else if(event.origin === plusButton && event.type == ButtonEvent.upInside){onPlusButtonUpInside()}
        else if(event.origin === minusButton && event.type == ButtonEvent.upInside){onMinusButtonUpInside()}
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