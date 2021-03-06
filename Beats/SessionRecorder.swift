

import Foundation

class SessionRecorder: NSObject {
    
    var delegate: SessionRecorderDelegate?
    
    var currentSession: Session?
    
    var state: SessionRecorderState {
        didSet {
            delegate?.recorderDidUpdateState(state)
        }
    }
    
    static let sharedInstance = SessionRecorder()
    
    private override init() {
        state = .Inactive
        super.init()
    }
    
    // MARK: Recording
    
    func startRecording() {
        state = .Recording
    }
    
    func pauseRecording() {
        state = .Paused
    }
    
    func finishRecording() {
        state = .Finished
        currentSession?.end()
    }
    
    // MARK: Sessions
    
    func newSession() {
        currentSession = Session()
    }
    
    func addValue(value: Int) {
        if state == .Recording {
            currentSession?.addValue(value)
        }
    }

}

enum SessionRecorderState {
    case Inactive
    case Recording
    case Paused
    case Finished
}
