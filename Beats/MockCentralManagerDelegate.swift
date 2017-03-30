

import Foundation

protocol MockCentralManagerDelegate {
    
    func centralManager(central: MockCentralManager, didDiscoverPeripheral peripheral: MockPeripheral,
        advertisementData: [String : AnyObject], RSSI: NSNumber)
    
    func centralManager(central: MockCentralManager, didConnectPeripheral peripheral: MockPeripheral)
    
}
