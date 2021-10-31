//
//  ViewController.swift
//  MemeMe
//
//  Created by skyme32 on 30/10/21.
//
// Source ICON: https://www.flaticon.es/icono-gratis/memes_5247390?term=meme&page=1&position=7&page=1&position=7&related_id=5247390&origin=search

import UIKit



class ViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    let styleTextAttributes: [NSAttributedString.Key: Any] = [
        .strokeColor: UIColor.black,
        .foregroundColor: UIColor.white,
        .font: UIFont(name: "impact", size: 28)!,
        .strokeWidth: -5.0
    ]
    let TEXT_TOP = "TOP"
    let TEXT_BOTTOM = "BOTTOM"

    // MARK: IBOutlet properties
    @IBOutlet weak var imagePicker: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextFiled: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var navBar: UIToolbar!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Style textfields and control the camera exist
        styleTextField(textField: topTextFiled, message: TEXT_TOP)
        styleTextField(textField: bottomTextField, message: TEXT_BOTTOM)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }

    override func viewWillAppear(_ animated: Bool) {
        statuShareButton()
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeFromKeyboardNotifications()
    }
    
    
    // MARK: Style from TextFields and Delegates
    func styleTextField(textField: UITextField, message: String) {
        textField.defaultTextAttributes = styleTextAttributes
        textField.textAlignment = .center
        textField.text = message
        textField.delegate = self
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.text == TEXT_TOP || textField.text == TEXT_BOTTOM {
            textField.text = ""
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
        
    
    // MARK: Actions Camera/Library & Share/Cancel
    @IBAction func pickAnImage(_ sender: Any) {
        showImagePickerController(sourceType: .photoLibrary)
    }
    
    @IBAction func cmaeraAnImage(_ sender: Any) {
        showImagePickerController(sourceType: .camera)
    }
    
    @IBAction func shareAction(_ sender: Any) {
        let activityController = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: nil)
        activityController.completionWithItemsHandler = { activity, completed, items, error in
            if completed {
                self.save()
                self.dismiss(animated: true, completion: nil)
            }
        }
        present(activityController, animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.topTextFiled.text = TEXT_TOP
        self.bottomTextField.text = TEXT_BOTTOM
        self.imagePicker.image = nil
        statuShareButton()
    }
    
    
    // MARK: Save the image
    func save() {
        // Generated the meme
        let memedImage = generateMemedImage()
        
        // Create the meme
        _ = Meme(topText: topTextFiled.text!, bottomText: bottomTextField.text!, originalImage: imagePicker.image!, memedImage: memedImage)
    }
    
    func generateMemedImage() -> UIImage {
        // Hide toolbar and navbar
        hideAndShowBars(status: true)

        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        // Show toolbar and navbar
        hideAndShowBars(status: false)

        return memedImage
    }
    
    
    // MARK: Status shareButton
    private func statuShareButton() {
        if imagePicker.image == nil {
            shareButton.isEnabled = false
        } else {
            shareButton.isEnabled = false
        }
    }
    
    // MARK: Status navBar & Toolbar
    private func hideAndShowBars(status: Bool) {
        navBar.isHidden = status
        toolbar.isHidden = status
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
            shareButton.isEnabled = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
