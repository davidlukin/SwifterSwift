//
//  UIImageViewExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/25/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

extension UIImageView {
	/// Download image from url and set it in an imageView.
	public func download(from url: String, contentMode: UIViewContentMode = .scaleAspectFit, placeHolder: UIImage? = nil) {
		image = placeHolder
		guard let url = URL(string: url) else {
			return
		}
		self.contentMode = contentMode
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			guard
				let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
				let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
				let data = data, error == nil,
				let image = UIImage(data: data)
				else {
					return
			}
			DispatchQueue.main.async() { () -> Void in
				self.image = image
			}
			}.resume()
	}
	
	/// Make image view blurry
	func blur(withStyle: UIBlurEffectStyle = .light) {
		let blurEffect = UIBlurEffect(style: withStyle)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.frame = self.bounds
		blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
		self.addSubview(blurEffectView)
		self.clipsToBounds = true
	}
	
	/// Return a blurred version of an image view
	func blurred(withStyle: UIBlurEffectStyle = .light) -> UIImageView {
		return self.blurred(withStyle: withStyle)
	}
	
}
