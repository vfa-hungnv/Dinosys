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
        stackImageWidth = (stackImage.frame.maxX - stackImage.frame.minX)
        imageWidth = Manchester.frame.maxX - Manchester.frame.minX
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    

        
        setUpLayout()
    }
    
    private func setUpLayout() {
        scrollView.showsHorizontalScrollIndicator = false
        
        London.layer.shadowOpacity = 0.6
        Manchester.layer.shadowOpacity = 0.6
        Paris.layer.shadowOpacity = 0.6
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
        
        let newTarget = newTargetOffset(imageWith: imageWidth, currentOffset: currentOffset, targetOffSet: targetOffset)
        
        targetContentOffset.pointee.x = CGFloat(newTarget.0)
        
        delegate?.updateTableView(index: Int(newTarget.1))
    }
    
    private func newTargetOffset(imageWith: Float, currentOffset: Float, targetOffSet: Float) -> (Float, Float) {
        typealias Result = (Float, Float)
        var newTargetOffset: Float = 0.0
        if newTargetOffset < 0 {
            newTargetOffset = 0
            return Result(newTargetOffset, 0.0)
        }
        let times = floorf((currentOffset / imageWith))
        newTargetOffset = times * imageWith + Float(stackImage.spacing) 

        
        return Result(newTargetOffset, times)
    }
}







