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
    
    var data: [String] = []
    
    //MARK: - UIViewController
    
    override func viewDidLoad() {
        tableView.registerNib(UINib(nibName: "ResizeAfterCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "ResizeAfterCell")
        
        self.data = Model.getTestData()
    }
    
    
    //MARK: - UITableViewController
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var estimatedCell = tableView.dequeueReusableCellWithIdentifier("ResizeAfterCell") as ResizeAfterCell
        estimatedCell.configureCell(data[indexPath.row], tableView: self.tableView)
        return estimatedCell
    }
}
