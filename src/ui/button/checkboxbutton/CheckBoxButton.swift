import Foundation
/**
 * TODO: Implement a way to also include the text in being in a checked status
 */
class CheckBoxButton : Button,ICheckable{
    private var isChecked:Bool
    var textString:String
    var checkBox : CheckBox?
    var text:Text?
    init(_ width:CGFloat, _ height:CGFloat, _ text:String = "defaultText", _ isChecked:Bool = false, _ parent:IElement? = nil, _ id:String? = nil) {
        self.textString = text
        self.isChecked = isChecked
        super.init(width,height,parent,id)
    }
    override func resolveSkin() {
        super.resolveSkin();
        checkBox = addSubView(CheckBox(13,13,isChecked,self))
        text = addSubView(Text(width,height,textString,self)) 
        text!.isInteractive = false
    }
    func setChecked(isChecked:Bool) {
        checkBox!.setChecked(isChecked)
    }
    override func onEvent(event: Event) {
        //Swift.print("CheckBoxButton.onEvent() type: " + "\(event.type)")
        super.onEvent(event)/*Forwards the event*/
    }
    /**
     * NOTE: this method represents something that should be handled by a method named getChecked, but since this class impliments Icheckable it has to implment checked and checkable
     */
    func getChecked() -> Bool {
        return checkBox != nil ? checkBox!.getChecked() : self.isChecked;/*<--Temp fix*/
    }
    override func getSkinState() -> String {
        return isChecked ? SkinStates.checked + " " + super.getSkinState() : super.getSkinState();
    }
    override func setSkinState(skinState:String) {
        //Swift.print("\(self.dynamicType)" + " setSkinState() skinState: " + "\(skinState)")
        super.setSkinState(skinState);
        text!.setSkinState(skinState);/*why is this set directly to the skin and not to the element?, Text doesnt have a setSkin method so i guess thats why?, well it does actually, through it super class Element, so fix this*/
    }
    func setSize(width : CGFloat, height : CGFloat) {
        super.setSize(width, height)
        checkBox!.setSkinState(checkBox!.skin!.state)
        text!.setSkinState(checkBox!.skin!.state)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}