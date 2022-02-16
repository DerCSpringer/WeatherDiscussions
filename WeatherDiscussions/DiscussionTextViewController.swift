
import UIKit

class DiscussionTextViewController: UIViewController {

    let forecastOffice: String

    required init(forecastOffice: String) {
        self.forecastOffice = forecastOffice
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createTextArea()
    }

    func createTextArea() {
        let textView = UITextView()

        view.addSubview(textView)

        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8.0).isActive = true

        textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8.0).isActive = true

        textView.text = "Loading...."
        textView.isEditable = false
        let font = textView.font
        textView.font = font?.withSize(21.0)

        WeatherAPI.weatherDiscussionFor(forecastOffice: forecastOffice) { forecastText in
            DispatchQueue.main.async {
                textView.text = forecastText
            }
        }

    }
    

}
