import UIKit

final class ProductPageViewController: UIViewController {
    private let productImageView = UIImageView()
    private let productTitleLabel = UILabel()
    private let productDescriptionLabel = UILabel()
    private let productContentsLabel = UILabel()
    private let productQuantityLabel = UILabel() // Volume or the weight of the product
    private let productPriceLabel = UILabel()
    private let productCompatibleIcon = UIImageView(image: UIImage(systemName: "exclamationmark.triangle.fill"))
    
    var shopURL = URL(string: "")
    
    private let productToShopButton = UIButton()
    
    let contentView = UIView()
    
    let KCALTable = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Private methods
    private func setupUI() {
        view.backgroundColor = .systemBackground
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize.width = 0
        scrollView.contentSize = CGSize(width: view.bounds.width, height: 1000)
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.pin(to: scrollView, [.top, .bottom, .left, .right])
        contentView.pinWidth(to: scrollView.widthAnchor)
        
        setupNavbar()
        setImageView()
        setTitleLabel()
        
        setupToShopButton()
        
        setupPriceLabel()
        setupQuantityLabel()
        
        setDescriptionLabel()
        setContentsLabel()
        setKCALTable()
        
        setupProductCompatibleIcon()
    }
    
    private func setupNavbar() {
        navigationItem.title = ""
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark.circle.fill"),
            style: .plain,
            target: self,
            action: #selector(closeButtonTapped)
        )
        navigationItem.leftBarButtonItem?.tintColor = .label
    }
    
    private func setImageView() {
        productImageView.layer.cornerRadius = 8
        productImageView.layer.cornerCurve = .continuous
        productImageView.clipsToBounds = true
        productImageView.contentMode = .scaleAspectFit
        productImageView.backgroundColor = .systemBackground
        contentView.addSubview(productImageView)
        
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.setHeight(180)
        productImageView.pinWidth(to: productImageView.heightAnchor)
//        productImageView.pinBottom(to: productTitleLabel.topAnchor, 6)
        productImageView.pin(to: contentView, [.left, .top], 6)
        productImageView.pinCenterY(to: contentView.centerYAnchor)
    }

    private func setTitleLabel() {
        productTitleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        productTitleLabel.numberOfLines = 4
        productTitleLabel.textColor = .label
        contentView.addSubview(productTitleLabel)
        
        productTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        productTitleLabel.pin(to: contentView, [.top, .right], 6)
        productTitleLabel.pinLeft(to: productImageView.safeAreaLayoutGuide.trailingAnchor, 6)
//        productTitleLabel.pinTop(to: imageView.bottomAnchor, 12)
//        productTitleLabel.pin(to: view, [.left, .right], 16)
        productTitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 16).isActive = true
    }
    
    private func setupQuantityLabel() {
        productQuantityLabel.font = .systemFont(ofSize: 12, weight: .light)
        productQuantityLabel.textColor = .systemGray2
        productQuantityLabel.numberOfLines = 1
        contentView.addSubview(productQuantityLabel)
        
        productQuantityLabel.translatesAutoresizingMaskIntoConstraints = false
        productQuantityLabel.setHeight(Int(productQuantityLabel.font.lineHeight))
        productQuantityLabel.pinLeft(to: productImageView.safeAreaLayoutGuide.trailingAnchor, 6)
        productQuantityLabel.pinBottom(to: productPriceLabel.topAnchor, 6)
        productQuantityLabel.pinRight(to: contentView, 6)
    }
    
    private func setupPriceLabel() {
        productPriceLabel.font = .systemFont(ofSize: 12, weight: .medium)
        productPriceLabel.textColor = .label
        productPriceLabel.numberOfLines = 1
        contentView.addSubview(productPriceLabel)
        
        productPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        productPriceLabel.setHeight(Int(productPriceLabel.font.lineHeight))
        productPriceLabel.pinLeft(to: productImageView.safeAreaLayoutGuide.trailingAnchor, 6)
        productPriceLabel.pinBottom(to: productToShopButton.topAnchor, 8)
        productPriceLabel.pinRight(to: contentView, 6)
    }
    
    private func setupToShopButton() {
        productToShopButton.setTitle("Перейти в магазин", for: .normal)
        productToShopButton.setTitleColor(.white, for: .normal)
        productToShopButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        productToShopButton.backgroundColor = .label
        productToShopButton.tintColor = .white
        
        productToShopButton.layer.cornerRadius = 8
        productToShopButton.layer.applyShadow(3)
        
        productToShopButton.addTarget(self, action: #selector(goToShopTapped), for: .touchUpInside)
        
        productToShopButton.startAnimatingPressActions()
        
        contentView.addSubview(productToShopButton)
        
        productToShopButton.setHeight(48)
        productToShopButton.pinLeft(to: productImageView.safeAreaLayoutGuide.trailingAnchor, 6)
        productToShopButton.pinBottom(to: productImageView.bottomAnchor)
        productToShopButton.pinRight(to: contentView, 12)
    }
    
    private func setDescriptionLabel() {
        let descriptionBackgroundView = UIView()
        descriptionBackgroundView.backgroundColor = .systemGray6
        descriptionBackgroundView.layer.cornerRadius = 8
        descriptionBackgroundView.layer.applyShadow(3)
        contentView.addSubview(descriptionBackgroundView)
        
        let headerLabel = UILabel()
        headerLabel.font = .systemFont(ofSize: 16, weight: .bold)
        headerLabel.text = "Описание"
        headerLabel.textColor = .label
        contentView.addSubview(headerLabel)
        
        productDescriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        productDescriptionLabel.numberOfLines = 3
        productDescriptionLabel.lineBreakMode = .byTruncatingTail
        productDescriptionLabel.textColor = .label
        contentView.addSubview(productDescriptionLabel)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.pin(to: contentView, [.left, .right], 24)
        headerLabel.pinTop(to: productImageView.bottomAnchor, 24)
        
        productDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        productDescriptionLabel.pin(to: contentView, [.left, .right], 24)
        productDescriptionLabel.pinTop(to: headerLabel.bottomAnchor, 24)
        
        descriptionBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        descriptionBackgroundView.pinTop(to: headerLabel.topAnchor, -12)
        descriptionBackgroundView.pin(to: productDescriptionLabel, [.left, .bottom, .right], -12)
    }
    
    private func setContentsLabel() {
        let contentsBackgroundView = UIView()
        contentsBackgroundView.backgroundColor = .systemGray6
        contentsBackgroundView.layer.cornerRadius = 8
        contentsBackgroundView.layer.applyShadow(3)
        contentView.addSubview(contentsBackgroundView)
        
        let headerLabel = UILabel()
        headerLabel.font = .systemFont(ofSize: 16, weight: .bold)
        headerLabel.text = "Состав"
        headerLabel.textColor = .label
        contentView.addSubview(headerLabel)
        
        productContentsLabel.font = .systemFont(ofSize: 14, weight: .regular)
        productContentsLabel.numberOfLines = 0
        productContentsLabel.lineBreakMode = .byTruncatingTail
        productContentsLabel.textColor = .label
        contentView.addSubview(productContentsLabel)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.pin(to: contentView, [.left, .right], 24)
        headerLabel.pinTop(to: productDescriptionLabel.bottomAnchor, 32)
        
        productContentsLabel.translatesAutoresizingMaskIntoConstraints = false
        productContentsLabel.pin(to: contentView, [.left, .right], 24)
        productContentsLabel.pinTop(to: headerLabel.bottomAnchor, 24)
        
        contentsBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        contentsBackgroundView.pinTop(to: headerLabel.topAnchor, -12)
        contentsBackgroundView.pin(to: productContentsLabel, [.left, .bottom, .right], -12)
    }
    
    private func setKCALTable() {
        KCALTable.translatesAutoresizingMaskIntoConstraints = false
        KCALTable.frame = contentView.bounds
        KCALTable.dataSource = self
        KCALTable.delegate = self
        KCALTable.register(TwoColumnTableCell.self, forCellReuseIdentifier: "cell")
        contentView.addSubview(KCALTable)
        
        KCALTable.pinTop(to: productContentsLabel.bottomAnchor, 24)
        KCALTable.pin(to: contentView, [.left, .right], 24)
    }
    
    private func setupProductCompatibleIcon() {
        productCompatibleIcon.tintColor = .systemRed
        productCompatibleIcon.layer.applyShadow()
        contentView.addSubview(productCompatibleIcon)
        productCompatibleIcon.setHeight(30)
        productCompatibleIcon.setWidth(30)
        productCompatibleIcon.pin(to: contentView, [.left, .top], 6)
    }
    
    // MARK: - Public Methods
    public func configure(with viewModel: ProductViewModel) {
        productTitleLabel.text = viewModel.name
        productPriceLabel.text = viewModel.price ?? "? ₽"
        productQuantityLabel.text = viewModel.volume ?? viewModel.weight ?? ""
        productDescriptionLabel.text = viewModel.description ?? "Описание отсутствует."
        productContentsLabel.text = viewModel.contents ?? "Состав отсутствует."
        shopURL = viewModel.productURL
        
        if let image = ProductCollectionViewController.imageCache.object(forKey: (viewModel.imageURL?.absoluteString ?? "") as NSString) as? UIImage {
            productImageView.image = image
        } else if let url = viewModel.imageURL {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data)
                    ProductCollectionViewController.imageCache.setObject(imageToCache!, forKey: url.absoluteString as NSString)
                    self?.productImageView.image = imageToCache
                }
            }.resume()
        }
    }
    
    // MARK: - Objc functions
    @objc
    private func goToShopTapped() {
        guard let url = shopURL else { return }
        UIApplication.shared.open(url)
    }
    
    @objc
    private func closeButtonTapped() {
        dismiss(animated: true)
//        self.navigationController?.popViewController(animated: true)
    }
}

extension ProductPageViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
}

extension ProductPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TwoColumnTableCell

        if indexPath.section == 0 {
            // Set up the header row
            cell.column1Label.text = "Header 1"
            cell.column2Label.text = "Header 2"
        } else {
            // Set up the data rows
            cell.column1Label.text = "Data \(indexPath.row + 1), Column 1"
            cell.column2Label.text = "Data \(indexPath.row + 1), Column 2"
        }

        return cell
    }
}
