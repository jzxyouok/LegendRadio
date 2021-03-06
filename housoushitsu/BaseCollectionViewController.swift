//
//  BaseCollectionViewController.swift
//  housoushitsu
//
//  Created by naoyashiga on 2015/07/04.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit


class BaseCollectionViewController: UICollectionViewController {
    var activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.interactivePopGestureRecognizer.delegate = self
        
        setBackButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setBackButton() {
        let backButton = UIBarButtonItem(title: "< 戻る", style: UIBarButtonItemStyle.Plain, target: self, action: "goBack")
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "AxisStd-Medium", size: 15)!], forState: UIControlState.Normal)
    }
    
    func goBack() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func showActivityIndicator(uiView: UIView) {
        activityIndicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        activityIndicator.center = uiView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.WhiteLarge
        uiView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 0
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "Cell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) 
    
        return cell
    }

    // MARK: UICollectionViewDelegate
//    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
//        if let count = navigationController?.viewControllers.count where count > 1 {
//            return true
//        }
//        return false
//    }

}
