//
//  TradeDetailVC.swift
//  TrackMint
//
//  Created by Iheb Mbarki on 27/9/2025.
//

import UIKit

//create Tableview (list of details)
//cell 1: 2 labels 1 static holder 2 dynamic data)
//cell 2: p/l
//cell 3: Notes
//OR Stack (done storyboard)
//Compare 2 gpt same for add trade later
// -> Stack for fixed fields(our case) faster, easier to style -> switch to tableView for scalability (more flexible in case we add more trade attributes later)

class TradeDetailVC: UIViewController {
    var trade: Trade?
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var coinImageView: UIImageView!
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var entryLabel: UILabel!
    @IBOutlet weak var exitLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var pnlLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    
    private let coinNames: [String: String] = [
        "BTC": "Bitcoin",
        "ETH": "Ethereum",
        "SOL": "Solana",
        "ADA": "Cardano",
        "XRP": "Ripple",
        "DOGE": "Dogecoin",
        "BNB": "Binance Coin"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    private func configureUI() {
        guard let trade = trade else { return }
        
        // Card View
        cardView.layer.cornerRadius = 12
        cardView.clipsToBounds = true
        
        // Coin Image
        let imageName = trade.coin.lowercased()
        coinImageView.image = UIImage(named: imageName) ?? UIImage(systemName: "bitcoinsign.circle")
        
        // Coin
        if let fullName = coinNames[trade.coin.uppercased()] {
            coinLabel.text = fullName
        } else {
            coinLabel.text = trade.coin.uppercased()
        }

        // Entry
        entryLabel.text = String(format: "%.2f USDT", trade.entry)
        exitLabel.text = String(format: "%.2f USDT", trade.exit)
        quantityLabel.text = String(format: "%.3f %@", trade.quantity, trade.coin.uppercased())
        
        // Trade Type Badge
        typeLabel.text = trade.type == .long ? "LONG" : "SHORT"
        typeLabel.textColor = .white
        typeLabel.font = UIFont.boldSystemFont(ofSize: 10)
        typeLabel.textAlignment = .center
        typeLabel.layer.cornerRadius = 10
        typeLabel.layer.masksToBounds = true
        typeLabel.backgroundColor = trade.type == .long ? .systemGreen : .systemRed
        typeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        typeLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        // PnL
        let profitLoss = trade.profitLoss
        pnlLabel.text = String(format: "%@%.2f USDT", profitLoss >= 0 ? "+" : "", profitLoss)
        pnlLabel.textColor = profitLoss >= 0 ? .systemGreen : .systemRed
        
        // Percentage
        let percentage = trade.percentageChange
        percentageLabel.text = String(format: "%@%.2f%%", percentage >= 0 ? "+" : "", percentage)
        percentageLabel.textColor = percentage >= 0 ? .systemGreen : .systemRed
        
        
        // Notes
        notesLabel.layer.cornerRadius = 12
        notesLabel.clipsToBounds = true
        if let notes = trade.notes, !notes.isEmpty {
            notesLabel.text = notes
        } else {
            notesLabel.text = "No notes added."
            notesLabel.textColor = .secondaryLabel
        }
        
    }
}
