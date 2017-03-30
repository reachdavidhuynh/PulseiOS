

import Foundation

class Record: NSObject {
    
    var value: Int!
    var time: NSDate!
    
    init(value: Int) {
        self.value = value
        self.time = NSDate()
    }
    
}
