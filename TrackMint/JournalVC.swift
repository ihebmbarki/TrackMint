//
//  JournalVC.swift
//  TrackMint
//
//  Created by Iheb Mbarki on 23/9/2025.
//

import UIKit

class JournalVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // Dummy trades
    var trades: [Trade] = [
        Trade(coin: "BTC", entry: 25000, exit: 27000, quantity: 0.1, date: Date(), type: .long, notes: "Strong breakout from resistance."),
        Trade(coin: "ETH", entry: 1600, exit: 1500, quantity: 1, date: Date(), type: .short, notes: "Expected pullback after overbought RSI."),
        Trade(coin: "SOL", entry: 22.5, exit: 28.6, quantity: 5, date: Date(), type: .short, notes: "Tried shorting, got squeezed."),
        Trade(coin: "ADA", entry: 0.35, exit: 0.40, quantity: 300, date: Date(), type: .long, notes: "Scalp trade, small profit target."),
        Trade(coin: "XRP", entry: 0.50, exit: 0.44, quantity: 200, date: Date(), type: .long, notes: "News-driven entry."),
        Trade(coin: "DOGE", entry: 0.075, exit: 0.090, quantity: 1000, date: Date(), type: .long, notes: "Meme trade."),
        Trade(coin: "BNB", entry: 310, exit: 295, quantity: 2, date: Date(), type: .short, notes: "Test trade, small position.")
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Journal"
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        if let addVC = storyboard?.instantiateViewController(withIdentifier: "AddTradeVC") as? AddTradeVC {
            addVC.onSave = { [weak self] newTrade in
                self?.trades.append(newTrade)
                self?.tableView.reloadData()
            }
            navigationController?.pushViewController(addVC, animated: true)
        }
    } 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trades.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let trade = trades[indexPath.row]
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "TradeDetailVC") as? TradeDetailVC {
            detailVC.trade = trade
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TradeCell", for: indexPath) as? TradeCell else {
            fatalError("Could not dequeue TradeCell")
        }
        
        let trade = trades[indexPath.row]
        cell.coinLabel.text = trade.coin
        cell.dateLabel.text = trade.date.formatted()
        
        // Profit/Loss absolute value
        let profitLoss = trade.profitLoss
        let pnlText = String(format: "%@%.3f USDT", profitLoss >= 0 ? "+" : "", profitLoss)
        cell.pnlLabel.text = pnlText
        cell.pnlLabel.textColor = profitLoss >= 0 ? .systemGreen : .systemRed
        
        // Percentage Change
        let percentage = trade.percentageChange
        let percentageText = String(format: "%@%.3f%%", percentage >= 0 ? "+" : "", percentage)
        cell.percentageLabel.text = percentageText
        
        // Coin Image
//         switch trade.coin.uppercased() {
//         case "BTC":
//             cell.coinImageView.image = UIImage(named: "btc")
//         case "ETH":
//             cell.coinImageView.image = UIImage(named: "eth")
//         case "SOL":
//             cell.coinImageView.image = UIImage(named: "sol")
//         case "ADA":
//             cell.coinImageView.image = UIImage(named: "ada")
//         case "XRP":
//             cell.coinImageView.image = UIImage(named: "xrp")
//         case "BNB":
//             cell.coinImageView.image = UIImage(named: "bnb")
//         case "DOGE":
//             cell.coinImageView.image = UIImage(named: "doge")
//         default:
//             cell.coinImageView.image = UIImage(systemName: "bitcoinsign.circle")
//         }
        
        // Coin Image (optimized)
        let imageName = trade.coin.lowercased()
        cell.coinImageView.image = UIImage(named: imageName) ?? UIImage(systemName: "bitcoinsign.circle")

        
        return cell
    }

}

//#Preview {
//    JournalVC()
//}
