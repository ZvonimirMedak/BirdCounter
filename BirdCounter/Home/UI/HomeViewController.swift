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
    
    let counterLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupInteraction()
    }
}

private extension HomeViewController {
    
    func setupUI() {
        view.addSubviews(counterLabel, yellowBirdButton, brownBirdButton, redBirdButton, blueBirdButton)
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
            make.height.width.equalTo(40)
        }
        
        redBirdButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(30)
            make.height.width.equalTo(40)
        }
        
        brownBirdButton.snp.makeConstraints { (make) in
            make.top.equalTo(yellowBirdButton.snp.bottom).inset(-40)
            make.leading.equalTo(yellowBirdButton)
            make.height.width.equalTo(40)
        }
        
        blueBirdButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(40)
            make.top.equalTo(redBirdButton.snp.bottom).inset(30)
            make.trailing.equalTo(redBirdButton)
        }
    }
    
    func setupInteraction() {
        
    }
}
