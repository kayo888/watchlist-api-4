//
//  NetworkProvider.swift
//  watchlist api
//
//  Created by Ehi Airewele  on 7/11/17.
//  Copyright © 2017 Ehi Airewele . All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

struct NetworkRequest {
    var stocks = [Stock]()
    var seconds = 60
    var timer = Timer()
    var isTimerRunning = false
    
    static func getTime() -> String {
        var date = Date()
        //        date.addTimeInterval(TimeInterval(-60))
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: date)
    }
    
    static func instantiateStock(symbol: String, completion: @escaping (WatchlistStock) -> Void) {
        var stockName = ""
        var stockLogo = UIImage()
        var stockPrice = 0.00
        var stockChange = 0.00
        var stockPercentage = 0.00
        
        let stockSymbol = symbol
        getStockName(symbol: symbol, completion: { (name) in
            let stockName = name
            getStockLogo(symbol: symbol) { (logo) in
                let stockLogo = logo
                
                getMinuteData(symbol: symbol) { (price, change, changePercentage) in
                    let stockPrice = price
                    let stockChange = change
                    let stockPercentage = changePercentage
                    
                    let object = WatchlistStock(symbol: stockSymbol, companyName: stockName, logo: stockLogo, price: stockPrice, changePercent: stockPercentage, change: stockChange)
                    
                    
                    completion(object)
                }
                
            }
            
        })
        
    }
    
    
    static func getStockName(symbol: String, completion: @escaping (String) -> Void) {
        let stockNameEndpoint = "\(Constants.IEX.IEXBase)\(symbol)\(Constants.IEXParameters.quote)"
        
        Alamofire.request(stockNameEndpoint).validate().responseJSON() { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    let name = json["companyName"].stringValue
                    completion(name)
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
    
    //    https://api.iextrading.com/1.0/stock/{symbol}/quote
    
    static func getStockLogo(symbol: String, completion: @escaping (UIImage) -> Void) {
        let stockLogoEndpoint = "\(Constants.IEX.IEXBase)\(symbol)\(Constants.IEXParameters.logo)"
        
        Alamofire.request(stockLogoEndpoint).validate().responseJSON() { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    let logo = json["url"].stringValue
                    
                    guard let url = URL(string: logo) else {
                        
                        print("error")
                        let image = UIImage(named: "notPoop.jpg")
                        completion(image!)
                        return
                    }
                    
                    
                    
                    let data = try? Data(contentsOf: url)
                    DispatchQueue.main.async {
                        
                        let image: UIImage = UIImage(data: (data)!)!
                        completion(image)
                    }
                }
            case .failure(let error):
                print(error)
                
            }
        }
    }
    //    https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=MSFT&interval=1min&apikey=demo
    //    time: String,
    
    static func getMinuteData(symbol: String, completion: @escaping (Double, Double, Double) -> Void) {
        let stockMinuteEndpoint = "\(Constants.AlphaVantage.alphaVantageBase)\(Constants.AlphaVantageParameters.intradayFunction)\(Constants.AlphaVantageParameters.symbolEqual)\(symbol)\(Constants.AlphaVantageParameters.interval1min)\(Constants.AlphaVantageParameters.AlphaVantageKey)"
        
        var close = 0.00
        var closeDayBefore = 0.00
        
        var time = Date()
        time.addTimeInterval(TimeInterval(-60))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(abbreviation: "EST")
        let resultTime = formatter.string(from: time)
        
        let date = Date()
        let formatDate = DateFormatter()
        formatDate.dateFormat = "yyyy-MM-dd"
        formatDate.timeZone = TimeZone(abbreviation: "EST")
        let resultDate = formatDate.string(from: date)
        
        let current = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.timeZone = TimeZone(abbreviation: "EST")
        let currentResult = dateFormatter.string(from: current)
        let calendar = Calendar.current
        
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: date)
        let resultYesterday = formatDate.string(from: yesterday!)
        let twoDays = Calendar.current.date(byAdding: .day, value: -2, to: date)
        let resultTwoDays = formatDate.string(from: twoDays!)
        let threeDays = Calendar.current.date(byAdding: .day, value: -3, to: date)
        let resultThreeDays = formatDate.string(from: threeDays!)
        
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: date)
        let (hour, minute) = stringToTime(string: resultTime)
        
        var between930And4 = (hour <= 16) && (hour >= 9)
        if (hour == 9) {
            if (minute >= 30) {
                between930And4 = true
            } else {
                between930And4 = false
            }
        } else if (hour == 16) {
            if (minute == 0) {
                between930And4 = true
            } else {
                between930And4 = false
            }
        }
        
        Alamofire.request(stockMinuteEndpoint).validate().responseJSON() { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    if (weekDay == 1) {
                        close = json["Time Series (1min)"]["\(resultTwoDays) 16:00:00"]["4. close"].doubleValue
                        closeDayBefore = json["Time Series (1min)"]["\(resultThreeDays) 16:00:00"]["4. close"].doubleValue
                    } else if (weekDay == 7) {
                        close = json["Time Series (1min)"]["\(resultYesterday) 16:00:00"]["4. close"].doubleValue
                        closeDayBefore = json["Time Series (1min)"]["\(resultTwoDays) 16:00:00"]["4. close"].doubleValue
                    } else if (!between930And4) {
                        close = json["Time Series (1min)"]["\(resultDate) 16:00:00"]["4. close"].doubleValue
                        closeDayBefore = json["Time Series (1min)"]["\(resultYesterday) 16:00:00"]["4. close"].doubleValue
                    } else {
                        close = json["Time Series (1min)"]["\(currentResult):00"]["4. close"].doubleValue
                        closeDayBefore = json["Time Series (1min)"]["\(resultYesterday) 16:00:00"]["4. close"].doubleValue
                    }
                    
                    close = Double(round(100 * close)/100)
                    let change = close - closeDayBefore
                    var changePercent = 0.00
                    
                    if (change < 0) {
                        changePercent = ((closeDayBefore - close)/(closeDayBefore)) * 100.00
                    } else if (change > 0) {
                        changePercent = ((close - closeDayBefore))/(closeDayBefore) * 100.00
                    } else {
                        changePercent = 0
                    }
                    completion(close, change, changePercent)
                }
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    static func stringToMinutes(input:String) -> Int {
        let components = input.components(separatedBy: ":")
        let hour = Int((components.first ?? "0")) ?? 0
        let minute = Int((components.last ?? "0")) ?? 0
        return hour*60 + minute
    }
    
    static func stringToTime(string: String) -> (hour: Int, minute: Int) {
        let result = string.components(separatedBy: ":")
        
        //let hour: Int = Int(result[0])!
        //let minute: Int = Int(result[1])!
        
        guard let hour = Int(result[0]), let minute = Int(result[1]) else {
            //print("hour \(hour) minute \(minute)")
            return (0, 1)
        }
        
        return (hour, minute)
        
    }
    
    static func getAverages (symbol: String, completion: @escaping ([String: Double]) -> Void) {
        let stockDataEndpoint = "\(Constants.IEX.IEXBase)\(symbol)\(Constants.IEXParameters.chartOneDay)"
        
        print(stockDataEndpoint)
        let time = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(abbreviation: "EST")
        let resultTime = formatter.string(from: time)
        
        let dayMinute = stringToTime(string: resultTime)
        var averages: [String:Double] = [:]
        
        Alamofire.request(stockDataEndpoint).validate().responseJSON() { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    let allTimeData = json.arrayValue
                    
                    for data in allTimeData {
                        let time = data["minute"].stringValue
                        let average = data["average"].doubleValue
                        
                            averages[time] = average
                        
                    }
//                    print(averages)
                    completion(averages)
                }
            case .failure(let error):
                print(error)
            }
            
            
        }
        
    }
    
    static func getNews (symbol: String, completion: @escaping ([NewsItem]) -> Void) {
        var newsItems = [NewsItem]()
        
        let newsEndpoint = "\(Constants.IEX.IEXBase)\(symbol)\(Constants.IEXParameters.stockNews)"
        
        Alamofire.request(newsEndpoint).validate().responseJSON() { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    let allNewsData = json.arrayValue
                    
                    for m in allNewsData {
                        let headline = json["headline"].stringValue
                        let source = json["source"].stringValue
                        let url = json["url"].url
                        let news = NewsItem(headline: headline, source: source, url: url!)
                        newsItems.append(news)
                        
                        completion(newsItems)
                    }
                }
            case .failure(let error):
                print(error)
            }
            
            
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
}

