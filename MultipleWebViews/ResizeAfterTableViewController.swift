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
    var loadingCover: UIView = UIView()
    var scrollToIndex: Int?
    
    var isFinishedLoading: Bool {
        return (tableView.visibleCells() as [ResizeAfterCell]).filter({ $0.cellData.height == nil }).count == 0 && scrollToIndex == nil
    }
    
    //MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "ResizeAfterCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "ResizeAfterCell")
        showLoadingScreen()
        
        var content = Model.getTestData()
        for i in 0..<content.count {
            var contentData = ResizeAfterCellData()
            contentData.content = content[i]
            data.append(contentData)
        }
        
        //scrollToIndex = 5 //uncomment this to test jumping to a specific post
    }
    
    override func viewDidAppear(animated: Bool) {
        if let scrollToIndex = scrollToIndex {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.01 * Double(NSEC_PER_SEC))),
                dispatch_get_main_queue(), {
                    self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: scrollToIndex, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
                }
            )
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
    
    override func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if loadingCover.superview != nil && isFinishedLoading {
            hideLoadingScreen()
        }
    }
    
    
    //MARK: - UIScrollView
    
    override func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        println("scrolled")
        if let scrollToIndex = scrollToIndex {
            //Check if the destination cell is visible, and loaded. If not, scroll again.
            var visibleCells = tableView.visibleCells() as [ResizeAfterCell]
            var destinationCell = visibleCells.filter({ $0.cellData.height != nil && self.tableView.indexPathForCell($0)!.row == self.scrollToIndex! }).first
            if destinationCell == nil {
                println("not there yet...")
                self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: scrollToIndex, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
            } else {
                //scroll one last time to make sure the cell is properly oriented
                self.scrollToIndex = nil
                self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: scrollToIndex, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
                println("all done")
            }
        }
    }
    
    
    //MARK: - Helper functions
    
    private func showLoadingScreen() {
        if loadingCover.superview == nil {
            loadingCover.backgroundColor = UIColor.blueColor()
            loadingCover.setTranslatesAutoresizingMaskIntoConstraints(false)
            var navBar = self.navigationController?.view.subviews.filter({ $0 is UINavigationBar }).first! as UINavigationBar
            self.navigationController?.view.addSubview(loadingCover)
            var constraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[navBar][loadingCover]|", options: nil, metrics: nil, views: ["loadingCover": loadingCover, "navBar": navBar])
            constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[loadingCover]|", options: nil, metrics: nil, views: ["loadingCover": loadingCover])
            self.navigationController?.view.addConstraints(constraints)
        }
        loadingCover.hidden = false
        MBProgressHUD.showHUDAddedTo(loadingCover, animated: true)
    }
    
    private func hideLoadingScreen() {
        MBProgressHUD.hideHUDForView(loadingCover, animated: true)
        loadingCover.hidden = true
    }
}

public class ResizeAfterCellData {
    var content: String = ""
    var height: CGFloat?
    var contentHeight: CGFloat?
}