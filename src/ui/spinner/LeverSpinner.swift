import Foundation
/**
 * // :TODO: Maybe we should Extend Spinner and create an Interface for Spinnner named ISpinner that we can work with in a SpinnerModifier class which could handle setting text and input text and setting value And another class Named SpinnerParser which could handle retriving inputText, text and value etc, this would unclutter this class and it would be easier to modify and extend in the future that is the agenda!
 * // :TODO: This should maybe be a decorator style pattern that wraps Stepper, then also make RepeatStepper ?
 * @Note if you need to lever a value between 0 and 1 then set min:0, max:1, increment:0.01, decimal:2, leverRange:1,leverHeight:400
 * @Note the reason we dont extend the Stepper component is because the the Stepper component impliments RepeateButton, which LeverStepper doesnt, we could override creating the RepeateButtons but it would obfuscate this class a little, and its nice to have this class as simple as possible since we might need to create different steppers or even extend this class// :TODO: what about Not implimenting RepeatButton in Spinner then and make another class named RepeatStepper and RepeatSpinner?
 * TODO: you may need to convert CGFloat to an Int if decimal is set to 0, do this in the LeverSpinner class
 */
class LeverSpinner : Element{
    private var maxVal:CGFloat
    private var minVal:CGFloat
    private var value:CGFloat;
    private var	increment:CGFloat;/*The amount of incrementation for each stepping*/
    private var decimals:Int;/*decimal places*/
    private var leverHeight:CGFloat;// :TODO: write a description about this value
    private var leverRange : CGFloat;
    
    var textInput:TextInput?
    var stepper:LeverStepper?
    
    override init(_ width: CGFloat, _ height: CGFloat, _ parent: IElement? = nil, _ id: String? = nil) {
        self.value = value
        self.minVal = min
        self.maxVal = max
        self.increment = increment
        self.decimals = decimals
        self.leverHeight = leverHeight// :TODO: rename to something less ambiguous
        self.leverRange = leverRange
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        textInput = addSubView(TextInput(100,20,"Value:","22",self)) as? TextInput
        stepper = addSubView(LeverStepper(100,24,0,1,CGFloat(Int.min),CGFloat(Int.max),0,100,200,self)) as? LeverStepper
    }
    /**
     * Returns "Spinner"
     * @Note This function is used to find the correct class type when synthezing the element stack
     */
    override func getClassType() -> String {
        return String(Spinner)
    }
    func onStepperChange(event : StepperEvent) {
        //			trace("LeverSpinner.onStepperChange.event.value: " + event.value);
        _value = event.value;
        _textInput.inputTextArea.setText(String(_value));
        dispatchEvent(new SpinnerEvent(SpinnerEvent.CHANGE,_value,true,true));
    }
    override func onEvent(event: Event) {
        //Swift.print( "CustomView.onEvent() event:" + "\(event)")
        if(event.origin === stepper && event.type == StepperEvent.change){
        //Swift.print("onStepperEvent() value: " + "\((event as! StepperEvent).value)")
        }
        
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
