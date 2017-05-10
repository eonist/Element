import Foundation
@testable import Utils

class StyleCache {}
/*Parser*/
extension StyleCache{
    /**
     * Compiles a list of css files derived from an xml
     */
    static func cssFileDateList(_ dataXML:XML)->[String:String]{
        guard let cssFileDatesXML:XML = dataXML.firstNode("cssFileDates"), let children = cssFileDatesXML.children else{
            return [String:String]()
        }
        let cssFileDates:[String:String] = children.reduce([String:String]()){
            var cssFileDates:[String:String] = $0
            let cssFilePath:String = $1.stringValue!
            let date:String = ($1 as! XML)["date"]!
            cssFileDates[cssFilePath] = date
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
    static func readStylesFromXML(_ xml:XML){
        //Swift.print("💾 StyleCache.readStylesFromDisk()")
        let startTime = NSDate()
        let stylesXML:XML = xml.firstNode("styles")!
        let styles:[IStyle] = stylesXML.children?.lazy.map{ child -> IStyle? in
            Style.unWrap(child as! XML)
        }.flatMap{$0} ?? []
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
        cssFileDateList.forEach{ filePath,date in
            let filePath:String = filePath
            let modificationDate:String = String(FileParser.modificationDate(filePath.tildePath).timeIntervalSince1970)
            let cachedModificationDate:String = date
            if(cachedModificationDate != modificationDate){return false}
        }
        return true
    }
    /**
     * Asserts if files has been caches, looks a bit buggy
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
        let styles:XML = StyleManager.styles.reduce("<styles></styles>".xml){
            let xml = Reflection.toXML($1)
            $0.appendChild(xml)
            return $0
        }
        data.appendChild(styles)
        let contentToWriteToDisk = data.xmlString
        _ = FileModifier.write("~/Desktop/styles.xml".tildePath, contentToWriteToDisk)
    }
}
