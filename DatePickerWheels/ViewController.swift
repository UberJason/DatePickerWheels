//
//  ViewController.swift
//  DatePickerWheels
//
//  Created by Jason Ji on 7/9/20.
//

import UIKit

class ViewController: UIViewController {

    var myInput: MyInput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Adding a UIDatePicker to a normal view hierarchy works as expected.
        let datePicker = MyInput().makeDatePicker()
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(datePicker)
        datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150).isActive = true
        
        
        // Adding a UIDatePicker as an inputView (see the `inputView` property on MyInput) does not work, it renders with zero frame.
        // The inputAccessoryView is the only thing that shows in this example.
        
        // Usage: Tap "Tap Me" to attempt to show a date picker and a toolbar above it, but only the toolbar appears on screen.
        
        myInput = MyInput()
        myInput.backgroundColor = .blue
        myInput.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(myInput)
        myInput.heightAnchor.constraint(equalToConstant: 50).isActive = true
        myInput.widthAnchor.constraint(equalToConstant: 200).isActive = true
        myInput.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myInput.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        myInput.layoutIfNeeded()
        
        let label = UILabel(frame: .zero)
        label.textColor = .systemBackground
        label.text = "Tap Me"
        myInput.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: myInput.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: myInput.centerYAnchor).isActive = true
        
        myInput.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(becomeInput)))
        
        addDescription()
    }
    
    func addDescription() {
        let label2 = UILabel(frame: .zero)
        label2.numberOfLines = 0
        label2.text =
            """
            Tap 'Tap Me' to attempt to show a date picker and a toolbar above it as an inputView / inputAccessoryView. But only the inputAccessoryView will show."

            Observe that displaying a DatePicker in the view normally works as expected.
            """
        label2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label2)
        label2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        label2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        label2.topAnchor.constraint(equalTo: myInput.bottomAnchor, constant: 32).isActive = true
    }

    @objc func timeChanged(_ sender: Any) {
        print("timeChanged")
    }
    
    @objc func becomeInput() {
        myInput.becomeFirstResponder()
    }
}

class MyInput: UIView {
    public override var canBecomeFirstResponder: Bool {
        return true
    }
    
    public override var inputView: UIView? {
        let datePicker = makeDatePicker()
        return datePicker
    }
    
    public override var inputAccessoryView: UIView? {
        return toolbar
    }
    
    public func makeDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = .systemBackground
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(timeChanged(_:)), for: .valueChanged)
        datePicker.maximumDate = Date()
        return datePicker
    }
    
    private lazy var toolbar: LabeledToolbarView = {
        let bar = LabeledToolbarView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44.0))

        bar.centerTitle = "A Toolbar"
        
        bar.doneHandler = { [weak self] in
            self?.resignFirstResponder()
        }
        bar.cancelHandler = { [weak self] in
            self?.resignFirstResponder()
        }
        
        return bar
    }()
    
    @objc func timeChanged(_ sender: Any) {
        print("timeChanged")
    }
}
