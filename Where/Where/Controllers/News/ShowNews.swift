
import UIKit
import WebKit

class ShowNews: UIViewController {
    
    var webView = WKWebView()
    var urlLink: String?
    var lbl = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        lbl.text = urlLink
        view.backgroundColor = .systemBackground
        
//        webView.load(NSURLRequest(url: NSURL(string: urlLink!)! as URL) as URLRequest)
//        setUp()
        
    }
    
    func setUp() {
        lbl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lbl)
        lbl.textColor = .systemBlue
        lbl.backgroundColor = .systemBrown
        lbl.text = "hello"
        NSLayoutConstraint.activate([
            lbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            lbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lbl.leftAnchor.constraint(equalTo: view.leftAnchor),
            lbl.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor),
            webView.leftAnchor.constraint(equalTo: view.leftAnchor)
        
        ])
    }
    
}
