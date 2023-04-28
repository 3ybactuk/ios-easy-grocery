import UIKit

final class SettingsViewController: UITableViewController {
    let switchControl = UISwitch()
    let exitCell = UITableViewCell(style: .default, reuseIdentifier: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        navigationController?.isToolbarHidden = true
        setupUI()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
        navigationController?.isToolbarHidden = true
    }
    
    // MARK:- Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        tableView.backgroundColor = .systemGroupedBackground
        tableView.separatorStyle = .none
        
        setupExitCell()

        tableView.tableFooterView = exitCell
        
        switchControl.isOn = true
        switchControl.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)

        setupNavbar()
    }
    
    private func setupExitCell() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(exitCellTapped))
        
        exitCell.textLabel?.text = "Выход из аккаунта"
        exitCell.textLabel?.textAlignment = .center
        exitCell.textLabel?.textColor = .systemRed
        exitCell.backgroundColor = .white
        exitCell.accessoryType = .none
        exitCell.addGestureRecognizer(tapGesture)
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 1
        case 2:
            return 0
        default:
            return 0
        }
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = "Row \(indexPath.row + 1), Section \(indexPath.section + 1)"
//        cell.accessoryType = .disclosureIndicator
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(accountSettingsTapped))
                cell.textLabel?.text = "Настройки аккаунта"
                cell.accessoryType = .disclosureIndicator
                cell.addGestureRecognizer(tapGesture)
            case 1:
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(notificationSettingsTapped))
                cell.textLabel?.text = "Настройки предпочтений"
                cell.accessoryType = .disclosureIndicator
                cell.addGestureRecognizer(tapGesture)
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Скрывать неподходящие продукты"
                cell.accessoryView = switchControl
            default:
                break
            }
        case 2:
            break
//            switch indexPath.row {
//            case 0:
//                cell.textLabel?.text = "Выйти из аккаунта"
//                cell.textLabel?.textColor = .systemRed
//            default:
//                break
//            }
        default:
            break
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        view.backgroundColor = .clear
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // Returns height - blank space between groups of cells
        return 40
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    func logOff() {
        UserDefaults.standard.set(false, forKey: "is_authenticated")
        
        // Remove the current root view controller from the window
        guard let window = UIApplication.shared.windows.first else { return }
        navigationController?.popToRootViewController(animated: false)
        window.rootViewController?.dismiss(animated: true, completion: nil)
        
        // Create an instance of the login view controller
        let loginVC = LoginViewController()
        
        // Set the login view controller as the root view controller of the window
        window.rootViewController = loginVC
        window.makeKeyAndVisible()
    }
    
    @objc func exitCellTapped() {
        print("Exit cell pressed")
        logOff()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func accountSettingsTapped() {
        
    }
    
    @objc func notificationSettingsTapped() {
        
    }
    
    @objc func switchValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            print("Switch is on")
            // Switch is on
        } else {
            print("Switch is off")
            // Switch is off
        }
    }

}

