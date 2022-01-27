

import UIKit
import FirebaseFirestore

class CommentsService {
    static let shared = CommentsService()
    let CommentsCollection = Firestore.firestore().collection("comments")
    
    func updateOrAddNote(comment: CommentCafe) {
        CommentsCollection.document(comment.id).setData([
            "id": comment.id,
            "content": comment.comment,
        ], merge: true)
    }
    
    //MARK: - listen To Comments
    
    func listenToComments(completion: @escaping (([CommentCafe]) -> Void)) {
        CommentsCollection.addSnapshotListener { snapshot, error in
            if error != nil {
                return
            }
            
            guard let docs = snapshot?.documents else { return }
            var comments = [CommentCafe]()
            
            for doc in docs {
                comments.append(CommentCafe(id: doc.get("id") as! String, comment: doc.get("content") as! String))
                
            }
            
            completion(comments)
        }
    }
    
    //MARK:- Delete Comment
    
    func delete(comment: CommentCafe) {
        
        CommentsCollection.document(comment.id).delete()
    }
}


