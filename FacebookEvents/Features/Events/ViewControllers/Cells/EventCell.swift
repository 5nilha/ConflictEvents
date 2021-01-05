//
//  EventCell.swift
//  FacebookEvents
//
//  Created by Fabio Quintanilha on 8/10/20.
//  Copyright © 2020 FabioQuintanilha. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
    
    static let identifier = "eventCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setView()
     }

     required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setView()
    }

    deinit {
        print("deinitializing EventTableViewCell for \(String(describing: self.titleLabel.text))")
    }
    
    override func prepareForReuse() {
        self.clearCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(event: EventViewModel, backgroundColor: UIColor) {
        self.titleLabel.text = event.title
        self.startTimeLabel.text = "Start at: \(event.startTime ?? "")"
        self.endTimeLabel.text = "Ends at: \(event.endTime ?? "")"
        self.contentView.backgroundColor = backgroundColor
        
        if event.isOverlaping {
            self.warningMessageLabel.text = "Overlapping with another Event"
            self.warningImageView.isHidden = false
            self.warningMessageLabel.isHidden = false
        }
    }
    
    func clearCell() {
        self.titleLabel.text = ""
        self.startTimeLabel.text = ""
        self.endTimeLabel.text = ""
        self.warningMessageLabel.text = ""
        self.warningImageView.isHidden = true
        self.warningMessageLabel.isHidden = true
    }
    
    func setView() {
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(hStack)
        self.contentView.addSubview(warningMessageLabel)
        self.contentView.addSubview(warningImageView)
        

        titleLabel.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant: 15).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant: -15).isActive = true
        
        startTimeView.widthAnchor.constraint(equalToConstant: 110).isActive = true
        endTimeView.widthAnchor.constraint(equalToConstant: 110).isActive = true
        
        startTimeView.addSubview(startTimeLabel)
        endTimeView.addSubview(endTimeLabel)
        
        startTimeLabel.topAnchor.constraint(equalTo:self.startTimeView.topAnchor, constant: 2).isActive = true
        startTimeLabel.centerXAnchor.constraint(equalTo:self.startTimeView.centerXAnchor).isActive = true
        startTimeLabel.bottomAnchor.constraint(equalTo:self.startTimeView.bottomAnchor, constant: -2).isActive = true
        
        endTimeLabel.topAnchor.constraint(equalTo:self.endTimeView.topAnchor, constant: 2).isActive = true
        endTimeLabel.centerXAnchor.constraint(equalTo:self.endTimeView.centerXAnchor).isActive = true
        endTimeLabel.bottomAnchor.constraint(equalTo:self.endTimeView.bottomAnchor, constant: -2).isActive = true
        
        hStack.addArrangedSubview(self.startTimeView)
        hStack.addArrangedSubview(self.endTimeView)
        hStack.topAnchor.constraint(equalTo:self.titleLabel.bottomAnchor, constant: 15).isActive = true
        hStack.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant: 15).isActive = true
        
        warningImageView.topAnchor.constraint(equalTo:self.hStack.bottomAnchor, constant: 15).isActive = true
        warningImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant: 15).isActive = true
        warningImageView.widthAnchor.constraint(equalToConstant: 13).isActive = true
        warningImageView.heightAnchor.constraint(equalToConstant: 13).isActive = true
        
        warningMessageLabel.topAnchor.constraint(equalTo:self.hStack.bottomAnchor, constant: 15).isActive = true
        warningMessageLabel.leadingAnchor.constraint(equalTo:self.warningImageView.trailingAnchor, constant: 10).isActive = true
        warningMessageLabel.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant: -15).isActive = true
        warningMessageLabel.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant: -10).isActive = true
        
    }
    
    var hStack: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Medium", size: 18)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    var startTimeView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.backgroundColor = UIColor(named: "mainColor")?.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var endTimeView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.backgroundColor = UIColor(named: "secondaryColor")?.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var startTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "avenir", size: 12)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var endTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "avenir", size: 12)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var warningMessageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "avenir", size: 11)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
       
   var warningImageView: UIImageView = {
       let imageView = UIImageView(image: UIImage(named: "warning_icon"))
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
   }()

}
