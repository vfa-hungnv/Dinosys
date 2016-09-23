//
//  ScrollViewController.swift
//  Dinosys
//
//  Created by Hung Nguyen on 9/23/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import UIKit

protocol UpdateTableViewProtocol {
    func updateTableView(contentOffSet: Float)
}


class ScrollViewController: UIViewController {
    @IBOutlet var London: UIImageView!
    @IBOutlet var Manchester: UIImageView!
    @IBOutlet var Paris: UIImageView!
    
    var delegate: UpdateTableViewProtocol?
    
    @IBOutlet var scrollView: UIScrollView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setUpLayout()
    }
    
    private func setUpData() {
        
        scrollView.delegate = self
        
        London.image = UIImage(named: "London")
        Paris.image = UIImage(named: "Paris")
        Manchester.image = UIImage(named: "Manchester")
    }
    
    private func setUpLayout() {
        scrollView.showsHorizontalScrollIndicator = false
    }
}

extension ScrollViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let contentOffSetX = scrollView.contentOffset.x
        delegate?.updateTableView(contentOffSet: Float(contentOffSetX))
    }
}
