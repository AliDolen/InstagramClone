

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet var emailText: UITextField!
    
    @IBOutlet var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        
    }
    
    
    
    
    @IBAction func signUp(_ sender: Any) {
        
        
        if emailText.text != "" && passwordText.text != "" {
            
            
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (authData, error) in
                
                
                if error != nil {
                    
                    self.AlertFunction(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error!")
                    
                } else {
                    
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                    
                    
                }
            
            }
         
        }
        else
        {
           
            AlertFunction(titleInput: "Error!", messageInput: "Username/password")
            
        }
        
    }
    
    
    
    func AlertFunction (titleInput:String , messageInput:String){
        
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
                   
                   let alertButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                   
                   alert.addAction(alertButton)
                   
                   self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func signIn(_ sender: Any) {
        
        
        if emailText.text != "" && passwordText.text != "" {
            
            
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (authdata, error) in
             
                if error != nil {
                    
                    
                      self.AlertFunction(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error!")
                    
                    
                }
                else {
                    
                    
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                    
                  
                }
              
            }
            
        }
        
        
    }
    
}

