//
//  ViewController.swift
//  TableView Test
//
//  Created by Warren Hansen on 6/10/18.
//  Copyright © 2018 Warren Hansen. All rights reserved.
//

// MARK:- TODO - populate from array
// MARK:- TODO - add weather

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    struct Person {
        var title: String
        var detail: String
    }
    
    var contacts: [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contacts.append( Person(title: "Warren Hansen", detail: "Camer Order Silicon Valley") )
        contacts.append( Person(title: "1 Camera", detail: "Arri Alexa") )
        contacts.append( Person(title: "1 Primes Zeiss Master Primes", detail: "12mm, 18mm, 21mm, 35mm, 50mm, 85mm, 100mm, 135mm, 150mm, 200mm, ") )
        contacts.append( Person(title: "1 Primes Zeiss Master Primes", detail: "12mm, 18mm, 21mm, 35mm, 50mm, 85mm, 100mm, 135mm, 150mm, 200mm, ") )
        contacts.append( Person(title: "1 Primes Zeiss Master Primes", detail: "12mm, 18mm, 21mm, 35mm, 50mm, 85mm, 100mm, 135mm, 150mm, 200mm, ") )
        contacts.append( Person(title: "1 Primes Zeiss Master Primes", detail: "12mm, 18mm, 21mm, 35mm, 50mm, 85mm, 100mm, 135mm, 150mm, 200mm, ") )
        contacts.append( Person(title: "1 Primes Zeiss Master Primes", detail: "12mm, 18mm, 21mm, 35mm, 50mm, 85mm, 100mm, 135mm, 150mm, 200mm, ") )
        
        contacts.append( Person(title: "Weather Report", detail: "1/2   71' - 92'   Partly Cloud\n1/2   71' - 92'   Partly Cloud\n1/2   71' - 92'   Partly Cloud\n1/2   71' - 92'   Partly Cloud\n1/2   71' - 92'   Partly Cloud") )
    

    }

    @IBAction func savePDF(_ sender: Any) {
        segueToNextViewContoller()
    }
    
    func segueToNextViewContoller() {
        let myVc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        myVc.filePath = createPdfFromTableView(fileName: "Cam")
        navigationController?.pushViewController(myVc, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListTableViewCell
        cell.titleTableView.text = contacts[indexPath.row].title
        cell.detailTableView.text = contacts[indexPath.row].detail
        return cell
    }
    
    func createPdfFromTableView(fileName:String)-> String {
        // need to un check "clip to bounds"
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
