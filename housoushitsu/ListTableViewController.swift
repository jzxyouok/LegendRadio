//
//  ListTableViewController.swift
//  housoushitsu
//
//  Created by naoyashiga on 2015/06/08.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    private var stories:[Story] = [Story]() {
        didSet{
            self.tableView?.reloadData()
        }
    }
    
    let reuseIdentifier = "ListTableViewCell"
    var searchText = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        
        setStories()
        
        var userDetailsNIB = UINib(nibName: reuseIdentifier, bundle: nil)
        self.tableView.registerNib(userDetailsNIB, forCellReuseIdentifier: reuseIdentifier)
        
        self.tableView.layoutMargins = UIEdgeInsetsZero
        self.tableView.estimatedRowHeight = 200
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setSearchText() -> String {
        let text = searchText.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        return text!
    }
    
    func setStories() {
        let searchWord = setSearchText()
        let requestURL = Config.REQUEST_BASE_URL + "q=\(searchWord)&part=snippet&maxResults=10&order=viewCount"
        
        println(requestURL)
        
        
        HousoushitsuObjectHandler.getStories(requestURL, callback: {(stories) -> Void in
            self.stories = stories
            println(self.stories)
        })
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ListTableViewCell
        
        let story = stories[indexPath.row]
        
        println(story.title)
        cell.titleLabel.text = story.title
        cell.thumbNailImageView.sd_setImageWithURL(NSURL(string: story.url))
        
        cell.layoutIfNeeded()

        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.cellLightBackgroundColor()
        } else {
            cell.backgroundColor = UIColor.cellDarkBackgroundColor()
        }
        
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ListTableViewCell
        
        let story = stories[indexPath.row]
        
        let vc = DetailViewController(nibName: "DetailViewController", bundle: nil)
        vc.navigationItem.title = story.title
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
