import UIKit

class ViewController: UIViewController {
    let loginView = LoginView()
    let nameLabel = UILabel()
    let descLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.isToolbarHidden = true
        view.backgroundColor = .systemGray6
        self.loginView.viewControllerDelegate = self
        
        setupLoginViewSV()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        navigationController?.isToolbarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func setupLoginViewSV() {
        loginView.layer.applyShadow(2.0)
        view.addSubview(loginView)

        loginView.translatesAutoresizingMaskIntoConstraints = false
        loginView.pin(to: view, [.left, .right], 24)
        loginView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor, 8)
        
        nameLabel.text = "Easy Grocery"
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont(name: "Happy Monkey", size: 48)
        nameLabel.textColor = UIColor.black
        nameLabel.font = nameLabel.font.withSize(48)
    
        descLabel.text = "помощник для людей с ограничениями питания"
        descLabel.textAlignment = .center
        descLabel.font = UIFont(name: "Fira Sans", size: 8)
        descLabel.textColor = UIColor.black
        descLabel.lineBreakMode = .byWordWrapping
        descLabel.numberOfLines = 2
        
        view.addSubview(nameLabel)
        view.addSubview(descLabel)
        
        nameLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 128)
        nameLabel.pinCenterX(to: view)
        
        descLabel.pinTop(to: nameLabel.bottomAnchor)
        descLabel.pinCenterX(to: view)
        descLabel.setWidth(256)
    }
}


protocol ViewControllerDelegate {
    func loggedIn()
    func switchToSearch()
}

extension ViewController: ViewControllerDelegate {
    func loggedIn() {
        print("Logged in invoked")
        let preferencesViewController = PreferencesViewController()
        preferencesViewController.viewControllerDelegate = self
//        self.present(preferencesViewController, animated: true, completion: nil)
//        navigationController?.isNavigationBarHidden = false
        navigationController?.pushViewController(preferencesViewController, animated: true)
    }
    
    func switchToSearch() {
        print("Search invoked")
        let searchViewController = SearchPageViewController()
        navigationController?.pushViewController(searchViewController, animated: true)
    }
}

