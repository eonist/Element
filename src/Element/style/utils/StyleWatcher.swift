import Cocoa
@testable import Utils

class StyleWatcher {
    /**
     * IMPORTANT: StyleManger.addStylesByURL("",true)<--liveEdit flag must be true to use this watch feature
     */
    static func watch(_ folderURL:String,_ fileURL:String, _ view:NSView) /*-> FileWatcher*/{
        let fileWatcher = FileWatcher([folderURL.tildePath])
        fileWatcher.event = { event in
            //Swift.print(self)
            if(event.fileChange && FilePathParser.fileExtension(event.path) == "css") {//assert for .css file changes, so that .ds etc doesnt trigger events etc
                Swift.print(event.description)
                Swift.print("update to the file happened: " + "\(event.path)")
                StyleManager.addStylesByURL(fileURL,true)
                ElementModifier.refreshSkin(view as! IElement)
                ElementModifier.floatChildren(view)
            }
        }
        fileWatcher.start()
        //return fileWatcher
    }
}
