

import Foundation

protocol BluetoothControllerDelegate {
    
    func bluetooothControllerStateChanged(state: BluetoothControllerState)
    
    func heartRateUpdated(hr: Int)
    
}
