//
//  TableViewCell.swift
//
//  Created by Felipe Ignacio Zapata Riffo//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    static let identifier = "cell"
    
    public func nib() ->UINib {
        return UINib(nibName: "cell", bundle: nil)
    }
    
    var typeLabel : UILabel = {
       let textoLabel = UILabel()
        textoLabel.textColor = .black
        textoLabel.textAlignment = .center
        textoLabel.backgroundColor = .clear
        textoLabel.numberOfLines = 0
        textoLabel.translatesAutoresizingMaskIntoConstraints = false
        textoLabel.font = UIFont.systemFont(ofSize: 14.0)
        return textoLabel
    }()
    
    var direccionLabel : UILabel = {
       let direccionLabel = UILabel()
        direccionLabel.textColor = .black
        direccionLabel.textAlignment = .center
        direccionLabel.backgroundColor = .clear
        direccionLabel.numberOfLines = 0
        direccionLabel.translatesAutoresizingMaskIntoConstraints = false
        direccionLabel.font = UIFont.systemFont(ofSize: 15.0)
        return direccionLabel
    }()
    
    var codeLabel : UILabel = {
       let codeLabel = UILabel()
        codeLabel.textColor = .black
        codeLabel.textAlignment = .center
        codeLabel.backgroundColor = .clear
        codeLabel.numberOfLines = 0
        codeLabel.translatesAutoresizingMaskIntoConstraints = false
        codeLabel.font = UIFont.systemFont(ofSize: 15.0)
        return codeLabel
    }()
    
    func setUpView(){
        contentView.addSubview(typeLabel)
        contentView.addSubview(direccionLabel)
        contentView.addSubview(codeLabel)
        
        typeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        typeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        typeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -300).isActive = true
        typeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50).isActive = true
        
    
        direccionLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 10).isActive = true
        direccionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        direccionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        codeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        codeLabel.leadingAnchor.constraint(equalTo: typeLabel.trailingAnchor, constant: 10).isActive = true
        codeLabel.bottomAnchor.constraint(equalTo: direccionLabel.topAnchor, constant: -10).isActive = true
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpView()
        
    }

}
