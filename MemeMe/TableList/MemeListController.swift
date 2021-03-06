//
//  MemeListController.swift
//  MemeMe
//
//  Created by skyme32 on 10/12/21.
//

import UIKit

class MemeListController: UITableViewController {
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = false
        
        // Reload de datasource
        self.tableView.reloadData()
    }

    @IBAction func createNewImage(_ sender: Any) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "CreateMemeViewController") as! ViewController
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    // MARK: Data source Table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemesCell", for: indexPath) as! MemeViewCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        // Set the name and image
        cell.titleLabel?.text = "\(meme.topText)...\(meme.bottomText)"
        cell.imageView?.image = meme.memedImage
                
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "CreateMemeViewController") as! ViewController
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
}
