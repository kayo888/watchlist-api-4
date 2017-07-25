 //
 //  StockViewCell.swift
 //  watchlist api
 //
 //  Created by Ehi Airewele  on 7/14/17.
 //  Copyright © 2017 Ehi Airewele . All rights reserved.
 //
 
 import UIKit
 import Kingfisher
 import Charts
 
 class StockViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var stockLogo: UIImageView!
    @IBOutlet weak var lineChartView: LineChartView!
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<values.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        print(dataEntries)
        
        
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "test")
        var dataSets = [IChartDataSet]()
        dataSets.append(lineChartDataSet)
        //let lineChartData = ChartData(dataSet: lineChartDataSet)
        
        //lineChartView.data = lineChartData
        lineChartView.data = LineChartData(dataSet: lineChartDataSet)
        /*
         lineChartView.animate(xAxisDuration: 1.0)
         */
    }
    
    
    
    /*
    override func awakeFromNib() {
        super.awakeFromNib()
        lineChartView.setNeedsDisplay()
        
        
        
    }
    */
 }
