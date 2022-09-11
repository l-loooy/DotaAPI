//
//  Constants.swift
//  DotaAPI
//
//  Created by admin on 11.09.2022.
//  Copyright © 2022 Sergey Lolaev. All rights reserved.
//

import Foundation

struct K {
    static let reuseCellIdentifier = "heroCell"
    
    struct Table {
        static let rowHeight = 70
    }
    
    struct NavigationController {
        static let heroesVCTitle = "Heroes"
        static let detailVCTitle = "Detail hero info"
    }
    
    struct URL {
        static let baseUrl = "https://api.opendota.com"
        static let heroStatsUrl = "https://api.opendota.com/api/heroStats"
    }
}
