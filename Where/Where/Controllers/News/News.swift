
import UIKit

class News: UIViewController {
    var cellId = "cell"
    var newsApi = NewsApi()
    var articles = [Article(title: "", url: "")]
    
    lazy var arabImg = UIImageView()
    lazy var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBrown
        setUpConst()
        tableView.delegate = self
        newsApi.delegate = self
        newsApi.fetchNews()
    }
    
    func setUpConst() {
        arabImg.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(arabImg)
        arabImg.image = UIImage(named: "ArabNews1")
        NSLayoutConstraint.activate([
            arabImg.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            arabImg.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            arabImg.heightAnchor.constraint(equalToConstant: 120),
            arabImg.widthAnchor.constraint(equalToConstant: 260)
        ])
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: arabImg.bottomAnchor, constant: 10),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        ])
    }
}

extension News: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = articles[indexPath.row].title
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
}

extension News:  UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let vc = ShowNews()
        let selectedRow = tableView.indexPathForSelectedRow?.row
        vc.urlLink = articles[selectedRow!].url
        print(indexPath.row)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension News: NewsAPIDelegate {
    func didFetchPosts(posts: NewsPosts) {
        print(posts)
        articles = posts.articles
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error?) {
        print(error)
    }
    
}
