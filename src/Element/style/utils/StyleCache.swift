import Foundation
@testable import Utils

class StyleCache {}
/*Parser*/
extension StyleCache{
    static let defaultXML:String = {
        let xmlString = "<data><cssFileDates></cssFileDates><styles></styles></data>"
        let prettyXMLString = XMLParser.prettyString(xmlString.xml)
        return prettyXMLString
    }()
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
    static func readStylesFromXML(_ xml:XML) -> [Stylable]{
        //Swift.print("💾 StyleCache.readStylesFromDisk()")
        return testPerformance("parse xml styles time") {//then try to measure the time of resolving all selectors
            let stylesXML:XML = xml.firstNode("styles")!
            let styles:[Stylable] = stylesXML.children?.lazy.map{ child -> Stylable? in
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
    private static func hasFileBeenCached(_ cssFileDateList:[String:String], _ filePath:String)->Bool{
        return cssFileDateList.first(where: {$0.0 == filePath}) != nil//functional programming 🎉
    }
    /**
     * PARAM:stylesURL: absolute path to root styles css file
     */
    static func cacheXML(cacheURL:String,stylesURL:String) throws -> XML{
        let xmlFileExists:Bool = FileAsserter.exists(cacheURL)/*Assert if the styles.xml exists and if it has content*/
        debug("xmlFileExists", xmlFileExists)
        if !xmlFileExists {/*Create a new styles.xml if non exists*/
            _ = FileModifier.write(cacheURL, defaultXML)
        }
        let xml:XML = FileParser.xml(cacheURL)//load the xml
        let cssFilesAndDates:[String:String] = StyleCache.cssFilesAndDates(xml)//file urls + date of last refresh of the file
        Swift.print("cssFilesAndDates.count: " + "\(cssFilesAndDates.count)")
        Swift.print("stylesURL.tildify: " + "\(stylesURL.tildify)")
        let hasURLBeenCached:Bool = StyleCache.hasFileBeenCached(cssFilesAndDates, stylesURL.tildify)/*2. assert if the query url has been cached and assert if the cached css files are all up to date*/
        debug("hasURLBeenCached",hasURLBeenCached)
        let isUpToDate = hasURLBeenCached && StyleCache.isUpToDate(cssFilesAndDates)//something must have been cached in order to check against cache
        debug("isUpToDate",isUpToDate)
        guard hasURLBeenCached && isUpToDate else {/*if true then: read the styles from the xml*/
            throw "hasURLBeenCached : \(hasURLBeenCached) isUpToDate: \(isUpToDate)"
        }
        return xml
    }
    /**
     * A. Reads styles from cache
     * B. or creates new cache and reads from css and stores it in cache
     * IMPORTANT: ⚠️️ the styles.xml file in bundle isn't written to, it's the styles.xml inside the .app file that is beeing written to
     */
    static func styles(stylesURL:String,cacheURL:String)  -> [Stylable]?{
//       Swift.print("StyleCache.styles() cacheURL: " + "\(cacheURL.tildify)")
        if let xml:XML = try? StyleCache.cacheXML(cacheURL:cacheURL, stylesURL:stylesURL) {
            let styles = StyleCache.readStylesFromXML(xml)/*Super fast loading of cached styles*/
            return testPerformance("StyleManager.addStyle time:") {//then try to measure the time of resolving all selectors
//                Swift.print("StyleCache.styles.count: " + "\(styles.count)")
                return styles
            }
        }
        return nil
    }
}
/*Modifier*/
extension StyleCache{
    /**
     * Store the styles as xml for faster load times
     * PARAM: filePath: "~/Desktop/styles.xml".tildePath
     */
    static func save(_ styles:[Stylable],to filePath:String){
//      Swift.print("writeStylesToDisk filePath: " + "\(filePath)")
        let xml:XML = "<data></data>".xml
        let cssFileDates:XML = StyleCache.cssFileDates()
        xml.appendChild(cssFileDates)
        let styles:XML = styles.reduce("<styles></styles>".xml){
            let xml = Reflect.toXML($1)
            $0.appendChild(xml)
            return $0
        }
        xml.appendChild(styles)
        //Swift.print("data.xmlString: " + "\(data.xmlString)")
        let contentToWriteToDisk = xml.prettyStr
        _ = FileModifier.write(filePath, contentToWriteToDisk)
    }
}
