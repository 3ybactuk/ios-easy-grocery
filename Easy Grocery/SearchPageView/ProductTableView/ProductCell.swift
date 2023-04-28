import UIKit

final class ProductCell: UITableViewCell {
    static let reuseIdentifier = "Product Cell"
    private let productImageView = UIImageView()
    private let productTitleLabel = UILabel()
    private let productQuantityLabel = UILabel() // Volume or the weight of the product
    private let productPriceLabel = UILabel()
    private let productCompatibleIcon = UIImageView(image: UIImage(systemName: "exclamationmark.triangle.fill"))
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupView()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupView() {
        setupImageView()
        setupTitleLabel()
        setupQuantityLabel()
        setupPriceLabel()
        setupProductCompatibleIcon()
        bringSubviewToFront(productCompatibleIcon)
    }
    
    private func setupImageView() {
        productImageView.layer.cornerRadius = 8
        productImageView.layer.cornerCurve = .continuous
        productImageView.clipsToBounds = true
        productImageView.contentMode = .scaleAspectFit
        productImageView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(productImageView)
        
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.setHeight(200)
//        productImageView.setWidth(32)
        productImageView.pin(to: contentView, [.top, .left, .right], 4)
//        productImageView.pin(to: contentView, [.top, .left, .right], 4)
//        productImageView.pinLeft(to: contentView, 16)
//        productImageView.pinWidth(to: newsImageView.heightAnchor)
    }
    
    private func setupTitleLabel() {
        productTitleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        productTitleLabel.textColor = .label
        productTitleLabel.numberOfLines = 3
        productTitleLabel.lineBreakMode = .byWordWrapping
        contentView.addSubview(productTitleLabel)
        productTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        productTitleLabel.setHeight(Int(productTitleLabel.font.lineHeight))
        productTitleLabel.pinTop(to: productImageView.bottomAnchor, 6)
        productTitleLabel.pin(to: contentView, [.left, .right], 6)
//        productTitleLabel.pinLeft(to: productImageView.trailingAnchor, 12)
//        productTitleLabel.pin(to: contentView, [.top, .right], 12)
    }
    
    private func setupQuantityLabel() {
        productQuantityLabel.font = .systemFont(ofSize: 8, weight: .light)
        productQuantityLabel.textColor = .systemGray2
        productQuantityLabel.numberOfLines = 1
        contentView.addSubview(productQuantityLabel)
        productQuantityLabel.setHeight(Int(productQuantityLabel.font.lineHeight))
        productQuantityLabel.pinTop(to: productTitleLabel.bottomAnchor, 6)
        productQuantityLabel.pin(to: contentView, [.left, .right], 6)
    }
    
    private func setupPriceLabel() {
        productPriceLabel.font = .systemFont(ofSize: 16, weight: .medium)
        productPriceLabel.textColor = .label
        productPriceLabel.numberOfLines = 1
        contentView.addSubview(productPriceLabel)
        productPriceLabel.setHeight(Int(productPriceLabel.font.lineHeight))
        productPriceLabel.pinTop(to: productQuantityLabel.bottomAnchor, 10)
        productPriceLabel.pin(to: contentView, [.left, .right], 6)
    }
    
    private func setupProductCompatibleIcon() {
        productCompatibleIcon.tintColor = .systemRed
        contentView.addSubview(productCompatibleIcon)
        productCompatibleIcon.setHeight(8)
        productCompatibleIcon.pin(to: contentView, [.right, .top], 6)
    }
    
    public func configure(_ viewModel: ProductViewModel) {
        productTitleLabel.text = viewModel.name
        productPriceLabel.text = viewModel.price ?? "?"
        productQuantityLabel.text = viewModel.volume ?? viewModel.weight ?? ""
        
//        if let url = viewModel.imageURL {
//            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in guard let data = data else {
//                    return
//                }
//                viewModel.imageData = data
//            }
//        }
        
        if let image = ProductTableViewController.imageCache.object(forKey: (viewModel.imageURL?.absoluteString ?? "") as NSString) as? UIImage {
            productImageView.image = image
        } else if let url = viewModel.imageURL {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in guard let data = data else {
                return
            }
            viewModel.imageData = data
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data)
                ProductTableViewController.imageCache.setObject(imageToCache!, forKey: url.absoluteString as NSString)
                self?.productImageView.image = imageToCache
                }
            }.resume()
        }
    }
}
