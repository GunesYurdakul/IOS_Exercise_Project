//
//  RatingControl.swift
//  GUNES
//
//  Created by Güneş Yurdakul on 08/08/2017.
//  Copyright © 2017 gunesyurdakul. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    //MARK:Properties
    private var ratingButtons = [UIButton]()
    var rating = 0{
        didSet{
            updateButtonSelectionStates()
        }
    }
    @IBInspectable var starSize: CGSize = CGSize(width:44.0, height:44.0){
        didSet{
            setUpButtons()
        }
    }
    @IBInspectable var starCount:Int = 5{
        didSet{
            setUpButtons()
        }
    }
    
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
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        for button in ratingButtons{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        for _ in 0..<starCount{
        let Button = UIButton()
       
        Button.setImage(emptyStar, for: .normal)
        Button.setImage(filledStar, for: .selected)
        Button.setImage(highlightedStar, for: .highlighted)
        Button.setImage(highlightedStar, for: [.highlighted, .selected])
            
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
        Button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
        
        Button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
        addArrangedSubview(Button)
        ratingButtons.append(Button)
        }
    }
    //MARK: Button Action
    func ratingButtonTapped(button:UIButton){
        guard let index = ratingButtons.index(of: button)else{
            fatalError("The button, \(button), is not in the ratingsButtons array: \(ratingButtons)")
        }
        let selectedRating = index + 1
        
        if selectedRating == rating {
            rating = 0
        }else{
            rating = selectedRating
        }
    
    }
    
    private func updateButtonSelectionStates(){
        for (index, button) in ratingButtons.enumerated(){
            button.isSelected = index < rating
        }
    }
    
}
