

import UIKit

final class HeartRateViewController: UIViewController, HeartRateKitUIDelegate {
    
    var heartRateKit: HeartRateKit?
    var recordingControlsVC: RecordingControlsViewController?
    var sessionRecorder = SessionRecorder.sharedInstance
    var receivedUsername = String()
    var receivedPassword = String()
    @IBOutlet weak var bpmLabel: UILabel!
    
    override func viewDidLoad() {
        heartRateKit = HeartRateKit.sharedInstance
        heartRateKit?.uiDelegate = self
        sessionRecorder.newSession()
        NSTimer.scheduledTimerWithTimeInterval(7.0, target: self, selector: "updateHeartbeat", userInfo: nil, repeats: true)
    }
 
   func updateHeartbeat() {
        var str = String()
        str = bpmLabel.text!
        let json = ["username":receivedUsername,"password":receivedPassword,"heartbeat":str]
        do{
            let jsonData = try NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
            // create post request
            let url = NSURL(string: "http://69.164.216.31:3000/updateHeartbeat")!
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            // insert json data to the request
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.HTTPBody = jsonData
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request){ data, response, error in
                if error != nil{
                    // print("Error -> \(error)")
                    return
                }
                do {
                    let result = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String:String]
                    //self.username.text = result!["username"]
                    
                    
                    //print("Response-> \(data)")
                    //self.performSegueWithIdentifier("segue1", sender: nil)
                } catch {
                    //print("Error -> \(error)")
                    return
                }
            }
            task.resume()
        } catch{
            print(error)
        }

    }
    
    func hrKitDidUpdateState(state: HeartRateKitState) {
        
    }
    
    func hrKitDidUpdateBPM(bpm: Int) {
        bpmLabel.text = "\(bpm)"
        sessionRecorder.addValue(bpm)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EmbedControls" {
            guard
                let vc = segue.destinationViewController as? RecordingControlsViewController
                else { fatalError("Incorrect EmbedControls segue") }
            recordingControlsVC = vc
        }
    }

}

