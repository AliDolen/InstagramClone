

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var commentArray = [String]()
    var postedByArray = [String]()
    var likeArray = [Int]()
    var urlArray = [String]()
    var ıdArray = [String]()

    
    
    @IBOutlet var tableView: UITableView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        getData()
        
        

    }
    
    func getData(){
        
        let firebaseDataBase = Firestore.firestore()
        
        
        firebaseDataBase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
          
            if error != nil {
                
                print(error?.localizedDescription)
               
            } else {
                
                if snapshot?.isEmpty != true && snapshot != nil  {
                    
                    self.postedByArray.removeAll(keepingCapacity: false)
                    self.commentArray.removeAll(keepingCapacity: false)
                    self.ıdArray.removeAll(keepingCapacity: false)
                    self.likeArray.removeAll(keepingCapacity: false)
                    self.urlArray.removeAll(keepingCapacity: false)
                    
                    
                    
                    
                    for document in snapshot!.documents {
                        
                        let documentID = document.documentID
                        
                            self.ıdArray.append(documentID)
                            
                        
                        if let PostedBy = document.get("PostedBy") as? String{
                            
                            self.postedByArray.append(PostedBy)
                            
                            
                        }
                        if let postComment = document.get("postComment") as? String {
                            
                            self.commentArray.append(postComment)
                            
                            
                        }
                    
                        if let imageURL = document.get("imageURL") as? String {
                            self.urlArray.append(imageURL)
                            
                            
                            
                        }
                        if let likes = document.get("likes") as? Int {
                            self.likeArray.append(likes)
                            
                            
                        }
                   
                }
                    
                    self.tableView.reloadData()
                
            }
            
            
        }
        
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.commentLabel.text = commentArray[indexPath.row]
        cell.likeLabel.text = String(likeArray[indexPath.row])
        cell.userEmailLabel.text = postedByArray[indexPath.row]
        cell.userimageView.sd_setImage(with: URL(string: self.urlArray[indexPath.row]))
        cell.documentIDLabel.text = ıdArray[indexPath.row]
        
        
        return cell
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return postedByArray.count
    }

    

}



