//
//  UIHelpers.swift
//  MyGitHubAPI
//
//  Created by macuser on 11/13/22.
//

import UIKit

class UIHelpers{
    
    /// for example, frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100)
    public static func createSpinnerFooter(frame: CGRect) -> UIView{
        let footerView = UIView(frame: frame)
        
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        
        spinner.startAnimating()
        return footerView
    }
}

extension String {
    
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        
        let size = self.boundingRect(
            with: textSize,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font : font],
            context: nil
        )
        
        return ceil(size.height)
    }
}

