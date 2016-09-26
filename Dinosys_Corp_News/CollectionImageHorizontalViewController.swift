//
//  CollectionImageHorizontalViewController.swift
//  Dinosys
//
//  Created by Hung Nguyen on 9/26/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import UIKit

protocol HorizonCollectionDelegate {
    func updateTableViewCell(index: Int)
    func changeFirstViewStatus(status: FirstViewControllerStatus)
}

class CollectionImageHorizontalViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    
    var delegate: HorizonCollectionDelegate?
  
    var Images: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFakeData()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        addGesture()
    }
    private func loadFakeData() {
        Images = ["Manchester", "Paris", "London"]
    }
}

extension CollectionImageHorizontalViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let Images = Images {
            return Images.count
        } else {
            return 1
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionImageCell",
                                                         for: indexPath) as! ImageCollectionViewCell
            cell.setImageView(imageName: (Images?[indexPath.row])!)
            return cell

    }
 
}
extension CollectionImageHorizontalViewController: UICollectionViewDelegate { }

extension CollectionImageHorizontalViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let offset = Float(collectionView.contentOffset.x)
        
        let width = Float(collectionView.collectionViewLayout.collectionViewContentSize.width)
        
        let totalCity = Float((Images?.count)!)
        

        let index = floorf(offset / (width/totalCity))
        
        delegate?.updateTableViewCell(index: Int(index))
    }
}

extension CollectionImageHorizontalViewController {
    
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
                delegate?.changeFirstViewStatus(status: .ExpandedTopView)
                
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
                delegate?.changeFirstViewStatus(status: .CollapsedTopView)
            default:
                break
            }
        }
    }
}



