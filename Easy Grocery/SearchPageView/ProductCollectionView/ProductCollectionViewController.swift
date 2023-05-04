import UIKit

class ProductCollectionViewController: UIViewController, SkeletonDisplayable {
    var collectionView: UICollectionView!
    private var productViewModels = [ProductViewModel]()
    private var isLoading = false
    private var excludedViewModels = [ProductViewModel]()
    
    private var currentPage = 0
    private var totalPages = 1
    
    var excludeSet = Set<String>()
    
    
    var hideExcludedEnabled = false
    
    public static let imageCache = NSCache<NSString, AnyObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        self.hideKeyboardWhenTappedAround()
        
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
        collectionView.isScrollEnabled = false
        self.isLoading = true
        self.showSkeleton()
        self.productViewModels = []
        self.excludeSet = Set(ParsingHelper.getExcludePreferences())
        
        let pageSize = 16
        let startIndex = max(0, currentPage * pageSize - pageSize)
//        let startIndex = 0
        let endIndex = currentPage * pageSize + pageSize
        let products = ParsingHelper.getProductsCSV()
        totalPages = products.count / pageSize
        
        for product in products[startIndex..<endIndex] {
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
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.collectionView.isScrollEnabled = true
            self.isLoading = false
            self.hideSkeleton()
            
            let currentItemCount = self.productViewModels.count
            let newItems = products[currentItemCount..<min(currentItemCount+pageSize, products.count)]
            let newIndexPaths = (currentItemCount..<currentItemCount+newItems.count).map { IndexPath(item: $0, section: 0) }
            
//            self.productViewModels.append(contentsOf: newItems)
//            self.excludedViewModels.append(contentsOf: excludedProducts)
            
            if self.productViewModels.count > pageSize {
                // Scroll to the middle of the new page
                let middleIndex = currentItemCount + (pageSize) 
                let middleIndexPath = IndexPath(item: middleIndex, section: 0)
                self.collectionView.scrollToItem(at: middleIndexPath, at: .centeredVertically, animated: false)
            }
            
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

extension ProductCollectionViewController: UICollectionViewDelegateFlowLayout {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentHeight = collectionView.contentSize.height
        let offsetY = scrollView.contentOffset.y
        let visibleHeight = scrollView.frame.height
        
        if 0.7 * offsetY < 0 && currentPage > 0 {
            // Load previous page
            currentPage -= 1
            fetchProducts()
        } else if 1.3 * offsetY > contentHeight - visibleHeight && currentPage < totalPages - 1 {
            // Load next page
            currentPage += 1
            fetchProducts()
        }
        
//        if 1.3 * offsetY > contentHeight - visibleHeight {
//            currentPage += 1
//            fetchProducts()
//        }
    }
}
