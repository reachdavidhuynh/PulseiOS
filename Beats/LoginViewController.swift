
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var txtUsername: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    var submitted = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        submitted = 0;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(submitted != 0) {
        let newVC: ProfileViewController = segue.destinationViewController as! ProfileViewController
        let username = txtUsername.text;
        let password = txtPassword.text;
        newVC.receivedUsername = username!
        newVC.receivedPassword = password!
        }
    }
    
    @IBAction func signInTapped(sender: UIButton) {
        var username:NSString = txtUsername.text!
        var password:NSString = txtPassword.text!
        
        if ( username.isEqualToString("") || password.isEqualToString("") ) {
            
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign in Failed!"
            alertView.message = "Please enter Username and Password"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
        else {
            let json = ["username":username,"password":password]
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
                    if error != nil{
                        print("Error -> \(error)")
                        return
                    }
                    do {
                        let result = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String:AnyObject]
                        print("Result -> \(result)")
                        self.submitted = 1;
                        dispatch_async(dispatch_get_main_queue(),{
                            self.performSegueWithIdentifier("segue1", sender: self)
                        })
                        //self.performSegueWithIdentifier("segue1", sender: nil)
                    } catch {
                        print("Error -> \(error)")
                        return
                    }
                }
                task.resume()
            } catch{
                print(error)
            }
                    }
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
