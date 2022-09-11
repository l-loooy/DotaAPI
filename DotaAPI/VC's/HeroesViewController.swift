//
//  ViewController.swift
//  DotaAPI
//
//  Created by admin on 28.08.2022.
//  Copyright © 2022 Sergey Lolaev. All rights reserved.
//

//https://api.opendota.com/api/heroStats
//https://api.opendota.com/apps/dota2/images/dota_react/heroes/antimage.png?
//https://api.opendota.com/apps/dota2/images/dota_react/heroes/icons/antimage.png?

import UIKit
import SnapKit

class HeroesViewController: UIViewController {
    
    private let heroesTableView = UITableView()
    private var heroes = [HeroModel]()
    var heroImages = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupTableView()
        getHero()
    }
    
    func getHero() {
        NetworkFetchData.shared.fetchHeroWith(K.URL.heroStatsUrl) { [weak self] heroModel, error in
            if error == nil {
                guard let hero = heroModel else {
                    return
                }
                
                //sorted heroes by name
                let sortedHeroesByNames = hero.sorted { s1, s2 -> Bool in
                    s1.localized_name < s2.localized_name
                }
                //self?.heroes.append(hero)
                //ошибка декодирования. почему я не мог добавить объект hero в массив heroes???
                //14 и 23 стр в NetworkFetchData
                self?.heroes = sortedHeroesByNames
                self?.heroesTableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    func getHeroImageWith(_ urlString: String) -> UIImage? {
        //2. Get valid URL
        guard let url = URL(string: urlString) else {
            return nil
        }
        var image: UIImage? = nil
        do {
            //3. Get valid data
            let data = try Data(contentsOf: url, options: [])
            //4. Make image
            image = UIImage(data: data)
        }
        catch {
            print(error.localizedDescription)
        }
        return image
    }
}


//MARK: - setConfiguration
extension HeroesViewController {
    
    private func setupNavigationController() {
        title = K.NavigationController.heroesVCTitle
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableView() {
        heroesTableView.register(UITableViewCell.self, forCellReuseIdentifier: K.reuseCellIdentifier)
        heroesTableView.delegate = self
        heroesTableView.dataSource = self
        self.view.addSubview(heroesTableView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        heroesTableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

//MARK: - UITableViewDelegate + UITableViewDataSource
extension HeroesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.reuseCellIdentifier, for: indexPath)
        cell.textLabel?.text = heroes[indexPath.row].localized_name.localizedUppercase
        
        let iconUrl = "\(K.URL.baseUrl)" + "\(heroes[indexPath.row].icon)"
        cell.imageView?.image = self.getHeroImageWith(iconUrl)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailHeroViewController = DetailHeroViewController()
        
        detailHeroViewController.nameLabel.text = heroes[indexPath.row].localized_name
        detailHeroViewController.attributeLabel.text = heroes[indexPath.row].primary_attr
        detailHeroViewController.attackLabel.text = heroes[indexPath.row].attack_type
        detailHeroViewController.legsCountLabel.text = String(heroes[indexPath.row].legs)
        
        //pass decoded image
        let imageUrl = "\(K.URL.baseUrl)" + "\(heroes[indexPath.row].img)"
        detailHeroViewController.heroImage.image = getHeroImageWith(imageUrl)
        
        self.navigationController?.pushViewController(detailHeroViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(K.Table.rowHeight)
    }
    
}


