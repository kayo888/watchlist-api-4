//
//  IndividualStockViewController.swift
//
//
//  Created by Ehi Airewele  on 7/17/17.
//
//

import UIKit
import Charts

class IndividualStockViewController: UIViewController {
    var stock: WatchlistStock?
    var newsArray = [NewsItem]()
    
    @IBOutlet weak var newsCollectionView: UICollectionView!
    @IBOutlet weak var individualStockView: UIView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var lineChartView: LineChartView!
    
    let pastelBlue = UIColor(red: 123.0/255.0, green: 148.0/255.0, blue: 206.0/255.0, alpha: 1.0)
    
    let sessions = ["11/1", "11/8", "11/15", "11/22", "11/29", "12/6"]
    
    let independentScores = [50.0, 60.0, 75.0, 80.0, 80.0, 80.0]
    var yVals1: [ChartDataEntry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setChart()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setChart() {
        yVals1 = insertChartDataEntry(independentScores)
        let lineChartDataSet1 = LineChartDataSet(values: yVals1, label: "Independent")
        lineChartDataSet1.setColor(pastelBlue)
        lineChartDataSet1.setCircleColor(pastelBlue)
        
        var lineChartDataSets: [LineChartDataSet] = []
        lineChartDataSets.append(lineChartDataSet1)
        
        //let lineChartData = LineChartData(xVals: sessions, dataSets: lineChartDataSets)
        
        let lineChartData = LineChartData(dataSets: lineChartDataSets)
        lineChartView.data = lineChartData
        
        lineChartView.chartDescription?.text = ""
        let limitLine = ChartLimitLine(limit: 80.0, label: "Target") // There's an alternative initializer without the label
        lineChartView.rightAxis.addLimitLine(limitLine)
        
        // Remove rightAxis labels. Comes from class ChartAxisBase.
        lineChartView.rightAxis.drawLabelsEnabled = false
        
        // Change the position of the x-axis labels
        lineChartView.xAxis.labelPosition = .bottom
        
        // Remove the chart's gray background color
        lineChartView.drawGridBackgroundEnabled = false
    }
    
    // Helper method
    func insertChartDataEntry(_ values: [Double]) -> [ChartDataEntry] {
        var chartDataEntries: [ChartDataEntry] = []
        for i in 0..<sessions.count {
            let yVal = ChartDataEntry(x: Double(i), y: values[i])
            chartDataEntries.append(yVal)
        }
        return chartDataEntries
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let stock = stock {
            nameLabel.text = stock.companyName
            priceLabel.text = "\(stock.price)"
            logo.image = stock.logo
            
            
        } else {
            
        }
    }
    
    func getNews () -> Void {
        let symbol = stock?.symbol
        
        NetworkRequest.getNews(symbol: symbol!) { (newsItems: [NewsItem]) in
            
            self.newsArray = newsItems
        }
        print("cheese")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            //            if identifier == "ShowNews" {
            //                let indexPath = stockView.indexPathsForSelectedItems?.first
            //
            //
            //                print(indexPath)
            //
            //                //                let stock = Stock[indexPath!.item]
            //                let individualStockViewController = segue.destination as! IndividualStockViewController
            //
            //                //                individualStockViewController.stock = stock
            //            }
            //        }
        }}
    
    
    
}

extension IndividualStockViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsViewCell", for: indexPath) as! NewsViewCell
        
        let newsCollection = newsArray[indexPath.item]
        cell.headlineLabel.text = newsCollection.headline
        cell.sourceLabel.text = newsCollection.source
        
        return cell
    }
    
}

extension IndividualStockViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let newsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "news") as! NewsViewController
        
        newsVC.url = self.newsArray[indexPath.item].url
        
        self.present(newsVC, animated: true, completion: nil)
    }
    
}



