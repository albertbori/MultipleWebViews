//
//  PreEstimatedTableViewController.swift
//  MultipleWebViews
//
//  Created by Albert Bori on 3/4/15.
//  Copyright (c) 2015 albertbori. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class PreEstimatedTableViewController: UITableViewController {
    
    var data: [PreEstimatedCellData] = []
    
    //MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "PreEstimatedCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "PreEstimatedCell")
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        //Load data async
        var estimationCell = self.tableView.dequeueReusableCellWithIdentifier("PreEstimatedCell") as PreEstimatedCell
        estimationCell.frame = tableView.frame
        estimationCell.layoutSubviews()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            var data = Model.getTestData().map({ PreEstimatedCellData(content: $0) }) as [PreEstimatedCellData]
            
            //Get estimated height for each cell. UIWebView loading is delegate-based, so we have to wait for it to come back with the answer
            for cellData in data {
                var semaphore = dispatch_semaphore_create(0)
                estimationCell.getEstimatedHeight(cellData, didEstimateHeight: { (cellHeight, contentHeight) -> () in
                    cellData.height = cellHeight
                    cellData.contentHeight = contentHeight
                    dispatch_semaphore_signal(semaphore)
                })
                dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
            }
            
            //reload table on main thread
            dispatch_async(dispatch_get_main_queue(), {
                self.data = data
                self.tableView.reloadData()
                MBProgressHUD.hideHUDForView(self.view, animated: true)
            })
        })
    }
    
    //MARK: - UITableViewController
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return data[indexPath.row].height ?? UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var estimatedCell = tableView.dequeueReusableCellWithIdentifier("PreEstimatedCell") as PreEstimatedCell
        estimatedCell.configureCell(data[indexPath.row])
        return estimatedCell
    }
}

public class PreEstimatedCellData {
    var content: String
    var height: CGFloat?
    var contentHeight: CGFloat?
    
    init(content: String) {
        self.content = content
    }
}
