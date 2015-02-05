//
//  FAFlickrSearchCollectionViewController.swift
//  FlickrApplication
//
//  Created by Clay McLeod on 2/4/15.
//  Copyright (c) 2015 Clay McLeod. All rights reserved.
//

import UIKit

class FAFlickrSearchCollectionViewController: UICollectionViewController, UITextFieldDelegate, UICollectionViewDelegateFlowLayout {
    
    private let flickr = Flickr()
    private var titles = [NSString]()
    private let reuseIdentifier = "FlickrCell"
    private var searches = [FlickrSearchResults]()
    
    override func viewDidLoad() {
        //self.navigationController?.navigationBar.barTintColor = FLICKR_APPLICATION_NAVBAR_THEME_COLOR
    }
    
    func photoForIndexPath(indexPath: NSIndexPath) -> FlickrPhoto {
        return searches[indexPath.section].searchResults[indexPath.row]
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        
        textField.addSubview(activityIndicator)
        
        activityIndicator.frame = CGRect(x: textField.bounds.width-activityIndicator.bounds.width-5, y: textField.bounds.height-activityIndicator.bounds.height-5, width: activityIndicator.bounds.width, height: activityIndicator.bounds.height)
        
        activityIndicator.startAnimating()
        self.titles.append(textField.text)
        NSLog(self.titles.description);
        flickr.searchFlickrForTerm(textField.text) {
            results, error in
            
            activityIndicator.removeFromSuperview()
            if error != nil {
                println("Error searching : \(error)")
            }
            
            if results != nil {
                self.searches.append(results!)
                self.collectionView?.reloadData()
            }
        }
        
        textField.text = nil
        textField.resignFirstResponder()
        return true
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return searches.count
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searches[section].searchResults.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as FACollectionViewCell
        let flickrPhoto = photoForIndexPath(indexPath)
        cell.backgroundColor = UIColor.blackColor()
        cell.imageView.image = flickrPhoto.thumbnail
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView!,
        layout collectionViewLayout: UICollectionViewLayout!,
        sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
            
            let flickrPhoto =  photoForIndexPath(indexPath)
            if var size = flickrPhoto.thumbnail?.size {
                size.width += 10
                size.height += 10
                return size
            }
            return CGSize(width: 100, height: 100)
    }
    
    private let sectionInsets = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 20.0, right: 00.0)
    
    func collectionView(collectionView: UICollectionView!,
        layout collectionViewLayout: UICollectionViewLayout!,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return sectionInsets
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        var reusableView : UICollectionReusableView? = nil
        
        if (kind == UICollectionElementKindSectionHeader) {
            let headerView : FAHeaderCollectionReusableView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView", forIndexPath: indexPath) as FAHeaderCollectionReusableView
            
            headerView.title.text = titles[indexPath.section]
            reusableView = headerView
        }
        
        return reusableView!
    }
}