//
//  trash.swift
//  watchlist api
//
//  Created by Ehi Airewele  on 7/12/17.
//  Copyright © 2017 Ehi Airewele . All rights reserved.
//

import Foundation

//    func parseGainerHTML(html: String) -> ([String]) {
//        let gainers = [String]()
//
//        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
//            for show in doc.css("<h3>Gainers</h3>[^ class='wsod_symbol']") {
//                let showString = show.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
//                let nameBegin = showString.substring(from: (showString.range(of: "<td><a href=\"/quote/quote.html?symb=")?.upperBound)!)
//                let gainerSymbol = nameBegin.substring(to: (nameBegin.range(of: "\"")?.lowerBound)!)
//                gainersArray.append(gainerSymbol)
//            }
//        }
//        return gainers
//    }
//
//
//let intTime = stringToTime(string: time)

//                        if (intTime.hour < dayMinute.hour) {
//                            let close = json["4. close"].doubleValue
//                            averages[time] = close
//                        } else if ((intTime.hour == dayMinute.hour) && (intTime.minute < dayMinute.minute)) {
//                            let average = json["average"].doubleValue
//                            averages[time] = average
//                        }
//
//    func parseLoserHTML(html: String) -> ([String]) {
//        let losers = [String]()
//
//        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
//            for show in doc.css("<h3>Losers</h3>[^ class='wsod_symbol']") {
//                let showString = show.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
//                let nameBegin = showString.substring(from: (showString.range(of: "<td><a href=\"/quote/quote.html?symb=")?.upperBound)!)
//                let loserSymbol = nameBegin.substring(to: (nameBegin.range(of: "\"")?.lowerBound)!)
//                losersArray.append(loserSymbol)
//            }
//        }
//        return losers
//    }







//    func handleStock(symbol: String, completion: @escaping (Stock) -> Void) {
//        let stockDataEndpoint = "\(Constants.AlphaVantage.alphaVantageBase)  \(Constants.AlphaVantageParameters.intradayFunction) \(symbol) \(Constants.AlphaVantageParameters.interval) \(Constants.AlphaVantageParameters.AlphaVantageKey)"
//
//        let stockInfoEndpoint = "\(Constants.IEX.IEXBase) {\(symbol)} \(Constants.IEXParameters.company)"
//
//        Alamofire.request(stockInfoEndpoint).validate().responseJSON() { response in
//            switch response.result {
//            case .success:
//                if let value = response.result.value {
//                    let json = JSON(value)
//                    let companyName = ["companyName"]
//                    let primaryExchange = ["primaryExchange"]
//                    let calculationPrice = ["calculationPrice"]
//                    let previousClose = ["previousClose"]
//                    let change = ["change"]
//                    let changePercent = ["changePercent"]
//                    let avgTotalVolume = ["avgTotalVolume"]
//                    let marketCap = ["marketCap"]
//                    let peRatio = ["peRatio"]
//                    let week52High = ["week52High"]
//                    let week52Low = ["week52Low"]
//
//                    let stock = Stock(symbol: symbol, companyName: companyName, logoURL: <#T##String#>, primaryExchange: primaryExchange, calculationPrice: calculationPrice, previousClose: previousClose, change: change, changePercent: changePercent, avgTotalVolume: avgTotalVolume, marketCap: marketCap, peRatio: peRatio, week52High: week52High, week52Low: week52Low)
//
//                    completion(stock)
//                }
//
//            case .failure(let error):
//                print(error)
//            }
//
//        }
//
//
//        // alamofire shit
//        // let json= JSON(value)
//        // let stock = Stock(..)
//        // completion(Stock)
//    }
//
//
//
//    private func escapedParameters(parameters: [String: AnyObject]) -> String {
//        if parameters.isEmpty {
//            return ""
//        } else {
//            var keyValuePairs = [String]()
//
//            for (key, value) in parameters {
//                // make sure that it is a string value
//                let stringValue = "\(value)"
//
//                let escapedValue = stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//
//                // append it
//                keyValuePairs.append(key + "=" + "\(escapedValue!)")
//            }
//            return "\(keyValuePairs)"
//        }
//
//
//
//
//
//
//
//
//
//
///}
//    var stock = Stock()
//    let dateFormatterGet = DateFormatter()
//    dateFormatterGet.dateFormat = "yyyy-MM-dd hh:mm:ss"
//    let calendar = NSCalendar.current
//    let hour = calendar.component(.hour, fromDate: NSDate)
//    let minutes = calendar.component(.minute, fromDate: NSDate)
//    let seconds = calendar.component(.seconds, fromDate: NSDate)

//    let date = NSDate()
//    var formatter = DateFormatter()
//    //    var formatter:DateFormatter = DateFormatter()
//    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//    formatter.timeZone = NSTimeZone(abbreviation: "EST")
//
//
//
//
//
//
//    let calendar = Calendar.current
//    let hour = calendar.component(.hour, from: date)
//    let minutes = calendar.component(.minute, from: date)
//    let seconds = calendar.component(.seconds, from: date)
//
//    //    formatter.dateStyle = .mediumStyle
//    formatter.timeStyle = .noStyle
//
//    // US English Locale (en_US)
//    dateFormatter.locale = Locale(identifier: "en_US")
//    print(dateFormatter.stringFromDate(date)) // Jan 2, 2001//    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//    let userCalendar = NSCalendar.current
//    let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
//    //    calendar.timeZone = NSTimeZone(name: "EST")
//    let requestedDateComponents: NSCalendar.Unit = [.year,
//                                                    .month,
//                                                    .day,
//                                                    .hour,
//                                                    .minute,
//                                                    .second
//    ]
//
//    func scrapeCNNMoneyGainers() -> Void {
//        Alamofire.request("http://money.cnn.com/data/hotstocks/index.html").responseString { response in
//            print("\(response.result.isSuccess)")
//            if let html = response.result.value {
//                self.parseGainerHTML(html: html)
//            }
//        }
//    }
//
//    func scrapeCNNMoneyLosers() -> Void {
//        Alamofire.request("http://money.cnn.com/data/hotstocks/index.html").responseString { response in
//            print("\(response.result.isSuccess)")
//            if let html = response.result.value {
//                self.parseLoserHTML(html: html)
//            }
//        }
//    }
