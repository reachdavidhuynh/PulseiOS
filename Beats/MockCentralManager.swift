

import Foundation
import CoreBluetooth

final class MockCentralManager: NSObject {
    
    var delegate: MockCentralManagerDelegate?
    
    var scanTimer: NSTimer?
    
    init(delegate: MockCentralManagerDelegate?, queue: dispatch_queue_t?) {
        self.delegate = delegate
        super.init()
    }
    
    func scanForPeripheralsWithServices(serviceUUIDs: [CBUUID]?, options: [String : AnyObject]?) {
        scanForPeripheralsWithServicesCalled = true
        
        scanTimer = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: #selector(MockCentralManager.discoverPeripheral), userInfo: nil, repeats: false)
    }
    
    func connectPeripheral(peripheral: MockPeripheral, options: [String: AnyObject]?) {
        connectedToPeripheral = true
       
        let timerArray = [peripheral]
        _ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(MockCentralManager.connectPeripheral(_:)), userInfo: timerArray, repeats: false)
    }
    
    // MARK: Helper methods
    
    func discoverPeripheral() {
        discoveredPeripheral = true
    
        let peripheral = MockPeripheral()
        delegate?.centralManager(self, didDiscoverPeripheral: peripheral, advertisementData: ["CBAdvertisementDataLocalNameKey": "MockPolarH7"], RSSI: 42)
    }
    
    func connectPeripheral(timer: NSTimer?) {
        guard
            let timer = timer,
            let userInfo = timer.userInfo,
            let peripheral = userInfo[0] as? MockPeripheral
        else { return }
        delegate?.centralManager(self, didConnectPeripheral: peripheral)
        timer.invalidate()
    }
    
    // MARK: Method Flags
    
    var scanForPeripheralsWithServicesCalled = false
    var discoveredPeripheral = false
    var connectedToPeripheral = true

}
