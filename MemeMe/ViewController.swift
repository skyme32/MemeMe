//
//  ViewController.swift
//  MemeMe
//
//  Created by skyme32 on 30/10/21.
//

import UIKit

class ViewController: UIViewController {

    // MARK: IBOutlet properties
    @IBOutlet weak var imagePicker: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    
    // MARK: Actions Camera & Library
    @IBAction func pickAnImage(_ sender: Any) {
        showImagePickerController(sourceType: .photoLibrary)
    }
    
    @IBAction func cmaeraAnImage(_ sender: Any) {
        showImagePickerController(sourceType: .camera)
    }
    
    
}

// MARK: Control Picker controller
extension ViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePicker.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
