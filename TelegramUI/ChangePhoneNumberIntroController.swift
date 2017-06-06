import Foundation
import Display
import AsyncDisplayKit
import TelegramCore

private final class ChangePhoneNumberIntroControllerNode: ASDisplayNode {
    var presentationData: PresentationData
    
    let iconNode: ASImageNode
    let labelNode: ASTextNode
    let buttonNode: HighlightableButtonNode
    
    var dismiss: (() -> Void)?
    var action: (() -> Void)?
    
    init(presentationData: PresentationData) {
        self.presentationData = presentationData
        
        self.iconNode = ASImageNode()
        self.labelNode = ASTextNode()
        self.buttonNode = HighlightableButtonNode()
        
        super.init(viewBlock: {
            return UITracingLayerView()
        }, didLoad: nil)
        
        self.iconNode.image = generateTintedImage(image: UIImage(bundleImageName: "Settings/ChangePhoneIntroIcon"), color: presentationData.theme.list.freeTextColor)
        let textColor = self.presentationData.theme.list.freeTextColor
        self.labelNode.attributedText = parseMarkdownIntoAttributedString(self.presentationData.strings.PhoneNumberHelp_Help, attributes: MarkdownAttributes(body: MarkdownAttributeSet(font: Font.regular(14.0), textColor: textColor), bold: MarkdownAttributeSet(font: Font.semibold(14.0), textColor: textColor), link: MarkdownAttributeSet(font: Font.regular(14.0), textColor: textColor), linkAttribute: { _ in return nil }), textAlignment: .center)
        self.buttonNode.setTitle(self.presentationData.strings.PhoneNumberHelp_ChangeNumber, with: Font.regular(19.0), with: self.presentationData.theme.list.itemAccentColor, for: .normal)
        self.buttonNode.addTarget(self, action: #selector(self.buttonPressed), forControlEvents: .touchUpInside)
        
        self.addSubnode(self.iconNode)
        self.addSubnode(self.labelNode)
        self.addSubnode(self.buttonNode)
        
        self.backgroundColor = self.presentationData.theme.list.blocksBackgroundColor
    }
    
    func animateIn() {
        self.layer.animatePosition(from: CGPoint(x: self.layer.position.x, y: self.layer.position.y + self.layer.bounds.size.height), to: self.layer.position, duration: 0.5, timingFunction: kCAMediaTimingFunctionSpring)
    }
    
    func animateOut() {
        self.layer.animatePosition(from: self.layer.position, to: CGPoint(x: self.layer.position.x, y: self.layer.position.y + self.layer.bounds.size.height), duration: 0.2, timingFunction: kCAMediaTimingFunctionEaseInEaseOut, removeOnCompletion: false, completion: { [weak self] _ in
            if let strongSelf = self {
                strongSelf.dismiss?()
            }
        })
    }
    
    func containerLayoutUpdated(_ layout: ContainerViewLayout, navigationBarHeight: CGFloat, transition: ContainedViewLayoutTransition) {
        var insets = layout.insets(options: [.statusBar])
        insets.top += navigationBarHeight
        let availableHeight = layout.size.height - insets.top - insets.bottom
        
        let largeScreen = availableHeight >= 420.0
        let contentHeight: CGFloat = largeScreen ? 420.0 : 400.0
        
        let iconSize = self.iconNode.measure(CGSize(width: 400.0, height: 400.0))
        let labelSize = self.labelNode.measure(CGSize(width: 295.0, height: CGFloat.greatestFiniteMagnitude))
        let buttonSize = self.buttonNode.measure(CGSize(width: 295.0, height: CGFloat.greatestFiniteMagnitude))
        
        transition.updateFrame(node: self.iconNode, frame: CGRect(origin: CGPoint(x: floor((layout.size.width - iconSize.width) / 2.0), y: insets.top + floor((availableHeight - contentHeight) / 2.0) + floor(iconSize.height * (largeScreen ? CGFloat(0.2) : CGFloat(0.5)))), size: iconSize))
        
        transition.updateFrame(node: self.labelNode, frame: CGRect(origin: CGPoint(x: floor((layout.size.width - labelSize.width) / 2.0), y: insets.top + floor((availableHeight - contentHeight) / 2.0) + floor((contentHeight - labelSize.height) / 2.0) + floor((contentHeight - iconSize.height - buttonSize.height) * 0.11)), size: labelSize))
        
        transition.updateFrame(node: self.buttonNode, frame: CGRect(origin: CGPoint(x: floor((layout.size.width - buttonSize.width) / 2.0), y: insets.top + floor((availableHeight - contentHeight) / 2.0) + contentHeight - buttonSize.height), size: buttonSize))
    }
    
    @objc func buttonPressed() {
        self.action?()
    }
}

final class ChangePhoneNumberIntroController: ViewController {
    private let account: Account
    private var didPlayPresentationAnimation = false
    
    private var presentationData: PresentationData
    
    init(account: Account, phoneNumber: String) {
        self.account = account
        
        self.presentationData = account.telegramApplicationContext.currentPresentationData.with { $0 }
        
        super.init(navigationBarTheme: NavigationBarTheme(rootControllerTheme: self.presentationData.theme))
        
        self.statusBar.statusBarStyle = self.presentationData.theme.rootController.statusBar.style.style
        
        self.title = phoneNumber
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: presentationData.strings.Common_Back, style: .plain, target: nil, action: nil)
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelPressed))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadDisplayNode() {
        self.displayNode = ChangePhoneNumberIntroControllerNode(presentationData: self.presentationData)
        (self.displayNode as! ChangePhoneNumberIntroControllerNode).dismiss = { [weak self] in
            self?.presentingViewController?.dismiss(animated: false, completion: nil)
        }
        (self.displayNode as! ChangePhoneNumberIntroControllerNode).action = { [weak self] in
            self?.proceed()
        }
        self.displayNodeDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /*if !self.didPlayPresentationAnimation {
            self.didPlayPresentationAnimation = true
            (self.displayNode as! ChangePhoneNumberIntroControllerNode).animateIn()
        }*/
    }
    
    override public func containerLayoutUpdated(_ layout: ContainerViewLayout, transition: ContainedViewLayoutTransition) {
        super.containerLayoutUpdated(layout, transition: transition)
        
        (self.displayNode as! ChangePhoneNumberIntroControllerNode).containerLayoutUpdated(layout, navigationBarHeight: self.navigationHeight, transition: transition)
    }
    
    @objc func cancelPressed() {
        (self.displayNode as! ChangePhoneNumberIntroControllerNode).animateOut()
    }
    
    func proceed() {
        self.present(standardTextAlertController(title: nil, text: self.presentationData.strings.PhoneNumberHelp_Alert, actions: [TextAlertAction(type: .defaultAction, title: self.presentationData.strings.Common_Cancel, action: {}), TextAlertAction(type: .genericAction, title: self.presentationData.strings.Common_OK, action: { [weak self] in
            if let strongSelf = self {
                (strongSelf.navigationController as? NavigationController)?.replaceTopController(ChangePhoneNumberController(account: strongSelf.account), animated: true)
            }
        })]), in: .window, with: ViewControllerPresentationArguments(presentationAnimation: .modalSheet))
    }
}
