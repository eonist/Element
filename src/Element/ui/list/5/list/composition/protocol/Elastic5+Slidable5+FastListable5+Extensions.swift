import Cocoa
@testable import Utils

extension Elastic5 where Self:Slidable5, Self:FastListable5 {
    func setProgressValue(_ value:CGFloat, _ dir:Dir) {/*Gets calls from MoverGroup*/
        //Swift.print("ElasticSlidableScrollableFastListable3.setProgressValue(val,dir)")
        setProgressVal(value, dir)//forward
        let sliderProgress = ElasticUtils.progress(value,contentSize[dir],maskSize[dir])//doing some double calculations here
        slider(dir).setProgressValue(sliderProgress)//temp fix
    }
}
