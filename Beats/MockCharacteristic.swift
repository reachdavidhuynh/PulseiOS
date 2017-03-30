

import CoreBluetooth

final class MockCharacteristic: CBMutableCharacteristic {
    
    var trueCharacteristic: CBMutableCharacteristic?
    var mockValue: NSData?
    
    init(type: CBUUID,
        properties: CBCharacteristicProperties,
        permissions: CBAttributePermissions) {
        super.init(type: type, properties: properties, value: nil, permissions: permissions)
    }
    
}
