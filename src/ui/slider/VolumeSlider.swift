import Cocoa

class VolumeSlider:HSlider{
    lazy var volumeGraphic:Element = Element(1,1,self,"volumeGraphic")
    override func resolveSkin() {
        //add the volume graphic before the thumb is added
        super.resolveSkin()
        volumeGraphic = addSubView(volumeGraphic)
    }
    override func onMouseMove(event: NSEvent) -> NSEvent? {
        volumeGraphic.setSize(thumb!.x, getHeight())//this should be set after super
        return super.onMouseMove(event)
    }
    override func onThumbMove(event: NSEvent) -> NSEvent? {
        volumeGraphic.setSize(thumb!.x, height)//this should be set after super
        return super.onThumbMove(event)
    }
    override func setProgressValue(progress: CGFloat) {
        
        super.setProgressValue(progress)
        volumeGraphic.setSize(thumb!.x, height)
    }
    override func setSize(width: CGFloat, _ height: CGFloat) {
        //setSize
        super.setSize(width,height)
        volumeGraphic.setSize(thumb!.x, height)
    }
}