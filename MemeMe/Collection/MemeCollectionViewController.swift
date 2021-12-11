//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by skyme32 on 10/12/21.
//

import UIKit

private let reuseIdentifier = "MemeCollectionCell"

class MemeCollectionViewController: UICollectionViewController {
    
    // MARK: Properties
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let space:CGFloat = 3.0
        let dimension = (self.view.frame.size.width - (2 * space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        flowLayout.scrollDirection = .vertical
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
    }
    
    
    // MARK: Lifcycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = false
        
        // Reload datasource
        self.collectionView.reloadData()
    }

    @IBAction func createNewImage(_ sender: Any) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "CreateMemeViewController") as! ViewController
        self.navigationController!.pushViewController(detailController, animated: true)
    }

    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "CreateMemeViewController") as! ViewController
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemeCollectionCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        // Set the name and image
        cell.memeImageView?.image = meme.memedImage
    
        return cell
    }

}
