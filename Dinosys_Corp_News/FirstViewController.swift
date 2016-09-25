//
//  FirstViewController.swift
//  Dinosys_Corp_News
//
//  Created by Hung Nguyen on 9/22/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var shortImages: UIView!
    fileprivate let manager = ManagerFake.share

    @IBOutlet var largeImages: UIView!
    @IBOutlet var tableView: UITableView!
    
    fileprivate var cityName = "London"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        setUpNibFile()
        setLayout()
    }
    
    private func setUpNibFile() {
        let nib = UINib(nibName: "EventTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "eventCell")
        let header = UINib(nibName: "EventHeaderCell", bundle: nil)
        tableView.register(header, forHeaderFooterViewReuseIdentifier: "headerCell")
    }
    
    private func setLayout() {
        tableView.estimatedSectionHeaderHeight = 200
        self.tableView.showsVerticalScrollIndicator = false
        shortImages.isHidden = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowScrollSegue" || segue.identifier == "ShortImages" {
            if let scrollView = segue.destination as? ScrollViewController{
                scrollView.delegate = self
            }
        }
    }

}

extension FirstViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = manager.cities?[cityName]?.events?.count {
            return count
        }
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventTableViewCell
        if let events =  manager.cities?[cityName]?.events {
            let event = events[indexPath.row]
            
            DispatchQueue.global().async {
                let image  = UIImage(named: event.imageName)
                let date = event.time?.shortDate
                DispatchQueue.main.async {
                    cell.eventImage.image = image
                    cell.eventName.text = event.eventName
                    cell.dateField.text = date
                    cell.decriptionField.text = event.discription
                }
            }
        }
        return cell
    }
}

extension FirstViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let _ = manager.cities?[cityName]?.events {
            let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerCell") as? EventHeaderCell
            return cell
        }
        return nil
    }
}

extension FirstViewController: EventScrollViewDelegate {
    func updateTableViewCell(index: Int) {
        
        switch index {
        case 0:
            cityName = "London"
        case 1:
            cityName = "Manchester"
        case 2:
            cityName = "Paris"
        default:
            break
        }
        print("City name: \(cityName)")
        tableView.reloadData()
    }
    
    func updateTableViewHeigh(isLarger: Bool) {
        shortImages.isHidden = isLarger
        //largeImages.removeFromSuperview()
    }
}

extension DateFormatter {
    convenience init(dateStyle: DateFormatter.Style) {
        self.init()
        self.dateStyle = dateStyle
    }
}

extension Date {
    struct Formatter {
        static let shortDate = DateFormatter(dateStyle: .medium)
    }
    var shortDate: String {
        return Formatter.shortDate.string(from: self)
    }
}
