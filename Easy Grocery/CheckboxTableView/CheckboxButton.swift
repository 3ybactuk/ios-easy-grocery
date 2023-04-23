import UIKit

class CheckboxButton: UIButton {
    private var checkedImage = UIImage(systemName: "checkmark.square.fill")
    private var uncheckedImage = UIImage(systemName: "square")

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(checkedImageType: String, uncheckedImageType: String) {
        self.checkedImage = UIImage(systemName: checkedImageType)
        self.uncheckedImage = UIImage(systemName: uncheckedImageType)
        
        super.init(frame: .zero)
        configureButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureButton()

    }

    private func configureButton() {
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        setImage(uncheckedImage, for: .normal)
        setImage(checkedImage, for: .selected)
        tintColor = .systemBlue
    }

    @objc func buttonTapped() {
        isSelected.toggle()
    }
}
