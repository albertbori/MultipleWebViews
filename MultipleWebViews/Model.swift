//
//  Model.swift
//  MultipleWebViews
//
//  Created by Albert Bori on 3/4/15.
//  Copyright (c) 2015 albertbori. All rights reserved.
//

import Foundation

public class Model {
    public class func getTestData() -> [String] {
        
        var testData = [
            "<h1>My Markdown Post</h1>\n<p><strong>Bold</strong><br />\n<em>Italic</em><br />\n<del>Strikethrough</del></p>\n<pre><code>func showVersion() {\n    var version = NSBundle.mainBundle().objectForInfoDictionaryKey('CFBundleShortVersionString') as String\n    var build = NSBundle.mainBundle().objectForInfoDictionaryKey(kCFBundleVersionKey as NSString) as String\n    hostLabel.text = '\\(API_HOST) v\\(version) build \\(build)'\n}\n</code></pre>\n<pre><code>func showVersion() {\n    var version = NSBundle.mainBundle().objectForInfoDictionaryKey('CFBundleShortVersionString') as String\n    var build = NSBundle.mainBundle().objectForInfoDictionaryKey(kCFBundleVersionKey as NSString) as String\n    hostLabel.text = '\\(API_HOST) v\\(version) build \\(build)'\n}\n</code></pre>\n<ul>\n<li>Cool</li>\n<li><p>Neat</p>\n</li>\n<li><p>Item 1</p>\n</li>\n<li>Item 2</li>\n</ul>\n<p>Raw link: <a href='http://google.com'>http://google.com</a><br />\nPretty link: <a href='http://google.com'>Internet</a></p>\n<p><img src='http://d3819ii77zvwic.cloudfront.net/wp-content/uploads/2014/07/ik49VlPshlPIz.gif' alt='Mind Blown' /></p>\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla interdum, massa eget sodales congue, leo est aliquam lectus, ac elementum magna diam efficitur arcu. Fusce at velit eu orci condimentum dignissim ut a nulla. Suspendisse justo nulla, semper et erat eget, rutrum vulputate ligula. Aliquam erat volutpat. Integer ut congue nibh. Suspendisse condimentum odio dapibus, ultricies tortor a, porttitor tellus. Etiam nec quam in elit consectetur elementum a eu libero. Aenean porta, lorem et pellentesque consequat, arcu magna tincidunt ipsum, in feugiat nunc diam vitae tellus. Praesent dignissim, lorem non mattis maximus, elit nisi bibendum metus, et sagittis purus risus ac orci.</p>\n<blockquote>\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla interdum, massa eget sodales congue, leo est aliquam lectus, ac elementum magna diam efficitur arcu. Fusce at velit eu orci condimentum dignissim ut a nulla. Suspendisse justo nulla, semper et erat eget, rutrum vulputate ligula. Aliquam erat volutpat. Integer ut congue nibh. Suspendisse condimentum odio dapibus, ultricies tortor a, porttitor tellus. Etiam nec quam in elit consectetur elementum a eu libero. Aenean porta, lorem et pellentesque consequat, arcu magna tincidunt ipsum, in feugiat nunc diam vitae tellus. Praesent dignissim, lorem non mattis maximus, elit nisi bibendum metus, et sagittis purus risus ac orci.</p>\n</blockquote>\n",
            "<h1>My Markdown Post</h1>\n",
            "<p><strong>Bold</strong><br />\n<em>Italic</em><br />\n<del>Strikethrough</del></p>\n",
            "<ul>\n<li>Cool</li>\n<li><p>Neat</p>\n</li>\n<li><p>Item 1</p>\n</li>\n<li>Item 2</li>\n</ul>\n",
            "<p>Raw link: <a href='http://google.com'>http://google.com</a><br />\nPretty link: <a href='http://google.com'>Internet</a></p>\n",
            "<pre><code>func showVersion() {\n    var version = NSBundle.mainBundle().objectForInfoDictionaryKey('CFBundleShortVersionString') as String\n    var build = NSBundle.mainBundle().objectForInfoDictionaryKey(kCFBundleVersionKey as NSString) as String\n    hostLabel.text = '\\(API_HOST) v\\(version) build \\(build)'\n}\n</code></pre>",
            "<p>Paragraph: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla interdum, massa eget sodales congue, leo est aliquam lectus, ac elementum magna diam efficitur arcu. Fusce at velit eu orci condimentum dignissim ut a nulla. Suspendisse justo nulla, semper et erat eget, rutrum vulputate ligula. Aliquam erat volutpat. Integer ut congue nibh. Suspendisse condimentum odio dapibus, ultricies tortor a, porttitor tellus. Etiam nec quam in elit consectetur elementum a eu libero. Aenean porta, lorem et pellentesque consequat, arcu magna tincidunt ipsum, in feugiat nunc diam vitae tellus. Praesent dignissim, lorem non mattis maximus, elit nisi bibendum metus, et sagittis purus risus ac orci.</p>\n",
            "<p><img src='http://d3819ii77zvwic.cloudfront.net/wp-content/uploads/2014/07/ik49VlPshlPIz.gif' alt='Mind Blown' /></p>\n",
            "<blockquote>\n<p>Blockquote: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla interdum, massa eget sodales congue, leo est aliquam lectus, ac elementum magna diam efficitur arcu. Fusce at velit eu orci condimentum dignissim ut a nulla. Suspendisse justo nulla, semper et erat eget, rutrum vulputate ligula. Aliquam erat volutpat. Integer ut congue nibh. Suspendisse condimentum odio dapibus, ultricies tortor a, porttitor tellus. Etiam nec quam in elit consectetur elementum a eu libero. Aenean porta, lorem et pellentesque consequat, arcu magna tincidunt ipsum, in feugiat nunc diam vitae tellus. Praesent dignissim, lorem non mattis maximus, elit nisi bibendum metus, et sagittis purus risus ac orci.</p>\n</blockquote>\n",
            "There's nothing interesting about this text. It doesn't have any html formatting whatsoever. It's just plain old regular text.",
            "A short bit of text"
        ]
        
        return testData.map({ Model.getFullHTML($0) })
    }
    
    private class func getFullHTML(innerHTML: String) -> String {
        //var style = "html{font-family:sans-serif;-webkit-text-size-adjust:100%;} body{background-color: #f2f8fa;margin:0;padding:0;border: 1px solid black;word-wrap: break-word} img{max-width:100%} code,pre{white-space: pre-wrap}" //<-- This causes even more height calculation incorrectness. Namely, image height is wrong, and forced-broken words are wrong
        var style = "html{font-family:sans-serif;-webkit-text-size-adjust:100%;} body{background-color: #f2f8fa;margin:0;padding:0;border: 1px solid blue}" //<-- nothing broken with this, except for naturally wrapping text height is wrong
        
        var html = "<html><head><style type='text/css'>\(style)</style></head><body>\(innerHTML)</body></html>"
        
        return html
    }
}