//
//  LabeledToolbarView.swift
//  Feeding
//
//  Created by Jason Ji on 7/11/18.
//  Copyright © 2018 Jason Ji. All rights reserved.
//

import UIKit

public class LabeledToolbarView: UIView {

    public var doneHandler: (() -> ())?
    public var cancelHandler: (() -> ())?
    
    public var centerTitle: String = "" {
        didSet {
            centerLabel?.text = centerTitle
        }
    }
    
    private var centerLabel: UILabel!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        sharedInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    func sharedInit() {
        backgroundColor = .secondarySystemBackground
        
        let line = UIView(frame: .zero)
        line.backgroundColor = .separator
        
        line.translatesAutoresizingMaskIntoConstraints = false
        addSubview(line)
        line.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        line.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        line.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        line.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1.0).isActive = true
        
        let doneButton = UIButton(type: .system)
        doneButton.setTitle("Done", for: .normal)
        doneButton.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(doneButton)
        doneButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        doneButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0).isActive = true
        
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
    
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cancelButton)
        cancelButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0).isActive = true
        
        centerLabel = UILabel(frame: .zero)
        centerLabel.text = centerTitle
        
        centerLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(centerLabel)
        centerLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        centerLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
    @objc private func doneTapped() {
        doneHandler?()
    }
    
    @objc private func cancelTapped() {
        cancelHandler?()
    }
    
}
