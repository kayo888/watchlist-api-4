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
    @IBOutlet weak var individualLineChartView: LineChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension IndividualStockViewController: 



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









