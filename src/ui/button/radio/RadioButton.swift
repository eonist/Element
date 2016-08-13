import Foundation
/**
 * TODO: impliment IDisableable also and extend DisableTextButton
 */
class RadioButton:TextButton,ISelectable{
    var radioBullet:RadioBullet?
    private var isSelected:Bool
    init(_ width:CGFloat, _ height:CGFloat, _ text:String = "defaultText", _ isSelected:Bool = false, _ parent:IElement? = nil, _ id:String? = nil) {
        self.isSelected = isSelected
        super.init(width,height,text,parent,id)
    }
    /**
     * @Note:when added to stage and if RadioBullet dispatches selct event it will bubble up and through this class (so no need for extra eventlistners and dispatchers in this class)
     * @Note the _radioBullet has an id of "radioBullet" (this may be usefull if you extend CheckBoxButton and that subclass has children that are of type Button and you want to identify this button and noth the others)
     */
    override func resolveSkin() {
        super.resolveSkin()
        radioBullet = addSubView(RadioBullet(NaN,NaN,isSelected,self))
    }
    func setSelected(isSelected:Bool) {
        radioBullet!.setSelected(isSelected)
    }
    /**
     * @Note this method represents something that should be handled by a method named getSelected, but since this class impliments ISelectable it has to implment selected and selectable
     */
    func getSelected()->Bool {
        return radioBullet != nil ? radioBullet!.getSelected() : isSelected;/*Temp fix*/
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}