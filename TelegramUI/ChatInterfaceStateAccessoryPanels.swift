import Foundation
import AsyncDisplayKit
import TelegramCore

func accessoryPanelForChatPresentationIntefaceState(_ chatPresentationInterfaceState: ChatPresentationInterfaceState, account: Account, currentPanel: AccessoryPanelNode?, interfaceInteraction: ChatPanelInterfaceInteraction?) -> AccessoryPanelNode? {
    if let _ = chatPresentationInterfaceState.interfaceState.selectionState {
        return nil
    }
    
    if let editMessage = chatPresentationInterfaceState.interfaceState.editMessage {
        if let editPanelNode = currentPanel as? EditAccessoryPanelNode, editPanelNode.messageId == editMessage.messageId {
            editPanelNode.interfaceInteraction = interfaceInteraction
            editPanelNode.updateThemeAndStrings(theme: chatPresentationInterfaceState.theme, strings: chatPresentationInterfaceState.strings)
            return editPanelNode
        } else {
            let panelNode = EditAccessoryPanelNode(account: account, messageId: editMessage.messageId, theme: chatPresentationInterfaceState.theme, strings: chatPresentationInterfaceState.strings)
            panelNode.interfaceInteraction = interfaceInteraction
            return panelNode
        }
    } else if let forwardMessageIds = chatPresentationInterfaceState.interfaceState.forwardMessageIds {
        if let forwardPanelNode = currentPanel as? ForwardAccessoryPanelNode, forwardPanelNode.messageIds == forwardMessageIds {
            forwardPanelNode.interfaceInteraction = interfaceInteraction
            forwardPanelNode.updateThemeAndStrings(theme: chatPresentationInterfaceState.theme, strings: chatPresentationInterfaceState.strings)
            return forwardPanelNode
        } else {
            let panelNode = ForwardAccessoryPanelNode(account: account, messageIds: forwardMessageIds, theme: chatPresentationInterfaceState.theme, strings: chatPresentationInterfaceState.strings)
            panelNode.interfaceInteraction = interfaceInteraction
            return panelNode
        }
    } else if let replyMessageId = chatPresentationInterfaceState.interfaceState.replyMessageId {
        if let replyPanelNode = currentPanel as? ReplyAccessoryPanelNode, replyPanelNode.messageId == replyMessageId {
            replyPanelNode.interfaceInteraction = interfaceInteraction
            replyPanelNode.updateThemeAndStrings(theme: chatPresentationInterfaceState.theme, strings: chatPresentationInterfaceState.strings)
            return replyPanelNode
        } else {
            let panelNode = ReplyAccessoryPanelNode(account: account, messageId: replyMessageId, theme: chatPresentationInterfaceState.theme, strings: chatPresentationInterfaceState.strings)
            panelNode.interfaceInteraction = interfaceInteraction
            return panelNode
        }
    } else if let urlPreview = chatPresentationInterfaceState.urlPreview, chatPresentationInterfaceState.interfaceState.composeDisableUrlPreview != urlPreview.0 {
        if let previewPanelNode = currentPanel as? WebpagePreviewAccessoryPanelNode, previewPanelNode.webpage.id == urlPreview.1.id {
            previewPanelNode.interfaceInteraction = interfaceInteraction
            previewPanelNode.replaceWebpage(urlPreview.1)
            previewPanelNode.updateThemeAndStrings(theme: chatPresentationInterfaceState.theme, strings: chatPresentationInterfaceState.strings)
            return previewPanelNode
        } else {
            let panelNode = WebpagePreviewAccessoryPanelNode(account: account, webpage: urlPreview.1, theme: chatPresentationInterfaceState.theme, strings: chatPresentationInterfaceState.strings)
            panelNode.interfaceInteraction = interfaceInteraction
            return panelNode
        }
    } else {
        return nil
    }
}
