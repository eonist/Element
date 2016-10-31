import Cocoa

class VolumeSlider:HSlider{
    lazy var volumeGraphic:Element = Element(1,1,self,"volumeGraphic")
    override func resolveSkin() {
        super.resolveSkin()
        volumeGraphic = addSubViewAt(volumeGraphic,self.indexOf(thumb!))//add the volume graphic bellow the thumb
    }
    override func onMouseMove(event: NSEvent) -> NSEvent? {
        volumeGraphic.setSize(thumb!.x+thumb!.width/2, getHeight())//this should be set after super
        return super.onMouseMove(event)
    }
    override func onThumbMove(event: NSEvent) -> NSEvent? {
        Swift.print("VolumeSlider.onThumbMove")
        volumeGraphic.setSize(thumb!.x+thumb!.width/2, getHeight())//this should be set after super
        return super.onThumbMove(event)
    }
    override func setProgressValue(progress: CGFloat) {
        super.setProgressValue(progress)
        volumeGraphic.setSize(thumb!.x+thumb!.width/2, getHeight())
    }
    override func setSize(width: CGFloat, _ height: CGFloat) {
        super.setSize(width,height)
        volumeGraphic.setSize(thumb!.x+thumb!.width/2, getHeight())
    }
}