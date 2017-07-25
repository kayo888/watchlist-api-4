//
//  NetworkConstants.swift
//  watchlist api
//
//  Created by Ehi Airewele  on 7/11/17.
//  Copyright © 2017 Ehi Airewele . All rights reserved.
//

import Foundation

struct Constants {
    //    https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=MSFT&interval=1min&apikey=demo
    
    
    struct AlphaVantage {
        static let alphaVantageBase = "https://www.alphavantage.co/query?"
    }

    struct AlphaVantageParameters {
        static let AlphaVantageKey = "&apikey=IBRP1HQPU3LCZNXZ"
        static let symbolEqual = "symbol="
        static let interval1min = "&interval=1min"
        static let interval30min = "&interval=30min"
        static let intradayFunction = "function=TIME_SERIES_INTRADAY&"
        static let dailyAdjustedFunction = "function=TIME_SERIES_DAILY_ADJUSTED&"
        static let weeklyFunction = "function=TIME_SERIES_WEEKLY&"
        static let monthlyFunction = "function=TIME_SERIES_MONTHLY&"
        static let sectorFunction = "SECTOR"
        //compare stocks based on others in their sector?
    }
    
//    struct AlphaVantageResponse {
//        static let closePrice = ""
//    
//    }
    
    //    https://api.iextrading.com/1.0/stock/{symbol}/quote

    struct IEX {
        static let IEXBase = "https://api.iextrading.com/1.0/stock/"
    }
    
    struct IEXParameters {
        static let fiveYear = "/chart/5y"
        static let twoYear = "/chart/2y"
        static let oneYear = "/chart/1y"
        static let yearToDate = "/chart/ytd"
        static let company = "/company"
        static let marketNews = "/market/news/last/10"
        static let stockNews = "/news/last/6"
        static let logo = "/logo"
        static let quote = "/quote"
        static let chartOneDay = "/chart/1d"
    }

//    let dateFormatter = NSDateFormatter()
//    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//    let date = dateFormatter.dateFromString("2015-09-01 00-32-40")
//    
//    // To convert the date into an HH:mm format
//    dateFormatter.dateFormat = "HH:mm"
//    let dateString = dateFormatter.stringFromDate(date!)
//    println(dateString)
    
//    struct time {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "HH:mm:ss"
//        static let openTime = ""
//        static let closeTime = ""
//        
//    }

}
