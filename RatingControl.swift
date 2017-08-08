//
//  RatingControl.swift
//  GUNES
//
//  Created by Güneş Yurdakul on 08/08/2017.
//  Copyright © 2017 gunesyurdakul. All rights reserved.
//

import UIKit

class RatingControl: UIStackView {
    
    private var ratingButtons = [UIButton]()
    var rating = 0
    
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setUpButtons()
    }
    
    //MARK: Private Methods
    private func setUpButtons(){
        for _ in 0..<5{
        let Button = UIButton()
        Button.backgroundColor = UIColor.cyan
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        Button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        Button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
        addArrangedSubview(Button)
        ratingButtons.append(Button)
        }
    }
    //MARK: Button Action
    func ratingButtonTapped(button:UIButton){
        print("Button pressed👍")
        }
    
}
