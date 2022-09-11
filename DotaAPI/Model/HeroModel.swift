//
//  HeroStatsModel.swift
//  DotaAPI
//
//  Created by admin on 09.09.2022.
//  Copyright © 2022 Sergey Lolaev. All rights reserved.
//

import Foundation

struct HeroModel: Decodable {
    let localized_name: String
    let primary_attr: String
    let attack_type: String
    let legs: Int
    let img: String
    let icon: String
}
