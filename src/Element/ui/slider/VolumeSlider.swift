import Cocoa
@testable import Utils

class VolumeSlider:HSlider{
    lazy var volumeGraphic:Element = Element(1,1,self,"volumeGraphic")//lazy so that its only created once, and we don't have to implement init
    override func resolveSkin() {
        super.resolveSkin()
        volumeGraphic = addSubViewAt(volumeGraphic,self.indexOf(thumb!))//TODO: add the volume graphic bellow the thumb
    }
    override func onMouseMove(event: NSEvent) -> NSEvent? {
        volumeGraphic.setSize(thumb!.x+thumb!.width/2, getHeight())//TODO: this should be set after super
        return super.onMouseMove(event: event)
    }
    override func onThumbMove(event: NSEvent) -> NSEvent {
        volumeGraphic.setSize(thumb!.x+thumb!.width/2, getHeight())//TODO: this should be set after super
        return super.onThumbMove(event: event)
    }
    override func setProgressValue(_ progress: CGFloat) {
        super.setProgressValue(progress)
        volumeGraphic.setSize(thumb!.x+thumb!.width/2, getHeight())
    }
    override func setSize(_ width: CGFloat, _ height: CGFloat) {
        super.setSize(width,height)
        volumeGraphic.setSize(thumb!.x+thumb!.width/2, getHeight())
    }
}
