//
//  ScrollViewController.swift
//  Dinosys
//
//  Created by Hung Nguyen on 9/23/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import UIKit

protocol EventScrollViewDelegate {
    func updateTableViewCell(index: Int)
    func updateTableViewHeigh(isLarger: Bool)
}


class ScrollViewController: UIViewController {

    @IBOutlet var Manchester: UIImageView!
    @IBOutlet var Paris: UIImageView!
    @IBOutlet var London: UIImageView!
    
    @IBOutlet var stackImage: UIStackView!
    
    @IBOutlet var scrollView: UIScrollView!
    
    var delegate: EventScrollViewDelegate?
    
    var stackImageWidth: CGFloat?
    var imageWidth: CGFloat?
    let index = 0
    
    override func viewDidLoad() {
        scrollView.delegate = self
        
        stackImageWidth = (stackImage.frame.maxX - stackImage.frame.minX)
        imageWidth = Manchester.frame.maxX - Manchester.frame.minX

        addGesture()
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

// For handle swipe up-down
extension ScrollViewController {
    
    fileprivate func addGesture() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture: )))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture: )))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped down")
                delegate?.updateTableViewHeigh(isLarger: false)
                
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
                delegate?.updateTableViewHeigh(isLarger: true)
            default:
                break
            }
        }
    }
}

extension ScrollViewController: UIScrollViewDelegate {

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let imageWidth = Float(Manchester.frame.maxX - Manchester.frame.minX)
        let currentOffset = Float(scrollView.contentOffset.x)
        let targetOffset = Float(targetContentOffset.pointee.x)
        
        let newTarget = newTargetOffset(imageWith: imageWidth, currentOffset: currentOffset, targetOffSet: targetOffset)
        
        targetContentOffset.pointee.x = CGFloat(newTarget.0)
        
        delegate?.updateTableViewCell(index: Int(newTarget.1))
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







