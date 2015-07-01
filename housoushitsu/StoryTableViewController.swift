//
//  StoryTableViewController.swift
//  housoushitsu
//
//  Created by naoyashiga on 2015/06/30.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit

class StoryTableViewController: BaseTableViewController {
    private var sections = [[Story]]() {
        didSet{
            self.tableView?.reloadData()
        }
    }
    private var queries = [String]()
    private let sectionStoriesCount = 3
    private let sectionCount = 8
    
    let reuseIdentifier = "ListTableViewCell"
    var searchText = ""
    var index = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStories()
        
        let tabBarHeight = self.tabBarController?.tabBar.frame.size.height
        tableView.contentInset = UIEdgeInsetsMake(0, 0, tabBarHeight!, 0)
        
        let userDetailsNIB = UINib(nibName: reuseIdentifier, bundle: nil)
        tableView.registerNib(userDetailsNIB, forCellReuseIdentifier: reuseIdentifier)
        
        tableView.estimatedRowHeight = 200
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        animateTable(customCell: ListTableViewCell())
    }
    
    // MARK: - Table view data source
    func setSearchText() -> String {
        let storyIndex = arc4random() % 391
        var searchText = ""
        
        if storyIndex < 100 {
            searchText = "放送室 0\(storyIndex)"
        } else {
            searchText = "放送室 \(storyIndex)"
        }
        
        queries.append("第\(storyIndex)回")
        
        let text = searchText.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        return text!
    }
    
    func setStories() {
        let searchWord = setSearchText()
        let requestURL = Config.REQUEST_BASE_URL + "q=\(searchWord)&part=snippet&maxResults=\(sectionStoriesCount)&order=viewCount"
        
        HousoushitsuObjectHandler.getStories(requestURL, callback: {(stories) -> Void in
            self.index++
            self.sections.append(stories)
            
            if self.index < self.sectionCount {
                self.setStories()
            }
        })
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return queries[section]
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        
        header.contentView.backgroundColor = UIColor.tableHeaderBackgroundColor()
        header.textLabel.textColor = UIColor.tableHeaderTextColor()
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionStoriesCount
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ListTableViewCell
        println("indexPath.section")
        println(indexPath.section)
        println("indexPath.row")
        println(indexPath.row)
        
            let sectionStories = sections[indexPath.section]
            let story = sectionStories[indexPath.row]
            
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
        
        let sectionStories = sections[indexPath.section]
        
            let story = sectionStories[indexPath.row]
            
            let vc = DetailViewController(nibName: "DetailViewController", bundle: nil)
            vc.navigationItem.title = story.title
            self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
