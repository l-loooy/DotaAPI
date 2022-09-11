//
//  DetailHeroViewController.swift
//  DotaAPI
//
//  Created by admin on 28.08.2022.
//  Copyright © 2022 Sergey Lolaev. All rights reserved.
//

import UIKit

class DetailHeroViewController: UIViewController {

    private var labelsStack = UIStackView()
    
    var heroImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .blue
        return image
    }()
    
     var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .black
        return label
    }()
    
     var attributeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Attribute"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .black
        return label
    }()
    
     var attackLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Attack"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .black
        return label
    }()
    
     var legsCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "LegsCount"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraint()
        setupNavigationController()
    }
}

//MARK: - setConfiguration
extension DetailHeroViewController {
    
    private func setupNavigationController() {
        title = K.NavigationController.detailVCTitle
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupViews() {
        labelsStack = UIStackView(arrangedSubviews: [nameLabel, attributeLabel, attackLabel, legsCountLabel],
                                  axis: .vertical,
                                  spacing: 20,
                                  distribution: .fillEqually)
    }
    
    private func setupConstraint() {
        view.addSubview(labelsStack)
        labelsStack.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(200)
        }
        
        view.addSubview(heroImage)
        heroImage.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(200)
            make.bottom.equalTo(labelsStack.snp.top).offset(-50)
        }
    } 
}
