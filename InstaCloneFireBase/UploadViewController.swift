
import UIKit
import Firebase

class UploadViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var textField: UITextField!
    
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        imageView.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTab))
        imageView.addGestureRecognizer(gestureRecognizer)
        
        

    }
    
    @objc func imageTab(){
        
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        
        present(picker, animated: true , completion: nil)
        
        
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageView.image = info[.originalImage] as? UIImage
        
         self.dismiss(animated: true, completion: nil)
        
    }
    
    func alertFunction(titleinput : String , titleMessage : String){
        
        let alert = UIAlertController(title: titleinput, message: titleMessage, preferredStyle: UIAlertController.Style.alert)
        
        let alertButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        
        alert.addAction(alertButton)
        
         self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
    @IBAction func uploadClicked(_ sender: Any) {
        
            // STORAGE
        
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        
        let mediaFolder = storageReferance.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            
            let uuid = UUID().uuidString
            
            let imageReferance = mediaFolder.child("\(uuid).jpg")
            imageReferance.putData(data, metadata: nil) { (metadata, error) in
                if error != nil {
                    
                    self.alertFunction(titleinput: "ERROR!", titleMessage: error?.localizedDescription ?? "Error")
                } else {
                    
                    imageReferance.downloadURL { (url, error) in
                    if error == nil {
                        
                        let imageURL  = url?.absoluteString
                        
                        
                                //DATABASE
                            
                       
                            let fireStoreDataBase = Firestore.firestore()
                            
                            var fireStoreReferance : DocumentReference? = nil
                            
                        let fireStorePost = ["imageURL" : imageURL! , "PostedBy" : Auth.auth().currentUser!.email! ,  "postComment" : self.textField.text! , "date" : FieldValue.serverTimestamp(), "likes" : 0] as [String : Any]
                            
                            
                            fireStoreReferance = fireStoreDataBase.collection("Posts").addDocument(data: fireStorePost, completion: { (error) in
                                
                                if error != nil {
                                    
                                    self.alertFunction(titleinput: "ERROR!", titleMessage: error?.localizedDescription ?? "Error")
                                    
                                }else {
                                    
                                    self.textField.text = ""
                                    self.imageView.image = UIImage(named: "system")
                                    
                                    self.tabBarController?.selectedIndex = 0
                          
                                    
                                    
                                }
                                
                            })
                            
                            
                        }
                       
                    }
                    
                }
            }
            
            
            
        }
    }
        
        
    }
    
