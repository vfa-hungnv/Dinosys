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
    
    var delegate: UpdateTableViewProtocol?
    
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ScrollViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let contentOffSetX = scrollView.contentOffset.x
        delegate?.updateTableView(contentOffSet: Float(contentOffSetX))
    }
}
