import UIKit

class CheckboxTableViewController: UITableViewController {
    var items: [CheckboxCell] = []
    var selectedItems: [CheckboxCell] = []
    var checkboxInActiveType = String()
    var checkboxActiveType = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CheckboxTableViewCell.self, forCellReuseIdentifier: "CheckboxCell")
        tableView.allowsSelection = false
//        tableView.estimatedRowHeight = 100
//        tableView.rowHeight = UITableView.automaticDimension
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(items.count)
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CheckboxCell", for: indexPath) as? CheckboxTableViewCell else {
            fatalError("Unable to dequeue CheckboxTableViewCell")
        }

        let item = items[indexPath.row]
        cell.titleLabel.text = item.title
        cell.descriptionLabel.text = item.description
        cell.checkboxButton.isSelected = selectedItems.contains(item)
        cell.checkboxButton.addTarget(self, action: #selector(checkboxTapped(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    func configure(_ items: [CheckboxCell], checkboxInactiveType: String = "square", checkboxActiveType: String = "checkmark.square.fill") {
        self.items.append(contentsOf: items)
        self.checkboxActiveType = checkboxActiveType
        self.checkboxInActiveType = checkboxInactiveType
    }

    // MARK: - Checkbox button action

    @objc private func checkboxTapped(sender: CheckboxButton) {
        guard let cell = sender.superview as? CheckboxTableViewCell,
              let indexPath = tableView.indexPath(for: cell) else {
            return
        }

        let item = items[indexPath.row]
        if sender.isSelected {
            selectedItems.append(item)
        } else {
            if let index = selectedItems.firstIndex(of: item) {
                selectedItems.remove(at: index)
            }
        }
        print(selectedItems)
    }
}
