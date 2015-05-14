

import UIKit

extension String {
    func escapeStr() -> String {
        var raw: NSString = self
        var str:CFString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,raw,"[].","+",CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding))
        return str as NSString as! String
    }
    
    func split(s:String)->Array<String>
    {
        if s.isEmpty{
            var x:Array<String> = []
            for y in self{
                x.append(String(y))
            }
            return x
        }
        return self.componentsSeparatedByString(s)
    }
    
    func reverse()-> String{
        var s:Array = self.split("").reverse()
        var x:String = ""
        for y in s{
            x += y
        }
        return x
    }
    
    func contain(s:String)->Bool{
        var ns = self as NSString
        if ns.rangeOfString(s).length > 0{
            return true
        }
        return false
    }
}

extension Array{

    func filter<T>(name:String)->Array<T>{
        var newArr:Array<T> = []
        for item in self {
            var pros:MirrorType = reflect(item)
            for(var i:Int = 1;i < pros.count;i++){
                var pro = pros[i]
                let key = pro.0        //pro  name
                let value = pro.1.value
                if name == key{
                    newArr.append(pro.1.value as! T)
                    break
                }
            }
        }
        return newArr
    }
}
