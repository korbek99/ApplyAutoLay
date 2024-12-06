//
//  HitsTableViewCell.swift
//  ApplyAutoLay
//
//  Created by Jose Preatorian on 04-12-24.
//

import UIKit
struct HitsViewCellModel {
    
    let title: String
    let name: String
    let dates: String
    init(name: String, title: String, dates: String) {
        self.title = title
        self.name = name
        self.dates = dates
    }
}
class HitsTableViewCell: UITableViewCell {
    let formatDate = UtilsDates()
    lazy var lblTitle: UILabel = {
        let label: UILabel = .init()
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var lblName: UILabel = {
        let label: UILabel = .init()
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
  
    lazy var lblDate: UILabel = {
        let label: UILabel = .init()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configLabels()
        setupUIUX()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configLabels() {
        
        lblName.font = UIFont.boldSystemFont(ofSize: 15.0)
        lblName.textColor = UIColor.gray
        lblName.numberOfLines = 0
        
        lblTitle.font = UIFont.systemFont(ofSize: 20.0)
        lblTitle.textColor = UIColor.black
        lblTitle.numberOfLines = 0
        lblTitle.lineBreakMode = .byWordWrapping
        
        lblDate.font = UIFont.boldSystemFont(ofSize: 15.0)
        lblDate.textColor = UIColor.gray
        lblDate.numberOfLines = 0
     
    }
    
    
    func setupUIUX() {
        self.backgroundColor = .white
        addSubview(lblName)
        addSubview(lblTitle)
        addSubview(lblDate)
    
        lblTitle.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        lblTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        lblTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        
        lblName.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 10).isActive = true
        lblName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        lblName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
       
        
        lblDate.topAnchor.constraint(equalTo: lblName.bottomAnchor, constant: 10).isActive = true
        lblDate.leadingAnchor.constraint(equalTo: lblName.trailingAnchor, constant: 5).isActive = true
       
    }
    
    func configure(_ model: HitsViewCellModel) {
   
        lblName.text = model.name + " - " + formatDate.timerAgoSet(from: model.dates)
        lblTitle.text = model.title
        lblDate.text =  "" //model.dates
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
