//
//  PetEditViewController.swift
//  PetFinder
//
//  Created by Luke Parham on 9/3/15.
//  Copyright © 2015 Luke Parham. All rights reserved.
//

import UIKit

class PetEditViewController: UIViewController {
    
    var saveButton = UIBarButtonItem()
    var profileImageView = UIImageView()
    
    var nameTextField = UITextField()
    var ageTextField  = UITextField()
    
    var keyboardUp = false
    
    var petId: Int?
    
    override func loadView() {
        view = UIView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)

        automaticallyAdjustsScrollViewInsets = false
        edgesForExtendedLayout = []
        
        let stackView = UIStackView(arrangedSubviews: [profileImageView, nameTextField, ageTextField])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10.0
        
        view.addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20.0).isActive = true
        
        profileImageView.heightAnchor.constraint(equalToConstant: 300.0).isActive = true
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if !keyboardUp {
            UIView.animate(withDuration: 0.25) {
                self.view.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 100)
            }
            keyboardUp = true
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if keyboardUp {
            UIView.animate(withDuration: 0.25) {
                self.view.center = CGPoint(x: self.view.center.x, y: self.view.center.y + 100)
            }
            keyboardUp = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restorationIdentifier = "PetEditViewController"
        restorationClass = PetEditViewController.self
        
        
        view.backgroundColor = UIColor.white
        
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(PetEditViewController.saveWasTapped))
        
        nameTextField.borderStyle = .roundedRect
        ageTextField.borderStyle = .roundedRect
        
        nameTextField.placeholder = "Name"
        ageTextField.placeholder = "Age"
        
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.backgroundColor = UIColor.lightGray
        
        setPet()
    }
    
    @objc func saveWasTapped() {
        MatchedPetsManager.sharedManager.updatePet(petId!, name: nameTextField.text, age: ageTextField.text)
        
        navigationController?.popViewController(animated: true)
    }
    
    func setPet() {
        guard let petId = petId, let pet = MatchedPetsManager.sharedManager.petForId(petId) else {
            return
        }
        
        nameTextField.text = "\(pet.name)"
        ageTextField.text = "\(pet.age)"
        profileImageView.image = UIImage(data: pet.imageData)
    }
    
    override func encodeRestorableState(with coder: NSCoder) {
        print(#function)

        if let image = profileImageView.image {
            coder.encode(UIImagePNGRepresentation(image), forKey: "image")
        }
        
        if let name = nameTextField.text {
            coder.encode(name, forKey: "name")
        }
        
        if let age = ageTextField.text {
            coder.encode(age, forKey: "age")
        }

        coder.encode(Int32(petId!), forKey: "id")

        super.encodeRestorableState(with: coder)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        print(#function)
        if let imageData = coder.decodeObject(forKey: "image") as? NSData {
            profileImageView.image = UIImage(data: imageData as Data)
        }
        
        if let name = coder.decodeObject(forKey: "name") as? String {
            nameTextField.text = name
        }
        
        if let age = coder.decodeObject(forKey: "age") as? String {
            ageTextField.text = age
        }
        
        petId = Int(coder.decodeInteger(forKey: "id"))
        
        super.decodeRestorableState(with: coder)
    }
}

extension PetEditViewController: UIViewControllerRestoration {
    static func viewController(withRestorationIdentifierPath identifierComponents: [Any], coder: NSCoder) -> UIViewController? {

        let vc = PetEditViewController()
        return vc
    }
}
