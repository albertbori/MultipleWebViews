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
    
    var cellData: ResizeAfterCellData!
    
    public func configureCell(cellData: ResizeAfterCellData) {
        self.cellData = cellData
        contentWebView.delegate = self
        contentWebView.scrollView.scrollEnabled = false
        self.contentWebViewHeightConstraint.constant = cellData.contentHeight ?? 1
        contentWebView.loadHTMLString(cellData.content, baseURL: nil)
        dateLabel.text = NSDate().description
    }
    
    public func webViewDidFinishLoad(webView: UIWebView) {
        if cellData.height == nil {
            if let var tableView = self.superview?.superview as? UITableView {
                if let indexPath = tableView.indexPathForCell(self) {
                    
                    var contentHeight = webView.scrollView.contentSize.height
                    
                    cellData.contentHeight = contentHeight
                    cellData.height = contentHeight + self.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height - contentWebViewHeightConstraint.constant
                    
                    println("row: \(indexPath.row)\tcontentHeight: \(contentHeight)\tcontentWidth: \(webView.scrollView.contentSize.width)\tcellFrameHeight: \(self.frame.height)\ttotalHeight: \(cellData.height!)")
                    tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
                }
            }
        }
    }
}