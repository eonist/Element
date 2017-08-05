import Foundation
@testable import Utils

class StyleCache {}
/*Parser*/
extension StyleCache{
    static let defaultXML:String = "<data><cssFileDates></cssFileDates><styles></styles></data>"
    /**
     * Compiles a list of css files derived from an xml
     * TODO: ⚠️️ return tuple instead
     */
    static func cssFilesAndDates(_ dataXML:XML)->[String:String]{
        guard let cssFileDatesXML:XML = dataXML.firstNode("cssFileDates"), let children = cssFileDatesXML.children else{
            return [String:String]()
        }
        let filesAndDates:[String:String] = children.reduce([String:String]()){
            var cssFileDates:[String:String] = $0
            let cssFilePath:String = $1.stringValue!
            let date:String = ($1 as! XML)["date"]!
            cssFileDates[cssFilePath] = date
            return cssFileDates
        }
        return filesAndDates
        
    }
    /**
     * Compiles an xml of css files and its modified date
     */
    static func cssFileDates()->XML{
        return StyleManager.cssFileURLS.reduce("<cssFileDates></cssFileDates>".xml){
            let absoluteURL = $1.tildePath//make it absolute: /Users/John/..
            let normalizedURL = FilePathModifier.normalize(absoluteURL) //no more backlash syntax like ../../
            let modificationDate = FileParser.modificationDate(normalizedURL)
            let cssFile = "<file></file>".xml
            cssFile["date"] = String(modificationDate.timeIntervalSince1970)
            let filePath:String = normalizedURL.tildify//make it user agnostic like ~/Desktop...
//            Swift.print("filePath: " + "\(filePath)")
            cssFile.stringValue = filePath
            $0.appendChild(cssFile)
            return $0
        }
    }
    /**
     * Read pre-parsed styles
     */
    static func readStylesFromXML(_ xml:XML) -> [IStyle]{
        //Swift.print("💾 StyleCache.readStylesFromDisk()")
        return testPerformance("parse xml styles time") {//then try to measure the time of resolving all selectors
            let stylesXML:XML = xml.firstNode("styles")!
            let styles:[IStyle] = stylesXML.children?.lazy.map{ child -> IStyle? in
                Style.unWrap(child as! XML)
                }.flatMap{$0} ?? []
            return styles
        }
    }
}
/*Asserter*/
extension StyleCache{
    /**
     * Asserts if the cssFiles that are cached have the same modified date as the cssFile that are querried
     */
    static func isUpToDate(_ cssFileDateList:[String:String])->Bool{
//        Swift.print("isUpToDate count" + "\(cssFileDateList.count)")
        for (filePath,date) in cssFileDateList{
            let filePath:String = filePath
            guard FileAsserter.exists(filePath.tildePath) else {return false}//if the file doesnt exist anymore, then its not upToDate
            let modificationDate:String = String(FileParser.modificationDate(filePath.tildePath).timeIntervalSince1970)
            let cachedModificationDate:String = date
            if cachedModificationDate != modificationDate {return false}
        }
        return true
    }
    /**
     * Asserts if files has been caches
     */
    static func hasFileBeenCached(_ cssFileDateList:[String:String], _ filePath:String)->Bool{
        return cssFileDateList.first(where: {$0.0 == filePath}) != nil//functional programming 🎉
    }
    /**
     * PARAM:stylesURL: absolute path to root styles css file
     */
    static func cacheXML(cacheURL:String,stylesURL:String) -> XML?{
        /*1. Assert if the styles.xml exists and if it has content*/
        Swift.print("cacheURL: " + "\(cacheURL)")
        let xmlFileExists:Bool = FileAsserter.exists(cacheURL)
        //Swift.print("xmlExists: " + "\(stylesXMLExists)")
        if !xmlFileExists {/*Create a new styles.xml if non exists*/
            _ = FileModifier.write(cacheURL, defaultXML)
        }
        let xml:XML = FileParser.xml(cacheURL)
        let cssFilesAndDates = StyleCache.cssFilesAndDates(xml)
        /*2. assert if the query url has been cached and assert if the cached css files are all up to date*/
        let hasURLBeenCached:Bool = StyleCache.hasFileBeenCached(cssFilesAndDates, stylesURL.tildify)
        Swift.print("hasURLBeenCached: " + "\(hasURLBeenCached ? "✅" : "🚫")")
        let isUpToDate = hasURLBeenCached && StyleCache.isUpToDate(cssFilesAndDates)//something must have been cached in order for 
        Swift.print("isUpToDate: " + "\(isUpToDate ?  "✅" : "🚫" )")
        if hasURLBeenCached && isUpToDate {/*if true then: read the styles from the xml*/
            return xml
        }else {
            return nil
        }
    }
    /**
     * A. Reads styles from cache
     * B. or creates new cache and reads from css and stores it in cache
     * IMPORTANT: ⚠️️ the styles.xml file in bundle isn't written to, it's the styles.xml inside the .app file that is beeing written to
     */
    static func styles(_ stylesURL:String,cacheURL:String = StyleManager.cacheURL) -> [IStyle]{
        Swift.print("StyleCache.styles() cacheURL: " + "\(cacheURL)")
        if let xml:XML = StyleCache.cacheXML(cacheURL:cacheURL, stylesURL:stylesURL) {
            let styles = StyleCache.readStylesFromXML(xml)/*Super fast loading of cached styles*/
            return testPerformance("StyleManager.addStyle time:") {//then try to measure the time of resolving all selectors
                Swift.print("styles.count: " + "\(styles.count)")
                return styles
            }
        }else {/*Else read and parse styles from the .css files and write a new cache to styles.xml*/
            let styles:[IStyle] = testPerformance ("Adding css styles time: "){/*performance test*/
                let cssString:String = CSSFileParser.cssString(stylesURL)/*This takes a few secs, basic.css takes around 4sec*/
                return StyleManagerUtils.styles(cssString,removeComments:false)/*<--we already removed comments so no need to do it again*/
            }
            StyleCache.save(styles,to:cacheURL)
            return styles
        }
    }
}
/*Modifier*/
extension StyleCache{
    /**
     * Store the styles as xml for faster load times
     * PARAM: filePath: "~/Desktop/styles.xml".tildePath
     */
    static func save(_ styles:[IStyle],to filePath:String){
        Swift.print("writeStylesToDisk filePath: " + "\(filePath)")
        let data:XML = "<data></data>".xml
        
        let cssFileDates:XML = StyleCache.cssFileDates()
        data.appendChild(cssFileDates)
        let styles:XML = styles.reduce("<styles></styles>".xml){
            let xml = Reflection.toXML($1)
            $0.appendChild(xml)
            return $0
        }
        data.appendChild(styles)
        //Swift.print("data.xmlString: " + "\(data.xmlString)")
        let contentToWriteToDisk = data.xmlString
        _ = FileModifier.write(filePath, contentToWriteToDisk)
    }
}


