import Foundation

class Switch:HSlider,ICheckable{
    private var isChecked:Bool = true
    override func createThumb() {
        thumb = addSubView(SwitchButton(thumbWidth, height,self))
        setProgressValue(progress)
    }
    
    override func onThumbMove(event:NSEvent)-> NSEvent?{
        super.onEvent(SliderEvent(SliderEvent.change,progress,self))
        return event
    }
    
    /**
     * Sets the self.isChecked variable (Toggles between two states)
     */
    func setChecked(_ isChecked:Bool) {
        self.isChecked = isChecked
        setSkinState(getSkinState())
    }
    func getChecked() -> Bool {
        return isChecked
    }
    override func getSkinState() -> String {
        return isChecked ? SkinStates.checked + " " + super.getSkinState() : super.getSkinState()
    }
}
class SwitchButton:Button{
    override func getClassType() -> String {
        return "\(Button.self)"
    }
}
