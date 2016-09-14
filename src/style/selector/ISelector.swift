protocol ISelector{
    var element:String{get}
    var classIds:Array<String>{get}
    var id:String{get}
    var states:Array<String>{get}
}

extension ISelector{
    /**
     *
     */
    func selector(xml:XML)->ISelector{
        let element:String = xml.firstNode("element")!.value
        let id:String = xml.firstNode("id")!.value
        let classIds:[String] = xml.firstNode("classIds")!.children.map{
            return ($0 as! XML).value
        }
        return Selector()
    }
}