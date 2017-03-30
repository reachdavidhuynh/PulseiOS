
protocol BluetoothControllerProtocol {
    
    var delegate: BluetoothControllerDelegate? { get set }
    
    func scanForAvailableMonitors()
    
} 
