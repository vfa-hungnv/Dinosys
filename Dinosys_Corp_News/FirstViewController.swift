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

    @IBOutlet var imageCollection: UIView!
    @IBOutlet var tableView: UITableView!
    
    fileprivate let manager = ManagerFake.share
    fileprivate var cityName = "London"
    
    var status: FirstViewControllerStatus = .ExpandedTopView
    
    //Contrain to modify when status change
    @IBOutlet var topViewHeight: NSLayoutConstraint!
    @IBOutlet var imageHeight: NSLayoutConstraint!
    @IBOutlet var tableHeight: NSLayoutConstraint!
    @IBOutlet var contrainToTop: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        setUpNibFile()
        setLayout()
    }
    
    func update(status: FirstViewControllerStatus) {

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

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CollectionHorizantal" {
            if let collectionImageHorizontal = segue.destination as? CollectionImageHorizontalViewController{
                collectionImageHorizontal.delegate = self
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
        if let city = manager.cities?[cityName]{
            if let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerCell") as? EventHeaderCell {
                cell.cityEventNameField.text = "\(city.name) events"
                return cell
            }
        }
        return nil
    }
}

// hander for delegate
extension FirstViewController: HorizonCollectionDelegate {
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
    
    func changeFirstViewStatus(status: FirstViewControllerStatus) {
        if status == .ExpandedTopView {
            print("Expanded")
            imageHeight.constant = 269
            tableHeight.constant = 270
            topViewHeight.constant = 88
            contrainToTop.constant = 0
        } else {
            print("Collapsed")
            imageHeight.constant = 150
            tableHeight.constant = 488
            topViewHeight.constant = 0
            contrainToTop.constant = -10
        }
    }
}

//Help method to parse date -> string
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
