
import Foundation

protocol NewsAPIDelegate {
    func didFetchPosts (posts: NewsPosts)
    func didFailWithError (error: Error?)
}

struct NewsApi {
    
    var delegate: NewsAPIDelegate?
    
    func fetchNews() {
        
        let urlString = URL(string: "https://newsapi.org/v2/top-headlines?sources=google-news-sa&apiKey=99b4f1af425c4e4e919ca5cfc46bb856")
        
        let urlSession = URLSession(configuration: .default)
        let task = urlSession.dataTask(with: urlString!) { (data, urlResponse, error) in
            if error != nil {
                print(error?.localizedDescription)
            }else {
                
                do {
                    let posts = try JSONDecoder().decode(NewsPosts.self, from: data!)
                    
                    delegate?.didFetchPosts(posts: posts)
                }catch {
                    print(error)
                }

            }
            
        }
        task.resume()
    }
    
}
