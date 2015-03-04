//
//  PreEstimatedTableViewController.swift
//  MultipleWebViews
//
//  Created by Albert Bori on 3/4/15.
//  Copyright (c) 2015 albertbori. All rights reserved.
//

import Foundation
import UIKit

class DTCoreTextTableViewController: UITableViewController {
    
    var data: [String] = []
    
    //MARK: - UIViewController
    
    override func viewDidLoad() {
        tableView.registerNib(UINib(nibName: "DTCoreTextCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "DTCoreTextCell")
        
        self.data = Model.getTestData()
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
