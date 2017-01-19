import Foundation
@testable import Utils

class StyleCache {}
/*Parser*/
extension StyleCache{
    /**
     * Compiles a list of css files derived from an xml
     */
    static func cssFileDateList(_ dataXML:XML)->[String:String]{
        var cssFileDates = [String:String]()
        let cssFileDatesXML = dataXML.firstNode("cssFileDates")
        cssFileDatesXML!.children?.forEach{
            let cssFilePath:String = $0.stringValue!
            //Swift.print("cssFilePath: " + "\(cssFilePath)")
            let date:String = ($0 as! XML)["date"]!
            //Swift.print("date: " + "\(date)")
            cssFileDates[cssFilePath] = date
        }
        return cssFileDates
    }
    /**
     * Compiles an xml of css files and its modified date
     */
    static func cssFileDates()->XML{
        let cssFileDates = "<cssFileDates></cssFileDates>".xml
        StyleManager.cssFileURLS.forEach{
            //Swift.print("$0: " + "\($0)")
            let filePath:String = $0.tildePath
            let modificationDate = FileParser.modificationDate(filePath)
            //Swift.print("modificationDate: " + "\(modificationDate)")
            //Swift.print("modificationDate.timeIntervalSince1970: " + "\(modificationDate.timeIntervalSince1970)")
            let cssFile = "<file></file>".xml
            cssFile["date"] = String(modificationDate.timeIntervalSince1970)
            cssFile.stringValue = $0
            cssFileDates.appendChild(cssFile)
        }
        return cssFileDates
    }
    /**
     * Read pre-parsed styles
     */
    static func readStylesFromDisk(_ xml:XML){
        //Swift.print("StyleCache.readStylesFromDisk()")
        let startTime = NSDate()
        var styles:[IStyle] = []
        //Swift.print("xml.children?.count: " + "\(xml.children?.count)")
        let stylesXML:XML = xml.firstNode("styles")!
        //Swift.print("stylesXML.children?.count: " + "\(stylesXML.children?.count)")
        stylesXML.children?.forEach{
            let style:Style? = Style.unWrap($0 as! XML)
            if(style != nil) {
                styles.append(style!)
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
