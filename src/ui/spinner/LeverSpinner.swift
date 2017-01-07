import Foundation
/**
 * TODO: Maybe we should Extend Spinner and create an Interface for Spinnner named ISpinner that we can work with in a SpinnerModifier class which could handle setting text and input text and setting value And another class Named SpinnerParser which could handle retriving inputText, text and value etc, this would unclutter this class and it would be easier to modify and extend in the future that is the agenda!
 * TODO: This should maybe be a decorator style pattern that wraps Stepper, then also make RepeatStepper ?
 * NOTE: if you need to lever a value between 0 and 1 then set min:0, max:1, increment:0.01, decimal:2, leverRange:1,leverHeight:400
 * NOTE: the reason we dont extend the Stepper component is because the the Stepper component impliments RepeateButton, which LeverStepper doesnt, we could override creating the RepeateButtons but it would obfuscate this class a little, and its nice to have this class as simple as possible since we might need to create different steppers or even extend this class// :TODO: what about Not implimenting RepeatButton in Spinner then and make another class named RepeatStepper and RepeatSpinner?
 * TODO: you may need to convert CGFloat to an Int if decimal is set to 0, do this in the LeverSpinner class
 */
class LeverSpinner:Element{
    var maxVal:CGFloat
    var minVal:CGFloat
    var val:CGFloat
    var	increment:CGFloat/*<--The amount of incrementation for each stepping*/
    var decimals:Int/*<--Decimal places*/
    var text:String
    var leverHeight:CGFloat//TODO: write a description about this value
    var leverRange:CGFloat
    var textInput:TextInput?
    var stepper:LeverStepper?
    init(_ width: CGFloat, _ height: CGFloat, _ text:String = "", _ value:CGFloat = 0, _ increment:CGFloat = 1, _ min:CGFloat = CGFloat.min , _ max:CGFloat = CGFloat.max, _ decimals:Int = 0, _ leverRange:CGFloat = 100, _ leverHeight:CGFloat = 200, _ parent: IElement? = nil, _ id: String? = nil) {
        self.val = value
        self.text = text
        self.minVal = min
        self.maxVal = max
        self.increment = increment
        self.decimals = decimals
        self.leverHeight = leverHeight//TODO: rename to something less ambiguous
        self.leverRange = leverRange
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        textInput = addSubView(TextInput(100,20,text,String(val),self))
        stepper = addSubView(LeverStepper(100,24,val,increment,minVal,maxVal,decimals,leverRange,leverHeight,self))
    }
    func onStepperChange(event:StepperEvent) {
        val = event.value
        textInput!.inputTextArea?.setTextValue(String(val))
        self.event!(SpinnerEvent(SpinnerEvent.change,self.val,self,self))
    }
    /**
     * //TODO: Also resolve decimal here?
     */
    func onInputTextChange(event:Event) {
        let valStr:String = textInput!.inputTextArea!.text!.getText()
        val = NumberParser.minMax(valStr.cgFloat, minVal, maxVal)
        stepper!.value = val
        self.event!(SpinnerEvent(SpinnerEvent.change,self.val,self,self))
    }
    override func onEvent(event: Event) {
        if(event.assert(StepperEvent.change, stepper)){
            onStepperChange(event as! StepperEvent)
        }else if(event.assert(Event.update, textInput!.inputTextArea!.text!.textField)){//You could use immediate here to shorten the if statement
            onInputTextChange(event)
        }
    }
    func setValue(var value:CGFloat) {
        value = NumberParser.minMax(value, minVal, maxVal)
        self.val = NumberModifier.toFixed(value,decimals)
        textInput!.inputTextArea?.setTextValue(String(self.val))
        stepper!.value = self.val
    }
    override func setSkinState(skinState:String) {
        super.setSkinState(skinState)
        textInput!.setSkinState(skinState)
        stepper!.setSkinState(skinState)
    }
    /**
     * Returns "Spinner"
     * NOTE: This function is used to find the correct class type when synthezing the element stack
     */
    override func getClassType() -> String {
        return String(Spinner)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}