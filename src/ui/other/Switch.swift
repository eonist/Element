import Foundation

class Switch:VolumeSlider,ICheckable{
    private var isChecked:Bool = false
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
    /*override func getClassType() -> String {
     return "\(VolumeSlider.self)"//borrow the VolumSlider look for now
     }*/
}
