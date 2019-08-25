//
//  DateTableViewCell.swift
//  InlineDatePicker
//
//  Created by GRT on 8/24/19.
//  Copyright © 2019 GRey-T-Programs. All rights reserved.
//

import UIKit

/// Date Format type
enum DateFormatType: String {
    /// Time
    case time = "HH:mm:ss"
    
    /// Date with hours
    case dateWithTime = "dd-MMM-yyyy  H:mm"
    
    /// Date
    case date = "dd-MMM-yyyy"
}

class DateTableViewCell: UITableViewCell {

    @IBOutlet var label: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // Update text
    func updateText(text: String, date: Date) {
        label.text = text
        dateLabel.text = date.convertToString(dateformat: .dateWithTime)
    }
    
    // Cell height
    class func cellHeight() -> CGFloat {
        return 44.0
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension Date {
    
    func convertToString(dateformat formatType: DateFormatType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatType.rawValue
        let newDate: String = dateFormatter.string(from: self)
        return newDate
    }
    
}
