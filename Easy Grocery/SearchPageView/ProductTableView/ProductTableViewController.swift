import UIKit

class ProductTableViewController: UIViewController {
    private var tableView = UITableView(frame: .zero, style: .plain)
    private var productViewModels = [ProductViewModel]()
    
    public static let imageCache = NSCache<NSString, AnyObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        configureTableView()
//        setupNavbar()
        fetchProducts()
    }
    
    private func configureTableView() {
        setTableViewUI()
        setTableViewDelegate()
        setTableViewCell()
    }
    
    private func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setTableViewUI() {
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rowHeight = 120
        tableView.pinLeft(to: view)
        tableView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        tableView.pinRight(to: view)
        tableView.pinBottom(to: view)
    }
    
    private func setTableViewCell() {
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseIdentifier)
    }
    
    private func fetchProducts() {
        productViewModels = []
        
        self.productViewModels = FileParsingHelper.getProductsCSV()
        self.tableView.reloadData()
//        self.isLoading = true
//        self.showSkeleton()
//        nam.getArticles(source: .Polygon, key: key) { data in
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                if let jsonArray = json as? [String: AnyObject] {
//
//                    if let articles = jsonArray["articles"] as? [[String : AnyObject]] {
//                        for article in articles {
//                            let title = article["title"] as? String
//                            let description = article["description"] as? String
//                            let imageURL = article["urlToImage"] as? String
//                            let articleURL = article["url"] as? String
//
//                            self.newsViewModels.append(                            NewsViewModel(title: title ?? "None", description:  description ?? "None", imageURL: URL(string: imageURL ?? ""), articleURL: URL(string: articleURL ?? ""))
//                            )
//                        }
//                    }
//                }
//
//                DispatchQueue.main.async {
//                    self.isLoading = false
//                    self.hideSkeleton()
//                    self.tableView.reloadData()
//                }
//            } catch {
//                print("error serializing JSON: \(error)")
//            }
//        }
    }
}

extension ProductTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let viewModel = productViewModels[indexPath.row]
        if let productCell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseIdentifier, for: indexPath) as? ProductCell {
            productCell.configure(viewModel)
            return productCell
        }
        
        return UITableViewCell()
    }
}

extension ProductTableViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let newsVC = NewsViewController()
//        newsVC.configure(with: productViewModels[indexPath.row])
//        navigationController?.pushViewController(newsVC, animated: true)
//    }
}
