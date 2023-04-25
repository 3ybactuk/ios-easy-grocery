import UIKit

final class SettingsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        navigationController?.isToolbarHidden = true
        setupUI()
        
    }
    
    // MARK:- Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        setupNavbar()
    }
    
    private func setupNavbar() {
        navigationItem.title = "Настройки"

//        navigationItem.leftBarButtonItem = UIBarButtonItem(
//            image: nil,
//            style: .plain,
//            target: self,
//            action: nil //#selector(goBackPressed)
//        )
//
//        navigationItem.rightBarButtonItem = UIBarButtonItem(
//            image: UIImage(systemName: "line.horizontal.3"),
//            style: .done,
//            target: self,
//            action: #selector(settingsPressed)
//        )
//        navigationItem.rightBarButtonItem?.tintColor = .label
    }

}
