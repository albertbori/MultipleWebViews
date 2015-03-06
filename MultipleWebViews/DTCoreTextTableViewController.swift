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

class DTCoreTextTableViewController: UITableViewController {
    
    var data: [DTCoreTextCellData] = []
    
    //MARK: - UIViewController
    
    override func viewDidLoad() {
        tableView.registerNib(UINib(nibName: "DTCoreTextCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "DTCoreTextCell")
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            var contents = Model.getTestData()
            var data = contents.map({ DTCoreTextCellData(content: $0) }) as [DTCoreTextCellData]
            
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
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var estimatedCell = tableView.dequeueReusableCellWithIdentifier("DTCoreTextCell") as DTCoreTextCell
        estimatedCell.configureCell(data[indexPath.row])
        return estimatedCell
    }
}

public class DTCoreTextCellData {
    var content: NSAttributedString
    
    init(content: String) {
        var data = content.dataUsingEncoding(NSUTF8StringEncoding)
        self.content = NSAttributedString(data: data!, options: nil, documentAttributes: nil, error: nil)!
    }
}
