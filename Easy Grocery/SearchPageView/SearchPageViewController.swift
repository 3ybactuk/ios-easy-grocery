import UIKit

final class SearchPageViewController: UIViewController {
    private var imageView = UIImageView()
    
    var cameraButton = UIBarButtonItem()
    var searchButton = UIBarButtonItem()
    var settingsButton = UIBarButtonItem()
    
    var cameraUIButton = UIButton()
    var searchUIButton = UIButton()
    var settingsUIButton = UIButton()

    var currentView = 0
    
    let settingsViewController = SettingsViewController()
    let productTableViewController = ProductTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        navigationController?.isToolbarHidden = false
        setupUI()
        
        searchPressed()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationController?.isToolbarHidden = false
        setupUI()
        searchPressed()
    }
    
    // MARK:- Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        setupNavbar()
        setupToolbar()
    }
    
    private func setupToolbar() {
        cameraUIButton.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        cameraUIButton.setTitle("   Сканер", for: .normal)
        cameraUIButton.addTarget(self, action: #selector(cameraPressed), for: .touchUpInside)
        
        searchUIButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchUIButton.setTitle("   Поиск", for: .normal)
        searchUIButton.addTarget(self, action: #selector(searchPressed), for: .touchUpInside)
        
        settingsUIButton.setImage(UIImage(systemName: "gear"), for: .normal)
        settingsUIButton.setTitle("Настройки", for: .normal)
        settingsUIButton.addTarget(self, action: #selector(settingsPressed), for: .touchUpInside)

        for button in [cameraUIButton, searchUIButton, settingsUIButton] {
            button.setTitleColor(.systemBlue, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .medium)
            button.sizeToFit()
            button.scaleImage(1.5)
            
            button.centerVertically()
        }
        
        cameraUIButton.setColor(.systemGray2)
        searchUIButton.setColor(.systemBlue)
        settingsUIButton.setColor(.systemGray2)
        
        updateToolBar()
    }
    
    private func updateToolBar() {
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        cameraButton = UIBarButtonItem(customView: cameraUIButton)
        searchButton = UIBarButtonItem(customView: searchUIButton)
//        settingsButton = UIBarButtonItem(customView: settingsUIButton)
        
        self.toolbarItems = [flexibleSpace, cameraButton, flexibleSpace, searchButton, flexibleSpace]
    }
    
    private func setupNavbar() {
        navigationItem.title = "Поиск"

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: nil,
            style: .plain,
            target: self,
            action: nil //#selector(goBackPressed)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "line.horizontal.3"),
            style: .done,
            target: self,
            action: #selector(settingsPressed)
        )
        navigationItem.rightBarButtonItem?.tintColor = .label
    }
    
    private func chooseButton(_ chosenButton: UIButton) {
        for button in [cameraUIButton, settingsUIButton, searchUIButton] {
            button.setColor(.systemGray2)
        }
        chosenButton.setColor(.systemBlue)
    }
    
    // MARK:- objc Button actions
    
    @objc
    private func searchPressed() {
        currentView = 1
        print("Search pressed")
        chooseButton(searchUIButton)
        updateToolBar()
        
        addChild(productTableViewController)
        view.addSubview(productTableViewController.view)
        
        productTableViewController.view.pin(to: view, [.top, .bottom, .left, .right])
        
//        manualTableVC.dismiss(animated: false)
        
//        addChild(presetsTableVC)
//        view.addSubview(presetsTableVC.view)
        
//        presetsTableVC.updateTableViewSelection()
        
//        presetsTableVC.view.translatesAutoresizingMaskIntoConstraints = false
//        presetsTableVC.view.pin(to: view, [.top, .bottom, .left, .right])

//        presetsTableVC.didMove(toParent: self)
    }
    
    @objc
    private func cameraPressed() {
        currentView = 0
        print("Camera pressed")
        chooseButton(cameraUIButton)
        updateToolBar()
    }
    
    @objc
    private func settingsPressed() {
        print("Settings pressed")
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
}
