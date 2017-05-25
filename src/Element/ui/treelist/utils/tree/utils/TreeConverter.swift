import Foundation
@testable import Utils
/**
 * Tree -> XML
 * XML -> Tree
 * JSON -> Tree
 */
class TreeConverter {
    /**
     * Convert xml to Tree-struture
     * EXAMPLE: "<item title=\"New folder\" isOpen=\"false\" hasChildren=\"true\"></item>".xml
     * EXAMPLE: TreeConverter.tree(a.xml) Output: Tree("item", nil, [], ["isOpen": "false", "title": "New folder", "hasChildren": "true"])
     */
    static func tree(_ xml:XML) -> Tree{
        var tree:Tree = Tree()
        //let count = xml.children!.count//or use rootElement.childCount TODO: test this
        func apply(_ item: inout Tree,_ child:XML){
            item.name = child.name
            let attribs:[String:String] = child.attribs
            //Swift.print("attribs.isEmpty: " + "\(attribs.isEmpty)")
            if(!attribs.isEmpty){
                item.props = attribs
            }
            if let content = child.stringValue, content.count > 0 {
                item.content = content
            }else if(child.hasComplexContent) {
                child.children?.forEach{
                    let subChild:XML = $0 as! XML
                    let subItem = TreeConverter.tree(subChild)
                    item.add(subItem)//this line makes it recusive
                }
                //_ = item.children += TreeConverter.tree(child).children
            }
        }
        apply(&tree,xml)
        return tree
    }
    /**
     * Converts Tree to XML
     */
    static func xml(_ tree:Tree) -> XML{
        /**
         * Array types
         */
        //Swift.print("handleArray: " + "name \(name)" + " $0.value: \(value)" )
        func toXML(_ tree:Tree)->XML{
            let xml = XML()
            xml.name = tree.name
            if(tree.content != nil){xml.stringValue = tree.content}
            if(tree.props != nil){xml.setAttributesWith(tree.props!)}
            return xml
        }
        
        let xml:XML = toXML(tree)
        tree.children.forEach{ child in/*This can be a single .map method*/
            let childXML:XML = TreeConverter.xml(child)
            xml += childXML
        }
        return xml
    }
    /**
     * Converts json to tree stucture
     */
    static func tree(_ json:Any?) -> Tree {
        //Swift.print("CustomTree.tree")
        var child = Tree()
        if let dict = JSONParser.dict(json) {
            //Swift.print("Dict.count: " + "\(dict.count)")
            dict.forEach { key,value in
                if let str = JSONParser.str(value){
                    child.props?[key] = str
                }else if let int = JSONParser.int(value){
                    child.props?[key] = int.string
                }else if let dictArr = JSONParser.dictArr(value) {//array with dict
                    dictArr.forEach{
                        if let dict = JSONParser.dict($0){
                            child.children.append(tree(dict))
                        }else{
                            fatalError("type not supported: \(type(of:json)) type \(JSONType.type(json))")
                        }
                    }
                }else if let arr = JSONParser.arr(value) {//array with any
                    var items:[String] = []
                    arr.forEach{
                        if let str = JSONParser.str($0){
                            items.append(str)
                        }else if let int = JSONParser.int($0){
                            items.append(int.string)
                        }else{
                            fatalError("type not supported: \(type(of:json)) type \(JSONType.type(json))")
                        }
                    }
                    child.attribs[key] = items//add items
                }else{
                    fatalError("type not supported: \(type(of:json)) type \(JSONType.type(json))")
                }
            }
        }else{
            fatalError("type not supported: \(type(of:json)) type \(JSONType.type(json))")
        }
        return child
    }
}
