import Foundation
import Display
import AsyncDisplayKit

private let timezoneOffset: Int32 = {
    let nowTimestamp = Int32(CFAbsoluteTimeGetCurrent() + NSTimeIntervalSince1970)
    var now: time_t = time_t(nowTimestamp)
    var timeinfoNow: tm = tm()
    localtime_r(&now, &timeinfoNow)
    return Int32(timeinfoNow.tm_gmtoff)
}()

private let granularity: Int32 = 60 * 60 * 24

final class ChatMessageDateHeader: ListViewItemHeader {
    private let timestamp: Int32
    private let roundedTimestamp: Int32
    
    let id: Int64
    let theme: PresentationTheme
    let strings: PresentationStrings
    
    init(timestamp: Int32, theme: PresentationTheme, strings: PresentationStrings) {
        self.timestamp = timestamp
        self.theme = theme
        self.strings = strings
        
        if timestamp == Int32.max {
            self.roundedTimestamp = timestamp / (granularity) * (granularity)
        } else {
            self.roundedTimestamp = ((timestamp + timezoneOffset) / (granularity)) * (granularity)
        }
        self.id = Int64(self.roundedTimestamp)
    }
    
    let stickDirection: ListViewItemHeaderStickDirection = .bottom
    
    let height: CGFloat = 34.0
    
    func node() -> ListViewItemHeaderNode {
        return ChatMessageDateHeaderNode(timestamp: self.roundedTimestamp, theme: self.theme, strings: self.strings)
    }
}

private let titleFont = Font.medium(13.0)

private func monthAtIndex(_ index: Int, strings: PresentationStrings) -> String {
    switch index {
        case 0:
            return strings.Month_GenJanuary
        case 1:
            return strings.Month_GenFebruary
        case 2:
            return strings.Month_GenMarch
        case 3:
            return strings.Month_GenApril
        case 4:
            return strings.Month_GenMay
        case 5:
            return strings.Month_GenJune
        case 6:
            return strings.Month_GenJuly
        case 7:
            return strings.Month_GenAugust
        case 8:
            return strings.Month_GenSeptember
        case 9:
            return strings.Month_GenOctober
        case 10:
            return strings.Month_GenNovember
        case 11:
            return strings.Month_GenDecember
        default:
            return ""
    }
}

final class ChatMessageDateHeaderNode: ListViewItemHeaderNode {
    let labelNode: TextNode
    let backgroundNode: ASImageNode
    let stickBackgroundNode: ASImageNode
    
    private let timestamp: Int32
    private var theme: PresentationTheme
    private var strings: PresentationStrings
    
    private var flashingOnScrolling = false
    private var stickDistanceFactor: CGFloat = 0.0
    
    //private let testNode = ASDisplayNode()
    
    init(timestamp: Int32, theme: PresentationTheme, strings: PresentationStrings) {
        self.timestamp = timestamp
        self.theme = theme
        self.strings = strings
        
        self.labelNode = TextNode()
        self.labelNode.isLayerBacked = true
        self.labelNode.displaysAsynchronously = true
        
        self.backgroundNode = ASImageNode()
        self.backgroundNode.isLayerBacked = true
        self.backgroundNode.displayWithoutProcessing = true
        self.backgroundNode.displaysAsynchronously = false
        
        self.stickBackgroundNode = ASImageNode()
        self.stickBackgroundNode.isLayerBacked = true
        self.stickBackgroundNode.displayWithoutProcessing = true
        self.stickBackgroundNode.displaysAsynchronously = false
        
        //self.testNode.backgroundColor = .black
        //self.testNode.isLayerBacked = true
        
        super.init(layerBacked: true, dynamicBounce: true, isRotated: true, seeThrough: false)
        
        self.transform = CATransform3DMakeRotation(CGFloat.pi, 0.0, 0.0, 1.0)
        
        let graphics = PresentationResourcesChat.principalGraphics(theme)
        
        self.backgroundNode.image = graphics.dateStaticBackground
        self.stickBackgroundNode.image = graphics.dateFloatingBackground
        self.stickBackgroundNode.alpha = 0.0
        self.backgroundNode.addSubnode(self.stickBackgroundNode)
        self.addSubnode(self.backgroundNode)
        self.addSubnode(self.labelNode)
        
        //self.addSubnode(self.testNode)
        
        let nowTimestamp = Int32(CFAbsoluteTimeGetCurrent() + NSTimeIntervalSince1970)
        
        var t: time_t = time_t(timestamp)
        var timeinfo: tm = tm()
        localtime_r(&t, &timeinfo)
        
        var now: time_t = time_t(nowTimestamp)
        var timeinfoNow: tm = tm()
        localtime_r(&now, &timeinfoNow)
        
        let text: String
        if timeinfo.tm_year == timeinfoNow.tm_year {
            if timeinfo.tm_yday == timeinfoNow.tm_yday {
                text = strings.Weekday_Today
            } else {
                text = "\(monthAtIndex(Int(timeinfo.tm_mon), strings: strings)) \(timeinfo.tm_mday)"
            }
        } else {
            text = "\(monthAtIndex(Int(timeinfo.tm_mon), strings: strings)) \(timeinfo.tm_mday), \(1900 + timeinfo.tm_year)"
        }
        
        let attributedString = NSAttributedString(string: text, font: titleFont, textColor: UIColor.white)
        let labelLayout = TextNode.asyncLayout(self.labelNode)
        
        let (size, apply) = labelLayout(attributedString, nil, 1, .end, CGSize(width: 320.0, height: CGFloat.greatestFiniteMagnitude), .natural, nil, UIEdgeInsets())
        let _ = apply()
        self.labelNode.frame = CGRect(origin: CGPoint(), size: size.size)
        
        /*(self.layer as! CASeeThroughTracingLayer).updateRelativePosition = { [weak self] position in
            if let strongSelf = self {
                strongSelf.testNode.frame = CGRect(origin: CGPoint(x: 0.0, y: 70.0 + position.y), size: CGSize(width: 40.0, height: 20.0))
                print("position \(position.x), \(position.y)")
            }
        }*/
    }
    
