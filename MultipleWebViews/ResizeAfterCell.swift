//
//  PreEstimatedCell.swift
//  MultipleWebViews
//
//  Created by Albert Bori on 3/4/15.
//  Copyright (c) 2015 albertbori. All rights reserved.
//

import Foundation
import UIKit

public class ResizeAfterCell: UITableViewCell, UIWebViewDelegate {
    
    @IBOutlet weak var contentWebView: UIWebView!
    @IBOutlet weak var contentWebViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var dateLabel: UILabel!
    
    private var _cellData: ResizeAfterCellData!
    
    public func configureCell(cellData: ResizeAfterCellData) {
        self._cellData = cellData
        contentWebView.delegate = self
        contentWebView.scrollView.scrollEnabled = false
        if let contentHeight = cellData.contentHeight {
            self.contentWebViewHeightConstraint.constant = contentHeight
        }
        contentWebView.loadHTMLString(cellData.content, baseURL: nil)
        dateLabel.text = NSDate().description
    }
    
    public func webViewDidFinishLoad(webView: UIWebView) {
        if _cellData.height == nil {
            println("got contentSize.height: \(webView.scrollView.contentSize.height) from contentSize.width: \(webView.scrollView.contentSize.width)")
            
            _cellData.contentHeight = webView.scrollView.contentSize.height
            _cellData.height = webView.scrollView.contentSize.height + self.frame.height //minus the default height of the web view
            println("get total height to \(_cellData.height!)")
            
            var tableView = self.superview!.superview as UITableView
            if let indexPath = tableView.indexPathForCell(self) {
                tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
            }
        }
    }
}