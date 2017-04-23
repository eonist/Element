import Foundation
@testable import Utils

class StyleCache {}
/*Parser*/
extension StyleCache{
    /**
     * Compiles a list of css files derived from an xml
     */
    static func cssFileDateList(_ dataXML:XML)->[String:String]{
        let cssFileDates = [String:String]()
        if let cssFileDatesXML:XML = dataXML.firstNode("cssFileDates"), let children = cssFileDatesXML.children{
            let cssFileDates:[String:String] = children.reduce(cssFileDates){
                var cssFileDates:[String:String] = $0
                let cssFilePath:String = $1.stringValue!
                let date:String = ($1 as! XML)["date"]!
                cssFileDates[cssFilePath] = date
                return cssFileDates
            }
            return cssFileDates
        }
        return cssFileDates
    }
    /**
     * Compiles an xml of css files and its modified date
     */
    static func cssFileDates()->XML{
        return StyleManager.cssFileURLS.reduce("<cssFileDates></cssFileDates>".xml){
            let filePath:String = $1.tildePath
            let modificationDate = FileParser.modificationDate(filePath)
            let cssFile = "<file></file>".xml
            cssFile["date"] = String(modificationDate.timeIntervalSince1970)
            cssFile.stringValue = $1
            $0.appendChild(cssFile)
            return $0
        }
    }
    /**
     * Read pre-parsed styles
     */
    static func readStylesFromDisk(_ xml:XML){
        //Swift.print("StyleCache.readStylesFromDisk()")
        let startTime = NSDate()
        // = []
        //Swift.print("xml.children?.count: " + "\(xml.children?.count)")
        let stylesXML:XML = xml.firstNode("styles")!
        //Swift.print("stylesXML.children?.count: " + "\(stylesXML.children?.count)")
        let styles:[IStyle] = stylesXML.children!.map{
            let style:Style? = Style.unWrap($0 as! XML)
            return style
        }.filter{
            
            if(style != nil) {
                return
            }
        }
        //Swift.print("styles.count: " + "\(styles.count)")//then check the count
        Swift.print("parse xml styles time: " + "\(abs(startTime.timeIntervalSinceNow))")//then try to measure the time of resolving all selectors
        let startTime2 = NSDate()
        Swift.print("styles.count: " + "\(styles.count)")
        StyleManager.addStyle(styles)
        Swift.print("addStyle time: " + "\(abs(startTime2.timeIntervalSinceNow))")//then try to measure the time of resolving all selectors
    }
}
/*Asserter*/
extension StyleCache{
    /**
     * Asserts if the cssFiles that are cached have the same modified date as the cssFile that are querried
     */
    static func isUpToDate(_ cssFileDateList:[String:String])->Bool{
        for (filePath,date) in cssFileDateList{
            let filePath:String = filePath
            let modificationDate:String = String(FileParser.modificationDate(filePath.tildePath).timeIntervalSince1970)
            let cachedModificationDate:String = date
            if(cachedModificationDate != modificationDate){return false}
        }
        return true
    }
    /**
     *
     */
    static func hasFileBeenCached(_ cssFileDateList:[String:String], _ filePath:String)->Bool{
        var hasBeenCached:Bool = false
        cssFileDateList.forEach{
            if($0.0 == filePath){
                hasBeenCached = true
            }
        }
        return hasBeenCached
    }
}
/*Modifier*/
extension StyleCache{
    /**
     * Store the styles as xml for faster load times
     */
    static func writeStylesToDisk(){
        let data:XML = "<data></data>".xml
        let cssFileDates:XML = StyleCache.cssFileDates()
        data.appendChild(cssFileDates)
        let styles:XML = "<styles></styles>".xml
        //Swift.print("StyleManager.styles.count: " + "\(StyleManager.styles.count)")
        StyleManager.styles.forEach{
            let xml = Reflection.toXML($0)
            styles.appendChild(xml)
            //Swift.print("xml.XMLString: " + "\(xml.xmlString)")
        }
        data.appendChild(styles)
        let contentToWriteToDisk = data.xmlString
        _ = FileModifier.write("~/Desktop/styles.xml".tildePath, contentToWriteToDisk)
    }
}
