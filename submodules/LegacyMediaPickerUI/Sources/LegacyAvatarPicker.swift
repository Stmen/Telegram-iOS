import Foundation
import UIKit
import Display
import SwiftSignalKit
import LegacyComponents
import TelegramPresentationData
import LegacyUI

public func presentLegacyAvatarEditor(theme: PresentationTheme, image: UIImage?, video: URL?, present: (ViewController, Any?) -> Void, imageCompletion: @escaping (UIImage) -> Void, videoCompletion: @escaping (UIImage, URL, TGVideoEditAdjustments?) -> Void) {
    let legacyController = LegacyController(presentation: .custom, theme: theme)
    legacyController.statusBar.statusBarStyle = .Ignore
    
    let emptyController = LegacyEmptyController(context: legacyController.context)!
    let navigationController = makeLegacyNavigationController(rootController: emptyController)
    navigationController.setNavigationBarHidden(true, animated: false)
    navigationController.navigationBar.transform = CGAffineTransform(translationX: -1000.0, y: 0.0)
    
    legacyController.bind(controller: navigationController)
    
    present(legacyController, nil)
    
    TGPhotoVideoEditor.present(with: legacyController.context, parentController: emptyController, image: image, video: video, didFinishWithImage: { image in
        if let image = image {
            imageCompletion(image)
        }
    }, didFinishWithVideo: { image, url, adjustments in
        if let image = image, let url = url {
            videoCompletion(image, url, adjustments)
        }
    })
}

public func presentLegacyAvatarPicker(holder: Atomic<NSObject?>, signup: Bool, theme: PresentationTheme, present: (ViewController, Any?) -> Void, openCurrent: (() -> Void)?, completion: @escaping (UIImage) -> Void) {
    let legacyController = LegacyController(presentation: .custom, theme: theme)
    legacyController.statusBar.statusBarStyle = .Ignore
    
    let emptyController = LegacyEmptyController(context: legacyController.context)!
    let navigationController = makeLegacyNavigationController(rootController: emptyController)
    navigationController.setNavigationBarHidden(true, animated: false)
    navigationController.navigationBar.transform = CGAffineTransform(translationX: -1000.0, y: 0.0)

    legacyController.bind(controller: navigationController)
    
    present(legacyController, nil)
        
    let mixin = TGMediaAvatarMenuMixin(context: legacyController.context, parentController: emptyController, hasSearchButton: false, hasDeleteButton: false, hasViewButton: openCurrent != nil, personalPhoto: true, isVideo: false, saveEditedPhotos: false, saveCapturedMedia: false, signup: signup)!
    let _ = holder.swap(mixin)
    mixin.didFinishWithImage = { image in
        guard let image = image else {
            return
        }
        completion(image)
    }
    mixin.didFinishWithView = {
        openCurrent?()
    }
    mixin.didDismiss = { [weak legacyController] in
        let _ = holder.swap(nil)
        legacyController?.dismiss()
    }
    let menuController = mixin.present()
    if let menuController = menuController {
        menuController.customRemoveFromParentViewController = { [weak legacyController] in
            legacyController?.dismiss()
        }
    }
}
