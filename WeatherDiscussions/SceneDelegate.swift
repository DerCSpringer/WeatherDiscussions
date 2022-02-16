
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        let viewModel = CityListViewModel()
        let viewController = CityListTableViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
    }

}

