import Cocoa
@testable import Utils
/**
 * TODO: Continue adding methods here
 */
extension Listable3 {
    /*Parsers*/
    var selected:ISelectable?{fatalError("not implemented yet")}/*Convenience*/
    var selectedIndex:Int{return 0}/*Convenience*/
    //var itemsHeight:CGFloat {fatalError("not implemented yet")}/*Convenience*/
    /*Modifiers*/
    func selectAt(_ index:Int){/*convenience*/
        print("IList.selectAt(\(index)) not implemented yet")
    }
    var dp:DataProvider {return self.dp}/*convenience*/
    //var itemsHeight: CGFloat {return dp.count * itemHeight}//👈 new
    
    /*new/temp TODO: maybe use where Self:IList && Self:Scrollable*/
    var interval:CGFloat{return floor(contentSize[dir] - maskSize[dir])/itemSize[dir]}
    var progress:CGFloat{return SliderParser.progress(contentContainer.point[dir], maskSize[dir], contentSize[dir])}
}
