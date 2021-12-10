//
//  MemeListController.swift
//  MemeMe
//
//  Created by skyme32 on 10/12/21.
//

import UIKit

class MemeListController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = false
    }

    @IBAction func createNewImage(_ sender: Any) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "CreateMemeViewController") as! ViewController
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
}

// MARK: Table View Data Source

extension MemeListController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VillainCell")!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
