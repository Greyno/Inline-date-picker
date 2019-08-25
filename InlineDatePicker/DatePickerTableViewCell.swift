//
//  DatePickerTableViewCell.swift
//  InlineDatePicker
//
//  Created by GRT on 8/24/19.
//  Copyright © 2019 GRey-T-Programs. All rights reserved.
//

import UIKit

protocol DatePickerDelegate: class {
    func didChangeDate(date: Date, indexPath: IndexPath)
}

class DatePickerTableViewCell: UITableViewCell {

    @IBOutlet var datePicker: UIDatePicker!
    
    var indexPath: IndexPath!
    weak var delegate: DatePickerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // Cell height
    class func cellHeight() -> CGFloat {
        return 162.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func updateCell(date: Date, indexPath: IndexPath) {
        datePicker.setDate(date, animated: true)
        print("UpdateCell index path row: \(indexPath.row)")
        self.indexPath = indexPath
    }
    
    @IBAction func didChangeDate(_ sender: UIDatePicker) {
        let indexPathForDisplayDate = IndexPath(row: indexPath.row - 1, section: indexPath.section)
        print("indexPathForDisplayDate is: \(indexPathForDisplayDate)")
        delegate?.didChangeDate(date: sender.date, indexPath: indexPathForDisplayDate)
    }


}
