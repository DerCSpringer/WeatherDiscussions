
import UIKit


class CityCell: UITableViewCell {
    
}

class CityListTableViewController: UITableViewController {
    
    var viewModel: CityListViewModel?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(viewModel: CityListViewModel) {
        self.viewModel = viewModel
        super.init(style: .plain)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cityName")
        navigationItem.title = "Discussion Cities"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                 target: self,
                                                                 action: #selector(Self.didPushAddCityBarButtonitem))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    @objc func didPushAddCityBarButtonitem() {
        let allCities = viewModel?.allAvailableCityList() ?? [""]
        let cityList = ListOfAllCitiesTableViewController(listOfCities: allCities)
        cityList.tableView.delegate = self
        navigationController?.pushViewController(cityList, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRows() ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityName")
        let cellTitle = viewModel?.listOfCitiesToDisplay(indexPath: indexPath)
        cell?.textLabel?.text = cellTitle
        return cell ?? UITableViewCell()
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tableView  {
        let weatherDiscussion = viewModel?.cityAbbreviationFor(indexPath:indexPath) ?? ""
            let discussionViewController = DiscussionTextViewController(forecastOffice: weatherDiscussion)
        navigationController?.pushViewController(discussionViewController, animated: true)
        } else {
            viewModel?.addCity(indexPath: indexPath)
            self.navigationController?.popViewController(animated: true)
        }
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indePath: IndexPath) -> Bool {
        true
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tableView == self.tableView {
            return UISwipeActionsConfiguration.init(actions: [UIContextualAction.init(style: .destructive, title: "Delete", handler: { [weak self] action, view, block in
                guard let weakSelf = self else {
                    return
                }
                weakSelf.viewModel?.removeCity(indexPath: indexPath)
                weakSelf.tableView.reloadData()
            })])
        }
        return nil
    }

}
