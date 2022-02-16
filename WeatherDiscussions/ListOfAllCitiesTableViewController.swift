
import UIKit

class ListOfAllCitiesTableViewController: UITableViewController {

    let listOfCities: [String]

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    required init(listOfCities: [String]) {
        self.listOfCities = listOfCities
        super.init(style: .plain)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cityName")
        navigationItem.title = "Add Discussion City"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listOfCities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < listOfCities.count else {
            fatalError("Outside of listOfCities count")
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityName", for: indexPath)
        let cellTitle = listOfCities[indexPath.row]
        cell.textLabel?.text = cellTitle
        return cell
    }

}
