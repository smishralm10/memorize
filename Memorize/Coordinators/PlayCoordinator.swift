//
//  PlayCoordinator.swift
//  Memorize
//
//  Created by AB027CJ on 2023/01/28.
//
import UIKit

class PlayCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let playViewController = PlayViewController.instantiate(from: .Main)
        let playViewModel = PlayViewModel()
        playViewModel.coordinator = self
        playViewController.viewModel = playViewModel
        navigationController.pushViewController(playViewController, animated: true)
    }
}
