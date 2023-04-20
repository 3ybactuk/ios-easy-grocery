import UIKit

final class PreferencesViewController: UIViewController {
    private var imageView = UIImageView()
    private var titleLabel = UILabel()
    private var descriptionLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        navigationController?.isToolbarHidden = false
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupNavbar()
        setupToolbar()
//        setImageView()
//        setTitleLabel()
//        setDescriptionLabel()
    }
    
    private func setupToolbar() {
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
//        let presetsButton = UIBarButtonItem(title: "Предустановки", image: UIImage(systemName: "format_list_bulleted"), target: self, action: #selector(presetsPressed))
//        let manualButton = UIBarButtonItem(title: "Выбрать вручную", image: UIImage(systemName: "format_list_bulleted"), target: self, action: #selector(manualPressed))
        let presetsButton = UIButton()
        presetsButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        presetsButton.setTitle("Предустановки", for: .normal)
        presetsButton.addTarget(self, action: #selector(presetsPressed), for: .touchUpInside)
        
        let manualButton = UIButton()
        manualButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        manualButton.setTitle("Выбрать вручную", for: .normal)
        manualButton.addTarget(self, action: #selector(manualPressed), for: .touchUpInside)

        for button in [presetsButton, manualButton] {
            button.setTitleColor(.systemBlue, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .medium)
            button.sizeToFit()
            button.scaleImage(1.5)
            
            button.centerVertically()
        }
        
        self.toolbarItems = [flexibleSpace, UIBarButtonItem(customView: presetsButton), flexibleSpace, UIBarButtonItem(customView: manualButton), flexibleSpace]
    }
    
    private func setupNavbar() {
        navigationItem.title = "Предпочтения"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(goBackPressed)
        )
        navigationItem.leftBarButtonItem?.tintColor = .label
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Готово",
            style: .done,
            target: self,
            action: #selector(donePressed)
        )
        navigationItem.leftBarButtonItem?.tintColor = .label
    }
    
    @objc
    private func presetsPressed() {
        
    }
    
    @objc
    private func manualPressed() {
        
    }
    
    @objc
    private func goBackPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func donePressed() {
        
    }
}
