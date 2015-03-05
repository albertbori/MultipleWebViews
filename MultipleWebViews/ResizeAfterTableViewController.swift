//
//  PreEstimatedTableViewController.swift
//  MultipleWebViews
//
//  Created by Albert Bori on 3/4/15.
//  Copyright (c) 2015 albertbori. All rights reserved.
//

import Foundation
import UIKit

class ResizeAfterTableViewController: UITableViewController {
    
    var data: [ResizeAfterCellData] = []
    
    
    //MARK: - UIViewController
    
    override func viewDidLoad() {
        tableView.registerNib(UINib(nibName: "ResizeAfterCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "ResizeAfterCell")
        
        var content = Model.getTestData()
        for i in 0..<content.count {
            var contentData = ResizeAfterCellData()
            contentData.content = content[i]
            data.append(contentData)
        }
    }
    
    
    //MARK: - UITableViewController
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let height = data[indexPath.row].height {
            return height
        }
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("ResizeAfterCell") as ResizeAfterCell
        cell.configureCell(data[indexPath.row])
        return cell
    }
}

public class ResizeAfterCellData {
    var content: String = ""
    var height: CGFloat?
    var contentHeight: CGFloat?
}