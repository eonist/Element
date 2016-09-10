import Foundation

class StyleManagerUtils{
    /**
     * Creates a directory with lists of styles. if style.selector.count is 3, then its added to the key:3 and also every key that is bigger than 3
     * PARAM: f: the key to group by (its a method that gets each item in items)
     * PARAM: items: the items to be grouped
     * PARAM: o: is an item in items
     * group with key 3 has 3 or more styleSelectors
     * grpup with key 1 has only styles with 1 selector or less
     * group with key 2 has only styles with 2 selector or less
     * group with key 3 has only styles with 3 selector or less
     * group with key 4 has only styles with 4 selector or less
     */
    class func groupBy<T, H: Hashable>(items: [T], f: (T) -> H) -> [H: [T]] {
        return items.reduce([:], combine: { (var ac: [H: [T]], o: T) -> [H: [T]] in
            append(&ac,o,f)
            return ac/*Return the grouped list*/
        })
    }
    /**
     *
     */
    class func append<T, H: Hashable>(/**/inout ac:[H: [T]]/*Dictionary<String,[IStyle]>*/, /*style*/_ o:T,_ f: (T) -> H){
        let selectorCount = f(o)/*h is the key, an item is passed to f to get h*/
        //Swift.print("selectorCount: " + "\(selectorCount)")
        if var c = ac[selectorCount] {/*if something already exist at key: h then append to that value*/
            c.append(o)
            ac.updateValue(c, forKey: selectorCount)/*re-add that value*/
        }else{
            ac.updateValue([o], forKey: selectorCount)/*add the item from items as an array*/
        }
        ac.keys.forEach{
            if(String($0).int < String(selectorCount).int) {/*add style to all arrays that have a selectorCount less than the current style has*/
                if var temp = ac[$0]{
                    temp.append(o)
                    ac.updateValue(temp, forKey: $0)/*add the item from items as an array*/
                }
                
            }
        }
        
        
    }
    
    /**
     *
     */
    class func concat(inout hashedStyles:Dictionary<String,[IStyle]>, _ styles:[IStyle]){
        styles.forEach{
            append(&hashedStyles, $0, { $0.selectors.count.string })
        }
    }
}