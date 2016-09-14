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
        let element:String = xml.firstNode("element")!.
        let id:String = xml.firstNode("id")
        return Selector()
    }
}