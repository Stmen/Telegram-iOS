import Foundation
import Display
import AsyncDisplayKit
import TelegramCore
import SwiftSignalKit
import Postbox

final class ChatMediaInputStickerPackItem: ListViewItem {
    let account: Account
    let inputNodeInteraction: ChatMediaInputNodeInteraction
    let collectionId: ItemCollectionId
    let stickerPackItem: StickerPackItem?
    let selectedItem: () -> Void
    let index: Int
    let theme: PresentationTheme
    
    var selectable: Bool {
        return true
    }
    
    init(account: Account, inputNodeInteraction: ChatMediaInputNodeInteraction, collectionId: ItemCollectionId, stickerPackItem: StickerPackItem?, index: Int, theme: PresentationTheme, selected: @escaping () -> Void) {
        self.account = account
        self.inputNodeInteraction = inputNodeInteraction
        self.collectionId = collectionId
        self.stickerPackItem = stickerPackItem
        self.selectedItem = selected
        self.index = index
        self.theme = theme
    }
    
    func nodeConfiguredForWidth(async: @escaping (@escaping () -> Void) -> Void, width: CGFloat, previousItem: ListViewItem?, nextItem: ListViewItem?, completion: @escaping (ListViewItemNode, @escaping () -> (Signal<Void, NoError>?, () -> Void)) -> Void) {
        async {
            let node = ChatMediaInputStickerPackItemNode()
            node.contentSize = CGSize(width: 41.0, height: 41.0)
            node.insets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
            node.inputNodeInteraction = self.inputNodeInteraction
            node.updateStickerPackItem(account: self.account, item: self.stickerPackItem, collectionId: self.collectionId, theme: self.theme)
            completion(node, {
                return (nil, {})
            })
        }
    }
    
    public func updateNode(async: @escaping (@escaping () -> Void) -> Void, node: ListViewItemNode, width: CGFloat, previousItem: ListViewItem?, nextItem: ListViewItem?, animation: ListViewItemUpdateAnimation, completion: @escaping (ListViewItemNodeLayout, @escaping () -> Void) -> Void) {
        completion(ListViewItemNodeLayout(contentSize: node.contentSize, insets: node.insets), {
            (node as? ChatMediaInputStickerPackItemNode)?.updateStickerPackItem(account: self.account, item: self.stickerPackItem, collectionId: self.collectionId, theme: self.theme)
        })
    }
    
    func selected(listView: ListView) {
        self.selectedItem()
    }
}

private let boundingSize = CGSize(width: 41.0, height: 41.0)
private let boundingImageSize = CGSize(width: 30.0, height: 30.0)
private let highlightSize = CGSize(width: 35.0, height: 35.0)
private let verticalOffset: CGFloat = 3.0

final class ChatMediaInputStickerPackItemNode: ListViewItemNode {
    private let imageNode: TransformImageNode
    private let highlightNode: ASImageNode
    
    var inputNodeInteraction: ChatMediaInputNodeInteraction?
    var currentCollectionId: ItemCollectionId?
    private var currentItem: StickerPackItem?
    private var theme: PresentationTheme?
    
    private let stickerFetchedDisposable = MetaDisposable()
    
    init() {
        self.highlightNode = ASImageNode()
        self.highlightNode.isLayerBacked = true
        self.highlightNode.isHidden = true
        
        self.imageNode = TransformImageNode()
        self.imageNode.isLayerBacked = true
        
        self.highlightNode.frame = CGRect(origin: CGPoint(x: floor((boundingSize.width - highlightSize.width) / 2.0) + verticalOffset, y: floor((boundingSize.height - highlightSize.height) / 2.0)), size: highlightSize)
        
        self.imageNode.transform = CATransform3DMakeRotation(CGFloat.pi / 2.0, 0.0, 0.0, 1.0)
        self.imageNode.alphaTransitionOnFirstUpdate = true
        
        super.init(layerBacked: false, dynamicBounce: false)
        
        self.addSubnode(self.highlightNode)
        self.addSubnode(self.imageNode)
    }
    
    deinit {
        self.stickerFetchedDisposable.dispose()
    }
    
    func updateStickerPackItem(account: Account, item: StickerPackItem?, collectionId: ItemCollectionId, theme: PresentationTheme) {
        self.currentCollectionId = collectionId
        
        if self.theme !== theme {
            self.theme = theme
            
            self.highlightNode.image = PresentationResourcesChat.chatMediaInputPanelHighlightedIconImage(theme)
        }
        
        if self.currentItem != item {
            self.currentItem = item
            
            if let item = item, let dimensions = item.file.dimensions {
                let imageSize = dimensions.aspectFitted(boundingImageSize)
                let imageApply = self.imageNode.asyncLayout()(TransformImageArguments(corners: ImageCorners(), imageSize: imageSize, boundingSize: boundingImageSize, intrinsicInsets: UIEdgeInsets()))
                imageApply()
                self.imageNode.setSignal(account: account, signal: chatMessageSticker(account: account, file: item.file, small: true))
                self.stickerFetchedDisposable.set(fileInteractiveFetched(account: account, file: item.file).start())
                self.imageNode.frame = CGRect(origin: CGPoint(x: floor((boundingSize.width - imageSize.width) / 2.0) + verticalOffset, y: floor((boundingSize.height - imageSize.height) / 2.0)), size: imageSize)
            }
            
            self.updateIsHighlighted()
        }
    }
    
    func updateIsHighlighted() {
        if let currentCollectionId = self.currentCollectionId, let inputNodeInteraction = self.inputNodeInteraction {
            self.highlightNode.isHidden = inputNodeInteraction.highlightedItemCollectionId != currentCollectionId
        }
    }
}
