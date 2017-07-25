//
//  Stock.swift
//  watchlist api
//
//  Created by Ehi Airewele  on 7/11/17.
//  Copyright © 2017 Ehi Airewele . All rights reserved.
//

import UIKit

struct Stock {
    let symbol: String
    let companyName: String
    let logo: UIImage 
    let price: Double
    let changePercent: Double
    let change: Double
    
    let close: Double
    let primaryExchange: String
    let calculationPrice: String
    let previousClose: Double
    let avgTotalVolume: Int
    let marketCap: Int
    let peRatio: Double
    let week52High: Double
    let week52Low: Double
    
}
//change, change% is calculated using calculationPrice from previousClose.

struct WatchlistStock {
    let symbol: String
    let companyName: String
    let logo: UIImage
    let price: Double
    let changePercent: Double
    let change: Double
}


//graph - 174w 158h
//name & symbol bold and price etc. opaque 
