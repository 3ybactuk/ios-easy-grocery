import UIKit

class ProductCollectionViewController: UIViewController, SkeletonDisplayable {
    var collectionView: UICollectionView!
    private var productViewModels = [ProductViewModel]()
    private var isLoading = false
    private var excludedViewModels = [ProductViewModel]()
    
    var excludeSet = Set<String>()
    
    var hideExcludedEnabled = false
    
    public static let imageCache = NSCache<NSString, AnyObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isLoading {
            showSkeleton()
        } else {
            hideSkeleton()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchProducts()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        configureCollectionView()
        fetchProducts()
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let itemWidth = (view.frame.width - 30) / 2
        let itemHeight = itemWidth * 1.5
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseIdentifier)
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.pin(to: view, [.top, .bottom, .left, .right])
    }
    
    func fetchProducts() {
        productViewModels = []
        self.isLoading = true
        self.showSkeleton()
        self.productViewModels = []
        self.excludeSet = Set(ParsingHelper.getExcludePreferences())
        
        
        for product in ParsingHelper.getProductsCSV() {
            var shouldAppend = true
            for excludedItem in excludeSet {
                if ParsingHelper.shouldExcludeProductByItem(excludedItem: excludedItem, product: product) {
                    excludedViewModels.append(product)
                    shouldAppend = false
                    break
                }
            }
            
            if !hideExcludedEnabled || shouldAppend {
                productViewModels.append(product)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isLoading = false
            self.hideSkeleton()
            self.collectionView.reloadData()
        }
    }
}

extension ProductCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isLoading {
            return 6
        }
        return productViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var viewModel = ProductViewModel("        ", weight: "     ", price: "     ")
        
        if !isLoading {
            viewModel = productViewModels[indexPath.item]
        }
        
        if let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseIdentifier, for: indexPath) as? ProductCell {
            productCell.configure(viewModel, isExcluded: excludedViewModels.contains(viewModel))
            return productCell
        }
        
        return UICollectionViewCell()
    }
}

extension ProductCollectionViewController: UICollectionViewDelegate, UIPopoverPresentationControllerDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productPageVC = ProductPageViewController()
        
        productPageVC.configure(with: productViewModels[indexPath.item], isExcluded: excludedViewModels.contains(productViewModels[indexPath.item]))
        
        self.navigationController?.pushViewController(productPageVC, animated: true)
    }
}
