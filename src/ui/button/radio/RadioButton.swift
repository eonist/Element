import Foundation

class RadioButton:SelectButton,ISelectable{// :TODO: impliment IDisableable also and extend DisableTextButton
    var radioBullet:RadioBullet
    var isSelected:Bool
    init(width:CGFloat, height:CGFloat, isFocused:Boolean = false, isDisabled:Boolean = false,text:String = "defaultText", isSelected:Bool? = false, parent:IElement? = nil, id:String? = nil) {
        _isSelected = isSelected;
        super(width,height,isFocused, isDisabled,text,parent,id,classId);
    }
    /**
     * @Note:when added to stage and if RadioBullet dispatches selct event it will bubble up and through this class (so no need for extra eventlistners and dispatchers in this class)
     * @Note the _radioBullet has an id of "radioBullet" (this may be usefull if you extend CheckBoxButton and that subclass has children that are of type Button and you want to identify this button and noth the others)
     */
    override func resolveSkin() {
        super.resolveSkin();
        radioBullet = addChild(RadioBullet(super.width,super.height,false,false,_isSelected,this)) as RadioBullet;
    }
    //----------------------------------
    //  implicit getters / setters
    //----------------------------------
    override func setSelected(isSelected:Bool) {
        _radioBullet.setSelected(isSelected);
    }
    //----------------------------------
    //  getters / setters
    //----------------------------------
    /**
     * @Note this method represents something that should be handled by a method named getSelected, but since this class impliments ISelectable it has to implment selected and selectable
     */
    func getSelected()->Bool {
        return radioBullet != nil ? radioBullet.selected : isSelected;/*Temp fix*/
    }
}

