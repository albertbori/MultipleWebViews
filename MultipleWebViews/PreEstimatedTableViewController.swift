//
//  PreEstimatedTableViewController.swift
//  MultipleWebViews
//
//  Created by Albert Bori on 3/4/15.
//  Copyright (c) 2015 albertbori. All rights reserved.
//

import Foundation
import UIKit

class PreEstimatedTableViewController: UITableViewController {
    
    var data: [String] = []
    
    var estimationCell: PreEstimatedCell!
    var estimatedCellHeights: [Int:CGFloat] = [:]
    var estimatedCellContentHeights: [Int:CGFloat] = [:]
    
    //MARK: - UIViewController
    
    override func viewDidLoad() {
        estimationCell = NSBundle.mainBundle().loadNibNamed("PreEstimatedCell", owner: self, options: nil).first! as PreEstimatedCell
        tableView.registerNib(UINib(nibName: "PreEstimatedCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "PreEstimatedCell")
        
        //Load data async
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            var contents = Model.getTestData()
            
            //Get estimated height for each cell. UIWebView loading is delegate-based, so we have to wait for it to come back with the answer
            for i in 0 ..< contents.count {
                var semaphore = dispatch_semaphore_create(0)
                self.estimationCell.getEstimatedHeight(contents[i], didEstimateHeight: { (cellHeight, contentHeight) -> () in
                    self.estimatedCellHeights[i] = cellHeight
                    self.estimatedCellContentHeights[i] = contentHeight
                    dispatch_semaphore_signal(semaphore)
                })
                dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
            }
            
            //reload table on main thread
            dispatch_async(dispatch_get_main_queue(), {
                self.data = contents
                self.tableView.reloadData()
            })
        })
    }
    
    
    //MARK: - UITableViewController
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var estimatedCell = tableView.dequeueReusableCellWithIdentifier("PreEstimatedCell") as PreEstimatedCell
        estimatedCell.configureCell(data[indexPath.row], estimatedContentHeight: estimatedCellContentHeights[indexPath.row])
        return estimatedCell
    }
}
