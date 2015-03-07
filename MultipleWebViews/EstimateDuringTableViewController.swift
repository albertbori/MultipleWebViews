//
//  EstimateDuringTableViewController.swift
//  MultipleWebViews
//
//  Created by Albert Bori on 3/6/15.
//  Copyright (c) 2015 albertbori. All rights reserved.
//

import UIKit
import MBProgressHUD

class EstimateDuringTableViewController: UITableViewController {
    
    var data: [String] = []
    var estimatedCellHeights: [Int:CGFloat] = [:]
    var estimatedCellContentHeights: [Int:CGFloat] = [:]
    
    //MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "EstimateDuringCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "EstimateDuringCell")
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        //Async doesn't seem to work... it crashes on the last item
        //Load data async
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {//
//            //reload table on main thread
//            dispatch_async(dispatch_get_main_queue(), {
//                self.data = Model.getTestData()
//                self.tableView.reloadData()
//                MBProgressHUD.hideHUDForView(self.view, animated: true)
//            })
//        })
        
        self.data = Model.getTestData()
        self.tableView.reloadData()
        MBProgressHUD.hideHUDForView(self.view, animated: true)
    }
    
    
    //MARK: - UITableViewController
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let height = self.estimatedCellHeights[indexPath.row] {
            println("found height for row  \(indexPath.row): \(height)")
            return height
        } else {
            println("couldn't find hieght for row \(indexPath.row) estimating...")
            var estimationCell = tableView.dequeueReusableCellWithIdentifier("EstimateDuringCell") as EstimateDuringCell
            var semaphore = dispatch_semaphore_create(0)
            estimationCell.getEstimatedHeight(data[indexPath.row], didEstimateHeight: { (cellHeight, contentHeight) -> () in
                self.estimatedCellHeights[indexPath.row] = cellHeight
                self.estimatedCellContentHeights[indexPath.row] = contentHeight
                dispatch_semaphore_signal(semaphore)
            })
            while dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW) > 0 {
                NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate.distantFuture() as NSDate)
            }
            println("estimation complete. Got height: \(self.estimatedCellHeights[indexPath.row]!)")
        }
        
        return self.estimatedCellHeights[indexPath.row] ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var estimatedCell = tableView.dequeueReusableCellWithIdentifier("EstimateDuringCell") as EstimateDuringCell
        estimatedCell.configureCell(data[indexPath.row], estimatedContentHeight: estimatedCellContentHeights[indexPath.row])
        return estimatedCell
    }
}
