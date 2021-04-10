//
//  HomeViewModel.swift
//  BirdCounter
//
//  Created by Zvonimir Medak on 10.04.2021..
//

import Foundation
import RxSwift
import RxCocoa

public enum HomeUserInteractionType {
    case birdSeen(type: BirdType)
    case reset
}


class HomeViewModel {
    
    public let loadDataSubject: ReplaySubject<()>
    public let userInteractionSubject: PublishSubject<HomeUserInteractionType>
    private let databaseRepository: DatabaseRepository
    public var screenData: BehaviorRelay<CounterItem>
    
    
    
    init(loadDataSubject: ReplaySubject<()>, userInteractionSubject: PublishSubject<HomeUserInteractionType>, screenData: BehaviorRelay<CounterItem>, databaseRepository: DatabaseRepository) {
        self.loadDataSubject = loadDataSubject
        self.userInteractionSubject = userInteractionSubject
        self.screenData = screenData
        self.databaseRepository = databaseRepository
    }
    
    func initilaizeVM() -> [Disposable] {
        var disposables: [Disposable] = []
        disposables.append(initializeLoadDataObservable(for: loadDataSubject))
        disposables.append(initiliazeUserInteractionObservable(for: userInteractionSubject))
        return disposables
    }
}

private extension HomeViewModel {
    
    func initializeLoadDataObservable(for subject: ReplaySubject<()>) -> Disposable {
        return subject
            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .map({ [unowned self] (_) -> CounterItem in
                return createScreenData()
            })
            .subscribe(onNext: { [unowned self] (item) in
                screenData.accept(item)
            })
    }
    
    func createScreenData() -> CounterItem {
        let counter = databaseRepository.getCounter()
        let birdTypeString = databaseRepository.getLastBirdType()
        var birdType: BirdType?
        switch birdTypeString {
        case "yellow":
            birdType = .yellow
        case "brown":
            birdType = .brown
        case "blue":
            birdType = .blue
        case "red":
            birdType = .red
        default:
            birdType = nil
        }
        return CounterItem(counter: counter, birdType: birdType)
    }
}

private extension HomeViewModel {
    
    func initiliazeUserInteractionObservable(for subject: PublishSubject<HomeUserInteractionType>) -> Disposable {
        return subject
            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [unowned self] (type) in
                handleUserInteraction(for: type)
            })
    }
    
    func handleUserInteraction(for type: HomeUserInteractionType) {
        switch type {
        case .birdSeen(let birdType):
            databaseRepository.birdChanged(bird: birdType)
            loadDataSubject.onNext(())
        case .reset:
            databaseRepository.reset()
            loadDataSubject.onNext(())
        }
    }
}
