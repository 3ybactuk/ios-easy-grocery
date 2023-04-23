import UIKit

final class PresetsCell: UITableViewCell {
    static let reuseIdentifier = "PresetsCell"
    private let presetLabel = UILabel()
    private let presetDescription = UILabel()
    
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
        setupTitleLabel()
        setupDescriptionLabel()
    }
    
    private func setupTitleLabel() {
        presetLabel.font = .systemFont(ofSize: 16, weight: .medium)
        presetLabel.textColor = .label
        presetLabel.numberOfLines = 1
        contentView.addSubview(presetLabel)
        presetLabel.translatesAutoresizingMaskIntoConstraints = false

        presetLabel.setHeight(Int(presetLabel.font.lineHeight))
//        presetLabel.pinLeft(to: newsImageView.trailingAnchor, 12)
        presetLabel.pin(to: contentView, [.top, .right], 12)
    }
    
    private func setupDescriptionLabel() {
        presetDescription.font = .systemFont(ofSize: 14, weight: .regular)
        presetDescription.textColor = .secondaryLabel
        presetDescription.numberOfLines = 0
        contentView.addSubview(presetDescription)
        presetDescription.translatesAutoresizingMaskIntoConstraints = false

//        newsDescriptionLabel.pinLeft(to: newsImageView.trailingAnchor, 12)
        presetDescription.pinTop(to: presetLabel.bottomAnchor, 12)
        presetDescription.pinRight(to: contentView, 16)
        presetDescription.pinBottom(to: contentView, 12)
    }
    
    public func configure(_ viewModel: PresetsViewModel) {
        presetLabel.text = viewModel.title
        presetDescription.text = viewModel.description
    }
}
