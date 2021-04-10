//
//  AppDelegate.swift
//  BirdCounter
//
//  Created by Zvonimir Medak on 10.04.2021..
//

import UIKit
import RxSwift
import RxCocoa
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else {return false}
        let initialViewController = UINavigationController(rootViewController: HomeViewController(viewModel: HomeViewModel(loadDataSubject: ReplaySubject<()>.create(bufferSize: 1), userInteractionSubject: PublishSubject<HomeUserInteractionType>(), screenData: BehaviorRelay<CounterItem>.init(value: CounterItem(counter: 0, birdType: nil)), databaseRepository: DatabaseRepositoryImpl())))
        window.rootViewController = initialViewController
        window.makeKeyAndVisible()
        return true
    }


}

