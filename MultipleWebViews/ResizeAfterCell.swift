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
    
    private weak var tableView: UITableView?
    
    public func configureCell(htmlContent: String, tableView: UITableView, estimatedContentHeight: CGFloat? = nil) {
        contentWebView.delegate = self
        contentWebView.scrollView.scrollEnabled = false
        contentWebView.loadHTMLString(htmlContent, baseURL: nil)
        dateLabel.text = NSDate().description
    }
    
    public func webViewDidFinishLoad(webView: UIWebView) {
        
        println("got webView.scrollView.contentSize.height: \(webView.scrollView.contentSize.height) from webView.scrollView.contentSize.width: \(webView.scrollView.contentSize.width)")
        
        self.contentWebViewHeightConstraint.constant = webView.scrollView.contentSize.height
        self.layoutIfNeeded()
        
        self.tableView?.beginUpdates()
        self.tableView?.endUpdates()
    }
}