

import Foundation

protocol HeartRateKitUIDelegate {
    
    func hrKitDidUpdateState(state: HeartRateKitState)
    func hrKitDidUpdateBPM(bpm: Int)
    
}
