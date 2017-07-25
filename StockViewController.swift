//
//  StockViewController.swift
//  watchlist api
//
//  Created by Ehi Airewele  on 7/10/17.
//  Copyright © 2017 Ehi Airewele . All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Kanna
import Charts

class StockViewController: UIViewController {
    @IBOutlet weak var stockView: UICollectionView!
    
    var stock: WatchlistStock?
    
    //    var symbol = "DE"
    var gainersArray: [WatchlistStock] = []
    var losersArray: [WatchlistStock] = []
    var moversArray: [WatchlistStock] = []
    
    
    var timer = Timer()
    
    var result = ""
    
    var timesArray = [String]()
    var valuesArray = [Double]()
    
    
    func countdown() {
        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    
    
    func updateTime(symbol: String? = nil) {
        
        let gainers: [String] = getGainerSymbols()!
        let losers: [String] = getLoserSymbols()!
        
        for gainerSymbol in gainers {
            getSymbolInfo(symbol: gainerSymbol) { (WatchlistStock) in
                self.gainersArray.append(WatchlistStock)
                self.moversArray.append(WatchlistStock)
            }
            
        }
        
        for loserSymbol in losers {
            getSymbolInfo(symbol: loserSymbol) { (WatchlistStock) in
                self.losersArray.append(WatchlistStock)
                self.moversArray.append(WatchlistStock)
                
                if self.losersArray.count == losers.count {
                    self.stockView.reloadData()
                }
            
            }
            //only get 9 gainers, losers not 10
            
        }
        /*
        for mover in moversArray {
            NetworkRequest.getAverages(symbol: mover.symbol) { (dict: [String : Double]) in
                self.timesArray = Array(dict.keys)
                self.valuesArray = Array(dict.values)
                
                //cell.setChart(dataPoints: timesArray, values: valueArray)
                DispatchQueue.main.async {
                    self.stockView.reloadData()
                }
            }
        }
        */
        
        
        
    }
    
    func getSymbolInfo(symbol: String? = nil, completion: @escaping (WatchlistStock) -> Void) {
        NetworkRequest.instantiateStock(symbol: symbol!) { (WatchlistStock) in
            //            print(WatchlistStock)
            completion(WatchlistStock)
        }
        //        completion(nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateTime()
    }
    
    
    func getGainerSymbols () -> [String]? {
        let myURLString = "https://docs.google.com/spreadsheets/d/15ta-RCEJkfdAQaajjMKkHtsh49benIAremVKvOMKfGo/pub?gid=1507041037&single=true&output=tsv"
        
        if let myURL = URL(string: myURLString) {
            
            do {
                let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
                let rows = myHTMLString.components(separatedBy: "\r\n")
                var symbols : [String] = []
                for (_, row) in rows.enumerated() {
                    for (j, item) in row.components(separatedBy: "\t").enumerated() {
                        let item = item.components(separatedBy: " ")
                        if j == 0 {
                            symbols.append(String(describing: item))
                        }
                    }
                }
                symbols.remove(at: 0)
                symbols.remove(at: 1)
                var filteredArray = [String]()
                for symbol in symbols {
                    let itemString = String(describing: symbol)
                    let itemSeperated = itemString.components(separatedBy: ",")
                    let code = itemSeperated.first
                    let test = code?.replacingOccurrences(of: "[\"", with: " ").replacingOccurrences(of: "\"" , with: " ").trimmingCharacters(in: .whitespaces)
                    filteredArray.append(test!)
                }
                return filteredArray
                
            } catch let error {
                print("Error: \(error)")
            }
        }
        return nil
    }
    
    func getLoserSymbols () -> [String]? {
        let myURLString = "https://docs.google.com/spreadsheets/d/15ta-RCEJkfdAQaajjMKkHtsh49benIAremVKvOMKfGo/pub?gid=1816177020&single=true&output=tsv"
        
        if let myURL = URL(string: myURLString) {
            
            do {
                let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
                let rows = myHTMLString.components(separatedBy: "\r\n")
                var symbols : [String] = []
                for (_, row) in rows.enumerated() {
                    for (j, item) in row.components(separatedBy: "\t").enumerated() {
                        let item = item.components(separatedBy: " ")
                        if j == 0 {
                            symbols.append(String(describing: item))
                        }
                    }
                }
                symbols.remove(at: 0)
                symbols.remove(at: 1)
                var filteredArray = [String]()
                for symbol in symbols {
                    let itemString = String(describing: symbol)
                    let itemSeperated = itemString.components(separatedBy: ",")
                    let code = itemSeperated.first
                    let test = code?.replacingOccurrences(of: "[\"", with: " ").replacingOccurrences(of: "\"" , with: " ").trimmingCharacters(in: .whitespaces)
                    filteredArray.append(test!)
                }
                
                return filteredArray
                
            } catch let error {
                print("Error: \(error)")
            }
        }
        return nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "ShowIndividualStock" {
                let indexPath = stockView.indexPathsForSelectedItems?.first
                
                
                print(indexPath)
                
                //                let stock = Stock[indexPath!.item]
                let individualStockViewController = segue.destination as! IndividualStockViewController
                individualStockViewController.stock = moversArray[(indexPath?.row)!]
                //                individualStockViewController.stock = stock
            }
        }
    }
    
}


extension StockViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moversArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WatchlistStockViewCell", for: indexPath) as! StockViewCell
        
        let watchListStock = moversArray[indexPath.item]
        cell.nameLabel.text = "(\(watchListStock.symbol))\(watchListStock.companyName)"
        cell.priceLabel.text = "$\(watchListStock.price)"
        cell.stockLogo.image = watchListStock.logo
        
//        NetworkRequest.getAverages(symbol: watchListStock.symbol) { (dict: [String : Double]) in
//            let timesArray = Array(dict.keys)
//            let valueArray = Array(dict.values)
//          
//            cell.setChart(dataPoints: timesArray, values: valueArray)
// 
//        }
        //cell.setChart(dataPoints: timesArray, values: valuesArray)
       // cell.lineChartView.setNeedsDisplay()
        
        return cell
        
    }
    
}

extension StockViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    
    
}
















