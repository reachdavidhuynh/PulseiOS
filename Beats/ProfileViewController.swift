

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var heartbeatwarning: UITextField!
    @IBOutlet weak var heartbeatdanger: UITextField!
    @IBOutlet weak var usercontact: UITextField!
    @IBOutlet weak var emergencycontact: UITextField!
    
    var receivedUsername = String()
    var receivedPassword = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        username.text = receivedUsername
        password.text = receivedPassword
        
        let json = ["username":receivedUsername,"password":receivedPassword]
        do{
            let jsonData = try NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
            // create post request
            let url = NSURL(string: "http://69.164.216.31:3000/login")!
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            // insert json data to the request
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.HTTPBody = jsonData
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request){ data, response, error in
                do {
                    guard let data = data else {
                        return;
                    }
                    guard let json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSDictionary else {
                        return;
                    }
                    print(json)
                    if(json.valueForKey("name") != nil) {
                        var nameText:String = json.valueForKey("name") as! String
                        dispatch_async(dispatch_get_main_queue(), {
                            self.name.text = nameText
                        })
                    }
                    if(json.valueForKey("age") != nil) {
                        var ageText:String = json.valueForKey("age") as! String
                        dispatch_async(dispatch_get_main_queue(), {
                            self.age.text = ageText
                        })
                    }
                    if(json.valueForKey("heartbeatwarning") != nil) {
                        var hbeatwText:String = json.valueForKey("heartbeatwarning") as! String
                        dispatch_async(dispatch_get_main_queue(), {
                            self.heartbeatwarning.text = hbeatwText
                        })
                    }
                    if(json.valueForKey("heartbeatdanger") != nil) {
                        var hbeatdText:String = json.valueForKey("heartbeatdanger") as! String
                        dispatch_async(dispatch_get_main_queue(), {
                            self.heartbeatdanger.text = hbeatdText
                        })
                    }
                    if(json.valueForKey("usernumber") != nil) {
                        var usercon:String = json.valueForKey("usernumber") as! String
                        dispatch_async(dispatch_get_main_queue(), {
                           self.usercontact.text = usercon
                        })
                    }
                    if(json.valueForKey("emcnumber") != nil) {
                        var emcnum:String = json.valueForKey("emcnumber") as! String
                        dispatch_async(dispatch_get_main_queue(), {
                            self.emergencycontact.text = emcnum
                        })
                    }
                    
                    /*age.text = json.valueForKey("age")
                    heartbeatwarning.text = json.valueForKey("heartbeatwarning")
                    heartbeatdanger.text = json.valueForKey("heartbeatdanger")
                    usercontact.text = json.valueForKey("usernumber")
                    emergencycontact.text = json.valueForKey("emcnumber")*/
                } catch let error as NSError {
                    print(error.debugDescription)
                }            }
            task.resume()
        } catch{
            print(error)
        }
        // Do any additional setup after loading the view.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let newVC: ScanningViewController = segue.destinationViewController as! ScanningViewController
        let username2 = username.text;
        let password2 = password.text;
        newVC.receivedUsername = username2!
        newVC.receivedPassword = password2!
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonpress(sender: AnyObject) {
        self.performSegueWithIdentifier("segue4", sender: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
