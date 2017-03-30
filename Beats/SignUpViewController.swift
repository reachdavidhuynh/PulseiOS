

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var txtusername: UITextField!
    
    @IBOutlet weak var txtpassword: UITextField!
    @IBOutlet weak var txtname: UITextField!
    @IBOutlet weak var txtage: UITextField!
    @IBOutlet weak var txtheight: UITextField!
    @IBOutlet weak var txtweight: UITextField!
    @IBOutlet weak var txtemergency: UITextField!
    @IBOutlet weak var txtusernumber: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    @IBAction func buttonPress(sender: UIButton) {
        
        var username2:NSString = txtusername.text!
        var password2:NSString = txtpassword.text!
        var name:NSString = txtname.text!
        var age:NSString = txtage.text!
        var heartbeatwarning:NSString = txtheight.text!
        var heartbeatdanger:NSString = txtweight.text!
        var emcnumber:NSString = txtemergency.text!
        var usernumber:NSString = txtusernumber.text!
        
        let json = ["username":username2,"password":password2,"name":name,"age":age,"heartbeatwarning":heartbeatwarning,"heartbeatdanger":heartbeatdanger,"emcnumber":emcnumber,"usernumber":usernumber]
        do{
            let jsonData = try NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
            // create post request
            let url = NSURL(string: "http://69.164.216.31:3000/create")!
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            // insert json data to the request
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.HTTPBody = jsonData
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request){ data, response, error in
                if error != nil{
                    print("Error -> \(error)")
                    return
                }
                do {
                    let result = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String:AnyObject]
                    print("Result -> \(result)")
                     //self.performSegueWithIdentifier("segue3", sender: nil)                
                } catch {
                    print("Error -> \(error)")
                }
            }
            task.resume()
                } catch{
            print(error)
        }
         self.performSegueWithIdentifier("segue3", sender: nil)
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
