//
//  ViewController.swift
//  TableView Test
//
//  Created by Warren Hansen on 6/10/18.
//  Copyright © 2018 Warren Hansen. All rights reserved.
//


// Mark- TODO - add weather

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func savePDF(_ sender: Any) {
        segueToNextViewContoller()
    }
    
    func createPDF(fileName:String)-> String {
        let data = NSMutableData()
        UIGraphicsBeginPDFContextToData(data, view.layer.bounds, nil)
        UIGraphicsBeginPDFPage()
        self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        UIGraphicsEndPDFContext()
        let path = NSTemporaryDirectory() + "\(fileName).pdf"
        data.write(toFile: path, atomically: true)
        print(path)
        return path
    }
    
    func segueToNextViewContoller() {
        let myVc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        myVc.filePath = createPdfFromTableView(fileName: "Cam")
        navigationController?.pushViewController(myVc, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) //as! FlagCell
        return cell
    }
    
    func createPdfFromTableView(fileName:String)-> String {
        let priorBounds: CGRect = self.tableView.bounds
        let fittedSize: CGSize = self.tableView.sizeThatFits(CGSize(width: priorBounds.size.width, height: self.tableView.contentSize.height))
        self.tableView.bounds = CGRect(x: 0, y: 0, width: fittedSize.width, height: fittedSize.height)
        self.tableView.reloadData()
        let pdfPageBounds: CGRect = CGRect(x: 0, y: 0, width: fittedSize.width, height: (fittedSize.height))
        let pdfData: NSMutableData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageBounds, nil)
        UIGraphicsBeginPDFPageWithInfo(pdfPageBounds, nil)
        self.tableView.layer.render(in: UIGraphicsGetCurrentContext()!)
        UIGraphicsEndPDFContext()
        
        let documentsFileName = NSTemporaryDirectory() + "\(fileName).pdf"
        pdfData.write(toFile: documentsFileName, atomically: true)
        print(documentsFileName)
        return documentsFileName
    }
}
