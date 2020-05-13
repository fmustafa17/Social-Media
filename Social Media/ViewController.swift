//
//  ViewController.swift
//  Storm Viewer
//
//  Created by Farhana Mustafa on 5/2/20.
//  Copyright © 2020 Farhana Mustafa. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Storm Viewer"
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        pictures = pictures.sorted(by: { $0 < $1 })
        print(pictures)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //load "Detail" View Controller and typecast it to be DetailViewController
        if let detailVC = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            //Success, set its selectedImage, selectedPictureNumber and totalPictures properties
            detailVC.selectedImage = pictures[indexPath.row]
            detailVC.selectedPictureNumber = indexPath.row + 1
            detailVC.totalPictures = pictures.count
            
            //Push it onto the Navigation controller
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

