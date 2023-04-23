import UIKit

final class PreferencesViewController: UIViewController {
    private var imageView = UIImageView()
    private var titleLabel = UILabel()
    private var descriptionLabel = UILabel()
    
    var presetsButton = UIBarButtonItem()
    var manualButton = UIBarButtonItem()
    
    let presetsUIButton = UIButton()
    let manualUIButton = UIButton()
    
    let presetsTableVC = CheckboxTableViewController()
    let manualTableVC = CheckboxTableViewController()
    
//    let presetsListView = PresetsListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        navigationController?.isToolbarHidden = false
        setupUI()
        presetsPressed()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupNavbar()
        setupToolbar()
    }
    
    private func setupToolbar() {
        presetsUIButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        presetsUIButton.setTitle("Предустановки", for: .normal)
        presetsUIButton.addTarget(self, action: #selector(presetsPressed), for: .touchUpInside)
        
        manualUIButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        manualUIButton.setTitle("Выбрать вручную", for: .normal)
        manualUIButton.addTarget(self, action: #selector(manualPressed), for: .touchUpInside)

        for button in [presetsUIButton, manualUIButton] {
            button.setTitleColor(.systemBlue, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .medium)
            button.sizeToFit()
            button.scaleImage(1.5)
            
            button.centerVertically()
        }
        
        presetsUIButton.setColor(.systemBlue)
        manualUIButton.setColor(.systemGray2)
        
        updateToolBar()
    }
    
    private func updateToolBar() {
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        presetsButton = UIBarButtonItem(customView: presetsUIButton)
        manualButton = UIBarButtonItem(customView: manualUIButton)
        
        
        self.toolbarItems = [flexibleSpace, presetsButton, flexibleSpace, manualButton, flexibleSpace]
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
        print("Presets pressed")
        manualUIButton.setColor(.systemGray2)
        presetsUIButton.setColor(.systemBlue)
        updateToolBar()
        
        let items: [CheckboxCell] = parseJSONFile(filename: "Presets") ?? []
        
        presetsTableVC.configure(items)
        
        addChild(presetsTableVC)
        view.addSubview(presetsTableVC.view)
        
        presetsTableVC.view.translatesAutoresizingMaskIntoConstraints = false
        presetsTableVC.view.pin(to: view, [.top, .bottom, .left, .right])

        presetsTableVC.didMove(toParent: self)
    }
    
    @objc
    private func manualPressed() {
        print("Manual pressed")
        
        presetsUIButton.setColor(.systemGray2)
        manualUIButton.setColor(.systemBlue)

        updateToolBar()
        
        let items: [CheckboxCell] = parseJSONFile(filename: "Manual") ?? []
        
        manualTableVC.configure(items, checkboxActiveType: "indeterminate_check_box")
        
        addChild(manualTableVC)
        view.addSubview(manualTableVC.view)
        
        manualTableVC.view.translatesAutoresizingMaskIntoConstraints = false
        manualTableVC.view.pin(to: view, [.top, .bottom, .left, .right])

        manualTableVC.didMove(toParent: self)
    }
    
    private func parseJSONFile(filename: String) -> [CheckboxCell]? {
        // Get the path to the JSON file
        guard let path = Bundle.main.path(forResource: filename, ofType: "JSON") else {
            return nil
        }
        
        do {
            // Read the contents of the file
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            
            // Decode the JSON data into an array of CheckboxCell objects
            let decoder = JSONDecoder()
            let cells = try decoder.decode([CheckboxCell].self, from: data)
            
            return cells
        } catch {
            print("Error decoding JSON file: \(error)")
            return nil
        }
    }

    
    @objc
    private func goBackPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func donePressed() {
        
    }
}
