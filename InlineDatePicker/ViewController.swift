//
//  ViewController.swift
//  InlineDatePicker
//
//  Created by GRT on 8/24/19.
//  Copyright © 2019 GRey-T-Programs. All rights reserved.
//
//Adapted from source code: https://github.com/rajtharan-g/InlineDatePicker
//Corresponding Medium page: https://medium.com/@tharanit99/how-to-implement-a-inline-date-picker-in-ios-with-swift-4-9f8274460dbc
//Create an in-line date picker in a tableview
import UIKit

class ViewController: UIViewController {

    var datePickerIndexPath: IndexPath?
    var inputTexts: [String] = ["Selected date"]
    var inputDates: [Date] = []
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addInitialValues()
    }

    func addInitialValues() {
        inputDates = Array(repeating: Date(), count: inputTexts.count)
    }
    
    func indexPathToInsertDatePicker(indexPath: IndexPath) -> IndexPath {
        if let datePickerIndexPath = datePickerIndexPath, datePickerIndexPath.row < indexPath.row {
            return indexPath
        } else {
            return IndexPath(row: indexPath.row + 1, section: indexPath.section)
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if datePickerIndexPath != nil {
            return inputTexts.count + 1
        } else {
            return inputTexts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if datePickerIndexPath == indexPath {
            let datePickerCell = tableView.dequeueReusableCell(withIdentifier: "DatePickerTableViewCell") as! DatePickerTableViewCell
            datePickerCell.updateCell(date: inputDates[indexPath.row - 1], indexPath: indexPath)
//            print("inputDates: \(inputDates[indexPath.row - 1])")
            datePickerCell.delegate = self
            return datePickerCell
            
        } else {
            let dateCell = tableView.dequeueReusableCell(withIdentifier: "DateTableViewCell") as! DateTableViewCell
            dateCell.updateText(text: inputTexts[indexPath.row], date: inputDates[indexPath.row])
            return dateCell
        }
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        print("Index path row selected is: \(indexPath.row)")
        if let datePickerIndexPath = datePickerIndexPath, datePickerIndexPath.row - 1 == indexPath.row {
            print("DatePickerIndexPath row for selected row is: \(datePickerIndexPath.row)")
            tableView.deleteRows(at: [datePickerIndexPath], with: .fade)
            self.datePickerIndexPath = nil
        } else {
            if let datePickerIndexPath = datePickerIndexPath {
                tableView.deleteRows(at: [datePickerIndexPath], with: .fade)
            }
            datePickerIndexPath = indexPathToInsertDatePicker(indexPath: indexPath)
            tableView.insertRows(at: [datePickerIndexPath!], with: .fade)
            tableView.deselectRow(at: indexPath, animated: true)
        }
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if datePickerIndexPath == indexPath {
            return DatePickerTableViewCell.cellHeight()
        } else {
            return DateTableViewCell.cellHeight()
        }
    }
    
}

extension ViewController: DatePickerDelegate {
    //Function should update the date label in row 0 with the date selected from the datePicker. Instead, code returns nil when unwrapping optional error
    func didChangeDate(date: Date, indexPath: IndexPath) {
        inputDates[indexPath.row] = date
        //index path for reload is [0,0], i.e. the row with the date label, but code finds nil
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
}

