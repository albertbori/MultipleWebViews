//
//  PreEstimatedCell.swift
//  MultipleWebViews
//
//  Created by Albert Bori on 3/4/15.
//  Copyright (c) 2015 albertbori. All rights reserved.
//

import Foundation
import UIKit

public class PreEstimatedCell: UITableViewCell, UIWebViewDelegate {
    
    @IBOutlet weak var contentWebView: UIWebView!
    @IBOutlet weak var contentWebViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var dateLabel: UILabel!
    
    var cellData: PreEstimatedCellData!
    
    public func configureCell(cellData: PreEstimatedCellData) {
        self.cellData = cellData
        contentWebView.delegate = self
        contentWebView.scrollView.scrollEnabled = false
        contentWebViewHeightConstraint.constant = cellData.contentHeight ?? 1.0
        contentWebView.loadHTMLString(cellData.content, baseURL: nil)
        dateLabel.text = NSDate().description
    }
    
    private var _didEstimateContentHeight: ((contentHeight: CGFloat) -> ())?
    func getEstimatedHeight(cellData: PreEstimatedCellData, didEstimateHeight: (cellHeight: CGFloat, contentHeight: CGFloat) -> ()) {
        _didEstimateContentHeight = { contentHeight in
            var cellHeight = self.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
            println("got cellHeight: \(cellHeight) from contentHeight: \(contentHeight)")
            didEstimateHeight(cellHeight: cellHeight, contentHeight: contentHeight)
        }
        configureCell(cellData)
    }
    
    public func webViewDidFinishLoad(webView: UIWebView) {
        if let didEstimateContentHeight = _didEstimateContentHeight {
            var widthString = webView.stringByEvaluatingJavaScriptFromString("document.body.offsetWidth")!
            var heightString: NSString = webView.stringByEvaluatingJavaScriptFromString("document.body.offsetHeight")! as NSString
            println("got contentHeight: \(heightString) from contentWidth: \(widthString)")
            contentWebViewHeightConstraint.constant = CGFloat(heightString.floatValue)
            didEstimateContentHeight(contentHeight: contentWebViewHeightConstraint.constant)
        }
    }
}