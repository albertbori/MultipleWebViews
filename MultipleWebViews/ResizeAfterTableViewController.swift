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

class ResizeAfterTableViewController: UITableViewController {
    
    var data: [ResizeAfterCellData] = []
    var loadingCover: UIView!
    
    
    //MARK: - UIViewController
    
    override func viewDidLoad() {
        tableView.registerNib(UINib(nibName: "ResizeAfterCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "ResizeAfterCell")
        loadingCover = UIView(frame: tableView.frame)
        loadingCover.backgroundColor = tableView.backgroundColor
        self.view.addSubview(loadingCover)
        
        var content = Model.getTestData()
        for i in 0..<content.count {
            var contentData = ResizeAfterCellData()
            contentData.content = content[i]
            data.append(contentData)
        }
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
    }
    
    override func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if loadingCover.superview != nil && data.filter({ cellData in cellData.height != nil }).count >= tableView.visibleCells().count {
            loadingCover.removeFromSuperview()
            MBProgressHUD.hideHUDForView(self.view, animated: true)
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