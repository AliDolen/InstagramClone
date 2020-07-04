

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

    }
        

    
    @IBAction func buttonClicked(_ sender: Any) {
        
        do {
            
         try Auth.auth().signOut()
            
          performSegue(withIdentifier: "toFirstPage", sender: nil)
            
        }
        catch {
            
            print("Error!")
            
            
        }
        
        
        
    }
    

}
