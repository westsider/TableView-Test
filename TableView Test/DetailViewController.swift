//
//  DetailViewController.swift
//  TableView Test
//
//  Created by Warren Hansen on 6/12/18.
//  Copyright © 2018 Warren Hansen. All rights reserved.
//

import UIKit
import WebKit
import PDFKit

class DetailViewController: UIViewController {

    var filePath = ""
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // webView.load(imagedata as Data, mimeType: "application/pdf", characterEncodingName: "UTF-8", baseURL: URL(string: "You can use URL of any file in your bundle here")!)
     //webView.document = PDFDocument(data: imagedata)
     //   webView.
        print(filePath)
        
        let url = NSURL(fileURLWithPath: filePath)
        //let webView = UIWebView()
        webView.loadFileURL(url as URL, allowingReadAccessTo: url as URL)
    }
}
