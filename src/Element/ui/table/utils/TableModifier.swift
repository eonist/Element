import Foundation

class TableModifier {
    /**
     *
     */
    static func selectRow(_ table:Table,_ index:Int,_ exception:Column? = nil) {
        //var startTime:Int = getTimer()
        for column in table.columns{ if(exception == nil || column != exception) {ListModifier.selectAt(column.list!, index)}}
        //print("selectRow-duration: " + (getTimer() - startTime))
    }
}
