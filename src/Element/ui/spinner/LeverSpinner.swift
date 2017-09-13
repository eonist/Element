import Foundation
@testable import Utils
/**
 * NOTE: If you need to lever a value between 0 and 1 then set min:0, max:1, increment:0.01, decimal:2, leverRange:1,leverHeight:400
 * NOTE: The reason we dont extend the Stepper component is because the the Stepper component impliments RepeateButton, which LeverStepper doesnt, we could override creating the RepeateButtons but it would obfuscate this class a little, and its nice to have this class as simple as possible since we might need to create different steppers or even extend this class// :TODO: what about Not implimenting RepeatButton in Spinner then and make another class named RepeatStepper and RepeatSpinner?
 * TODO: ⚠️️ Maybe we should Extend Spinner and create an Interface for Spinnner named ISpinner that we can work with in a SpinnerModifier class which could handle setting text and input text and setting value And another class Named SpinnerParser which could handle retriving inputText, text and value etc, this would unclutter this class and it would be easier to modify and extend in the future that is the agenda!
 * TODO: ⚠️️ This should maybe be a decorator style pattern that wraps Stepper, then also make RepeatStepper ?
 * TODO: ⚠️️ You may need to convert CGFloat to an Int if decimal is set to 0, do this in the LeverSpinner class
 */
class LeverSpinner:Element{
    lazy var textInput:TextInput = createTextInput()
    lazy var stepper:LeverStepper = createStepper()
    var initData:LeverStepper.InitData
    var text:String
    init(initData:InitData = defaultData, text:String = "", size:CGSize = CGSize(NaN,NaN),id:String? = nil){
        self.initData = initData
        self.text = text
        super.init(size:size,id:id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        _ = textInput
        _ = stepper
    }
    func onStepperChange(_ event:StepperEvent) {
        initData.value = event.value
        textInput.inputTextArea.setTextValue(String(initData.value))
        self.event(SpinnerEvent(SpinnerEvent.change,self.initData.value,self,self))
    }
    /**
     * TODO: ⚠️️ Also resolve decimal here?
     */
    func onInputTextChange(_ event:Event) {
        let valStr:String = textInput.inputTextArea.text.getText()
        initData.value = NumberParser.minMax(valStr.cgFloat, initData.min, initData.max)
        stepper.initData.value = initData.value
        self.event(SpinnerEvent(SpinnerEvent.change,initData.value,self,self))
    }
    override func onEvent(_ event: Event) {
        if event.assert(StepperEvent.change, stepper){
            onStepperChange(event as! StepperEvent)
        }else if event.assert(Event.update, textInput.inputTextArea.text.textField){//You could use immediate here to shorten the if statement
            onInputTextChange(event)
        }
    }
    func setValue(_ value:CGFloat) {
        let value:CGFloat = NumberParser.minMax(value, initData.min, initData.max)
        initData.value = CGFloatModifier.toFixed(value,initData.decimals)
        textInput.inputTextArea.setTextValue(String(initData.value))
        stepper.initData.value = initData.value
    }
    override var skinState:String {
        get {return super.skinState}
        set {
            super.skinState = newValue
            textInput.skinState = newValue//⚠️️ I dont think this is correct
            stepper.skinState = newValue//⚠️️ I dont think this is correct
        }
    }
    /**
     * Returns "Spinner"
     * NOTE: This function is used to find the correct class type when synthezing the element stack
     */
    override func getClassType() -> String {
        return "\(Spinner.self)"
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    //dep
    init(_ width:CGFloat, _ height:CGFloat, _ text:String = "", _ value:CGFloat = 0, _ increment:CGFloat = 1, _ min:CGFloat = Int.min.cgFloat , _ max:CGFloat = Int.max.cgFloat, _ decimals:Int = 0, _ leverRange:CGFloat = 100, _ leverHeight:CGFloat = 200, _ parent:ElementKind? = nil, _ id:String? = nil) {
        self.text = text
        self.initData.value = value
        self.initData.min = min
        self.initData.max = max
        self.initData.increment = increment
        self.initData.decimals = decimals
        self.initData.leverHeight = leverHeight
        self.initData.leverRange = leverRange
        super.init(size:CGSize(width,height),id:id)
    }
}
extension LeverSpinner{
    static let defaultData:InitData = LeverStepper.defaultData
    typealias InitData = LeverStepper.InitData
    func createTextInput()-> TextInput{
        return self.addSubView(TextInput.init(text: text, inputText: initData.value.string, size: CGSize(100,20)))
    }
    func createStepper() -> LeverStepper{
        return self.addSubView(LeverStepper.init(initData: initData, size: CGSize(100,24)))
    }
}

class Spinner:Element{}//TODO: write an alias instead? Does that work?
