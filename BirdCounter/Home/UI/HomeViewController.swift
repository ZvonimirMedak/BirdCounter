//
//  HomeViewController.swift
//  BirdCounter
//
//  Created by Zvonimir Medak on 10.04.2021..
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift

class HomeViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let counterLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    let yellowBirdButton: UIButton = {
        let button = UIButton()
        button.setTitle("YELLOW", for: .normal)
        button.backgroundColor = .yellow
        return button
    }()
    
    let brownBirdButton: UIButton = {
        let button = UIButton()
        button.setTitle("BROWN", for: .normal)
        button.backgroundColor = .brown
        return button
    }()
    
    let redBirdButton: UIButton = {
        let button = UIButton()
        button.setTitle("RED", for: .normal)
        button.backgroundColor = .red
        return button
    }()
    
    let blueBirdButton: UIButton = {
        let button = UIButton()
        button.setTitle("BLUE", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("RESET", for: .normal)
        button.backgroundColor = .cyan
        return button
    }()
    
    private let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupInteraction()
        initializeVM()
        viewModel.loadDataSubject.onNext(())
    }
}

private extension HomeViewController {
    
    func setupUI() {
        view.addSubviews(counterLabel, yellowBirdButton, brownBirdButton, redBirdButton, blueBirdButton, resetButton)
        view.backgroundColor = .white
        setupConstraints()
    }
    
    func setupConstraints() {
        counterLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(50)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
        
        yellowBirdButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(30)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
        
        redBirdButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(30)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
        
        brownBirdButton.snp.makeConstraints { (make) in
            make.top.equalTo(yellowBirdButton.snp.bottom).inset(-40)
            make.leading.equalTo(yellowBirdButton)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
        
        blueBirdButton.snp.makeConstraints { (make) in
            make.width.equalTo(80)
            make.height.equalTo(40)
            make.top.equalTo(redBirdButton.snp.bottom).inset(-40)
            make.trailing.equalTo(redBirdButton)
        }
        
        resetButton.snp.makeConstraints { (make) in
            make.width.equalTo(80)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalTo(blueBirdButton.snp.bottom).inset(-40)
        }
    }
}

private extension HomeViewController {
    
    func initializeVM() {
        disposeBag.insert(viewModel.initilaizeVM())
        initializeScreenDataObservable(for: viewModel.screenData).disposed(by: disposeBag)
    }
    
    func initializeScreenDataObservable(for subject: BehaviorRelay<CounterItem>) -> Disposable {
        return subject
            .observe(on: MainScheduler.instance)
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [unowned self] (item) in
                handleItemChange(for: item)
            })
    }
    
    func handleItemChange(for item: CounterItem) {
        counterLabel.text = String(item.counter)
        switch item.birdType {
        case .yellow:
            counterLabel.backgroundColor = .yellow
        case .brown:
            counterLabel.backgroundColor = .brown
        case .red:
            counterLabel.backgroundColor = .red
        case .blue:
            counterLabel.backgroundColor = .blue
        default:
            counterLabel.backgroundColor = .white
        }
    }
    
    func setupInteraction() {
        yellowBirdButton.rx.tap
            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [unowned self] in
                viewModel.userInteractionSubject.onNext(.birdSeen(type: .yellow))
            })
            .disposed(by: disposeBag)
        
        redBirdButton.rx.tap
            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [unowned self] in
                viewModel.userInteractionSubject.onNext(.birdSeen(type: .red))
            })
            .disposed(by: disposeBag)
        
        blueBirdButton.rx.tap
            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [unowned self] in
                viewModel.userInteractionSubject.onNext(.birdSeen(type: .blue))
            })
            .disposed(by: disposeBag)
        
        brownBirdButton.rx.tap
            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [unowned self] in
                viewModel.userInteractionSubject.onNext(.birdSeen(type: .brown))
            })
            .disposed(by: disposeBag)
        
        resetButton.rx.tap
            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [unowned self] in
                viewModel.userInteractionSubject.onNext(.reset)
            })
            .disposed(by: disposeBag)
    }
}
