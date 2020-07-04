
import UIKit
import Firebase

class FeedCell: UITableViewCell {

    @IBOutlet var userEmailLabel: UILabel!
    @IBOutlet var commentLabel: UILabel!
    @IBOutlet var likeLabel: UILabel!
    @IBOutlet var userimageView: UIImageView!
    @IBOutlet var documentIDLabel: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
       
        
        
    }
    
    @IBAction func likeButtonClicked(_ sender: Any) {
        
        
        let firebaseDataStore = Firestore.firestore()
        
        if let likecount = Int(likeLabel.text!) {
            
            let likestore = ["likes" : likecount + 1] as [String : Any]

            firebaseDataStore.collection("Posts").document(documentIDLabel.text!).setData(likestore, merge: true)
            
            
        }
        
        
        
        
        
        
    }
    
        

}
