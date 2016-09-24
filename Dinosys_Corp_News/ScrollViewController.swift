//
//  ScrollViewController.swift
//  Dinosys
//
//  Created by Hung Nguyen on 9/23/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import UIKit

protocol UpdateTableViewProtocol {
    func updateTableView(index: Int)
}


class ScrollViewController: UIViewController {

    @IBOutlet var Manchester: UIImageView!
    @IBOutlet var Paris: UIImageView!
    @IBOutlet var London: UIImageView!
    
    @IBOutlet var stackImage: UIStackView!

    
    @IBOutlet var scrollView: UIScrollView!
    
    var delegate: UpdateTableViewProtocol?
    
    var stackImageWidth: CGFloat?
    var imageWidth: CGFloat?
    let index = 0
    
    override func viewDidLoad() {
        scrollView.delegate = self
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        scrollView.showsHorizontalScrollIndicator = false
        stackImageWidth = (stackImage.frame.maxX - stackImage.frame.minX)
        imageWidth = Manchester.frame.maxX - Manchester.frame.minX
        
        
    }
    
    fileprivate func calculateCityShow(contenntOffset: CGPoint) -> Int{
        let offSet = contenntOffset.x
        let stackWidth = stackImage.frame.maxX - stackImage.frame.minX
        
        let index = (Int)(stackWidth / offSet)
        return index
    }
}

extension ScrollViewController: UIScrollViewDelegate {

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let imageWidth = Float(Manchester.frame.maxX - Manchester.frame.minX)
        let currentOffset = Float(scrollView.contentOffset.x)
        let targetOffset = Float(targetContentOffset.pointee.x)
        var newTargetOffset = Float(0)
        
        
        if targetOffset > currentOffset {
            newTargetOffset = ceilf(currentOffset / imageWidth) * imageWidth
        } else {
            newTargetOffset = floorf(currentOffset / imageWidth) * imageWidth
        }
    
        if newTargetOffset < 0 {
            newTargetOffset = 0
        } else if newTargetOffset > currentOffset {
            newTargetOffset = currentOffset
        }

        let new = CGPoint(x: Int(newTargetOffset), y: 0)
    
        scrollView.setContentOffset(new, animated: true)
    }
}







