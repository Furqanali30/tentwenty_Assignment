//
//  ExtensionsClass.swift
//  Golwiz
//
//  Created by Furqan Ali Khan on 08/02/2021.
//

import Foundation
import UIKit



@objc class ClosureSleeve: NSObject {
    let closure: (String)->()

    init (_ closure: @escaping (String)->()) {
        self.closure = closure
    }

    @objc func invoke (inputString:String) {
        closure(inputString)
    }
    
}

extension UIView
{
    var borderWidth:CGFloat{
        get{
            return self.layer.borderWidth
        }
        set(newValue){
            self.layer.borderWidth = newValue
        }
    }
    
    var borderColor:CGColor{
        get{
            return self.layer.borderColor!
        }
        set(newValue){
            self.layer.borderColor = newValue
        }
    }
    
    var cornerRadius:CGFloat{
        get{
            return self.layer.cornerRadius
        }
        set(newValue){
            self.layer.cornerRadius = newValue
        }
    }
    
    var X:CGFloat{
        get {
            return self.frame.origin.x
        }
    }
    
    var Y:CGFloat{
        get {
            return self.frame.origin.y
        }
    }
    
    var width:CGFloat{
        get {
            return self.frame.width
        }
    }
    
    var height:CGFloat{
        get {
            return self.frame.height
        }
    }
    
    func SumYPlusHeight() -> CGFloat
    {
        return (self.frame.origin.y + self.frame.height)
        
    }
    
    func SumXPlusWidth() -> CGFloat
    {
        return (self.frame.origin.x + self.frame.width)
        
    }
    
    func constraintWithIdentifier(_ identifier: String) -> NSLayoutConstraint? {
        return self.constraints.first { $0.identifier == identifier }
    }
    
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorTwo.cgColor, colorOne.cgColor]
        //        gradientLayer.locations = [0.0, 4.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        layer.insertSublayer(gradientLayer, at: 0)
    }
   
       func cornerRadiusSelectedSides(corners: UIRectCorner, radius: CGFloat) {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    
   
}


extension String {
    func firstValueIsGreaterThanSecondFurqan(second:String) -> Bool {
        
        let firstValue:Float = Float(self) ?? 0
        let secondValue:Float = Float(second) ?? 0
        
        if firstValue > secondValue
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    var int:Int{
        get{
            return Int(self) ?? 0
        }
    }
    
    var float:Float{
        get{
            return Float(self) ?? 0
        }
    }
    
    var cgFloat:CGFloat{
        get{
            return CGFloat(Float(self) ?? 0)
        }
    }
    
    
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
    

        func isValidEmail() -> Bool {
            // here, `try!` will always succeed because the pattern is valid
            let regex = try! NSRegularExpression(pattern: "^[\\W]*([\\w+\\-.%]+@[\\w\\-.]+\\.[A-Za-z] {2,4}[\\W]*,{1}[\\W]*)*([\\w+\\-.%]+@[\\w\\-.]+\\.[A-Za-z]{2,4})[\\W]*$", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
        }
    
    
}

extension UIImage {
    func toBase64() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
    
    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
     let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
     UIGraphicsBeginImageContextWithOptions(size, false, 0)
     color.setFill()
     UIRectFill(rect)
     let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
     UIGraphicsEndImageContext()
     return image
    }
}


extension UIImageView {
    func makeCircular(){
        self.cornerRadius = (self.width / 2)
    }
    
    

}

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
    
    convenience init(r:CGFloat,g:CGFloat,b:CGFloat)
    {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

extension UITableView{
    var parentViewController:UIViewController{
        get
        {
            let parenViewController:UIViewController = GetCurrentViewControllerClass.FirstAvailableViewController(inputView: self)
            return parenViewController
        }
    }
    
    func scrollToTopFunctionMine()
    {
        self.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    func scrollToBottomFunctionMine()
    {
        self.scrollToRow(at: IndexPath(row: self.numberOfRows(inSection: 0)-1, section: 0), at: .top, animated: false)
    }
    
    func removeTopPadding()
    {
        if #available(iOS 15.0, *) {
            self.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
    }
}

extension UICollectionView{
    var parentViewController:UIViewController{
        get
        {
            let parenViewController:UIViewController = GetCurrentViewControllerClass.FirstAvailableViewController(inputView: self)
            return parenViewController
        }
    }
    
}

extension UITableViewCell{
    var parentViewController:UIViewController{
        get
        {
            let parenViewController:UIViewController = GetCurrentViewControllerClass.FirstAvailableViewController(inputView: self)
            return parenViewController
        }
    }
}

extension UICollectionViewCell{
    var parentViewController:UIViewController{
        get
        {
            let parenViewController:UIViewController = GetCurrentViewControllerClass.FirstAvailableViewController(inputView: self)
            return parenViewController
        }
    }
}

extension UIButton{
    func click(){
        self.sendActions(for: .touchUpInside)
    }
    
    func click(event:UIControl.Event){
        self.sendActions(for: event)
    }
}


extension Int{
    var CgFloat:CGFloat{
        get{
            return CGFloat(self)
        }
    }
    var string:String{
        get{
            return String(self)
        }
    }
}


extension Float{
    var string:String{
        get{
            return String(self)
        }
    }
    
    var clean: String {
           return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
        }
}

extension Double{
    var string:String{
        get{
            return String(self)
        }
    }
}


extension CGFloat{
    var ceil:CGFloat{
        get{
            return self.rounded(.up)
        }
    }
    
    var floor:CGFloat{
        get{
            return self.rounded(.down)
        }
    }
    
    var string:String{
        get{
            return String(Float(self))
        }
    }
    
    var clean: String {
           return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(Float(self))
        }
    
    
}

extension CGFloat {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> CGFloat {
        let divisor = pow(10.0, CGFloat(places))
        return (self * divisor).rounded() / divisor
    }
}


extension UITextView: UITextViewDelegate {
    
    /// Resize the placeholder when the UITextView bounds change
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    /// The UITextView placeholder text
    public var placeholder: String? {
        get {
            var placeholderText: String?
            
            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeholderLabel.text
            }
            
            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }
    
    /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
    ///
    /// - Parameter textView: The UITextView that got updated
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = !self.text.isEmpty
        }
    }
    
    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top - 2
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height

            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }
    
    /// Adds a placeholder UILabel to this UITextView
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()
        
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.white
        placeholderLabel.tag = 100
        
        placeholderLabel.isHidden = !self.text.isEmpty
        placeholderLabel.isUserInteractionEnabled = false
        
        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
        self.delegate = self
    }
    
}


extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: self)
    }

}
