//
//  PreEstimatedCell.swift
//  MultipleWebViews
//
//  Created by Albert Bori on 3/4/15.
//  Copyright (c) 2015 albertbori. All rights reserved.
//

import Foundation
import UIKit

public class DTCoreTextCell: UITableViewCell, UIWebViewDelegate {
    
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    private weak var tableView: UITableView?
    
    public func configureCell(htmlContent: String) {
        var data = htmlContent.dataUsingEncoding(NSUTF8StringEncoding)
        contentTextView.attributedText = NSAttributedString(data: data!, options: nil, documentAttributes: nil, error: nil)
        dateLabel.text = NSDate().description
    }
}