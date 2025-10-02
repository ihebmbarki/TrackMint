//
//  AddTradeVC.swift
//  TrackMint
//
//  Created by Iheb Mbarki on 23/9/2025.
//

import UIKit

class AddTradeVC: UIViewController {
    
    @IBOutlet weak var coinTextField: UITextField!
    @IBOutlet weak var entryTextField: UITextField!
    @IBOutlet weak var exitTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextView!
    
    var onSave: ((Trade) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notesTextView.layer.cornerRadius = 12
        notesTextView.clipsToBounds = true
    }
    

    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let coin = coinTextField.text,
                  let entry = Double(entryTextField.text ?? ""),
                  let exit = Double(exitTextField.text ?? ""),
                  let quantity = Double(quantityTextField.text ?? "") else { return }
        let notesText = notesTextView.textColor == .secondaryLabel ? "" : notesTextView.text

        let newTrade = Trade(
            coin: coin,
            entry: entry,
            exit: exit,
            quantity: quantity,
            date: datePicker.date,
            type: typeSegmentedControl.selectedSegmentIndex == 0 ? .long : .short,
            notes: notesText
        )
        
        // Call the callback
          onSave?(newTrade)

          // Go back to the list
          navigationController?.popViewController(animated: true)
    }
    
}

extension AddTradeVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .secondaryLabel {
            textView.text = ""
            textView.textColor = .label  
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Add any notes here..."
            textView.textColor = .secondaryLabel
        }
    }
}
