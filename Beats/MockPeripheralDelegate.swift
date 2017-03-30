

import CoreBluetooth

protocol MockPeripheralDelegate {
    
    func peripheral(peripheral: MockPeripheral, didDiscoverServices error: NSError?)
    func peripheral(peripheral: MockPeripheral, didDiscoverCharacteristics error: NSError?)
    func peripheral(peripheral: MockPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?)
    
}