    func updateThemeAndStrings(theme: PresentationTheme, strings: PresentationStrings) {
        self.theme = theme
        self.strings = strings
        
        let graphics = PresentationResourcesChat.principalGraphics(theme)
        
        self.backgroundNode.image = graphics.dateStaticBackground
        self.stickBackgroundNode.image = graphics.dateFloatingBackground
        
        self.setNeedsLayout()
    }
    
    override func layout() {
        super.layout()
        
        let bounds = self.bounds
        
        let labelLayout = TextNode.asyncLayout(self.labelNode)
        
        let size = self.labelNode.bounds.size
        let backgroundSize = CGSize(width: size.width + 8.0 + 8.0, height: 26.0)
        
        let backgroundFrame = CGRect(origin: CGPoint(x: floorToScreenPixels((bounds.size.width - backgroundSize.width) / 2.0), y: (34.0 - 26.0) / 2.0), size: backgroundSize)
        self.stickBackgroundNode.frame = CGRect(origin: CGPoint(), size: backgroundFrame.size)
        self.backgroundNode.frame = backgroundFrame
        self.labelNode.frame = CGRect(origin: CGPoint(x: backgroundFrame.origin.x + 8.0, y: backgroundFrame.origin.y + floorToScreenPixels((backgroundSize.height - size.height) / 2.0) - 1.0), size: size)
    }
    
    override func updateStickDistanceFactor(_ factor: CGFloat, transition: ContainedViewLayoutTransition) {
        if !self.stickDistanceFactor.isEqual(to: factor) {
            self.stickBackgroundNode.alpha = factor
            
            let wasZero = self.stickDistanceFactor < 0.5
            let isZero = factor < 0.5
            self.stickDistanceFactor = factor
            
            if wasZero != isZero {
                var animated = true
                if case .immediate = transition {
                    animated = false
                }
                self.updateFlashing(animated: animated)
            }
        }
    }
    
    override func updateFlashingOnScrolling(_ isFlashingOnScrolling: Bool, animated: Bool) {
        self.flashingOnScrolling = isFlashingOnScrolling
        self.updateFlashing(animated: animated)
    }
    
    private func updateFlashing(animated: Bool) {
        let flashing = self.flashingOnScrolling || self.stickDistanceFactor < 0.5
        
        let alpha: CGFloat = flashing ? 1.0 : 0.0
        let previousAlpha = self.backgroundNode.alpha
        
        if !previousAlpha.isEqual(to: alpha) {
            self.backgroundNode.alpha = alpha
            self.labelNode.alpha = alpha
            if animated {
                let duration: Double = flashing ? 0.3 : 0.4
                self.backgroundNode.layer.animateAlpha(from: previousAlpha, to: alpha, duration: duration)
                self.labelNode.layer.animateAlpha(from: previousAlpha, to: alpha, duration: duration)
            }
        }
    }
}
