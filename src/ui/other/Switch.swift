import Cocoa

class Switch:HSlider,ICheckable{
    private var isChecked:Bool = true
    override func createThumb() {
        thumb = addSubView(SwitchButton(thumbWidth, height,self))
        setProgressValue(progress)
    }
    override func onThumbMove(event:NSEvent) -> NSEvent{
        let event = super.onThumbMove(event: event)
        Swift.print("progress: " + "\(progress)")
        /*if(progress < 0.5 && isChecked){
            setChecked(false)//set disable
        }else if(progress > 0.5 && !isChecked){
            setChecked(true)//set enable
        }*/
        let style:IStyle = StyleModifier.clone(skin!.style!,skin!.style!.name)/*we clone the style so other Element instances doesnt get their style changed aswell*/// :TODO: this wont do if the skin state changes, therefor we need something similar to DisplayObjectSkin
        //StyleParser.describe(style)
        var styleProperty = style.getStyleProperty("fill") /*edits the style*/
        //Swift.print("styleProperty: " + "\(styleProperty)")
        //Swift.print("color.hex: " + "\(color.hexString)")
        if(styleProperty != nil){//temp
            let green:NSColor = NSColorParser.nsColor(UInt(0x39D149))
            let color:NSColor = NSColor.white.blended(withFraction: progress, of: green)!
            styleProperty!.value = color
            skin!.setStyle(style)/*updates the skin*/
        }
        
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
