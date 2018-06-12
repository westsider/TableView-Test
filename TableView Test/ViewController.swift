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
        myVc.filePath = createPDF(fileName: "Cam")
        navigationController?.pushViewController(myVc, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) //as! FlagCell
        return cell
    }
}
