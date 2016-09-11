import Foundation

class StyleResolverUtils {
    /**
     * Return an array of WeightedStyle instances
     * @Note while loading the Basic.css flat structure queries 97656  vs treestructure queries 13324 (this is why we use a treestructure querey technique)
     */
    static func query(querySelectors:[ISelector],_ searchTree:[String:Any],_ cursor:Int = 0, _ selectorWeights:[SelectorWeight] = []) -> [WeightedStyle]{
        var weightedStyles:[WeightedStyle] = []
        //var styles:[IStyle] = []
        for key in searchTree.keys {
            //print("key: " + key + " object: "+searchTree[key] + " at cursor: "+cursor);
            if(key == "style") {weightedStyles.append(WeightedStyle(searchTree[key] as! IStyle, StyleWeight(selectorWeights)))}
            else{
                for (var i : Int = cursor; i < querySelectors.count; i++) {
                    let querySelector:ISelector = querySelectors[i]
                    if(key == querySelector.element){
                        //print("matching element found, keep digging deeper");
                        let result:[WeightedStyle] = query(querySelectors, searchTree[key] as! [String:Any],i+1)
                        if(result.count > 0) {weightedStyles += result}
                    }
                }
            }
        }
        return weightedStyles
    }
}
