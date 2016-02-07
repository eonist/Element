import Foundation
/**
 * // :TODO: Maybe we should Extend Spinner and create an Interface for Spinnner named ISpinner that we can work with in a SpinnerModifier class which could handle setting text and input text and setting value And another class Named SpinnerParser which could handle retriving inputText, text and value etc, this would unclutter this class and it would be easier to modify and extend in the future that is the agenda!
 * // :TODO: This should maybe be a decorator style pattern that wraps Stepper, then also make RepeatStepper ?
 * @Note if you need to lever a value between 0 and 1 then set min:0, max:1, increment:0.01, decimal:2, leverRange:1,leverHeight:400
 * @Note the reason we dont extend the Stepper component is because the the Stepper component impliments RepeateButton, which LeverStepper doesnt, we could override creating the RepeateButtons but it would obfuscate this class a little, and its nice to have this class as simple as possible since we might need to create different steppers or even extend this class// :TODO: what about Not implimenting RepeatButton in Spinner then and make another class named RepeatStepper and RepeatSpinner?
 */
class LeverSpinner : Element{
    var textInput:TextInput?
    var stepper:LeverStepper?
    override init(_ width: CGFloat, _ height: CGFloat, _ parent: IElement? = nil, _ id: String? = nil) {
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        textInput = Text(100,20,"Hello world",self)
        addSubview(self.text)
        text.isInteractive = false
        
        stepper = addSubView(LeverStepper(100,24,self)) as! LeverStepper
        
    }
    /**
     * Returns "Spinner"
     * @Note This function is used to find the correct class type when synthezing the element stack
     */
    override func getClassType() -> String {
        return String(Spinner)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
