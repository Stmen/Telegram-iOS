import Foundation

private func getValue(_ dict: [String: String], _ key: String) -> String {
    if let value = dict[key] {
        return value
    } else {
        return key
    }
}

private extension PluralizationForm {
    var canonicalSuffix: String {
        switch self {
            case .zero:
                return "_many"
            case .one:
                return "_one"
            case .two:
                return "_two"
            case .few:
                return "_1_3"
            case .many:
                return "_any"
            case .other:
                return "_any"
        }
    }
}
private func getValueWithForm(_ dict: [String: String], _ key: String, _ form: PluralizationForm) -> String {
    if let value = dict[key + form.canonicalSuffix] {
        return value
    }
    return key
}

private let argumentRegex = try! NSRegularExpression(pattern: "%(((\\d+)\\$)?)([@df])", options: [])
private func extractArgumentRanges(_ value: String) -> [(Int, NSRange)] {
    var result: [(Int, NSRange)] = []
    let string = value as NSString
    let matches = argumentRegex.matches(in: string as String, options: [], range: NSRange(location: 0, length: string.length))
    var index = 0
    for match in matches {
        var currentIndex = index
        if match.rangeAt(3).location != NSNotFound {
            currentIndex = Int(string.substring(with: match.rangeAt(3)))! - 1
        }
        result.append((currentIndex, match.rangeAt(0)))
        index += 1
    }
    result.sort(by: { $0.1.location < $1.1.location })
    return result
}

func formatWithArgumentRanges(_ value: String, _ ranges: [(Int, NSRange)], _ arguments: [String]) -> (String, [(Int, NSRange)]) {
    let string = value as NSString

    var resultingRanges: [(Int, NSRange)] = []

    var currentLocation = 0

    let result = NSMutableString()
    for (index, range) in ranges {
        if currentLocation < range.location {
            result.append(string.substring(with: NSRange(location: currentLocation, length: range.location - currentLocation)))
        }
        resultingRanges.append((index, NSRange(location: result.length, length: (arguments[index] as NSString).length)))
        result.append(arguments[index])
        currentLocation = range.location + range.length
    }
    if currentLocation != string.length {
        result.append(string.substring(with: NSRange(location: currentLocation, length: string.length - currentLocation)))
    }
    return (result as String, resultingRanges)
}
public final class PresentationStrings {
    private let lc: UInt32

    public let languageCode: String

    public let Channel_BanUser_Title: String
    public let Preview_SaveGif: String
    public let EnterPasscode_EnterNewPasscodeNew: String
    public let Privacy_Calls_WhoCanCallMe: String
    public let Watch_NoConnection: String
    private let _Group_Username_LinkHint: String
    private let _Group_Username_LinkHint_r: [(Int, NSRange)]
    public func Group_Username_LinkHint(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Group_Username_LinkHint, self._Group_Username_LinkHint_r, [_0])
    }
    public let Activity_UploadingPhoto: String
    public let PrivacySettings_PrivacyTitle: String
    private let _DialogList_PinLimitError: String
    private let _DialogList_PinLimitError_r: [(Int, NSRange)]
    public func DialogList_PinLimitError(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_DialogList_PinLimitError, self._DialogList_PinLimitError_r, [_0])
    }
    public let Settings_LogoutError: String
    public let Cache_ClearCache: String
    public let Common_Close: String
    public let ChangePhoneNumberCode_Called: String
    public let Login_PhoneTitle: String
    private let _Cache_Clear: String
    private let _Cache_Clear_r: [(Int, NSRange)]
    public func Cache_Clear(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Cache_Clear, self._Cache_Clear_r, [_0])
    }
    public let EnterPasscode_EnterNewPasscodeChange: String
    public let Watch_ChatList_Compose: String
    public let DialogList_SearchSectionDialogs: String
    public let Contacts_TabTitle: String
    public let TwoStepAuth_SetupPasswordConfirmPassword: String
    public let ChannelIntro_Text: String
    public let PrivacySettings_SecurityTitle: String
    private let _Login_SmsRequestState1: String
    private let _Login_SmsRequestState1_r: [(Int, NSRange)]
    public func Login_SmsRequestState1(_ _0: Int) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Login_SmsRequestState1, self._Login_SmsRequestState1_r, ["\(_0)"])
    }
    public let Conversation_Download: String
    private let _Call_StatusOngoing: String
    private let _Call_StatusOngoing_r: [(Int, NSRange)]
    public func Call_StatusOngoing(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Call_StatusOngoing, self._Call_StatusOngoing_r, [_0])
    }
    public let Settings_LogoutConfirmationText: String
    public let BlockedUsers_Info: String
    public let ChatSettings_AutomaticAudioDownload: String
    public let Map_OpenInFoursquare: String
    public let Privacy_Calls_CustomShareHelp: String
    public let Group_MessagePhotoUpdated: String
    public let Message_PinnedInvoice: String
    public let Login_InfoAvatarAdd: String
    public let WebSearch_RecentSectionTitle: String
    private let _CHAT_MESSAGE_TEXT: String
    private let _CHAT_MESSAGE_TEXT_r: [(Int, NSRange)]
    public func CHAT_MESSAGE_TEXT(_ _1: String, _ _2: String, _ _3: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHAT_MESSAGE_TEXT, self._CHAT_MESSAGE_TEXT_r, [_1, _2, _3])
    }
    public let Message_Sticker: String
    public let Channel_Management_Remove: String
    public let Paint_Regular: String
    public let Channel_Username_Help: String
    private let _Profile_CreateEncryptedChatOutdatedError: String
    private let _Profile_CreateEncryptedChatOutdatedError_r: [(Int, NSRange)]
    public func Profile_CreateEncryptedChatOutdatedError(_ _0: String, _ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Profile_CreateEncryptedChatOutdatedError, self._Profile_CreateEncryptedChatOutdatedError_r, [_0, _1])
    }
    public let Login_InactiveHelp: String
    public let ChatSettings_Security: String
    private let _Time_PreciseDate_9: String
    private let _Time_PreciseDate_9_r: [(Int, NSRange)]
    public func Time_PreciseDate_9(_ _1: String, _ _2: String, _ _3: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Time_PreciseDate_9, self._Time_PreciseDate_9_r, [_1, _2, _3])
    }
    private let _PINNED_STICKER: String
    private let _PINNED_STICKER_r: [(Int, NSRange)]
    public func PINNED_STICKER(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_PINNED_STICKER, self._PINNED_STICKER_r, [_1, _2])
    }
    public let Conversation_ShareInlineBotLocationConfirmation: String
    private let _Channel_AdminLog_MessageEdited: String
    private let _Channel_AdminLog_MessageEdited_r: [(Int, NSRange)]
    public func Channel_AdminLog_MessageEdited(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Channel_AdminLog_MessageEdited, self._Channel_AdminLog_MessageEdited_r, [_0])
    }
    private let _PHONE_CALL_REQUEST: String
    private let _PHONE_CALL_REQUEST_r: [(Int, NSRange)]
    public func PHONE_CALL_REQUEST(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_PHONE_CALL_REQUEST, self._PHONE_CALL_REQUEST_r, [_1])
    }
    public let AccessDenied_MicrophoneRestricted: String
    public let Your_cards_expiration_year_is_invalid: String
    public let GroupInfo_InviteByLink: String
    private let _Notification_LeftChat: String
    private let _Notification_LeftChat_r: [(Int, NSRange)]
    public func Notification_LeftChat(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_LeftChat, self._Notification_LeftChat_r, [_0])
    }
    private let _Channel_AdminLog_MessageAdmin: String
    private let _Channel_AdminLog_MessageAdmin_r: [(Int, NSRange)]
    public func Channel_AdminLog_MessageAdmin(_ _0: String, _ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Channel_AdminLog_MessageAdmin, self._Channel_AdminLog_MessageAdmin_r, [_0, _1, _2])
    }
    public let PrivacyLastSeenSettings_NeverShareWith_Placeholder: String
    public let TwoStepAuth_SetupEmail: String
    public let Login_ResetAccountProtected_Reset: String
    private let _MESSAGE_CONTACT: String
    private let _MESSAGE_CONTACT_r: [(Int, NSRange)]
    public func MESSAGE_CONTACT(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_MESSAGE_CONTACT, self._MESSAGE_CONTACT_r, [_1])
    }
    private let _Group_Management_ErrorNotMember: String
    private let _Group_Management_ErrorNotMember_r: [(Int, NSRange)]
    public func Group_Management_ErrorNotMember(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Group_Management_ErrorNotMember, self._Group_Management_ErrorNotMember_r, [_0])
    }
    public let MediaPicker_MomentsDateRangeSameMonthYearFormat: String
    public let Notification_MessageLifetime1w: String
    public let PasscodeSettings_AutoLock_IfAwayFor_5minutes: String
    public let ChatSettings_Groups: String
    public let State_Connecting: String
    private let _Message_ForwardedMessageShort: String
    private let _Message_ForwardedMessageShort_r: [(Int, NSRange)]
    public func Message_ForwardedMessageShort(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Message_ForwardedMessageShort, self._Message_ForwardedMessageShort_r, [_0])
    }
    public let Watch_ConnectionDescription: String
    private let _Notification_CallTimeFormat: String
    private let _Notification_CallTimeFormat_r: [(Int, NSRange)]
    public func Notification_CallTimeFormat(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_CallTimeFormat, self._Notification_CallTimeFormat_r, [_1, _2])
    }
    public let Paint_Delete: String
    public let Channel_MessagePhotoUpdated: String
    public let SharedMedia_All: String
    public let Cache_Help: String
    private let _Login_EmailPhoneBody: String
    private let _Login_EmailPhoneBody_r: [(Int, NSRange)]
    public func Login_EmailPhoneBody(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Login_EmailPhoneBody, self._Login_EmailPhoneBody_r, [_0])
    }
    public let Checkout_ShippingAddress: String
    public let Channel_BanList_RestrictedTitle: String
    public let Checkout_TotalAmount: String
    public let Conversation_MessageEditedLabel: String
    public let SharedMedia_EmptyLinksText: String
    public let Channel_Members_Kick: String
    public let GoogleDrive_FolderIsEmpty: String
    public let Calls_NoCallsPlaceholder: String
    public let Message_PinnedDeletedMessage: String
    public let Conversation_PinMessageAlert_OnlyPin: String
    public let ReportPeer_ReasonOther_Send: String
    public let Conversation_InstantPagePreview: String
    public let PasscodeSettings_SimplePasscodeHelp: String
    public let Group_ErrorAddTooMuch: String
    public let GroupInfo_Title: String
    public let State_Updating: String
    public let StickerSettings_ContextShow: String
    public let Map_GetDirections: String
    private let _TwoStepAuth_PendingEmailHelp: String
    private let _TwoStepAuth_PendingEmailHelp_r: [(Int, NSRange)]
    public func TwoStepAuth_PendingEmailHelp(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_TwoStepAuth_PendingEmailHelp, self._TwoStepAuth_PendingEmailHelp_r, [_0])
    }
    public let UserInfo_PhoneCall: String
    public let MusicPlayer_VoiceNote: String
    public let Paint_Duplicate: String
    public let Channel_Username_InvalidTaken: String
    private let _Profile_ShareContactGroupFormat: String
    private let _Profile_ShareContactGroupFormat_r: [(Int, NSRange)]
    public func Profile_ShareContactGroupFormat(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Profile_ShareContactGroupFormat, self._Profile_ShareContactGroupFormat_r, [_0])
    }
    public let SecretChat_Title: String
    public let Group_UpgradeConfirmation: String
    public let Checkout_LiabilityAlertTitle: String
    public let GroupInfo_GroupNamePlaceholder: String
    public let Conversation_InfoBroadcastList: String
    private let _Notification_JoinedGroupByLink: String
    private let _Notification_JoinedGroupByLink_r: [(Int, NSRange)]
    public func Notification_JoinedGroupByLink(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_JoinedGroupByLink, self._Notification_JoinedGroupByLink_r, [_0])
    }
    private let _Time_PreciseDate_8: String
    private let _Time_PreciseDate_8_r: [(Int, NSRange)]
    public func Time_PreciseDate_8(_ _1: String, _ _2: String, _ _3: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Time_PreciseDate_8, self._Time_PreciseDate_8_r, [_1, _2, _3])
    }
    public let Login_HaveNotReceivedCodeInternal: String
    public let LoginPassword_Title: String
    public let Conversation_PlayVideo: String
    public let PasscodeSettings_SimplePasscode: String
    public let Conversation_MicrophoneAccessDisabled: String
    public let NewContact_Title: String
    public let Username_CheckingUsername: String
    public let Login_ResetAccountProtected_TimerTitle: String
    public let UserInfo_InviteBotToGroup: String
    public let Checkout_Email: String
    public let CheckoutInfo_SaveInfo: String
    private let _ChangePhoneNumberCode_CallTimer: String
    private let _ChangePhoneNumberCode_CallTimer_r: [(Int, NSRange)]
    public func ChangePhoneNumberCode_CallTimer(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_ChangePhoneNumberCode_CallTimer, self._ChangePhoneNumberCode_CallTimer_r, [_0])
    }
    public let TwoStepAuth_SetupPasswordEnterPasswordNew: String
    public let Weekday_Wednesday: String
    private let _Channel_AdminLog_MessageToggleSignaturesOff: String
    private let _Channel_AdminLog_MessageToggleSignaturesOff_r: [(Int, NSRange)]
    public func Channel_AdminLog_MessageToggleSignaturesOff(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Channel_AdminLog_MessageToggleSignaturesOff, self._Channel_AdminLog_MessageToggleSignaturesOff_r, [_0])
    }
    public let Month_ShortDecember: String
    public let Channel_SignMessages: String
    public let Conversation_Moderate_Delete: String
    public let Conversation_CloudStorage_ChatStatus: String
    public let Login_InfoTitle: String
    public let Privacy_GroupsAndChannels_NeverAllow_Placeholder: String
    public let Message_Video: String
    public let Notification_ChannelInviterSelf: String
    private let _VideoPreview_OptionSD: String
    private let _VideoPreview_OptionSD_r: [(Int, NSRange)]
    public func VideoPreview_OptionSD(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_VideoPreview_OptionSD, self._VideoPreview_OptionSD_r, [_0])
    }
    public let Conversation_SecretLinkPreviewAlert: String
    public let Channel_AdminLog_BanEmbedLinks: String
    public let Cache_Videos: String
    public let NetworkUsageSettings_MediaImageDataSection: String
    public let TwoStepAuth_GenericHelp: String
    private let _DialogList_SingleRecordingAudioSuffix: String
    private let _DialogList_SingleRecordingAudioSuffix_r: [(Int, NSRange)]
    public func DialogList_SingleRecordingAudioSuffix(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_DialogList_SingleRecordingAudioSuffix, self._DialogList_SingleRecordingAudioSuffix_r, [_0])
    }
    public let Checkout_NewCard_CardholderNameTitle: String
    public let Settings_FAQ_Button: String
    private let _GroupInfo_AddParticipantConfirmation: String
    private let _GroupInfo_AddParticipantConfirmation_r: [(Int, NSRange)]
    public func GroupInfo_AddParticipantConfirmation(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_GroupInfo_AddParticipantConfirmation, self._GroupInfo_AddParticipantConfirmation_r, [_0])
    }
    public let AccessDenied_PhotosRestricted: String
    public let Map_Locating: String
    private let _SearchImages_Downloading_Kb: String
    private let _SearchImages_Downloading_Kb_r: [(Int, NSRange)]
    public func SearchImages_Downloading_Kb(_ _0: Int) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_SearchImages_Downloading_Kb, self._SearchImages_Downloading_Kb_r, ["\(_0)"])
    }
    private let _Profile_ShareBotPersonFormat: String
    private let _Profile_ShareBotPersonFormat_r: [(Int, NSRange)]
    public func Profile_ShareBotPersonFormat(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Profile_ShareBotPersonFormat, self._Profile_ShareBotPersonFormat_r, [_0])
    }
    public let SearchImages_SearchImages: String
    public let SharedMedia_EmptyMusicText: String
    public let Cache_ByPeerHeader: String
    public let Bot_GroupStatusReadsHistory: String
    public let TwoStepAuth_ResetAccountConfirmation: String
    public let CallSettings_Always: String
    public let SearchImages_DownloadCancelled: String
    public let Settings_LogoutConfirmationTitle: String
    public let UserInfo_FirstNamePlaceholder: String
    public let ChatSettings_AutoPlayAudio: String
    public let LoginPassword_ResetAccount: String
    public let Privacy_GroupsAndChannels_AlwaysAllow: String
    private let _Notification_JoinedChat: String
    private let _Notification_JoinedChat_r: [(Int, NSRange)]
    public func Notification_JoinedChat(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_JoinedChat, self._Notification_JoinedChat_r, [_0])
    }
    public let ChannelInfo_DeleteChannel: String
    public let NetworkUsageSettings_BytesReceived: String
    public let BlockedUsers_BlockTitle: String
    public let AccessDenied_PhotosAndVideos: String
    public let Channel_Username_Title: String
    private let _Channel_AdminLog_MessageToggleSignaturesOn: String
    private let _Channel_AdminLog_MessageToggleSignaturesOn_r: [(Int, NSRange)]
    public func Channel_AdminLog_MessageToggleSignaturesOn(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Channel_AdminLog_MessageToggleSignaturesOn, self._Channel_AdminLog_MessageToggleSignaturesOn_r, [_0])
    }
    private let _Conversation_EncryptionWaiting: String
    private let _Conversation_EncryptionWaiting_r: [(Int, NSRange)]
    public func Conversation_EncryptionWaiting(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Conversation_EncryptionWaiting, self._Conversation_EncryptionWaiting_r, [_0])
    }
    public let Calls_NotNow: String
    public let Conversation_Report: String
    private let _CHANNEL_MESSAGE_DOC: String
    private let _CHANNEL_MESSAGE_DOC_r: [(Int, NSRange)]
    public func CHANNEL_MESSAGE_DOC(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHANNEL_MESSAGE_DOC, self._CHANNEL_MESSAGE_DOC_r, [_1])
    }
    public let Channel_AdminLogFilter_EventsAll: String
    public let Call_ConnectionErrorTitle: String
    public let Settings_ChatSettings: String
    public let Group_About_Help: String
    private let _CHANNEL_MESSAGE_NOTEXT: String
    private let _CHANNEL_MESSAGE_NOTEXT_r: [(Int, NSRange)]
    public func CHANNEL_MESSAGE_NOTEXT(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHANNEL_MESSAGE_NOTEXT, self._CHANNEL_MESSAGE_NOTEXT_r, [_1])
    }
    public let Month_GenSeptember: String
    public let PrivacySettings_LastSeenEverybody: String
    public let PhotoEditor_BlurToolRadial: String
    public let TwoStepAuth_PasswordRemoveConfirmation: String
    public let Channel_EditAdmin_PermissionEditMessages: String
    public let TwoStepAuth_ChangePassword: String
    public let Watch_MessageView_Title: String
    private let _Notification_PinnedRoundMessage: String
    private let _Notification_PinnedRoundMessage_r: [(Int, NSRange)]
    public func Notification_PinnedRoundMessage(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_PinnedRoundMessage, self._Notification_PinnedRoundMessage_r, [_0])
    }
    public let Conversation_DeleteGroup: String
    private let _Time_PreciseDate_7: String
    private let _Time_PreciseDate_7_r: [(Int, NSRange)]
    public func Time_PreciseDate_7(_ _1: String, _ _2: String, _ _3: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Time_PreciseDate_7, self._Time_PreciseDate_7_r, [_1, _2, _3])
    }
    public let Channel_Management_LabelCreator: String
    private let _Notification_PinnedStickerMessage: String
    private let _Notification_PinnedStickerMessage_r: [(Int, NSRange)]
    public func Notification_PinnedStickerMessage(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_PinnedStickerMessage, self._Notification_PinnedStickerMessage_r, [_0])
    }
    public let Settings_SaveEditedPhotos: String
    public let PhotoEditor_QualityTool: String
    public let Login_NetworkError: String
    public let TwoStepAuth_EnterPasswordForgot: String
    public let Compose_ChannelMembers: String
    public let Common_Yes: String
    public let KeyCommand_JumpToPreviousUnreadChat: String
    public let CheckoutInfo_ReceiverInfoPhone: String
    public let GroupInfo_AddParticipantTitle: String
    private let _CHANNEL_MESSAGE_TEXT: String
    private let _CHANNEL_MESSAGE_TEXT_r: [(Int, NSRange)]
    public func CHANNEL_MESSAGE_TEXT(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHANNEL_MESSAGE_TEXT, self._CHANNEL_MESSAGE_TEXT_r, [_1, _2])
    }
    public let Checkout_PayNone: String
    public let CheckoutInfo_ErrorNameInvalid: String
    public let Channel_Share: String
    public let Notification_PaymentSent: String
    public let Settings_Username: String
    public let Notification_CallMissedShort: String
    public let Call_CallInProgressTitle: String
    public let PhotoEditor_Skip: String
    public let AuthSessions_TerminateOtherSessionsHelp: String
    public let Call_AudioRouteHeadphones: String
    public let Contacts_InviteFriends: String
    public let Channel_BanUser_PermissionSendMessages: String
    public let Notifications_InAppNotificationsVibrate: String
    public let StickerPack_Share: String
    public let Watch_MessageView_Reply: String
    public let Call_AudioRouteSpeaker: String
    public let PrivacySettings_DeleteAccountNever: String
    private let _WelcomeScreen_ContactsAccessHelp: String
    private let _WelcomeScreen_ContactsAccessHelp_r: [(Int, NSRange)]
    public func WelcomeScreen_ContactsAccessHelp(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_WelcomeScreen_ContactsAccessHelp, self._WelcomeScreen_ContactsAccessHelp_r, [_0])
    }
    private let _MESSAGE_GEO: String
    private let _MESSAGE_GEO_r: [(Int, NSRange)]
    public func MESSAGE_GEO(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_MESSAGE_GEO, self._MESSAGE_GEO_r, [_1])
    }
    public let Checkout_Title: String
    public let Privacy_Calls: String
    public let Channel_AdminLogFilter_EventsInfo: String
    private let _Channel_AdminLog_MessagePinned: String
    private let _Channel_AdminLog_MessagePinned_r: [(Int, NSRange)]
    public func Channel_AdminLog_MessagePinned(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Channel_AdminLog_MessagePinned, self._Channel_AdminLog_MessagePinned_r, [_0])
    }
    private let _Channel_AdminLog_MessageToggleInvitesOn: String
    private let _Channel_AdminLog_MessageToggleInvitesOn_r: [(Int, NSRange)]
    public func Channel_AdminLog_MessageToggleInvitesOn(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Channel_AdminLog_MessageToggleInvitesOn, self._Channel_AdminLog_MessageToggleInvitesOn_r, [_0])
    }
    public let Conversation_SearchWebImages: String
    public let KeyCommand_ScrollDown: String
    public let Conversation_LinkDialogSave: String
    public let Presence_offline: String
    public let Conversation_SendMessageErrorFlood: String
    private let _Conversation_ForwardToPersonFormat: String
    private let _Conversation_ForwardToPersonFormat_r: [(Int, NSRange)]
    public func Conversation_ForwardToPersonFormat(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Conversation_ForwardToPersonFormat, self._Conversation_ForwardToPersonFormat_r, [_0])
    }
    public let CheckoutInfo_ErrorShippingNotAvailable: String
    public let SharedMedia_Incoming: String
    private let _Checkout_SavePasswordTimeoutAndTouchId: String
    private let _Checkout_SavePasswordTimeoutAndTouchId_r: [(Int, NSRange)]
    public func Checkout_SavePasswordTimeoutAndTouchId(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Checkout_SavePasswordTimeoutAndTouchId, self._Checkout_SavePasswordTimeoutAndTouchId_r, [_0])
    }
    public let CheckoutInfo_ShippingInfoCountry: String
    public let Map_ShowPlaces: String
    public let Camera_VideoMode: String
    private let _Watch_Time_ShortFullAt: String
    private let _Watch_Time_ShortFullAt_r: [(Int, NSRange)]
    public func Watch_Time_ShortFullAt(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Watch_Time_ShortFullAt, self._Watch_Time_ShortFullAt_r, [_1, _2])
    }
    public let UserInfo_TelegramCall: String
    public let PrivacyLastSeenSettings_CustomShareSettingsHelp: String
    public let Channel_AdminLog_InfoPanelAlertText: String
    public let Watch_State_WaitingForNetwork: String
    public let Cache_Photos: String
    public let Message_PinnedStickerMessage: String
    public let PhotoEditor_QualityMedium: String
    public let Privacy_PaymentsClearInfo: String
    public let PhotoEditor_CurvesRed: String
    public let Privacy_PaymentsTitle: String
    public let Login_PhoneNumberHelp: String
    public let User_DeletedAccount: String
    public let Call_StatusFailed: String
    private let _Notification_GroupInviter: String
    private let _Notification_GroupInviter_r: [(Int, NSRange)]
    public func Notification_GroupInviter(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_GroupInviter, self._Notification_GroupInviter_r, [_0])
    }
    public let Localization_ChooseLanguage: String
    public let CheckoutInfo_ShippingInfoAddress2Placeholder: String
    private let _Notification_SecretChatMessageScreenshot: String
    private let _Notification_SecretChatMessageScreenshot_r: [(Int, NSRange)]
    public func Notification_SecretChatMessageScreenshot(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_SecretChatMessageScreenshot, self._Notification_SecretChatMessageScreenshot_r, [_0])
    }
    private let _DialogList_SingleUploadingPhotoSuffix: String
    private let _DialogList_SingleUploadingPhotoSuffix_r: [(Int, NSRange)]
    public func DialogList_SingleUploadingPhotoSuffix(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_DialogList_SingleUploadingPhotoSuffix, self._DialogList_SingleUploadingPhotoSuffix_r, [_0])
    }
    public let Channel_LeaveChannel: String
    public let Compose_NewGroup: String
    public let TwoStepAuth_EmailPlaceholder: String
    public let PhotoEditor_ExposureTool: String
    public let ChatAdmins_AdminLabel: String
    public let Contacts_FailedToSendInvitesMessage: String
    public let Login_Code: String
    public let Channel_Username_InvalidCharacters: String
    public let Calls_CallTabTitle: String
    public let FeatureDisabled_Oops: String
    public let Login_InviteButton: String
    public let ShareMenu_Send: String
    public let Conversation_InfoGroup: String
    public let WatchRemote_AlertTitle: String
    public let Preview_ProfilePhotoTitle: String
    public let Checkout_Phone: String
    public let Channel_SignMessages_Help: String
    public let Calls_SubmitRating: String
    public let Camera_FlashOn: String
    public let Watch_MessageView_Forward: String
    private let _Time_PreciseDate_6: String
    private let _Time_PreciseDate_6_r: [(Int, NSRange)]
    public func Time_PreciseDate_6(_ _1: String, _ _2: String, _ _3: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Time_PreciseDate_6, self._Time_PreciseDate_6_r, [_1, _2, _3])
    }
    public let DialogList_You: String
    public let Weekday_Monday: String
    public let Watch_Suggestion_Yes: String
    public let AccessDenied_Camera: String
    public let WatchRemote_NotificationText: String
    public let Activity_Location: String
    public let SharedMedia_ViewInChat: String
    public let Activity_RecordingAudio: String
    public let Watch_Stickers_StickerPacks: String
    private let _Target_ShareGameConfirmationPrivate: String
    private let _Target_ShareGameConfirmationPrivate_r: [(Int, NSRange)]
    public func Target_ShareGameConfirmationPrivate(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Target_ShareGameConfirmationPrivate, self._Target_ShareGameConfirmationPrivate_r, [_0])
    }
    public let Checkout_NewCard_PostcodePlaceholder: String
    public let Conversation_SearchImages: String
    public let DialogList_DeleteConversationConfirmation: String
    public let AttachmentMenu_SendAsFile: String
    public let Message_GamePreviewLabel: String
    public let Checkout_ShippingOption_Header: String
    public let Watch_Conversation_Unblock: String
    public let Channel_AdminLog_MessagePreviousLink: String
    public let CallSettings_PrivacyDescription: String
    public let Conversation_ContextMenuCopy: String
    public let GroupInfo_UpgradeButton: String
    public let PrivacyLastSeenSettings_NeverShareWith: String
    public let ConvertToSupergroup_HelpText: String
    public let MediaPicker_VideoMuteDescription: String
    private let _SearchImages_Downloading_Mb: String
    private let _SearchImages_Downloading_Mb_r: [(Int, NSRange)]
    public func SearchImages_Downloading_Mb(_ _0: Int) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_SearchImages_Downloading_Mb, self._SearchImages_Downloading_Mb_r, ["\(_0)"])
    }
    public let UserInfo_ShareMyContactInfo: String
    private let _FileSize_GB: String
    private let _FileSize_GB_r: [(Int, NSRange)]
    public func FileSize_GB(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_FileSize_GB, self._FileSize_GB_r, [_0])
    }
    public let Month_ShortJanuary: String
    public let Channel_BanUser_PermissionsHeader: String
    public let PhotoEditor_QualityVeryHigh: String
    public let Login_TermsOfServiceLabel: String
    private let _MESSAGE_TEXT: String
    private let _MESSAGE_TEXT_r: [(Int, NSRange)]
    public func MESSAGE_TEXT(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_MESSAGE_TEXT, self._MESSAGE_TEXT_r, [_1, _2])
    }
    public let DialogList_NoMessagesTitle: String
    public let AccessDenied_Contacts: String
    public let Your_cards_security_code_is_invalid: String
    public let Tour_StartButton: String
    public let CheckoutInfo_Title: String
    public let ChangePhoneNumberCode_Help: String
    public let Web_Error: String
    public let ShareFileTip_Title: String
    public let Username_InvalidStartsWithNumber: String
    public let ChatSettings_RevertLanguage: String
    public let Conversation_ReportSpamAndLeave: String
    private let _DialogList_EncryptedChatStartedIncoming: String
    private let _DialogList_EncryptedChatStartedIncoming_r: [(Int, NSRange)]
    public func DialogList_EncryptedChatStartedIncoming(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_DialogList_EncryptedChatStartedIncoming, self._DialogList_EncryptedChatStartedIncoming_r, [_0])
    }
    public let Calls_AddTab: String
    public let ChannelMembers_WhoCanAddMembers_Admins: String
    public let Tour_Text5: String
    public let Watch_Stickers_RecentPlaceholder: String
    public let Common_Select: String
    private let _Notification_MessageLifetimeRemoved: String
    private let _Notification_MessageLifetimeRemoved_r: [(Int, NSRange)]
    public func Notification_MessageLifetimeRemoved(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_MessageLifetimeRemoved, self._Notification_MessageLifetimeRemoved_r, [_1])
    }
    private let _PINNED_INVOICE: String
    private let _PINNED_INVOICE_r: [(Int, NSRange)]
    public func PINNED_INVOICE(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_PINNED_INVOICE, self._PINNED_INVOICE_r, [_1])
    }
    public let Month_GenFebruary: String
    public let Contacts_SelectAll: String
    public let Month_GenOctober: String
    public let CheckoutInfo_ErrorPhoneInvalid: String
    public let SharedMedia_TitleVideo: String
    public let Checkout_PaymentMethod_New: String
    public let ShareMenu_Comment: String
    public let Channel_Management_LabelEditor: String
    public let TwoStepAuth_SetPasswordHelp: String
    public let Channel_AdminLogFilter_EventsTitle: String
    public let Username_LinkCopied: String
    public let DialogList_Conversations: String
    public let Channel_EditAdmin_PermissionAddAdmins: String
    public let Conversation_SendMessage: String
    public let Notification_CallIncoming: String
    private let _MESSAGE_FWDS: String
    private let _MESSAGE_FWDS_r: [(Int, NSRange)]
    public func MESSAGE_FWDS(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_MESSAGE_FWDS, self._MESSAGE_FWDS_r, [_1, _2])
    }
    private let _Time_PreciseDate_5: String
    private let _Time_PreciseDate_5_r: [(Int, NSRange)]
    public func Time_PreciseDate_5(_ _1: String, _ _2: String, _ _3: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Time_PreciseDate_5, self._Time_PreciseDate_5_r, [_1, _2, _3])
    }
    public let Conversation_InputTextCommentPlaceholder: String
    public let Map_OpenInYandexMaps: String
    public let Month_ShortNovember: String
    public let AccessDenied_Settings: String
    public let EncryptionKey_Title: String
    public let Profile_MessageLifetime1h: String
    private let _Map_DistanceAway: String
    private let _Map_DistanceAway_r: [(Int, NSRange)]
    public func Map_DistanceAway(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Map_DistanceAway, self._Map_DistanceAway_r, [_0])
    }
    public let Compose_NewMessage: String
    public let Checkout_ErrorPaymentFailed: String
    public let Map_OpenInWaze: String
    public let Common_ChooseVideo: String
    public let Checkout_ShippingMethod: String
    public let Login_InfoFirstNamePlaceholder: String
    public let DialogList_Broadcast: String
    public let Checkout_ErrorProviderAccountInvalid: String
    public let CallSettings_TabIconDescription: String
    public let Checkout_WebConfirmation_Title: String
    public let PasscodeSettings_AutoLock: String
    public let Notifications_MessageNotificationsPreview: String
    public let Conversation_BlockUser: String
    public let MessageTimer_Custom: String
    public let Conversation_SilentBroadcastTooltipOff: String
    public let Conversation_Mute: String
    public let Call_CallBack: String
    public let CreateGroup_SoftUserLimitAlert: String
    public let AccessDenied_LocationDenied: String
    public let Tour_Title6: String
    public let Settings_UsernameEmpty: String
    public let PrivacySettings_TwoStepAuth: String
    public let Conversation_FileICloudDrive: String
    public let KeyCommand_SendMessage: String
    private let _Channel_AdminLog_MessageDeleted: String
    private let _Channel_AdminLog_MessageDeleted_r: [(Int, NSRange)]
    public func Channel_AdminLog_MessageDeleted(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Channel_AdminLog_MessageDeleted, self._Channel_AdminLog_MessageDeleted_r, [_0])
    }
    public let DialogList_DeleteBotConfirmation: String
    public let Common_TakePhotoOrVideo: String
    public let Notification_MessageLifetime2s: String
    public let Checkout_ErrorGeneric: String
    public let Conversation_FileGoogleDrive: String
    private let _MediaPicker_Processing: String
    private let _MediaPicker_Processing_r: [(Int, NSRange)]
    public func MediaPicker_Processing(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_MediaPicker_Processing, self._MediaPicker_Processing_r, [_0])
    }
    public let Channel_AdminLog_CanBanUsers: String
    public let Cache_Indexing: String
    private let _ENCRYPTION_REQUEST: String
    private let _ENCRYPTION_REQUEST_r: [(Int, NSRange)]
    public func ENCRYPTION_REQUEST(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_ENCRYPTION_REQUEST, self._ENCRYPTION_REQUEST_r, [_1])
    }
    public let StickerSettings_ContextInfo: String
    public let Message_SharedContact: String
    public let Channel_BanUser_PermissionEmbedLinks: String
    public let Channel_Username_CreateCommentsEnabled: String
    public let GroupInfo_InviteLink_LinkSection: String
    public let Privacy_Calls_AlwaysAllow_Placeholder: String
    public let CheckoutInfo_ShippingInfoPostcode: String
    public let PasscodeSettings_EncryptDataHelp: String
    public let KeyCommand_FocusOnInputField: String
    public let Cache_KeepMedia: String
    public let WebPreview_GettingLinkInfo: String
    public let Group_Setup_TypePublicHelp: String
    public let Channel_Moderator_AccessLevelModeratorHelp: String
    public let Map_Satellite: String
    public let Username_InvalidTaken: String
    private let _Notification_PinnedAudioMessage: String
    private let _Notification_PinnedAudioMessage_r: [(Int, NSRange)]
    public func Notification_PinnedAudioMessage(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_PinnedAudioMessage, self._Notification_PinnedAudioMessage_r, [_0])
    }
    public let Notification_MessageLifetime1d: String
    public let Profile_MessageLifetime2s: String
    private let _TwoStepAuth_RecoveryEmailUnavailable: String
    private let _TwoStepAuth_RecoveryEmailUnavailable_r: [(Int, NSRange)]
    public func TwoStepAuth_RecoveryEmailUnavailable(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_TwoStepAuth_RecoveryEmailUnavailable, self._TwoStepAuth_RecoveryEmailUnavailable_r, [_0])
    }
    public let Calls_RatingFeedback: String
    public let Profile_EncryptionKey: String
    public let Watch_Suggestion_WhatsUp: String
    public let LoginPassword_PasswordPlaceholder: String
    public let TwoStepAuth_EnterPasswordPassword: String
    private let _CHANNEL_MESSAGE_CONTACT: String
    private let _CHANNEL_MESSAGE_CONTACT_r: [(Int, NSRange)]
    public func CHANNEL_MESSAGE_CONTACT(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHANNEL_MESSAGE_CONTACT, self._CHANNEL_MESSAGE_CONTACT_r, [_1])
    }
    public let PrivacySettings_DeleteAccountHelp: String
    private let _Time_PreciseDate_4: String
    private let _Time_PreciseDate_4_r: [(Int, NSRange)]
    public func Time_PreciseDate_4(_ _1: String, _ _2: String, _ _3: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Time_PreciseDate_4, self._Time_PreciseDate_4_r, [_1, _2, _3])
    }
    public let Channel_Info_Banned: String
    public let Conversation_ShareBotContactConfirmationTitle: String
    public let ConversationProfile_UsersTooMuchError: String
    public let ChatAdmins_AllMembersAreAdminsOffHelp: String
    public let Privacy_GroupsAndChannels_WhoCanAddMe: String
    public let Settings_PhoneNumber: String
    public let Login_CodeExpiredError: String
    private let _DialogList_MultipleTypingSuffix: String
    private let _DialogList_MultipleTypingSuffix_r: [(Int, NSRange)]
    public func DialogList_MultipleTypingSuffix(_ _0: Int) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_DialogList_MultipleTypingSuffix, self._DialogList_MultipleTypingSuffix_r, ["\(_0)"])
    }
    public let ChannelMembers_Blacklist_EmptyText: String
    public let Bot_GenericBotStatus: String
    public let Common_edit: String
    public let Settings_AppLanguage: String
    public let PrivacyLastSeenSettings_WhoCanSeeMyTimestamp: String
    private let _Notification_Kicked: String
    private let _Notification_Kicked_r: [(Int, NSRange)]
    public func Notification_Kicked(_ _0: String, _ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_Kicked, self._Notification_Kicked_r, [_0, _1])
    }
    public let Conversation_Send: String
    public let ChannelInfo_DeleteChannelConfirmation: String
    public let Weekday_ShortSaturday: String
    public let Map_SendThisLocation: String
    public let DialogList_RecentTitleBots: String
    private let _Notification_PinnedDocumentMessage: String
    private let _Notification_PinnedDocumentMessage_r: [(Int, NSRange)]
    public func Notification_PinnedDocumentMessage(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_PinnedDocumentMessage, self._Notification_PinnedDocumentMessage_r, [_0])
    }
    public let Conversation_ContextMenuReply: String
    public let Channel_BanUser_PermissionSendMedia: String
    public let NetworkUsageSettings_Wifi: String
    public let Call_Accept: String
    public let GroupInfo_SetGroupPhotoDelete: String
    public let PhotoEditor_CropAuto: String
    public let PhotoEditor_ContrastTool: String
    public let MediaPicker_MomentsDateYearFormat: String
    public let CheckoutInfo_ReceiverInfoNamePlaceholder: String
    public let Privacy_PaymentsClear_ShippingInfo: String
    public let TwoStepAuth_GenericError: String
    public let Channel_Moderator_AccessLevelEditorHelp: String
    public let Compose_NewChannelButton: String
    public let ConversationMedia_EmptyTitle: String
    public let Date_DialogDateFormat: String
    public let ReportPeer_ReasonSpam: String
    public let Compose_TokenListPlaceholder: String
    private let _PINNED_VIDEO: String
    private let _PINNED_VIDEO_r: [(Int, NSRange)]
    public func PINNED_VIDEO(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_PINNED_VIDEO, self._PINNED_VIDEO_r, [_1])
    }
    public let StickerPacksSettings_Title: String
    public let Privacy_Calls_NeverAllow_Placeholder: String
    public let Settings_Support: String
    public let Notification_GroupInviterSelf: String
    public let MaskStickerSettings_Title: String
    public let Watch_Suggestion_ThankYou: String
    public let TwoStepAuth_SetPassword: String
    public let GoogleDrive_LoadErrorMessage: String
    public let GroupInfo_InviteLink_ShareLink: String
    public let ChannelMembers_AllMembersMayInviteOnHelp: String
    public let Common_Cancel: String
    public let Preview_LoadingImages: String
    public let ChangePhoneNumberCode_RequestingACall: String
    public let PrivacyLastSeenSettings_NeverShareWith_Title: String
    public let KeyCommand_JumpToNextChat: String
    public let Tour_Text1: String
    public let StickerPack_Remove: String
    public let Conversation_HoldForVideo: String
    public let Checkout_NewCard_Title: String
    public let Channel_TitleInfo: String
    public let Settings_About_Help: String
    private let _Time_PreciseDate_3: String
    private let _Time_PreciseDate_3_r: [(Int, NSRange)]
    public func Time_PreciseDate_3(_ _1: String, _ _2: String, _ _3: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Time_PreciseDate_3, self._Time_PreciseDate_3_r, [_1, _2, _3])
    }
    public let Watch_Conversation_Reply: String
    public let ShareMenu_CopyShareLink: String
    public let Channel_Setup_TypePrivateHelp: String
    public let PhotoEditor_GrainTool: String
    public let Watch_Suggestion_TalkLater: String
    public let TwoStepAuth_ChangeEmail: String
    private let _ENCRYPTION_ACCEPT: String
    private let _ENCRYPTION_ACCEPT_r: [(Int, NSRange)]
    public func ENCRYPTION_ACCEPT(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_ENCRYPTION_ACCEPT, self._ENCRYPTION_ACCEPT_r, [_1])
    }
    public let Conversation_ShareBotLocationConfirmationTitle: String
    public let NetworkUsageSettings_BytesSent: String
    public let Conversation_ForwardContacts: String
    private let _Notification_ChangedGroupName: String
    private let _Notification_ChangedGroupName_r: [(Int, NSRange)]
    public func Notification_ChangedGroupName(_ _0: String, _ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_ChangedGroupName, self._Notification_ChangedGroupName_r, [_0, _1])
    }
    private let _MESSAGE_VIDEO: String
    private let _MESSAGE_VIDEO_r: [(Int, NSRange)]
    public func MESSAGE_VIDEO(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_MESSAGE_VIDEO, self._MESSAGE_VIDEO_r, [_1])
    }
    private let _Checkout_PayPrice: String
    private let _Checkout_PayPrice_r: [(Int, NSRange)]
    public func Checkout_PayPrice(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Checkout_PayPrice, self._Checkout_PayPrice_r, [_0])
    }
    private let _Notification_PinnedTextMessage: String
    private let _Notification_PinnedTextMessage_r: [(Int, NSRange)]
    public func Notification_PinnedTextMessage(_ _0: String, _ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_PinnedTextMessage, self._Notification_PinnedTextMessage_r, [_0, _1])
    }
    public let GroupInfo_InvitationLinkDoesNotExist: String
    public let ReportPeer_ReasonOther_Placeholder: String
    public let PasscodeSettings_AutoLock_Disabled: String
    public let Wallpaper_Title: String
    public let Watch_Compose_CreateMessage: String
    public let Message_Audio: String
    public let Notification_CreatedGroup: String
    public let Conversation_SearchNoResults: String
    public let ChannelMembers_BanList_EmptyText: String
    public let ReportPeer_ReasonViolence: String
    public let Group_Username_RemoveExistingUsernamesInfo: String
    public let Message_InvoiceLabel: String
    private let _LastSeen_AtWeekday: String
    private let _LastSeen_AtWeekday_r: [(Int, NSRange)]
    public func LastSeen_AtWeekday(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_LastSeen_AtWeekday, self._LastSeen_AtWeekday_r, [_0])
    }
    public let Contacts_SearchLabel: String
    public let Group_Username_InvalidStartsWithNumber: String
    public let Channel_AdminLogFilter_Title: String
    public let ChatAdmins_AllMembersAreAdminsOnHelp: String
    public let Month_ShortSeptember: String
    public let Group_Username_CreatePublicLinkHelp: String
    public let Login_CallRequestState2: String
    public let TwoStepAuth_RecoveryUnavailable: String
    public let Bot_Unblock: String
    public let SharedMedia_CategoryMedia: String
    public let Conversation_HoldForAudio: String
    public let Conversation_ClousStorageInfo_Description1: String
    public let Channel_Members_InviteLink: String
    public let WebSearch_RecentClearConfirmation: String
    public let Core_ServiceUserStatus: String
    public let Notification_ChannelMigratedFrom: String
    public let Settings_Title: String
    public let Call_StatusBusy: String
    public let ArchivedPacksAlert_Title: String
    public let ConversationMedia_Title: String
    private let _Conversation_MessageViaUser: String
    private let _Conversation_MessageViaUser_r: [(Int, NSRange)]
    public func Conversation_MessageViaUser(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Conversation_MessageViaUser, self._Conversation_MessageViaUser_r, [_0])
    }
    public let Presence_invisible: String
    public let DialogList_Create: String
    public let Tour_Title4: String
    public let Call_StatusEnded: String
    public let Conversation_UnpinMessageAlert: String
    private let _Conversation_MessageDialogRetryAll: String
    private let _Conversation_MessageDialogRetryAll_r: [(Int, NSRange)]
    public func Conversation_MessageDialogRetryAll(_ _1: Int) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Conversation_MessageDialogRetryAll, self._Conversation_MessageDialogRetryAll_r, ["\(_1)"])
    }
    private let _Checkout_PasswordEntry_Text: String
    private let _Checkout_PasswordEntry_Text_r: [(Int, NSRange)]
    public func Checkout_PasswordEntry_Text(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Checkout_PasswordEntry_Text, self._Checkout_PasswordEntry_Text_r, [_0])
    }
    public let Call_Message: String
    public let Contacts_MemberSearchSectionTitleGroup: String
    private let _Conversation_BotInteractiveUrlAlert: String
    private let _Conversation_BotInteractiveUrlAlert_r: [(Int, NSRange)]
    public func Conversation_BotInteractiveUrlAlert(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Conversation_BotInteractiveUrlAlert, self._Conversation_BotInteractiveUrlAlert_r, [_0])
    }
    public let GroupInfo_SharedMedia: String
    public let Channel_Username_InvalidStartsWithNumber: String
    public let KeyCommand_JumpToPreviousChat: String
    public let Conversation_Call: String
    public let KeyCommand_ScrollUp: String
    private let _Privacy_GroupsAndChannels_InviteToChannelError: String
    private let _Privacy_GroupsAndChannels_InviteToChannelError_r: [(Int, NSRange)]
    public func Privacy_GroupsAndChannels_InviteToChannelError(_ _0: String, _ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Privacy_GroupsAndChannels_InviteToChannelError, self._Privacy_GroupsAndChannels_InviteToChannelError_r, [_0, _1])
    }
    public let Document_TargetConfirmationFormat: String
    public let Group_Setup_TypeHeader: String
    private let _DialogList_SinglePlayingGameSuffix: String
    private let _DialogList_SinglePlayingGameSuffix_r: [(Int, NSRange)]
    public func DialogList_SinglePlayingGameSuffix(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_DialogList_SinglePlayingGameSuffix, self._DialogList_SinglePlayingGameSuffix_r, [_0])
    }
    public let AttachmentMenu_SendAsFiles: String
    public let Profile_MessageLifetime1m: String
    public let DialogList_SelectContact: String
    public let Settings_AppleWatch: String
    public let Conversation_View: String
    public let Contacts_Invite: String
    public let Channel_AdminLog_MessagePreviousDescription: String
    public let Your_card_was_declined: String
    public let PhoneNumberHelp_ChangeNumber: String
    public let ReportPeer_ReasonPornography: String
    public let Notification_CreatedChannel: String
    public let PhotoEditor_Original: String
    public let Target_SelectGroup: String
    public let Channel_AdminLog_InfoPanelAlertTitle: String
    public let Notifications_GroupNotificationsPreview: String
    public let Message_PinnedLocationMessage: String
    public let Settings_Logout: String
    public let Profile_Username: String
    public let Group_Username_InvalidTooShort: String
    public let AuthSessions_TerminateOtherSessions: String
    public let PasscodeSettings_TryAgainIn1Minute: String
    public let Notifications_InAppNotifications: String
    public let Channels_Title: String
    public let StickerPack_ViewPack: String
    public let EnterPasscode_ChangeTitle: String
    public let Call_Decline: String
    public let UserInfo_AddPhone: String
    public let Web_CopyLink: String
    public let Activity_PlayingGame: String
    public let CheckoutInfo_ShippingInfoStatePlaceholder: String
    public let Notifications_MessageNotificationsSound: String
    public let Call_StatusWaiting: String
    public let Weekday_ShortWednesday: String
    public let DC_UPDATE: String
    public let PasscodeSettings_AutoLock_IfAwayFor_5hours: String
    public let Notifications_Title: String
    public let Conversation_PinnedMessage: String
    public let Channel_AdminLog_MessagePreviousMessage: String
    public let ConversationProfile_LeaveDeleteAndExit: String
    public let State_connecting: String
    public let WebPreview_LinkPreview: String
    public let Map_OpenInHereMaps: String
    public let CheckoutInfo_Pay: String
    public let DialogList_Messages: String
    public let Login_CountryCode: String
    public let CheckoutInfo_ShippingInfoState: String
    public let Map_OpenInGooglePlus: String
    private let _CHAT_MESSAGE_AUDIO: String
    private let _CHAT_MESSAGE_AUDIO_r: [(Int, NSRange)]
    public func CHAT_MESSAGE_AUDIO(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHAT_MESSAGE_AUDIO, self._CHAT_MESSAGE_AUDIO_r, [_1, _2])
    }
    public let Login_SmsRequestState2: String
    public let Preview_SaveToCameraRoll: String
    public let PasscodeSettings_ChangePasscode: String
    public let TwoStepAuth_RecoveryCodeInvalid: String
    private let _Message_PaymentSent: String
    private let _Message_PaymentSent_r: [(Int, NSRange)]
    public func Message_PaymentSent(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Message_PaymentSent, self._Message_PaymentSent_r, [_0])
    }
    public let Message_PinnedAudioMessage: String
    public let Login_InfoDeletePhoto: String
    public let Settings_SaveIncomingPhotosHelp: String
    public let TwoStepAuth_RecoveryCodeExpired: String
    public let TwoStepAuth_EmailTitle: String
    public let Privacy_GroupsAndChannels_NeverAllow: String
    public let Conversation_AddContact: String
    public let PhotoEditor_QualityLow: String
    public let Paint_Outlined: String
    public let Checkout_PasswordEntry_Title: String
    public let Common_Done: String
    public let PrivacySettings_LastSeenContacts: String
    public let CheckoutInfo_ShippingInfoAddress1: String
    public let UserInfo_LastNamePlaceholder: String
    public let Conversation_StatusKickedFromChannel: String
    public let GroupInfo_InviteLink_RevokeAlert_Text: String
    private let _DialogList_SingleTypingSuffix: String
    private let _DialogList_SingleTypingSuffix_r: [(Int, NSRange)]
    public func DialogList_SingleTypingSuffix(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_DialogList_SingleTypingSuffix, self._DialogList_SingleTypingSuffix_r, [_0])
    }
    public let LastSeen_JustNow: String
    public let CheckoutInfo_ShippingInfoAddress2: String
    public let Watch_Suggestion_No: String
    public let BroadcastListInfo_AddRecipient: String
    private let _Channel_Management_ErrorNotMember: String
    private let _Channel_Management_ErrorNotMember_r: [(Int, NSRange)]
    public func Channel_Management_ErrorNotMember(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Channel_Management_ErrorNotMember, self._Channel_Management_ErrorNotMember_r, [_0])
    }
    public let Privacy_Calls_NeverAllow: String
    public let Settings_About_Title: String
    public let PhoneNumberHelp_Help: String
    public let Service_NetworkConfigurationUpdatedMessage: String
    private let _Time_MonthOfYear_9: String
    private let _Time_MonthOfYear_9_r: [(Int, NSRange)]
    public func Time_MonthOfYear_9(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Time_MonthOfYear_9, self._Time_MonthOfYear_9_r, [_0])
    }
    public let Channel_LinkItem: String
    public let Camera_Retake: String
    public let StickerPack_ShowStickers: String
    private let _CHAT_CREATED: String
    private let _CHAT_CREATED_r: [(Int, NSRange)]
    public func CHAT_CREATED(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHAT_CREATED, self._CHAT_CREATED_r, [_1, _2])
    }
    public let LastSeen_WithinAMonth: String
    private let _PrivacySettings_LastSeenContactsPlus: String
    private let _PrivacySettings_LastSeenContactsPlus_r: [(Int, NSRange)]
    public func PrivacySettings_LastSeenContactsPlus(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_PrivacySettings_LastSeenContactsPlus, self._PrivacySettings_LastSeenContactsPlus_r, [_0])
    }
    public let Conversation_FileHowTo: String
    public let ChangePhoneNumberNumber_NewNumber: String
    public let Compose_NewChannel: String
    public let Channel_AdminLog_CanChangeInviteLink: String
    private let _Call_CallInProgressMessage: String
    private let _Call_CallInProgressMessage_r: [(Int, NSRange)]
    public func Call_CallInProgressMessage(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Call_CallInProgressMessage, self._Call_CallInProgressMessage_r, [_1, _2])
    }
    public let Conversation_InputTextBroadcastPlaceholder: String
    private let _ShareFileTip_Text: String
    private let _ShareFileTip_Text_r: [(Int, NSRange)]
    public func ShareFileTip_Text(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_ShareFileTip_Text, self._ShareFileTip_Text_r, [_0])
    }
    private let _CancelResetAccount_TextSMS: String
    private let _CancelResetAccount_TextSMS_r: [(Int, NSRange)]
    public func CancelResetAccount_TextSMS(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CancelResetAccount_TextSMS, self._CancelResetAccount_TextSMS_r, [_0])
    }
    public let Channel_EditAdmin_PermissionInviteUsers: String
    public let Conversation_Document: String
    public let SearchImages_RetryDownload: String
    public let GroupInfo_DeleteAndExit: String
    public let GroupInfo_InviteLink_CopyLink: String
    public let Weekday_Friday: String
    public let Login_ResetAccountProtected_Title: String
    public let Settings_SetProfilePhoto: String
    public let Compose_ChannelTokenListPlaceholder: String
    public let Channel_EditAdmin_PermissionPinMessages: String
    public let Your_card_has_expired: String
    private let _CHAT_MESSAGE_INVOICE: String
    private let _CHAT_MESSAGE_INVOICE_r: [(Int, NSRange)]
    public func CHAT_MESSAGE_INVOICE(_ _1: String, _ _2: String, _ _3: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHAT_MESSAGE_INVOICE, self._CHAT_MESSAGE_INVOICE_r, [_1, _2, _3])
    }
    public let ChannelInfo_ConfirmLeave: String
    public let ShareMenu_CopyShareLinkGame: String
    public let ReportPeer_ReasonOther: String
    private let _Username_UsernameIsAvailable: String
    private let _Username_UsernameIsAvailable_r: [(Int, NSRange)]
    public func Username_UsernameIsAvailable(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Username_UsernameIsAvailable, self._Username_UsernameIsAvailable_r, [_0])
    }
    public let KeyCommand_JumpToNextUnreadChat: String
    public let Conversation_EncryptedDescriptionTitle: String
    public let DialogList_Pin: String
    private let _Notification_RemovedGroupPhoto: String
    private let _Notification_RemovedGroupPhoto_r: [(Int, NSRange)]
    public func Notification_RemovedGroupPhoto(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_RemovedGroupPhoto, self._Notification_RemovedGroupPhoto_r, [_0])
    }
    public let Channel_ErrorAddTooMuch: String
    public let GroupInfo_SharedMediaNone: String
    public let ChatSettings_TextSizeUnits: String
    public let ChatSettings_AutoPlayAnimations: String
    public let Conversation_FileOpenIn: String
    public let Channel_Setup_TypePublic: String
    private let _ChangePhone_ErrorOccupied: String
    private let _ChangePhone_ErrorOccupied_r: [(Int, NSRange)]
    public func ChangePhone_ErrorOccupied(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_ChangePhone_ErrorOccupied, self._ChangePhone_ErrorOccupied_r, [_0])
    }
    public let DialogList_RecentTitleGroups: String
    public let Privacy_GroupsAndChannels_CustomShareHelp: String
    public let KeyCommand_ChatInfo: String
    public let Notification_CreatedBroadcastList: String
    public let PhotoEditor_HighlightsTint: String
    public let Watch_Compose_AddContact: String
    public let Coub_TapForSound: String
    public let Compose_NewEncryptedChat: String
    public let PhotoEditor_CropReset: String
    public let Login_InvalidLastNameError: String
    public let Channel_Members_AddMembers: String
    public let Tour_Title2: String
    public let Login_TermsOfServiceHeader: String
    public let AuthSessions_OtherSessions: String
    public let Watch_UserInfo_Title: String
    public let InstantPage_FeedbackButton: String
    private let _Generic_OpenHiddenLinkAlert: String
    private let _Generic_OpenHiddenLinkAlert_r: [(Int, NSRange)]
    public func Generic_OpenHiddenLinkAlert(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Generic_OpenHiddenLinkAlert, self._Generic_OpenHiddenLinkAlert_r, [_0])
    }
    public let Conversation_Contact: String
    public let NetworkUsageSettings_GeneralDataSection: String
    public let Service_ApplyLocalization: String
    private let _StickerPack_RemovePrompt: String
    private let _StickerPack_RemovePrompt_r: [(Int, NSRange)]
    public func StickerPack_RemovePrompt(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_StickerPack_RemovePrompt, self._StickerPack_RemovePrompt_r, [_0])
    }
    public let Channel_NotificationCommentsDisabled: String
    public let EnterPasscode_RepeatNewPasscode: String
    public let InstantPage_AutoNightTheme: String
    public let CloudStorage_Title: String
    public let Month_ShortOctober: String
    public let Settings_FAQ: String
    public let PrivacySettings_LastSeen: String
    public let DialogList_SearchSectionRecent: String
    public let ChatSettings_AutomaticVideoMessageDownload: String
    public let Conversation_ContextMenuDelete: String
    public let Tour_Text6: String
    public let PhotoEditor_WarmthTool: String
    private let _Time_MonthOfYear_8: String
    private let _Time_MonthOfYear_8_r: [(Int, NSRange)]
    public func Time_MonthOfYear_8(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Time_MonthOfYear_8, self._Time_MonthOfYear_8_r, [_0])
    }
    public let Common_TakePhoto: String
    public let PhotoEditor_Current: String
    public let UserInfo_CreateNewContact: String
    public let NetworkUsageSettings_MediaDocumentDataSection: String
    public let Login_CodeSentCall: String
    public let Watch_PhotoView_Title: String
    private let _PrivacySettings_LastSeenContactsMinus: String
    private let _PrivacySettings_LastSeenContactsMinus_r: [(Int, NSRange)]
    public func PrivacySettings_LastSeenContactsMinus(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_PrivacySettings_LastSeenContactsMinus, self._PrivacySettings_LastSeenContactsMinus_r, [_0])
    }
    public let Login_InfoUpdatePhoto: String
    public let ShareMenu_SelectChats: String
    public let Group_ErrorSendRestrictedMedia: String
    public let Channel_EditAdmin_PermissinAddAdminOff: String
    public let Cache_Files: String
    public let PhotoEditor_EnhanceTool: String
    public let Conversation_SearchPlaceholder: String
    public let Calls_Search: String
    public let BroadcastListInfo_Title: String
    public let WatchRemote_AlertText: String
    public let Channel_AdminLog_CanInviteUsers: String
    public let Conversation_Block: String
    public let AttachmentMenu_PhotoOrVideo: String
    public let Channel_BanUser_PermissionReadMessages: String
    public let Month_ShortMarch: String
    public let GroupInfo_InviteLink_Title: String
    public let Watch_LastSeen_JustNow: String
    public let BroadcastLists_Title: String
    public let PhoneLabel_Title: String
    public let PrivacySettings_Passcode: String
    public let Paint_ClearConfirm: String
    private let _Checkout_SavePasswordTimeout: String
    private let _Checkout_SavePasswordTimeout_r: [(Int, NSRange)]
    public func Checkout_SavePasswordTimeout(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Checkout_SavePasswordTimeout, self._Checkout_SavePasswordTimeout_r, [_0])
    }
    public let PhotoEditor_BlurToolOff: String
    public let AccessDenied_VideoMicrophone: String
    public let Weekday_ShortThursday: String
    public let UserInfo_ShareContact: String
    public let LoginPassword_InvalidPasswordError: String
    public let Login_PhoneAndCountryHelp: String
    public let CheckoutInfo_ReceiverInfoName: String
    private let _LastSeen_TodayAt: String
    private let _LastSeen_TodayAt_r: [(Int, NSRange)]
    public func LastSeen_TodayAt(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_LastSeen_TodayAt, self._LastSeen_TodayAt_r, [_0])
    }
    private let _Time_YesterdayAt: String
    private let _Time_YesterdayAt_r: [(Int, NSRange)]
    public func Time_YesterdayAt(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Time_YesterdayAt, self._Time_YesterdayAt_r, [_0])
    }
    public let Weekday_Yesterday: String
    public let Conversation_InputTextSilentBroadcastPlaceholder: String
    public let Embed_PlayingInPIP: String
    public let Call_StatusIncoming: String
    public let Conversation_Play: String
    public let Settings_PrivacySettings: String
    public let Conversation_SilentBroadcastTooltipOn: String
    private let _CHAT_MESSAGE_GEO: String
    private let _CHAT_MESSAGE_GEO_r: [(Int, NSRange)]
    public func CHAT_MESSAGE_GEO(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHAT_MESSAGE_GEO, self._CHAT_MESSAGE_GEO_r, [_1, _2])
    }
    public let DialogList_SearchLabel: String
    public let Login_CodeSentInternal: String
    public let Channel_AdminLog_BanSendMessages: String
    public let Channel_MessagePhotoRemoved: String
    public let Conversation_StatusKickedFromGroup: String
    public let Compose_NewChannel_AddMemberHelp: String
    public let GroupInfo_ChatAdmins: String
    public let PhotoEditor_CurvesAll: String
    public let Compose_Create: String
    private let _LOCKED_MESSAGE: String
    private let _LOCKED_MESSAGE_r: [(Int, NSRange)]
    public func LOCKED_MESSAGE(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_LOCKED_MESSAGE, self._LOCKED_MESSAGE_r, [_1])
    }
    public let Conversation_ContextMenuShare: String
    private let _Call_GroupFormat: String
    private let _Call_GroupFormat_r: [(Int, NSRange)]
    public func Call_GroupFormat(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Call_GroupFormat, self._Call_GroupFormat_r, [_1, _2])
    }
    public let Forward_ChannelReadOnly: String
    public let Privacy_GroupsAndChannels_NeverAllow_Title: String
    public let Conversation_StatusGroupDeactivated: String
    private let _CHAT_JOINED: String
    private let _CHAT_JOINED_r: [(Int, NSRange)]
    public func CHAT_JOINED(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHAT_JOINED, self._CHAT_JOINED_r, [_1, _2])
    }
    public let Conversation_Moderate_Ban: String
    public let Group_Status: String
    public let Watch_Suggestion_Absolutely: String
    public let Conversation_InputTextPlaceholder: String
    private let _Time_MonthOfYear_7: String
    private let _Time_MonthOfYear_7_r: [(Int, NSRange)]
    public func Time_MonthOfYear_7(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Time_MonthOfYear_7, self._Time_MonthOfYear_7_r, [_0])
    }
    public let SharedMedia_TitleAudio: String
    public let TwoStepAuth_RecoveryCode: String
    public let SharedMedia_CategoryDocs: String
    public let Channel_AdminLog_CanChangeInfo: String
    public let Channel_AdminLogFilter_EventsAdmins: String
    private let _AuthSessions_AppUnofficial: String
    private let _AuthSessions_AppUnofficial_r: [(Int, NSRange)]
    public func AuthSessions_AppUnofficial(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_AuthSessions_AppUnofficial, self._AuthSessions_AppUnofficial_r, [_0])
    }
    public let Channel_EditAdmin_PermissionsHeader: String
    private let _DialogList_SingleUploadingVideoSuffix: String
    private let _DialogList_SingleUploadingVideoSuffix_r: [(Int, NSRange)]
    public func DialogList_SingleUploadingVideoSuffix(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_DialogList_SingleUploadingVideoSuffix, self._DialogList_SingleUploadingVideoSuffix_r, [_0])
    }
    public let Group_UpgradeNoticeHeader: String
    private let _CHAT_DELETE_YOU: String
    private let _CHAT_DELETE_YOU_r: [(Int, NSRange)]
    public func CHAT_DELETE_YOU(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHAT_DELETE_YOU, self._CHAT_DELETE_YOU_r, [_1, _2])
    }
    private let _MESSAGE_NOTEXT: String
    private let _MESSAGE_NOTEXT_r: [(Int, NSRange)]
    public func MESSAGE_NOTEXT(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_MESSAGE_NOTEXT, self._MESSAGE_NOTEXT_r, [_1])
    }
    private let _CHAT_MESSAGE_GIF: String
    private let _CHAT_MESSAGE_GIF_r: [(Int, NSRange)]
    public func CHAT_MESSAGE_GIF(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHAT_MESSAGE_GIF, self._CHAT_MESSAGE_GIF_r, [_1, _2])
    }
    public let GroupInfo_InviteLink_CopyAlert_Success: String
    public let Channel_Info_Members: String
    public let ShareFileTip_CloseTip: String
    public let KeyCommand_Find: String
    public let Preview_VideoNotYetDownloaded: String
    public let Checkout_NewCard_PostcodeTitle: String
    private let _Channel_AdminLog_MessageRestricted: String
    private let _Channel_AdminLog_MessageRestricted_r: [(Int, NSRange)]
    public func Channel_AdminLog_MessageRestricted(_ _0: String, _ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Channel_AdminLog_MessageRestricted, self._Channel_AdminLog_MessageRestricted_r, [_0, _1, _2])
    }
    public let Channel_EditAdmin_PermissinAddAdminOn: String
    public let WebSearch_GIFs: String
    public let TwoStepAuth_EnterPasswordTitle: String
    private let _CHANNEL_MESSAGE_GAME: String
    private let _CHANNEL_MESSAGE_GAME_r: [(Int, NSRange)]
    public func CHANNEL_MESSAGE_GAME(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHANNEL_MESSAGE_GAME, self._CHANNEL_MESSAGE_GAME_r, [_1, _2])
    }
    public let AccessDenied_CallMicrophone: String
    public let Conversation_DeleteMessagesForEveryone: String
    public let UserInfo_TapToCall: String
    public let Common_Edit: String
    public let Conversation_OpenFile: String
    public let Message_PinnedDocumentMessage: String
    public let Channel_ShareChannel: String
    public let PrivacySettings_DeleteAccountNowConfirmation: String
    public let Checkout_TotalPaidAmount: String
    public let Conversation_UnsupportedMedia: String
    private let _Message_ForwardedMessage: String
    private let _Message_ForwardedMessage_r: [(Int, NSRange)]
    public func Message_ForwardedMessage(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Message_ForwardedMessage, self._Message_ForwardedMessage_r, [_0])
    }
    public let Checkout_NewCard_SaveInfoEnableHelp: String
    public let Call_AudioRouteHide: String
    public let CallSettings_OnMobile: String
    public let Conversation_GifTooltip: String
    public let CheckoutInfo_ErrorCityInvalid: String
    public let Profile_CreateEncryptedChatError: String
    public let Map_LocationTitle: String
    public let Compose_Recipients: String
    public let Message_ReplyActionButtonShowReceipt: String
    public let PhotoEditor_ShadowsTool: String
    public let Checkout_NewCard_CardholderNamePlaceholder: String
    public let Cache_Title: String
    public let Month_GenMay: String
    private let _Notification_CreatedChat: String
    private let _Notification_CreatedChat_r: [(Int, NSRange)]
    public func Notification_CreatedChat(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_CreatedChat, self._Notification_CreatedChat_r, [_0])
    }
    public let Calls_NoMissedCallsPlacehoder: String
    public let Watch_UserInfo_Block: String
    public let Watch_LastSeen_ALongTimeAgo: String
    public let StickerPacksSettings_ManagingHelp: String
    public let Privacy_GroupsAndChannels_InviteToChannelMultipleError: String
    public let PrivacySettings_TouchIdEnable: String
    public let SearchImages_Title: String
    public let Channel_BlackList_Title: String
    public let Checkout_NewCard_SaveInfo: String
    public let Notification_CallMissed: String
    public let Profile_ShareContactButton: String
    public let Group_ErrorSendRestrictedStickers: String
    public let Bot_GroupStatusDoesNotReadHistory: String
    public let Notification_Mute1h: String
    public let Cache_ClearCacheAlert: String
    public let BroadcastLists_NoListsYet: String
    public let Settings_TabTitle: String
    private let _Time_MonthOfYear_6: String
    private let _Time_MonthOfYear_6_r: [(Int, NSRange)]
    public func Time_MonthOfYear_6(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Time_MonthOfYear_6, self._Time_MonthOfYear_6_r, [_0])
    }
    public let NetworkUsageSettings_MediaAudioDataSection: String
    public let GroupInfo_DeactivatedStatus: String
    private let _CHAT_PHOTO_EDITED: String
    private let _CHAT_PHOTO_EDITED_r: [(Int, NSRange)]
    public func CHAT_PHOTO_EDITED(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHAT_PHOTO_EDITED, self._CHAT_PHOTO_EDITED_r, [_1, _2])
    }
    public let Conversation_ContextMenuMore: String
    private let _PrivacySettings_LastSeenEverybodyMinus: String
    private let _PrivacySettings_LastSeenEverybodyMinus_r: [(Int, NSRange)]
    public func PrivacySettings_LastSeenEverybodyMinus(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_PrivacySettings_LastSeenEverybodyMinus, self._PrivacySettings_LastSeenEverybodyMinus_r, [_0])
    }
    public let Weekday_Today: String
    public let Login_InvalidFirstNameError: String
    private let _Notification_Joined: String
    private let _Notification_Joined_r: [(Int, NSRange)]
    public func Notification_Joined(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_Joined, self._Notification_Joined_r, [_0])
    }
    private let _VideoPreview_OptionHD: String
    private let _VideoPreview_OptionHD_r: [(Int, NSRange)]
    public func VideoPreview_OptionHD(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_VideoPreview_OptionHD, self._VideoPreview_OptionHD_r, [_0])
    }
    public let Paint_Clear: String
    public let TwoStepAuth_RecoveryFailed: String
    private let _MESSAGE_AUDIO: String
    private let _MESSAGE_AUDIO_r: [(Int, NSRange)]
    public func MESSAGE_AUDIO(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_MESSAGE_AUDIO, self._MESSAGE_AUDIO_r, [_1])
    }
    public let Checkout_PasswordEntry_Pay: String
    public let Notifications_MessageNotificationsHelp: String
    public let Notification_EncryptedChatRequested: String
    public let EnterPasscode_EnterCurrentPasscode: String
    public let Channel_Management_LabelModerator: String
    private let _MESSAGE_GAME: String
    private let _MESSAGE_GAME_r: [(Int, NSRange)]
    public func MESSAGE_GAME(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_MESSAGE_GAME, self._MESSAGE_GAME_r, [_1, _2])
    }
    public let Conversation_Moderate_Report: String
    public let MessageTimer_Forever: String
    private let _Conversation_EncryptedPlaceholderTitleIncoming: String
    private let _Conversation_EncryptedPlaceholderTitleIncoming_r: [(Int, NSRange)]
    public func Conversation_EncryptedPlaceholderTitleIncoming(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Conversation_EncryptedPlaceholderTitleIncoming, self._Conversation_EncryptedPlaceholderTitleIncoming_r, [_0])
    }
    private let _Map_AccurateTo: String
    private let _Map_AccurateTo_r: [(Int, NSRange)]
    public func Map_AccurateTo(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Map_AccurateTo, self._Map_AccurateTo_r, [_0])
    }
    private let _Call_ParticipantVersionOutdatedError: String
    private let _Call_ParticipantVersionOutdatedError_r: [(Int, NSRange)]
    public func Call_ParticipantVersionOutdatedError(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Call_ParticipantVersionOutdatedError, self._Call_ParticipantVersionOutdatedError_r, [_0])
    }
    public let Tour_Text2: String
    public let Preview_ViewStickerPack: String
    public let Conversation_MessageDialogDelete: String
    public let Calls_Clear: String
    public let Username_Placeholder: String
    private let _Notification_PinnedDeletedMessage: String
    private let _Notification_PinnedDeletedMessage_r: [(Int, NSRange)]
    public func Notification_PinnedDeletedMessage(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_PinnedDeletedMessage, self._Notification_PinnedDeletedMessage_r, [_0])
    }
    public let UserInfo_BotHelp: String
    public let Contacts_contact: String
    public let TwoStepAuth_PasswordSet: String
    public let Channel_Moderator_AccessLevelEditor: String
    public let EnterPasscode_TouchId: String
    private let _CHANNEL_MESSAGE_VIDEO: String
    private let _CHANNEL_MESSAGE_VIDEO_r: [(Int, NSRange)]
    public func CHANNEL_MESSAGE_VIDEO(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHANNEL_MESSAGE_VIDEO, self._CHANNEL_MESSAGE_VIDEO_r, [_1])
    }
    public let Checkout_ErrorInvoiceAlreadyPaid: String
    public let ChatAdmins_Title: String
    public let BroadcastLists_NoListsText: String
    public let ChannelMembers_WhoCanAddMembers: String
    public let ChannelMembers_AllMembersMayInviteOffHelp: String
    public let Conversation_InfoPrivate: String
    public let PasscodeSettings_Help: String
    public let Conversation_EditingMessagePanelTitle: String
    private let _NetworkUsageSettings_CellularUsageSince: String
    private let _NetworkUsageSettings_CellularUsageSince_r: [(Int, NSRange)]
    public func NetworkUsageSettings_CellularUsageSince(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_NetworkUsageSettings_CellularUsageSince, self._NetworkUsageSettings_CellularUsageSince_r, [_0])
    }
    public let GroupInfo_ConvertToSupergroup: String
    private let _Notification_PinnedContactMessage: String
    private let _Notification_PinnedContactMessage_r: [(Int, NSRange)]
    public func Notification_PinnedContactMessage(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_PinnedContactMessage, self._Notification_PinnedContactMessage_r, [_0])
    }
    public let CallSettings_UseLessDataLongDescription: String
    public let Conversation_SecretChatContextBotAlert: String
    public let Channel_Moderator_AccessLevelRevoke: String
    public let CheckoutInfo_ReceiverInfoTitle: String
    public let Channel_AdminLogFilter_EventsRestrictions: String
    public let GroupInfo_InviteLink_RevokeLink: String
    public let Conversation_Unmute: String
    public let Checkout_PaymentMethod_Title: String
    private let _AppLanguage_LanguageSuggested: String
    private let _AppLanguage_LanguageSuggested_r: [(Int, NSRange)]
    public func AppLanguage_LanguageSuggested(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_AppLanguage_LanguageSuggested, self._AppLanguage_LanguageSuggested_r, [_0])
    }
    public let Notifications_MessageNotifications: String
    public let ChannelMembers_WhoCanAddMembersAdminsHelp: String
    public let DialogList_DeleteBotConversationConfirmation: String
    private let _MediaPicker_AccessDeniedHelp: String
    private let _MediaPicker_AccessDeniedHelp_r: [(Int, NSRange)]
    public func MediaPicker_AccessDeniedHelp(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_MediaPicker_AccessDeniedHelp, self._MediaPicker_AccessDeniedHelp_r, [_0])
    }
    private let _GroupInfo_InvitationLinkAccept: String
    private let _GroupInfo_InvitationLinkAccept_r: [(Int, NSRange)]
    public func GroupInfo_InvitationLinkAccept(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_GroupInfo_InvitationLinkAccept, self._GroupInfo_InvitationLinkAccept_r, [_0])
    }
    public let Conversation_ClousStorageInfo_Description2: String
    public let Map_Hybrid: String
    public let Channel_Setup_Title: String
    public let Activity_UploadingVideo: String
    public let Channel_Info_Management: String
    private let _Notification_MessageLifetimeChangedOutgoing: String
    private let _Notification_MessageLifetimeChangedOutgoing_r: [(Int, NSRange)]
    public func Notification_MessageLifetimeChangedOutgoing(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_MessageLifetimeChangedOutgoing, self._Notification_MessageLifetimeChangedOutgoing_r, [_1])
    }
    public let Conversation_DeleteOneMessage: String
    public let PhotoEditor_QualityVeryLow: String
    public let Month_ShortFebruary: String
    public let Compose_NewBroadcast: String
    public let Conversation_ForwardTitle: String
    public let Settings_FAQ_URL: String
    public let TwoStepAuth_ConfirmationChangeEmail: String
    public let Activity_RecordingVideoMessage: String
    public let WelcomeScreen_ContactsAccessSettings: String
    public let SharedMedia_EmptyFilesText: String
    private let _Contacts_AccessDeniedHelpLandscape: String
    private let _Contacts_AccessDeniedHelpLandscape_r: [(Int, NSRange)]
    public func Contacts_AccessDeniedHelpLandscape(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Contacts_AccessDeniedHelpLandscape, self._Contacts_AccessDeniedHelpLandscape_r, [_0])
    }
    public let Channel_NotificationCommentsEnabled: String
    public let PasscodeSettings_UnlockWithTouchId: String
    public let Contacts_AccessDeniedHelpON: String
    private let _Time_MonthOfYear_5: String
    private let _Time_MonthOfYear_5_r: [(Int, NSRange)]
    public func Time_MonthOfYear_5(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Time_MonthOfYear_5, self._Time_MonthOfYear_5_r, [_0])
    }
    private let _PrivacySettings_LastSeenContactsMinusPlus: String
    private let _PrivacySettings_LastSeenContactsMinusPlus_r: [(Int, NSRange)]
    public func PrivacySettings_LastSeenContactsMinusPlus(_ _0: String, _ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_PrivacySettings_LastSeenContactsMinusPlus, self._PrivacySettings_LastSeenContactsMinusPlus_r, [_0, _1])
    }
    public let NetworkUsageSettings_ResetStats: String
    private let _Notification_ChannelInviter: String
    private let _Notification_ChannelInviter_r: [(Int, NSRange)]
    public func Notification_ChannelInviter(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_ChannelInviter, self._Notification_ChannelInviter_r, [_0])
    }
    public let Profile_MessageLifetimeForever: String
    public let Conversation_Edit: String
    public let TwoStepAuth_ResetAccountHelp: String
    public let Month_GenDecember: String
    private let _Watch_LastSeen_YesterdayAt: String
    private let _Watch_LastSeen_YesterdayAt_r: [(Int, NSRange)]
    public func Watch_LastSeen_YesterdayAt(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Watch_LastSeen_YesterdayAt, self._Watch_LastSeen_YesterdayAt_r, [_0])
    }
    public let Channel_ErrorAddBlocked: String
    public let Conversation_Unpin: String
    public let Call_RecordingDisabledMessage: String
    public let Conversation_Stop: String
    public let Conversation_UnblockUser: String
    public let Conversation_Unblock: String
    private let _CHANNEL_MESSAGE_GIF: String
    private let _CHANNEL_MESSAGE_GIF_r: [(Int, NSRange)]
    public func CHANNEL_MESSAGE_GIF(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHANNEL_MESSAGE_GIF, self._CHANNEL_MESSAGE_GIF_r, [_1])
    }
    public let Channel_AdminLogFilter_EventsEditedMessages: String
    public let Channel_Username_InvalidTooShort: String
    public let Watch_LastSeen_WithinAWeek: String
    public let BlockedUsers_SelectUserTitle: String
    public let Profile_MessageLifetime1w: String
    public let DialogList_TabTitle: String
    public let UserInfo_GenericPhoneLabel: String
    public let MediaPicker_MomentsDateFormat: String
    private let _Conversation_DownloadKilobytes: String
    private let _Conversation_DownloadKilobytes_r: [(Int, NSRange)]
    public func Conversation_DownloadKilobytes(_ _0: Int) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Conversation_DownloadKilobytes, self._Conversation_DownloadKilobytes_r, ["\(_0)"])
    }
    private let _Username_LinkHint: String
    private let _Username_LinkHint_r: [(Int, NSRange)]
    public func Username_LinkHint(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Username_LinkHint, self._Username_LinkHint_r, [_0])
    }
    public let NetworkUsageSettings_Title: String
    public let CheckoutInfo_ShippingInfoPostcodePlaceholder: String
    public let Wallpaper_Wallpaper: String
    public let GroupInfo_InviteLink_RevokeAlert_Revoke: String
    public let SharedMedia_TitleLink: String
    public let Channel_JoinChannel: String
    public let StickerPack_Add: String
    public let Group_ErrorNotMutualContact: String
    public let AccessDenied_LocationDisabled: String
    public let Conversation_DownloadPhoto: String
    public let Login_UnknownError: String
    public let Presence_online: String
    public let DialogList_Title: String
    public let Stickers_Install: String
    public let SearchImages_NoImagesFound: String
    private let _Notification_RemovedUserPhoto: String
    private let _Notification_RemovedUserPhoto_r: [(Int, NSRange)]
    public func Notification_RemovedUserPhoto(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_RemovedUserPhoto, self._Notification_RemovedUserPhoto_r, [_0])
    }
    private let _Watch_Time_ShortTodayAt: String
    private let _Watch_Time_ShortTodayAt_r: [(Int, NSRange)]
    public func Watch_Time_ShortTodayAt(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Watch_Time_ShortTodayAt, self._Watch_Time_ShortTodayAt_r, [_0])
    }
    public let UserInfo_GroupsInCommon: String
    public let ChatSettings_Language: String
    public let AccessDenied_CameraDisabled: String
    public let Message_PinnedContactMessage: String
    public let UserInfo_Call: String
    public let Conversation_InputTextDisabledPlaceholder: String
    public let Map_ForwardViaTelegram: String
    public let Month_GenMarch: String
    public let Watch_UserInfo_Unmute: String
    public let PhotoEditor_BlurTool: String
    public let Common_Delete: String
    public let Username_Title: String
    public let Login_PhoneFloodError: String
    public let CheckoutInfo_ErrorPostcodeInvalid: String
    private let _CHANNEL_MESSAGE_PHOTO: String
    private let _CHANNEL_MESSAGE_PHOTO_r: [(Int, NSRange)]
    public func CHANNEL_MESSAGE_PHOTO(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHANNEL_MESSAGE_PHOTO, self._CHANNEL_MESSAGE_PHOTO_r, [_1])
    }
    public let Channel_AdminLog_InfoPanelTitle: String
    public let Group_ErrorAddTooMuchBots: String
    private let _Notification_CallFormat: String
    private let _Notification_CallFormat_r: [(Int, NSRange)]
    public func Notification_CallFormat(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_CallFormat, self._Notification_CallFormat_r, [_1, _2])
    }
    private let _CHAT_MESSAGE_PHOTO: String
    private let _CHAT_MESSAGE_PHOTO_r: [(Int, NSRange)]
    public func CHAT_MESSAGE_PHOTO(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHAT_MESSAGE_PHOTO, self._CHAT_MESSAGE_PHOTO_r, [_1, _2])
    }
    private let _Channel_AdminLog_MessageToggleInvitesOff: String
    private let _Channel_AdminLog_MessageToggleInvitesOff_r: [(Int, NSRange)]
    public func Channel_AdminLog_MessageToggleInvitesOff(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Channel_AdminLog_MessageToggleInvitesOff, self._Channel_AdminLog_MessageToggleInvitesOff_r, [_0])
    }
    public let UserInfo_ShareBot: String
    public let TwoStepAuth_EmailSkip: String
    public let Conversation_JumpToDate: String
    public let CheckoutInfo_ReceiverInfoEmailPlaceholder: String
    public let Message_Photo: String
    public let Conversation_ReportSpam: String
    public let Camera_FlashAuto: String
    private let _Time_MonthOfYear_4: String
    private let _Time_MonthOfYear_4_r: [(Int, NSRange)]
    public func Time_MonthOfYear_4(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Time_MonthOfYear_4, self._Time_MonthOfYear_4_r, [_0])
    }
    public let Call_ConnectionErrorMessage: String
    public let Compose_NewChannel_AddMember: String
    public let Watch_State_Updating: String
    public let LastSeen_ALongTimeAgo: String
    public let DialogList_SearchSectionGlobal: String
    public let ChangePhoneNumberNumber_NumberPlaceholder: String
    public let GroupInfo_AddUserLeftError: String
    public let GroupInfo_GroupType: String
    public let Watch_Suggestion_OnMyWay: String
    public let Checkout_NewCard_PaymentCard: String
    public let PhotoEditor_CropAspectRatioOriginal: String
    public let MediaPicker_MomentsDateRangeFormat: String
    public let UserInfo_NotificationsDisabled: String
    private let _CONTACT_JOINED: String
    private let _CONTACT_JOINED_r: [(Int, NSRange)]
    public func CONTACT_JOINED(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CONTACT_JOINED, self._CONTACT_JOINED_r, [_1])
    }
    public let PrivacyLastSeenSettings_AlwaysShareWith_Title: String
    public let BlockedUsers_LeavePrefix: String
    public let NetworkUsageSettings_ResetStatsConfirmation: String
    public let Channel_EditAdmin_PermissionPostMessages: String
    public let DialogList_EncryptionProcessing: String
    public let Conversation_ApplyLocalization: String
    public let Conversation_DeleteManyMessages: String
    public let CancelResetAccount_Title: String
    public let Notification_CallOutgoingShort: String
    public let Channel_Moderator_AccessLevelHeader: String
    public let SharedMedia_TitleAll: String
    public let Conversation_SlideToCancel: String
    public let AuthSessions_TerminateSession: String
    public let Channel_AdminLogFilter_EventsDeletedMessages: String
    public let PrivacyLastSeenSettings_AlwaysShareWith_Placeholder: String
    public let Channel_Members_Title: String
    public let Channel_AdminLog_CanDeleteMessages: String
    public let Group_Setup_TypePrivateHelp: String
    private let _Notification_PinnedVideoMessage: String
    private let _Notification_PinnedVideoMessage_r: [(Int, NSRange)]
    public func Notification_PinnedVideoMessage(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_PinnedVideoMessage, self._Notification_PinnedVideoMessage_r, [_0])
    }
    public let Conversation_ContextMenuStickerPackAdd: String
    public let Channel_AdminLogFilter_EventsNewMembers: String
    public let Channel_AdminLogFilter_EventsPinned: String
    private let _Conversation_Moderate_DeleteAllMessages: String
    private let _Conversation_Moderate_DeleteAllMessages_r: [(Int, NSRange)]
    public func Conversation_Moderate_DeleteAllMessages(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Conversation_Moderate_DeleteAllMessages, self._Conversation_Moderate_DeleteAllMessages_r, [_0])
    }
    public let SharedMedia_CategoryOther: String
    public let GoogleDrive_LogoutMessage: String
    public let Preview_DeletePhoto: String
    public let PasscodeSettings_TurnPasscodeOn: String
    public let GroupInfo_ChannelListNamePlaceholder: String
    public let DialogList_Unpin: String
    public let GroupInfo_SetGroupPhoto: String
    public let StickerPacksSettings_ArchivedPacks_Info: String
    public let ConvertToSupergroup_Title: String
    private let _CHAT_MESSAGE_NOTEXT: String
    private let _CHAT_MESSAGE_NOTEXT_r: [(Int, NSRange)]
    public func CHAT_MESSAGE_NOTEXT(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHAT_MESSAGE_NOTEXT, self._CHAT_MESSAGE_NOTEXT_r, [_1, _2])
    }
    public let Channel_Setup_TypeHeader: String
    private let _Notification_NewAuthDetected: String
    private let _Notification_NewAuthDetected_r: [(Int, NSRange)]
    public func Notification_NewAuthDetected(_ _1: String, _ _2: String, _ _3: String, _ _4: String, _ _5: String, _ _6: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_NewAuthDetected, self._Notification_NewAuthDetected_r, [_1, _2, _3, _4, _5, _6])
    }
    public let Notification_CallCanceledShort: String
    public let PhotoEditor_RevertMessage: String
    public let AccessDenied_VideoMessageCamera: String
    public let Conversation_Search: String
    private let _Channel_Management_PromotedBy: String
    private let _Channel_Management_PromotedBy_r: [(Int, NSRange)]
    public func Channel_Management_PromotedBy(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Channel_Management_PromotedBy, self._Channel_Management_PromotedBy_r, [_0])
    }
    private let _PrivacySettings_LastSeenNobodyPlus: String
    private let _PrivacySettings_LastSeenNobodyPlus_r: [(Int, NSRange)]
    public func PrivacySettings_LastSeenNobodyPlus(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_PrivacySettings_LastSeenNobodyPlus, self._PrivacySettings_LastSeenNobodyPlus_r, [_0])
    }
    public let Preview_ForwardViaTelegram: String
    public let Notifications_InAppNotificationsSounds: String
    public let Call_StatusRequesting: String
    private let _CHAT_MESSAGE_CONTACT: String
    private let _CHAT_MESSAGE_CONTACT_r: [(Int, NSRange)]
    public func CHAT_MESSAGE_CONTACT(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHAT_MESSAGE_CONTACT, self._CHAT_MESSAGE_CONTACT_r, [_1, _2])
    }
    public let Group_UpgradeNoticeText1: String
    public let ChatSettings_Other: String
    private let _Channel_AdminLog_MessageChangedChannelAbout: String
    private let _Channel_AdminLog_MessageChangedChannelAbout_r: [(Int, NSRange)]
    public func Channel_AdminLog_MessageChangedChannelAbout(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Channel_AdminLog_MessageChangedChannelAbout, self._Channel_AdminLog_MessageChangedChannelAbout_r, [_0])
    }
    private let _Call_EmojiDescription: String
    private let _Call_EmojiDescription_r: [(Int, NSRange)]
    public func Call_EmojiDescription(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Call_EmojiDescription, self._Call_EmojiDescription_r, [_0])
    }
    public let Settings_SaveIncomingPhotos: String
    private let _Conversation_Bytes: String
    private let _Conversation_Bytes_r: [(Int, NSRange)]
    public func Conversation_Bytes(_ _0: Int) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Conversation_Bytes, self._Conversation_Bytes_r, ["\(_0)"])
    }
    public let GroupInfo_InviteLink_Help: String
    private let _Time_MonthOfYear_3: String
    private let _Time_MonthOfYear_3_r: [(Int, NSRange)]
    public func Time_MonthOfYear_3(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Time_MonthOfYear_3, self._Time_MonthOfYear_3_r, [_0])
    }
    public let Conversation_ContextMenuForward: String
    public let Calls_Missed: String
    public let Call_StatusRinging: String
    public let Invitation_JoinGroup: String
    public let Notification_PinnedMessage: String
    public let Message_Location: String
    private let _Notification_MessageLifetimeChanged: String
    private let _Notification_MessageLifetimeChanged_r: [(Int, NSRange)]
    public func Notification_MessageLifetimeChanged(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_MessageLifetimeChanged, self._Notification_MessageLifetimeChanged_r, [_1, _2])
    }
    public let Message_Contact: String
    private let _Watch_LastSeen_TodayAt: String
    private let _Watch_LastSeen_TodayAt_r: [(Int, NSRange)]
    public func Watch_LastSeen_TodayAt(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Watch_LastSeen_TodayAt, self._Watch_LastSeen_TodayAt_r, [_0])
    }
    public let Channel_Moderator_AccessLevelModerator: String
    public let GoogleDrive_Logout: String
    public let PhotoEditor_RevertToOriginal: String
    public let Common_More: String
    public let Preview_OpenInInstagram: String
    public let PhotoEditor_HighlightsTool: String
    private let _Channel_Username_UsernameIsAvailable: String
    private let _Channel_Username_UsernameIsAvailable_r: [(Int, NSRange)]
    public func Channel_Username_UsernameIsAvailable(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Channel_Username_UsernameIsAvailable, self._Channel_Username_UsernameIsAvailable_r, [_0])
    }
    private let _PINNED_GAME: String
    private let _PINNED_GAME_r: [(Int, NSRange)]
    public func PINNED_GAME(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_PINNED_GAME, self._PINNED_GAME_r, [_1])
    }
    public let GroupInfo_BroadcastListNamePlaceholder: String
    public let Conversation_ShareBotContactConfirmation: String
    public let Login_CodeSentSms: String
    public let Conversation_ReportSpamConfirmation: String
    public let ChannelMembers_ChannelAdminsTitle: String
    public let CallSettings_UseLessData: String
    private let _TwoStepAuth_EnterPasswordHint: String
    private let _TwoStepAuth_EnterPasswordHint_r: [(Int, NSRange)]
    public func TwoStepAuth_EnterPasswordHint(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_TwoStepAuth_EnterPasswordHint, self._TwoStepAuth_EnterPasswordHint_r, [_0])
    }
    public let CallSettings_TabIcon: String
    public let Conversation_EditForward: String
    public let ConversationProfile_UnknownAddMemberError: String
    private let _Conversation_FileHowToText: String
    private let _Conversation_FileHowToText_r: [(Int, NSRange)]
    public func Conversation_FileHowToText(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Conversation_FileHowToText, self._Conversation_FileHowToText_r, [_0])
    }
    public let Channel_AdminLog_BanSendMedia: String
    public let Tour_Text7: String
    public let Contacts_contactsvar: String
    public let Watch_UserInfo_Unblock: String
    public let Conversation_EditDelete: String
    public let Conversation_ViewPhoto: String
    public let StickerPacksSettings_ArchivedMasks: String
    public let Message_Animation: String
    public let Checkout_PaymentMethod: String
    public let Channel_AdminLog_TitleSelectedEvents: String
    public let Privacy_Calls_NeverAllow_Title: String
    public let Cache_Music: String
    private let _Login_CallRequestState1: String
    private let _Login_CallRequestState1_r: [(Int, NSRange)]
    public func Login_CallRequestState1(_ _0: Int) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Login_CallRequestState1, self._Login_CallRequestState1_r, ["\(_0)"])
    }
    private let _SearchImages_ImageNofM: String
    private let _SearchImages_ImageNofM_r: [(Int, NSRange)]
    public func SearchImages_ImageNofM(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_SearchImages_ImageNofM, self._SearchImages_ImageNofM_r, [_1, _2])
    }
    public let Channel_Username_CreatePrivateLinkHelp: String
    private let _FileSize_B: String
    private let _FileSize_B_r: [(Int, NSRange)]
    public func FileSize_B(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_FileSize_B, self._FileSize_B_r, [_0])
    }
    private let _Target_ShareGameConfirmationGroup: String
    private let _Target_ShareGameConfirmationGroup_r: [(Int, NSRange)]
    public func Target_ShareGameConfirmationGroup(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Target_ShareGameConfirmationGroup, self._Target_ShareGameConfirmationGroup_r, [_0])
    }
    public let PhotoEditor_SaturationTool: String
    public let ImagePicker_NoPhotos: String
    public let Call_StatusConnecting: String
    public let Channel_BanUser_BlockFor: String
    public let Preview_DeleteVideo: String
    public let Bot_Start: String
    private let _Channel_AdminLog_MessageChangedGroupAbout: String
    private let _Channel_AdminLog_MessageChangedGroupAbout_r: [(Int, NSRange)]
    public func Channel_AdminLog_MessageChangedGroupAbout(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Channel_AdminLog_MessageChangedGroupAbout, self._Channel_AdminLog_MessageChangedGroupAbout_r, [_0])
    }
    public let Notifications_TextTone: String
    public let DialogList_Draft: String
    private let _Watch_Time_ShortYesterdayAt: String
    private let _Watch_Time_ShortYesterdayAt_r: [(Int, NSRange)]
    public func Watch_Time_ShortYesterdayAt(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Watch_Time_ShortYesterdayAt, self._Watch_Time_ShortYesterdayAt_r, [_0])
    }
    public let Contacts_InviteToTelegram: String
    private let _PINNED_DOC: String
    private let _PINNED_DOC_r: [(Int, NSRange)]
    public func PINNED_DOC(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_PINNED_DOC, self._PINNED_DOC_r, [_1])
    }
    private let _ConversationProfile_UserLeftChatError: String
    private let _ConversationProfile_UserLeftChatError_r: [(Int, NSRange)]
    public func ConversationProfile_UserLeftChatError(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_ConversationProfile_UserLeftChatError, self._ConversationProfile_UserLeftChatError_r, [_0])
    }
    public let ChatSettings_PrivateChats: String
    public let Settings_CallSettings: String
    public let Channel_EditAdmin_PermissionDeleteMessages: String
    public let Conversation_CloudStorageInfo_Title: String
    public let Channel_BanUser_PermissionSendStickersAndGifs: String
    public let Channel_AdminLog_Status: String
    public let Notification_RenamedChannel: String
    public let BlockedUsers_BlockUser: String
    public let ChatSettings_TextSize: String
    public let MediaPicker_AccessDeniedError: String
    public let ChannelInfo_DeleteGroup: String
    private let _BlockedUsers_BlockFormat: String
    private let _BlockedUsers_BlockFormat_r: [(Int, NSRange)]
    public func BlockedUsers_BlockFormat(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_BlockedUsers_BlockFormat, self._BlockedUsers_BlockFormat_r, [_0])
    }
    public let PhoneNumberHelp_Alert: String
    private let _PINNED_TEXT: String
    private let _PINNED_TEXT_r: [(Int, NSRange)]
    public func PINNED_TEXT(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_PINNED_TEXT, self._PINNED_TEXT_r, [_1, _2])
    }
    public let Watch_ChannelInfo_Title: String
    public let WebSearch_RecentSectionClear: String
    public let Channel_AdminLogFilter_AdminsAll: String
    public let StickerPack_AddStickers: String
    public let Channel_Setup_TypePrivate: String
    public let PhotoEditor_TintTool: String
    public let Watch_Suggestion_CantTalk: String
    public let PhotoEditor_QualityHigh: String
    private let _CHAT_MESSAGE_STICKER: String
    private let _CHAT_MESSAGE_STICKER_r: [(Int, NSRange)]
    public func CHAT_MESSAGE_STICKER(_ _1: String, _ _2: String, _ _3: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHAT_MESSAGE_STICKER, self._CHAT_MESSAGE_STICKER_r, [_1, _2, _3])
    }
    public let Map_ChooseAPlace: String
    public let Tour_Title7: String
    public let Watch_Bot_Restart: String
    public let StickerPack_ShareStickers: String
    public let ChannelMembers_AllMembersMayInvite: String
    public let Channel_About_Help: String
    public let Web_OpenExternal: String
    public let UserInfo_AddContact: String
    public let Call_EncryptionKey_Title: String
    public let PhotoEditor_BlurToolLinear: String
    public let AuthSessions_EmptyText: String
    public let Notification_MessageLifetime1m: String
    private let _Call_StatusBar: String
    private let _Call_StatusBar_r: [(Int, NSRange)]
    public func Call_StatusBar(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Call_StatusBar, self._Call_StatusBar_r, [_0])
    }
    public let Month_ShortJuly: String
    public let Watch_MessageView_ViewOnPhone: String
    public let CheckoutInfo_ShippingInfoAddress1Placeholder: String
    public let CallSettings_Never: String
    public let DialogList_SelectContacts: String
    public let Conversation_DownloadProgressMegabytes: String
    public let TwoStepAuth_EmailSent: String
    private let _Notification_PinnedAnimationMessage: String
    private let _Notification_PinnedAnimationMessage_r: [(Int, NSRange)]
    public func Notification_PinnedAnimationMessage(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_PinnedAnimationMessage, self._Notification_PinnedAnimationMessage_r, [_0])
    }
    public let TwoStepAuth_RecoveryTitle: String
    public let WatchRemote_AlertOpen: String
    public let ExplicitContent_AlertChannel: String
    public let TwoStepAuth_ConfirmationText: String
    public let Widget_AuthRequired: String
    private let _ForwardedAuthors2: String
    private let _ForwardedAuthors2_r: [(Int, NSRange)]
    public func ForwardedAuthors2(_ _0: String, _ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_ForwardedAuthors2, self._ForwardedAuthors2_r, [_0, _1])
    }
    public let ChannelInfo_DeleteGroupConfirmation: String
    public let Login_SmsRequestState3: String
    public let Notifications_AlertTones: String
    public let Calls_TabTitle: String
    public let Login_InfoAvatarPhoto: String
    public let Contacts_MemberSearchSectionTitleChannel: String
    public let PhotoEditor_CurvesTool: String
    public let Preview_LoadingVideo: String
    public let State_updating: String
    public let TwoStepAuth_ResetAccount: String
    public let Checkout_ShippingOption_Title: String
    public let Weekday_Tuesday: String
    public let Preview_Tooltip: String
    public let Conversation_EncryptionProcessing: String
    private let _CHAT_ADD_MEMBER: String
    private let _CHAT_ADD_MEMBER_r: [(Int, NSRange)]
    public func CHAT_ADD_MEMBER(_ _1: String, _ _2: String, _ _3: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHAT_ADD_MEMBER, self._CHAT_ADD_MEMBER_r, [_1, _2, _3])
    }
    public let Weekday_ShortSunday: String
    public let Month_ShortJune: String
    public let Month_GenApril: String
    public let StickerPacksSettings_ShowStickersButton: String
    public let MediaPicker_MomentsDateRangeSameMonthFormat: String
    public let CheckoutInfo_ShippingInfoTitle: String
    public let StickerPacksSettings_ShowStickersButtonHelp: String
    private let _Compatibility_SecretMediaVersionTooLow: String
    private let _Compatibility_SecretMediaVersionTooLow_r: [(Int, NSRange)]
    public func Compatibility_SecretMediaVersionTooLow(_ _0: String, _ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Compatibility_SecretMediaVersionTooLow, self._Compatibility_SecretMediaVersionTooLow_r, [_0, _1])
    }
    public let CallSettings_RecentCalls: String
    public let Conversation_Megabytes: String
    public let TwoStepAuth_FloodError: String
    public let Paint_Stickers: String
    public let Login_InvalidCountryCode: String
    public let Privacy_Calls_AlwaysAllow_Title: String
    public let Username_InvalidTooShort: String
    public let Weekday_ShortFriday: String
    public let Conversation_ClearAll: String
    public let MediaPicker_Moments: String
    public let Call_PhoneCallInProgressMessage: String
    public let SharedMedia_EmptyTitle: String
    public let Checkout_Name: String
    public let Preview_GroupPhotoTitle: String
    private let _AUTH_REGION: String
    private let _AUTH_REGION_r: [(Int, NSRange)]
    public func AUTH_REGION(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_AUTH_REGION, self._AUTH_REGION_r, [_1, _2])
    }
    public let Settings_NotificationsAndSounds: String
    private let _GroupInfo_InvitationLinkAcceptChannel: String
    private let _GroupInfo_InvitationLinkAcceptChannel_r: [(Int, NSRange)]
    public func GroupInfo_InvitationLinkAcceptChannel(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_GroupInfo_InvitationLinkAcceptChannel, self._GroupInfo_InvitationLinkAcceptChannel_r, [_0])
    }
    public let Conversation_EncryptionCanceled: String
    public let AccessDenied_SaveMedia: String
    public let Channel_Username_InvalidTooManyUsernames: String
    public let Compose_GroupTokenListPlaceholder: String
    public let Profile_ImageUploadError: String
    public let Conversation_MessageDeliveryFailed: String
    public let Privacy_PaymentsClear_PaymentInfo: String
    public let Notification_Mute1hMin: String
    public let Notifications_GroupNotifications: String
    public let CheckoutInfo_SaveInfoHelp: String
    public let StickerPacksSettings_ArchivedMasks_Info: String
    public let ChannelMembers_WhoCanAddMembers_AllMembers: String
    public let Channel_Edit_PrivatePublicLinkAlert: String
    public let Watch_Conversation_UserInfo: String
    public let Application_Name: String
    public let Conversation_AddToReadingList: String
    public let Conversation_FileDropbox: String
    public let Login_PhonePlaceholder: String
    public let ExplicitContent_AlertUser: String
    public let Profile_MessageLifetime1d: String
    public let Calls_CallTabDescription: String
    public let CheckoutInfo_ShippingInfoCityPlaceholder: String
    public let Resolve_ErrorNotFound: String
    public let PhotoEditor_FadeTool: String
    public let Channel_TitleShowDiscussion: String
    public let Channel_Setup_TypePublicHelp: String
    public let GroupInfo_InviteLink_RevokeAlert_Success: String
    public let Channel_Setup_PublicNoLink: String
    public let Conversation_Info: String
    public let ChannelInfo_InvitationLinkDoesNotExist: String
    private let _Time_TodayAt: String
    private let _Time_TodayAt_r: [(Int, NSRange)]
    public func Time_TodayAt(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Time_TodayAt, self._Time_TodayAt_r, [_0])
    }
    public let Conversation_Processing: String
    private let _InstantPage_AuthorAndDateTitle: String
    private let _InstantPage_AuthorAndDateTitle_r: [(Int, NSRange)]
    public func InstantPage_AuthorAndDateTitle(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_InstantPage_AuthorAndDateTitle, self._InstantPage_AuthorAndDateTitle_r, [_1, _2])
    }
    private let _Watch_LastSeen_AtDate: String
    private let _Watch_LastSeen_AtDate_r: [(Int, NSRange)]
    public func Watch_LastSeen_AtDate(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Watch_LastSeen_AtDate, self._Watch_LastSeen_AtDate_r, [_0])
    }
    public let Conversation_Location: String
    public let DialogList_PasscodeLockHelp: String
    public let Channel_Management_Title: String
    public let Notifications_InAppNotificationsPreview: String
    public let PrivacySettings_FloodControlError: String
    public let EnterPasscode_EnterTitle: String
    public let ReportPeer_ReasonOther_Title: String
    public let Month_GenJanuary: String
    public let Conversation_ForwardChats: String
    public let SharedMedia_TitlePhoto: String
    public let Channel_UpdatePhotoItem: String
    public let GroupInfo_InvitationLinkAlreadyAccepted: String
    public let UserInfo_StartSecretChat: String
    public let Watch_State_Connecting: String
    public let PrivacySettings_LastSeenNobody: String
    private let _FileSize_MB: String
    private let _FileSize_MB_r: [(Int, NSRange)]
    public func FileSize_MB(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_FileSize_MB, self._FileSize_MB_r, [_0])
    }
    public let ChatSearch_SearchPlaceholder: String
    public let TwoStepAuth_ConfirmationAbort: String
    public let GroupInfo_KickedStatus: String
    public let TwoStepAuth_SetupPasswordConfirmFailed: String
    private let _LastSeen_YesterdayAt: String
    private let _LastSeen_YesterdayAt_r: [(Int, NSRange)]
    public func LastSeen_YesterdayAt(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_LastSeen_YesterdayAt, self._LastSeen_YesterdayAt_r, [_0])
    }
    public let AppleWatch_ReplyPresetsHelp: String
    public let Localization_LanguageName: String
    public let Map_OpenIn: String
    public let Message_File: String
    private let _Channel_AdminLog_MessageChangedGroupUsername: String
    private let _Channel_AdminLog_MessageChangedGroupUsername_r: [(Int, NSRange)]
    public func Channel_AdminLog_MessageChangedGroupUsername(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Channel_AdminLog_MessageChangedGroupUsername, self._Channel_AdminLog_MessageChangedGroupUsername_r, [_0])
    }
    private let _CHAT_MESSAGE_GAME: String
    private let _CHAT_MESSAGE_GAME_r: [(Int, NSRange)]
    public func CHAT_MESSAGE_GAME(_ _1: String, _ _2: String, _ _3: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHAT_MESSAGE_GAME, self._CHAT_MESSAGE_GAME_r, [_1, _2, _3])
    }
    public let Month_ShortMay: String
    private let _WelcomeScreen_Greeting: String
    private let _WelcomeScreen_Greeting_r: [(Int, NSRange)]
    public func WelcomeScreen_Greeting(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_WelcomeScreen_Greeting, self._WelcomeScreen_Greeting_r, [_0])
    }
    public let Tour_Text3: String
    public let Contacts_GlobalSearch: String
    public let Watch_Suggestion_CallSoon: String
    public let DialogList_LanguageTooltip: String
    public let Map_LoadError: String
    public let WelcomeScreen_Logout: String
    private let _Service_ApplyLocalizationWithWarnings: String
    private let _Service_ApplyLocalizationWithWarnings_r: [(Int, NSRange)]
    public func Service_ApplyLocalizationWithWarnings(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Service_ApplyLocalizationWithWarnings, self._Service_ApplyLocalizationWithWarnings_r, [_0])
    }
    public let AccessDenied_VoiceMicrophone: String
    private let _CHANNEL_MESSAGE_STICKER: String
    private let _CHANNEL_MESSAGE_STICKER_r: [(Int, NSRange)]
    public func CHANNEL_MESSAGE_STICKER(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHANNEL_MESSAGE_STICKER, self._CHANNEL_MESSAGE_STICKER_r, [_1, _2])
    }
    public let PrivacySettings_Title: String
    public let PasscodeSettings_TurnPasscodeOff: String
    public let MediaPicker_AddCaption: String
    public let Channel_AdminLog_BanReadMessages: String
    public let SharedMedia_Outgoing: String
    public let Channel_About_Error: String
    public let Channel_Status: String
    public let Map_ChooseLocationTitle: String
    public let Map_OpenInYandexNavigator: String
    public let SearchImages_SkipImage: String
    public let State_WaitingForNetwork: String
    public let TwoStepAuth_EmailHelp: String
    public let PhotoEditor_SharpenTool: String
    public let Common_of: String
    public let AuthSessions_Title: String
    public let PrivacyLastSeenSettings_AlwaysShareWith: String
    public let EnterPasscode_EnterPasscode: String
    public let Notifications_Reset: String
    public let GroupInfo_InvitationLinkGroupFull: String
    private let _Channel_AdminLog_MessageChangedChannelUsername: String
    private let _Channel_AdminLog_MessageChangedChannelUsername_r: [(Int, NSRange)]
    public func Channel_AdminLog_MessageChangedChannelUsername(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Channel_AdminLog_MessageChangedChannelUsername, self._Channel_AdminLog_MessageChangedChannelUsername_r, [_0])
    }
    public let GoogleDrive_LogoutLogout: String
    private let _CHAT_MESSAGE_DOC: String
    private let _CHAT_MESSAGE_DOC_r: [(Int, NSRange)]
    public func CHAT_MESSAGE_DOC(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHAT_MESSAGE_DOC, self._CHAT_MESSAGE_DOC_r, [_1, _2])
    }
    public let Watch_AppName: String
    private let _Channel_NotificationSelfAdded: String
    private let _Channel_NotificationSelfAdded_r: [(Int, NSRange)]
    public func Channel_NotificationSelfAdded(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Channel_NotificationSelfAdded, self._Channel_NotificationSelfAdded_r, [_0])
    }
    public let ConvertToSupergroup_HelpTitle: String
    public let Conversation_TapAndHoldToRecord: String
    public let Channel_ShareNoLink: String
    private let _MESSAGE_GIF: String
    private let _MESSAGE_GIF_r: [(Int, NSRange)]
    public func MESSAGE_GIF(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_MESSAGE_GIF, self._MESSAGE_GIF_r, [_1])
    }
    private let _DialogList_EncryptedChatStartedOutgoing: String
    private let _DialogList_EncryptedChatStartedOutgoing_r: [(Int, NSRange)]
    public func DialogList_EncryptedChatStartedOutgoing(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_DialogList_EncryptedChatStartedOutgoing, self._DialogList_EncryptedChatStartedOutgoing_r, [_0])
    }
    public let Checkout_PayWithTouchId: String
    private let _Notification_InvitedMany: String
    private let _Notification_InvitedMany_r: [(Int, NSRange)]
    public func Notification_InvitedMany(_ _0: String, _ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_InvitedMany, self._Notification_InvitedMany_r, [_0, _1])
    }
    private let _CHAT_ADD_YOU: String
    private let _CHAT_ADD_YOU_r: [(Int, NSRange)]
    public func CHAT_ADD_YOU(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHAT_ADD_YOU, self._CHAT_ADD_YOU_r, [_1, _2])
    }
    public let CheckoutInfo_ShippingInfoCity: String
    public let Conversation_DiscardVoiceMessageTitle: String
    public let Conversation_ClousStorageInfo_Description3: String
    public let Profile_MessageLifetime: String
    public let GoogleDrive_LogoutTitle: String
    public let Conversation_PinMessageAlertGroup: String
    public let Settings_FAQ_Intro: String
    public let PrivacySettings_AuthSessions: String
    public let Tour_Title5: String
    public let ChatAdmins_AllMembersAreAdmins: String
    public let Group_Management_AddModeratorHelp: String
    public let Channel_Username_CheckingUsername: String
    public let Activity_UploadingAudio: String
    private let _DialogList_SingleRecordingVideoMessageSuffix: String
    private let _DialogList_SingleRecordingVideoMessageSuffix_r: [(Int, NSRange)]
    public func DialogList_SingleRecordingVideoMessageSuffix(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_DialogList_SingleRecordingVideoMessageSuffix, self._DialogList_SingleRecordingVideoMessageSuffix_r, [_0])
    }
    private let _Contacts_AccessDeniedHelpPortrait: String
    private let _Contacts_AccessDeniedHelpPortrait_r: [(Int, NSRange)]
    public func Contacts_AccessDeniedHelpPortrait(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Contacts_AccessDeniedHelpPortrait, self._Contacts_AccessDeniedHelpPortrait_r, [_0])
    }
    public let Channel_Info_BlackList: String
    private let _Checkout_LiabilityAlert: String
    private let _Checkout_LiabilityAlert_r: [(Int, NSRange)]
    public func Checkout_LiabilityAlert(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Checkout_LiabilityAlert, self._Checkout_LiabilityAlert_r, [_1, _1])
    }
    public let Profile_BotInfo: String
    public let StickerPack_RemoveStickers: String
    public let Compose_NewChannel_Members: String
    public let Notification_Reply: String
    public let Watch_Stickers_Recents: String
    public let GroupInfo_SetGroupPhotoStop: String
    public let Conversation_PinMessageAlertChannel: String
    public let AttachmentMenu_File: String
    private let _MESSAGE_STICKER: String
    private let _MESSAGE_STICKER_r: [(Int, NSRange)]
    public func MESSAGE_STICKER(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_MESSAGE_STICKER, self._MESSAGE_STICKER_r, [_1, _2])
    }
    public let Profile_MessageLifetime5s: String
    private let _PINNED_PHOTO: String
    private let _PINNED_PHOTO_r: [(Int, NSRange)]
    public func PINNED_PHOTO(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_PINNED_PHOTO, self._PINNED_PHOTO_r, [_1])
    }
    public let Channel_EditAdmin_PermissionChangeInviteLink: String
    public let Channel_AdminLog_CanAddAdmins: String
    public let WelcomeScreen_Title: String
    public let TwoStepAuth_SetupHint: String
    public let Conversation_StatusLeftGroup: String
    public let Conversation_ShareBotLocationConfirmation: String
    public let Conversation_DeleteMessagesForMe: String
    public let Message_PinnedAnimationMessage: String
    public let Checkout_ErrorPrecheckoutFailed: String
    public let Camera_PhotoMode: String
    public let Channel_About_Placeholder: String
    public let Channel_About_Title: String
    private let _MESSAGE_PHOTO: String
    private let _MESSAGE_PHOTO_r: [(Int, NSRange)]
    public func MESSAGE_PHOTO(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_MESSAGE_PHOTO, self._MESSAGE_PHOTO_r, [_1])
    }
    public let Calls_RatingTitle: String
    public let SharedMedia_EmptyText: String
    public let Channel_Username_CreateCommentsHelp: String
    public let Login_PadPhoneHelp: String
    public let StickerPacksSettings_ArchivedPacks: String
    public let Channel_ErrorAccessDenied: String
    public let Generic_ErrorMoreInfo: String
    public let Notification_GroupDeactivated: String
    public let Channel_AdminLog_TitleAllEvents: String
    public let PrivacySettings_TouchIdTitle: String
    public let ChannelMembers_WhoCanAddMembersAllHelp: String
    public let ChangePhoneNumberCode_CodePlaceholder: String
    public let Camera_SquareMode: String
    private let _Conversation_EncryptedPlaceholderTitleOutgoing: String
    private let _Conversation_EncryptedPlaceholderTitleOutgoing_r: [(Int, NSRange)]
    public func Conversation_EncryptedPlaceholderTitleOutgoing(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Conversation_EncryptedPlaceholderTitleOutgoing, self._Conversation_EncryptedPlaceholderTitleOutgoing_r, [_0])
    }
    public let NetworkUsageSettings_CallDataSection: String
    public let Login_PadPhoneHelpTitle: String
    public let Profile_CreateNewContact: String
    public let AccessDenied_VideoMessageMicrophone: String
    public let PhotoEditor_VignetteTool: String
    public let LastSeen_WithinAWeek: String
    public let Widget_NoUsers: String
    public let Channel_Edit_EnableComments: String
    public let DialogList_NoMessagesText: String
    private let _CHANNEL_MESSAGE_AUDIO: String
    private let _CHANNEL_MESSAGE_AUDIO_r: [(Int, NSRange)]
    public func CHANNEL_MESSAGE_AUDIO(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHANNEL_MESSAGE_AUDIO, self._CHANNEL_MESSAGE_AUDIO_r, [_1])
    }
    public let Calls_NewCall: String
    public let SharedMedia_TitleFile: String
    public let MaskStickerSettings_Info: String
    public let Conversation_FilePhotoOrVideo: String
    private let _Watch_LastSeen_AtWeekday: String
    private let _Watch_LastSeen_AtWeekday_r: [(Int, NSRange)]
    public func Watch_LastSeen_AtWeekday(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Watch_LastSeen_AtWeekday, self._Watch_LastSeen_AtWeekday_r, [_0])
    }
    public let Channel_AdminLog_BanSendStickers: String
    public let Common_Next: String
    public let Watch_Notification_Joined: String
    public let ImagePicker_NoVideos: String
    public let GroupInfo_DeleteAndExitConfirmation: String
    public let ChatSettings_Cache: String
    public let TwoStepAuth_EmailInvalid: String
    private let _CHAT_MESSAGE_VIDEO: String
    private let _CHAT_MESSAGE_VIDEO_r: [(Int, NSRange)]
    public func CHAT_MESSAGE_VIDEO(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHAT_MESSAGE_VIDEO, self._CHAT_MESSAGE_VIDEO_r, [_1, _2])
    }
    public let Month_GenJune: String
    private let _Login_EmailCodeSubject: String
    private let _Login_EmailCodeSubject_r: [(Int, NSRange)]
    public func Login_EmailCodeSubject(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Login_EmailCodeSubject, self._Login_EmailCodeSubject_r, [_0])
    }
    private let _CHAT_TITLE_EDITED: String
    private let _CHAT_TITLE_EDITED_r: [(Int, NSRange)]
    public func CHAT_TITLE_EDITED(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHAT_TITLE_EDITED, self._CHAT_TITLE_EDITED_r, [_1, _2])
    }
    public let Watch_UnlockRequired: String
    private let _NetworkUsageSettings_WifiUsageSince: String
    private let _NetworkUsageSettings_WifiUsageSince_r: [(Int, NSRange)]
    public func NetworkUsageSettings_WifiUsageSince(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_NetworkUsageSettings_WifiUsageSince, self._NetworkUsageSettings_WifiUsageSince_r, [_0])
    }
    public let Watch_LastSeen_Lately: String
    public let Watch_Compose_CurrentLocation: String
    private let _CHANNEL_MESSAGE_FWDS: String
    private let _CHANNEL_MESSAGE_FWDS_r: [(Int, NSRange)]
    public func CHANNEL_MESSAGE_FWDS(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHANNEL_MESSAGE_FWDS, self._CHANNEL_MESSAGE_FWDS_r, [_1, _2])
    }
    public let DialogList_RecentTitlePeople: String
    public let Conversation_ViewLocation: String
    public let GroupInfo_Notifications: String
    private let _MESSAGE_DOC: String
    private let _MESSAGE_DOC_r: [(Int, NSRange)]
    public func MESSAGE_DOC(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_MESSAGE_DOC, self._MESSAGE_DOC_r, [_1])
    }
    public let Group_Username_CreatePrivateLinkHelp: String
    public let Notifications_GroupNotificationsSound: String
    public let AuthSessions_EmptyTitle: String
    public let Privacy_GroupsAndChannels_AlwaysAllow_Title: String
    private let _MediaPicker_Nof: String
    private let _MediaPicker_Nof_r: [(Int, NSRange)]
    public func MediaPicker_Nof(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_MediaPicker_Nof, self._MediaPicker_Nof_r, [_0])
    }
    public let Common_Create: String
    public let Message_InvoiceShipmentLabel: String
    public let Contacts_TopSection: String
    public let Your_cards_number_is_invalid: String
    private let _MESSAGE_INVOICE: String
    private let _MESSAGE_INVOICE_r: [(Int, NSRange)]
    public func MESSAGE_INVOICE(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_MESSAGE_INVOICE, self._MESSAGE_INVOICE_r, [_1, _2])
    }
    private let _Channel_AdminLog_MessageRemovedChannelUsername: String
    private let _Channel_AdminLog_MessageRemovedChannelUsername_r: [(Int, NSRange)]
    public func Channel_AdminLog_MessageRemovedChannelUsername(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Channel_AdminLog_MessageRemovedChannelUsername, self._Channel_AdminLog_MessageRemovedChannelUsername_r, [_0])
    }
    public let Group_MessagePhotoRemoved: String
    public let UserInfo_AddToExisting: String
    private let _LastSeen_AtDate: String
    private let _LastSeen_AtDate_r: [(Int, NSRange)]
    public func LastSeen_AtDate(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_LastSeen_AtDate, self._LastSeen_AtDate_r, [_0])
    }
    public let Conversation_MessageDialogRetry: String
    public let Watch_ChatList_NoConversationsTitle: String
    public let BlockedUsers_Title: String
    public let MediaPicker_MomentsDateRangeYearFormat: String
    public let Cache_ClearNone: String
    public let Login_InvalidCodeError: String
    public let Contacts_contacts: String
    public let Channel_BanList_BlockedTitle: String
    public let NetworkUsageSettings_Cellular: String
    public let Watch_Location_Access: String
    private let _CONTACT_ACTIVATED: String
    private let _CONTACT_ACTIVATED_r: [(Int, NSRange)]
    public func CONTACT_ACTIVATED(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CONTACT_ACTIVATED, self._CONTACT_ACTIVATED_r, [_1])
    }
    public let BlockedUsers_AlreadyBlocked: String
    public let PrivacySettings_DeleteAccountIfAwayFor: String
    public let PrivacySettings_DeleteAccountTitle: String
    public let PrivacyLastSeenSettings_CustomShareSettings_Delete: String
    private let _ENCRYPTED_MESSAGE: String
    private let _ENCRYPTED_MESSAGE_r: [(Int, NSRange)]
    public func ENCRYPTED_MESSAGE(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_ENCRYPTED_MESSAGE, self._ENCRYPTED_MESSAGE_r, [_1])
    }
    public let Watch_LastSeen_WithinAMonth: String
    public let PrivacyLastSeenSettings_CustomHelp: String
    public let TwoStepAuth_EnterPasswordHelp: String
    public let Bot_Stop: String
    public let Privacy_GroupsAndChannels_AlwaysAllow_Placeholder: String
    private let _AUTH_UNKNOWN: String
    private let _AUTH_UNKNOWN_r: [(Int, NSRange)]
    public func AUTH_UNKNOWN(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_AUTH_UNKNOWN, self._AUTH_UNKNOWN_r, [_1])
    }
    public let UserInfo_BotSettings: String
    public let Your_cards_expiration_month_is_invalid: String
    public let PrivacyLastSeenSettings_EmpryUsersPlaceholder: String
    private let _CHANNEL_MESSAGE_ROUND: String
    private let _CHANNEL_MESSAGE_ROUND_r: [(Int, NSRange)]
    public func CHANNEL_MESSAGE_ROUND(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHANNEL_MESSAGE_ROUND, self._CHANNEL_MESSAGE_ROUND_r, [_1])
    }
    public let GoogleDrive_FolderLoadError: String
    public let Message_VideoMessage: String
    public let Conversation_ContextMenuStickerPackInfo: String
    public let Login_ResetAccountProtected_LimitExceeded: String
    public let Watch_Suggestion_TextInABit: String
    private let _CHAT_DELETE_MEMBER: String
    private let _CHAT_DELETE_MEMBER_r: [(Int, NSRange)]
    public func CHAT_DELETE_MEMBER(_ _1: String, _ _2: String, _ _3: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHAT_DELETE_MEMBER, self._CHAT_DELETE_MEMBER_r, [_1, _2, _3])
    }
    public let Conversation_EncryptedForwardingAlert: String
    public let Conversation_DiscardVoiceMessageAction: String
    public let PhotoEditor_CurvesBlue: String
    public let Message_PinnedVideoMessage: String
    private let _Settings_OpenSystemPrivacySettings: String
    private let _Settings_OpenSystemPrivacySettings_r: [(Int, NSRange)]
    public func Settings_OpenSystemPrivacySettings(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Settings_OpenSystemPrivacySettings, self._Settings_OpenSystemPrivacySettings_r, [_0])
    }
    private let _Login_EmailPhoneSubject: String
    private let _Login_EmailPhoneSubject_r: [(Int, NSRange)]
    public func Login_EmailPhoneSubject(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Login_EmailPhoneSubject, self._Login_EmailPhoneSubject_r, [_0])
    }
    public let Group_EditAdmin_PermissionChangeInfo: String
    public let TwoStepAuth_Email: String
    public let Map_SendMyCurrentLocation: String
    private let _MESSAGE_ROUND: String
    private let _MESSAGE_ROUND_r: [(Int, NSRange)]
    public func MESSAGE_ROUND(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_MESSAGE_ROUND, self._MESSAGE_ROUND_r, [_1])
    }
    public let Map_Unknown: String
    public let Wallpaper_Set: String
    public let SharedMedia_CategoryLinks: String
    public let AccessDenied_Title: String
    public let Conversation_ClearAllConfirmation: String
    public let TwoStepAuth_EmailSkipAlert: String
    public let ChatSettings_Stickers: String
    public let Camera_FlashOff: String
    public let TwoStepAuth_Title: String
    public let TwoStepAuth_SetupPasswordEnterPasswordChange: String
    public let WebSearch_Images: String
    public let Checkout_ErrorProviderAccountTimeout: String
    public let Conversation_typing: String
    public let Common_Back: String
    public let Common_Search: String
    private let _CancelResetAccount_Success: String
    private let _CancelResetAccount_Success_r: [(Int, NSRange)]
    public func CancelResetAccount_Success(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CancelResetAccount_Success, self._CancelResetAccount_Success_r, [_0])
    }
    public let Common_No: String
    public let Login_EmailNotConfiguredError: String
    public let Watch_Suggestion_OK: String
    public let Profile_AddToExisting: String
    private let _PINNED_NOTEXT: String
    private let _PINNED_NOTEXT_r: [(Int, NSRange)]
    public func PINNED_NOTEXT(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_PINNED_NOTEXT, self._PINNED_NOTEXT_r, [_1])
    }
    private let _Login_EmailCodeBody: String
    private let _Login_EmailCodeBody_r: [(Int, NSRange)]
    public func Login_EmailCodeBody(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Login_EmailCodeBody, self._Login_EmailCodeBody_r, [_0])
    }
    public let Profile_About: String
    private let _EncryptionKey_Description: String
    private let _EncryptionKey_Description_r: [(Int, NSRange)]
    public func EncryptionKey_Description(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_EncryptionKey_Description, self._EncryptionKey_Description_r, [_1, _2])
    }
    public let Conversation_UnreadMessages: String
    public let Tour_Title3: String
    public let PrivacyLastSeenSettings_GroupsAndChannelsHelp: String
    public let Watch_Contacts_NoResults: String
    public let Watch_UserInfo_MuteTitle: String
    public let MediaPicker_Choose: String
    public let Conversation_DownloadMegabytes: String
    private let _Privacy_GroupsAndChannels_InviteToGroupError: String
    private let _Privacy_GroupsAndChannels_InviteToGroupError_r: [(Int, NSRange)]
    public func Privacy_GroupsAndChannels_InviteToGroupError(_ _0: String, _ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Privacy_GroupsAndChannels_InviteToGroupError, self._Privacy_GroupsAndChannels_InviteToGroupError_r, [_0, _1])
    }
    private let _Message_PinnedTextMessage: String
    private let _Message_PinnedTextMessage_r: [(Int, NSRange)]
    public func Message_PinnedTextMessage(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Message_PinnedTextMessage, self._Message_PinnedTextMessage_r, [_0])
    }
    private let _Watch_Time_ShortWeekdayAt: String
    private let _Watch_Time_ShortWeekdayAt_r: [(Int, NSRange)]
    public func Watch_Time_ShortWeekdayAt(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Watch_Time_ShortWeekdayAt, self._Watch_Time_ShortWeekdayAt_r, [_1, _2])
    }
    public let DialogList_Typing: String
    public let Notification_CallBack: String
    public let Map_LocatingError: String
    public let MediaPicker_Send: String
    public let ChannelIntro_Title: String
    public let SearchImages_ErrorDownloadingImage: String
    private let _PINNED_GIF: String
    private let _PINNED_GIF_r: [(Int, NSRange)]
    public func PINNED_GIF(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_PINNED_GIF, self._PINNED_GIF_r, [_1])
    }
    public let Profile_PhonebookAccessDisabled: String
    public let LoginPassword_PasswordHelp: String
    public let BlockedUsers_Unblock: String
    public let Conversation_ViewFile: String
    public let Notifications_GroupNotificationsAlert: String
    public let Paint_Masks: String
    public let StickerPack_ErrorNotFound: String
    private let _PINNED_CONTACT: String
    private let _PINNED_CONTACT_r: [(Int, NSRange)]
    public func PINNED_CONTACT(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_PINNED_CONTACT, self._PINNED_CONTACT_r, [_1])
    }
    private let _Conversation_ForwardToGroupFormat: String
    private let _Conversation_ForwardToGroupFormat_r: [(Int, NSRange)]
    public func Conversation_ForwardToGroupFormat(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Conversation_ForwardToGroupFormat, self._Conversation_ForwardToGroupFormat_r, [_0])
    }
    private let _FileSize_KB: String
    private let _FileSize_KB_r: [(Int, NSRange)]
    public func FileSize_KB(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_FileSize_KB, self._FileSize_KB_r, [_0])
    }
    public let Watch_GroupInfo_Title: String
    public let PhotoEditor_Set: String
    private let _Notification_Invited: String
    private let _Notification_Invited_r: [(Int, NSRange)]
    public func Notification_Invited(_ _0: String, _ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_Invited, self._Notification_Invited_r, [_0, _1])
    }
    public let Watch_AuthRequired: String
    public let Conversation_EncryptedDescription1: String
    public let AppleWatch_ReplyPresets: String
    public let Conversation_EncryptedDescription2: String
    public let NetworkUsageSettings_MediaVideoDataSection: String
    public let Paint_Edit: String
    public let Conversation_EncryptedDescription3: String
    public let Login_CodeFloodError: String
    private let _Call_EncryptionKey_Description: String
    private let _Call_EncryptionKey_Description_r: [(Int, NSRange)]
    public func Call_EncryptionKey_Description(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Call_EncryptionKey_Description, self._Call_EncryptionKey_Description_r, [_1, _2])
    }
    public let Conversation_EncryptedDescription4: String
    public let AppleWatch_Title: String
    public let Conversation_StatusTyping: String
    public let Contacts_AccessDeniedError: String
    public let GoogleDrive_LoadErrorTitle: String
    public let Share_Title: String
    public let Map_Send: String
    public let TwoStepAuth_ConfirmationTitle: String
    public let Conversation_SupportPlaceholder: String
    public let ChatSettings_Title: String
    public let AuthSessions_CurrentSession: String
    public let Watch_Microphone_Access: String
    private let _Notification_RenamedChat: String
    private let _Notification_RenamedChat_r: [(Int, NSRange)]
    public func Notification_RenamedChat(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_RenamedChat, self._Notification_RenamedChat_r, [_0])
    }
    public let Watch_Conversation_GroupInfo: String
    public let UserInfo_Title: String
    public let Service_LocalizationDownloadError: String
    public let Login_InfoHelp: String
    public let ShareMenu_ShareTo: String
    public let Message_PinnedGame: String
    public let Channel_AdminLog_CanSendMessages: String
    public let Notification_RenamedGroup: String
    public let Weekday_Thursday: String
    private let _Call_PrivacyErrorMessage: String
    private let _Call_PrivacyErrorMessage_r: [(Int, NSRange)]
    public func Call_PrivacyErrorMessage(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Call_PrivacyErrorMessage, self._Call_PrivacyErrorMessage_r, [_0])
    }
    public let ChangePhoneNumberNumber_Title: String
    public let TwoStepAuth_EnterPasswordInvalid: String
    public let DialogList_SearchSectionMessages: String
    private let _Profile_ShareBotGroupFormat: String
    private let _Profile_ShareBotGroupFormat_r: [(Int, NSRange)]
    public func Profile_ShareBotGroupFormat(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Profile_ShareBotGroupFormat, self._Profile_ShareBotGroupFormat_r, [_0])
    }
    public let Preview_DeleteGif: String
    public let Weekday_Saturday: String
    public let UserInfo_DeleteContact: String
    public let Notifications_ResetAllNotifications: String
    public let Notification_MessageLifetimeRemovedOutgoing: String
    public let Map_More: String
    public let Login_ContinueWithLocalization: String
    public let GroupInfo_AddParticipant: String
    public let Watch_Location_Current: String
    public let Map_MapTitle: String
    public let Checkout_NewCard_SaveInfoHelp: String
    public let MediaPicker_CameraRoll: String
    private let _TwoStepAuth_RecoverySent: String
    private let _TwoStepAuth_RecoverySent_r: [(Int, NSRange)]
    public func TwoStepAuth_RecoverySent(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_TwoStepAuth_RecoverySent, self._TwoStepAuth_RecoverySent_r, [_0])
    }
    public let Channel_AdminLog_CanPinMessages: String
    public let KeyCommand_NewMessage: String
    public let Compose_NewBroadcastButton: String
    public let NetworkUsageSettings_TotalSection: String
    private let _PINNED_AUDIO: String
    private let _PINNED_AUDIO_r: [(Int, NSRange)]
    public func PINNED_AUDIO(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_PINNED_AUDIO, self._PINNED_AUDIO_r, [_1])
    }
    public let Privacy_GroupsAndChannels: String
    public let Conversation_DiscardVoiceMessageDescription: String
    private let _Notification_ChangedGroupPhoto: String
    private let _Notification_ChangedGroupPhoto_r: [(Int, NSRange)]
    public func Notification_ChangedGroupPhoto(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_ChangedGroupPhoto, self._Notification_ChangedGroupPhoto_r, [_0])
    }
    public let TwoStepAuth_RemovePassword: String
    public let Privacy_GroupsAndChannels_CustomHelp: String
    public let Notification_GroupMigratedToChannel: String
    public let UserInfo_NotificationsDisable: String
    public let Watch_UserInfo_Service: String
    public let Privacy_Calls_CustomHelp: String
    public let ChangePhoneNumberCode_Code: String
    public let UserInfo_Invite: String
    public let CheckoutInfo_ErrorStateInvalid: String
    public let DialogList_ClearHistoryConfirmation: String
    public let CheckoutInfo_ErrorEmailInvalid: String
    public let Month_GenNovember: String
    public let PhotoEditor_TintIntensity: String
    public let UserInfo_NotificationsEnable: String
    private let _Target_InviteToGroupConfirmation: String
    private let _Target_InviteToGroupConfirmation_r: [(Int, NSRange)]
    public func Target_InviteToGroupConfirmation(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Target_InviteToGroupConfirmation, self._Target_InviteToGroupConfirmation_r, [_0])
    }
    public let Map_Map: String
    public let Map_OpenInMaps: String
    public let Common_OK: String
    public let TwoStepAuth_SetupHintTitle: String
    public let Watch_Suggestion_Nope: String
    public let GroupInfo_LeftStatus: String
    public let Cache_ClearProgress: String
    public let Login_InvalidPhoneError: String
    public let Cache_ClearEmpty: String
    public let Map_Search: String
    public let ChannelMembers_GroupAdminsTitle: String
    private let _Channel_AdminLog_MessageRemovedGroupUsername: String
    private let _Channel_AdminLog_MessageRemovedGroupUsername_r: [(Int, NSRange)]
    public func Channel_AdminLog_MessageRemovedGroupUsername(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Channel_AdminLog_MessageRemovedGroupUsername, self._Channel_AdminLog_MessageRemovedGroupUsername_r, [_0])
    }
    public let ChatSettings_AutomaticPhotoDownload: String
    public let Update_Update: String
    public let Group_ErrorAddTooMuchAdmins: String
    public let Login_SelectCountry_Title: String
    public let Notification_EncryptedChatAccepted: String
    public let Notifications_GroupNotificationsHelp: String
    public let PhotoEditor_CropAspectRatioSquare: String
    public let Notification_CallOutgoing: String
    public let Weekday_ShortMonday: String
    public let Channel_Edit_AboutItem: String
    public let Checkout_Receipt_Title: String
    public let Login_InfoLastNamePlaceholder: String
    public let Contacts_InvitationText: String
    public let Channel_Members_AddMembersHelp: String
    public let ReportPeer_Report: String
    public let Channel_EditMessageErrorGeneric: String
    public let LoginPassword_FloodError: String
    public let EncryptionKey_TapToEmojify: String
    public let Conversation_InfoChannel: String
    public let TwoStepAuth_SetupPasswordTitle: String
    public let PhotoEditor_DiscardChanges: String
    public let Group_UpgradeNoticeText2: String
    private let _PINNED_ROUND: String
    private let _PINNED_ROUND_r: [(Int, NSRange)]
    public func PINNED_ROUND(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_PINNED_ROUND, self._PINNED_ROUND_r, [_1])
    }
    private let _ChannelInfo_ChannelForbidden: String
    private let _ChannelInfo_ChannelForbidden_r: [(Int, NSRange)]
    public func ChannelInfo_ChannelForbidden(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_ChannelInfo_ChannelForbidden, self._ChannelInfo_ChannelForbidden_r, [_0])
    }
    public let Conversation_ShareMyContactInfo: String
    private let _Profile_ShareContactPersonFormat: String
    private let _Profile_ShareContactPersonFormat_r: [(Int, NSRange)]
    public func Profile_ShareContactPersonFormat(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Profile_ShareContactPersonFormat, self._Profile_ShareContactPersonFormat_r, [_0])
    }
    private let _CHANNEL_MESSAGE_GEO: String
    private let _CHANNEL_MESSAGE_GEO_r: [(Int, NSRange)]
    public func CHANNEL_MESSAGE_GEO(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHANNEL_MESSAGE_GEO, self._CHANNEL_MESSAGE_GEO_r, [_1])
    }
    public let Group_Info_AdminLog: String
    public let StickerPacksSettings_FeaturedPacks: String
    public let Month_GenAugust: String
    public let Channel_Username_CreatePublicLinkHelp: String
    public let StickerPack_Send: String
    public let Watch_Suggestion_HoldOn: String
    public let StickerSettings_MaskContextInfo: String
    public let AttachmentMenu_ImageSearch: String
    private let _PINNED_GEO: String
    private let _PINNED_GEO_r: [(Int, NSRange)]
    public func PINNED_GEO(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_PINNED_GEO, self._PINNED_GEO_r, [_1])
    }
    public let PasscodeSettings_EncryptData: String
    public let Notification_CallCanceled: String
    public let Common_NotNow: String
    public let PasscodeSettings_Title: String
    public let StickerPack_BuiltinPackName: String
    public let Watch_Suggestion_BRB: String
    public let Login_CodeTitle: String
    private let _CHAT_MESSAGE_ROUND: String
    private let _CHAT_MESSAGE_ROUND_r: [(Int, NSRange)]
    public func CHAT_MESSAGE_ROUND(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHAT_MESSAGE_ROUND, self._CHAT_MESSAGE_ROUND_r, [_1, _2])
    }
    public let Notifications_MessageNotificationsAlert: String
    public let Username_InvalidCharacters: String
    public let GroupInfo_LabelAdmin: String
    public let GroupInfo_Sound: String
    public let Channel_EditAdmin_PermissionBanUsers: String
    public let Wallpaper_PhotoLibrary: String
    public let Settings_About: String
    private let _CHAT_LEFT: String
    private let _CHAT_LEFT_r: [(Int, NSRange)]
    public func CHAT_LEFT(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHAT_LEFT, self._CHAT_LEFT_r, [_1, _2])
    }
    public let LoginPassword_ForgotPassword: String
    private let _DialogList_AwaitingEncryption: String
    private let _DialogList_AwaitingEncryption_r: [(Int, NSRange)]
    public func DialogList_AwaitingEncryption(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_DialogList_AwaitingEncryption, self._DialogList_AwaitingEncryption_r, [_0])
    }
    public let ChatSettings_Appearance: String
    public let Tour_Title1: String
    private let _Notification_ChangedUserPhoto: String
    private let _Notification_ChangedUserPhoto_r: [(Int, NSRange)]
    public func Notification_ChangedUserPhoto(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_ChangedUserPhoto, self._Notification_ChangedUserPhoto_r, [_0])
    }
    public let Conversation_LinkDialogCopy: String
    private let _Notification_PinnedLocationMessage: String
    private let _Notification_PinnedLocationMessage_r: [(Int, NSRange)]
    public func Notification_PinnedLocationMessage(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_PinnedLocationMessage, self._Notification_PinnedLocationMessage_r, [_0])
    }
    private let _Notification_PinnedPhotoMessage: String
    private let _Notification_PinnedPhotoMessage_r: [(Int, NSRange)]
    public func Notification_PinnedPhotoMessage(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_PinnedPhotoMessage, self._Notification_PinnedPhotoMessage_r, [_0])
    }
    private let _DownloadingStatus: String
    private let _DownloadingStatus_r: [(Int, NSRange)]
    public func DownloadingStatus(_ _0: String, _ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_DownloadingStatus, self._DownloadingStatus_r, [_0, _1])
    }
    public let Calls_All: String
    private let _Channel_MessageTitleUpdated: String
    private let _Channel_MessageTitleUpdated_r: [(Int, NSRange)]
    public func Channel_MessageTitleUpdated(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Channel_MessageTitleUpdated, self._Channel_MessageTitleUpdated_r, [_0])
    }
    public let Call_CallAgain: String
    public let TwoStepAuth_RecoveryCodeHelp: String
    public let UserInfo_SendMessage: String
    private let _Channel_Username_LinkHint: String
    private let _Channel_Username_LinkHint_r: [(Int, NSRange)]
    public func Channel_Username_LinkHint(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Channel_Username_LinkHint, self._Channel_Username_LinkHint_r, [_0])
    }
    public let Paint_RecentStickers: String
    public let Login_CallRequestState3: String
    public let Channel_Edit_LinkItem: String
    public let CallSettings_Title: String
    public let ChangePhoneNumberNumber_Help: String
    public let Watch_Suggestion_Thanks: String
    public let Channel_Moderator_Title: String
    public let Message_PinnedPhotoMessage: String
    public let Notification_SecretChatScreenshot: String
    private let _Conversation_DeleteMessagesFor: String
    private let _Conversation_DeleteMessagesFor_r: [(Int, NSRange)]
    public func Conversation_DeleteMessagesFor(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Conversation_DeleteMessagesFor, self._Conversation_DeleteMessagesFor_r, [_0])
    }
    public let Activity_UploadingDocument: String
    public let Watch_ChatList_NoConversationsText: String
    public let ReportPeer_AlertSuccess: String
    public let Tour_Text4: String
    public let Channel_Info_Description: String
    public let AccessDenied_LocationTracking: String
    public let MessageTimer_Title: String
    public let Watch_Compose_Send: String
    public let Preview_CopyAddress: String
    public let Settings_BlockedUsers: String
    public let Month_ShortAugust: String
    public let Channel_AdminLogFilter_AdminsTitle: String
    public let Channel_EditAdmin_PermissionChangeInfo: String
    public let Notifications_ResetAllNotificationsHelp: String
    public let DialogList_EncryptionRejected: String
    public let AccessDenied_CameraRestricted: String
    public let Target_InviteToGroupErrorAlreadyInvited: String
    public let Watch_Message_ForwardedFrom: String
    public let Channel_AboutItem: String
    public let PhotoEditor_CurvesGreen: String
    public let CheckoutInfo_ShippingInfoCountryPlaceholder: String
    public let Month_GenJuly: String
    public let Conversation_DeleteChat: String
    private let _DialogList_SingleUploadingFileSuffix: String
    private let _DialogList_SingleUploadingFileSuffix_r: [(Int, NSRange)]
    public func DialogList_SingleUploadingFileSuffix(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_DialogList_SingleUploadingFileSuffix, self._DialogList_SingleUploadingFileSuffix_r, [_0])
    }
    public let ChannelIntro_CreateChannel: String
    public let WelcomeScreen_ContactsAccessDisabled: String
    public let Channel_Management_AddModerator: String
    public let Common_ChoosePhoto: String
    public let Group_Username_Help: String
    public let Conversation_Pin: String
    public let Channel_AdminLog_CanStartCalls: String
    private let _Login_ResetAccountProtected_Text: String
    private let _Login_ResetAccountProtected_Text_r: [(Int, NSRange)]
    public func Login_ResetAccountProtected_Text(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Login_ResetAccountProtected_Text, self._Login_ResetAccountProtected_Text_r, [_0])
    }
    public let Camera_TapAndHoldForVideo: String
    public let Bot_DescriptionTitle: String
    public let FeaturedStickerPacks_Title: String
    public let Map_OpenInGoogleMaps: String
    public let Notification_MessageLifetime5s: String
    public let EnterPasscode_SetupTitle: String
    public let Contacts_Title: String
    public let Channel_Management_AddModeratorHelp: String
    private let _CHAT_MESSAGE_FWDS: String
    private let _CHAT_MESSAGE_FWDS_r: [(Int, NSRange)]
    public func CHAT_MESSAGE_FWDS(_ _1: String, _ _2: String, _ _3: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHAT_MESSAGE_FWDS, self._CHAT_MESSAGE_FWDS_r, [_1, _2, _3])
    }
    public let WelcomeScreen_UpdatingTitle: String
    private let _Login_CodeHelp: String
    private let _Login_CodeHelp_r: [(Int, NSRange)]
    public func Login_CodeHelp(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Login_CodeHelp, self._Login_CodeHelp_r, [_0])
    }
    public let Conversation_MessageDialogEdit: String
    public let PrivacyLastSeenSettings_Title: String
    public let Notifications_ClassicTones: String
    public let GoogleDrive_Title: String
    public let Conversation_LinkDialogOpen: String
    public let Conversation_ClousStorageInfo_Description4: String
    public let Privacy_Calls_AlwaysAllow: String
    public let Privacy_PaymentsClearInfoHelp: String
    public let Notification_MessageLifetime1h: String
    private let _Notification_CreatedChatWithTitle: String
    private let _Notification_CreatedChatWithTitle_r: [(Int, NSRange)]
    public func Notification_CreatedChatWithTitle(_ _0: String, _ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Notification_CreatedChatWithTitle, self._Notification_CreatedChatWithTitle_r, [_0, _1])
    }
    public let CheckoutInfo_ReceiverInfoEmail: String
    public let LastSeen_Lately: String
    public let Month_ShortApril: String
    public let ConversationProfile_ErrorCreatingConversation: String
    private let _PHONE_CALL_MISSED: String
    private let _PHONE_CALL_MISSED_r: [(Int, NSRange)]
    public func PHONE_CALL_MISSED(_ _1: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_PHONE_CALL_MISSED, self._PHONE_CALL_MISSED_r, [_1])
    }
    public let Map_AccessDeniedError: String
    private let _Conversation_Kilobytes: String
    private let _Conversation_Kilobytes_r: [(Int, NSRange)]
    public func Conversation_Kilobytes(_ _0: Int) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Conversation_Kilobytes, self._Conversation_Kilobytes_r, ["\(_0)"])
    }
    public let Group_ErrorAddBlocked: String
    public let MediaPicker_Videos: String
    public let BlockedUsers_AddNew: String
    public let StickerPacksSettings_StickerPacksSection: String
    public let Channel_NotificationLoading: String
    private let _CHAT_RETURNED: String
    private let _CHAT_RETURNED_r: [(Int, NSRange)]
    public func CHAT_RETURNED(_ _1: String, _ _2: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_CHAT_RETURNED, self._CHAT_RETURNED_r, [_1, _2])
    }
    public let PhotoEditor_ShadowsTint: String
    public let ExplicitContent_AlertTitle: String
    public let Channel_AdminLogFilter_EventsLeaving: String
    public let StickerPack_HideStickers: String
    private let _Group_MessageTitleUpdated: String
    private let _Group_MessageTitleUpdated_r: [(Int, NSRange)]
    public func Group_MessageTitleUpdated(_ _0: String) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Group_MessageTitleUpdated, self._Group_MessageTitleUpdated_r, [_0])
    }
    public let Checkout_EnterPassword: String
    public let UserInfo_NotificationsEnabled: String
    public let Weekday_ShortTuesday: String
    public let Notification_CallIncomingShort: String
    public let ConvertToSupergroup_Note: String
    public let Conversation_EmptyPlaceholder: String
    public let Conversation_BroadcastTitle: String
    public let Username_Help: String
    public let StickerSettings_ContextHide: String
    public let Weekday_Sunday: String
    public let Preview_LoadingImage: String
    private let _Conversation_DownloadProgressKilobytes: String
    private let _Conversation_DownloadProgressKilobytes_r: [(Int, NSRange)]
    public func Conversation_DownloadProgressKilobytes(_ _1: Int, _ _2: Int) -> (String, [(Int, NSRange)]) {
        return formatWithArgumentRanges(_Conversation_DownloadProgressKilobytes, self._Conversation_DownloadProgressKilobytes_r, ["\(_1)", "\(_2)"])
    }
    public let Settings_ChatBackground: String
    private let _MessageTimer_Seconds_zero: String
    private let _MessageTimer_Seconds_one: String
    private let _MessageTimer_Seconds_two: String
    private let _MessageTimer_Seconds_few: String
    private let _MessageTimer_Seconds_many: String
    private let _MessageTimer_Seconds_other: String
    public func MessageTimer_Seconds(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._MessageTimer_Seconds_zero, "\(value)")
            case .one:
                return String(format: self._MessageTimer_Seconds_one, "\(value)")
            case .two:
                return String(format: self._MessageTimer_Seconds_two, "\(value)")
            case .few:
                return String(format: self._MessageTimer_Seconds_few, "\(value)")
            case .many:
                return String(format: self._MessageTimer_Seconds_many, "\(value)")
            case .other:
                return String(format: self._MessageTimer_Seconds_other, "\(value)")
        }
    }
    private let _Call_Seconds_zero: String
    private let _Call_Seconds_one: String
    private let _Call_Seconds_two: String
    private let _Call_Seconds_few: String
    private let _Call_Seconds_many: String
    private let _Call_Seconds_other: String
    public func Call_Seconds(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._Call_Seconds_zero, "\(value)")
            case .one:
                return String(format: self._Call_Seconds_one, "\(value)")
            case .two:
                return String(format: self._Call_Seconds_two, "\(value)")
            case .few:
                return String(format: self._Call_Seconds_few, "\(value)")
            case .many:
                return String(format: self._Call_Seconds_many, "\(value)")
            case .other:
                return String(format: self._Call_Seconds_other, "\(value)")
        }
    }
    private let _MessageTimer_ShortSeconds_zero: String
    private let _MessageTimer_ShortSeconds_one: String
    private let _MessageTimer_ShortSeconds_two: String
    private let _MessageTimer_ShortSeconds_few: String
    private let _MessageTimer_ShortSeconds_many: String
    private let _MessageTimer_ShortSeconds_other: String
    public func MessageTimer_ShortSeconds(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._MessageTimer_ShortSeconds_zero, "\(value)")
            case .one:
                return String(format: self._MessageTimer_ShortSeconds_one, "\(value)")
            case .two:
                return String(format: self._MessageTimer_ShortSeconds_two, "\(value)")
            case .few:
                return String(format: self._MessageTimer_ShortSeconds_few, "\(value)")
            case .many:
                return String(format: self._MessageTimer_ShortSeconds_many, "\(value)")
            case .other:
                return String(format: self._MessageTimer_ShortSeconds_other, "\(value)")
        }
    }
    private let _Notification_GameScoreSimple_zero: String
    private let _Notification_GameScoreSimple_one: String
    private let _Notification_GameScoreSimple_two: String
    private let _Notification_GameScoreSimple_few: String
    private let _Notification_GameScoreSimple_many: String
    private let _Notification_GameScoreSimple_other: String
    public func Notification_GameScoreSimple(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._Notification_GameScoreSimple_zero, "\(value)")
            case .one:
                return String(format: self._Notification_GameScoreSimple_one, "\(value)")
            case .two:
                return String(format: self._Notification_GameScoreSimple_two, "\(value)")
            case .few:
                return String(format: self._Notification_GameScoreSimple_few, "\(value)")
            case .many:
                return String(format: self._Notification_GameScoreSimple_many, "\(value)")
            case .other:
                return String(format: self._Notification_GameScoreSimple_other, "\(value)")
        }
    }
    private let _Notification_GameScoreExtended_zero: String
    private let _Notification_GameScoreExtended_one: String
    private let _Notification_GameScoreExtended_two: String
    private let _Notification_GameScoreExtended_few: String
    private let _Notification_GameScoreExtended_many: String
    private let _Notification_GameScoreExtended_other: String
    public func Notification_GameScoreExtended(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._Notification_GameScoreExtended_zero, "\(value)")
            case .one:
                return String(format: self._Notification_GameScoreExtended_one, "\(value)")
            case .two:
                return String(format: self._Notification_GameScoreExtended_two, "\(value)")
            case .few:
                return String(format: self._Notification_GameScoreExtended_few, "\(value)")
            case .many:
                return String(format: self._Notification_GameScoreExtended_many, "\(value)")
            case .other:
                return String(format: self._Notification_GameScoreExtended_other, "\(value)")
        }
    }
    private let _PasscodeSettings_FailedAttempts_zero: String
    private let _PasscodeSettings_FailedAttempts_one: String
    private let _PasscodeSettings_FailedAttempts_two: String
    private let _PasscodeSettings_FailedAttempts_few: String
    private let _PasscodeSettings_FailedAttempts_many: String
    private let _PasscodeSettings_FailedAttempts_other: String
    public func PasscodeSettings_FailedAttempts(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._PasscodeSettings_FailedAttempts_zero, "\(value)")
            case .one:
                return String(format: self._PasscodeSettings_FailedAttempts_one, "\(value)")
            case .two:
                return String(format: self._PasscodeSettings_FailedAttempts_two, "\(value)")
            case .few:
                return String(format: self._PasscodeSettings_FailedAttempts_few, "\(value)")
            case .many:
                return String(format: self._PasscodeSettings_FailedAttempts_many, "\(value)")
            case .other:
                return String(format: self._PasscodeSettings_FailedAttempts_other, "\(value)")
        }
    }
    private let _MuteFor_Hours_zero: String
    private let _MuteFor_Hours_one: String
    private let _MuteFor_Hours_two: String
    private let _MuteFor_Hours_few: String
    private let _MuteFor_Hours_many: String
    private let _MuteFor_Hours_other: String
    public func MuteFor_Hours(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._MuteFor_Hours_zero, "\(value)")
            case .one:
                return String(format: self._MuteFor_Hours_one, "\(value)")
            case .two:
                return String(format: self._MuteFor_Hours_two, "\(value)")
            case .few:
                return String(format: self._MuteFor_Hours_few, "\(value)")
            case .many:
                return String(format: self._MuteFor_Hours_many, "\(value)")
            case .other:
                return String(format: self._MuteFor_Hours_other, "\(value)")
        }
    }
    private let _MessageTimer_ShortMinutes_zero: String
    private let _MessageTimer_ShortMinutes_one: String
    private let _MessageTimer_ShortMinutes_two: String
    private let _MessageTimer_ShortMinutes_few: String
    private let _MessageTimer_ShortMinutes_many: String
    private let _MessageTimer_ShortMinutes_other: String
    public func MessageTimer_ShortMinutes(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._MessageTimer_ShortMinutes_zero, "\(value)")
            case .one:
                return String(format: self._MessageTimer_ShortMinutes_one, "\(value)")
            case .two:
                return String(format: self._MessageTimer_ShortMinutes_two, "\(value)")
            case .few:
                return String(format: self._MessageTimer_ShortMinutes_few, "\(value)")
            case .many:
                return String(format: self._MessageTimer_ShortMinutes_many, "\(value)")
            case .other:
                return String(format: self._MessageTimer_ShortMinutes_other, "\(value)")
        }
    }
    private let _Notification_GameScoreSelfExtended_zero: String
    private let _Notification_GameScoreSelfExtended_one: String
    private let _Notification_GameScoreSelfExtended_two: String
    private let _Notification_GameScoreSelfExtended_few: String
    private let _Notification_GameScoreSelfExtended_many: String
    private let _Notification_GameScoreSelfExtended_other: String
    public func Notification_GameScoreSelfExtended(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._Notification_GameScoreSelfExtended_zero, "\(value)")
            case .one:
                return String(format: self._Notification_GameScoreSelfExtended_one, "\(value)")
            case .two:
                return String(format: self._Notification_GameScoreSelfExtended_two, "\(value)")
            case .few:
                return String(format: self._Notification_GameScoreSelfExtended_few, "\(value)")
            case .many:
                return String(format: self._Notification_GameScoreSelfExtended_many, "\(value)")
            case .other:
                return String(format: self._Notification_GameScoreSelfExtended_other, "\(value)")
        }
    }
    private let _MessageTimer_ShortDays_zero: String
    private let _MessageTimer_ShortDays_one: String
    private let _MessageTimer_ShortDays_two: String
    private let _MessageTimer_ShortDays_few: String
    private let _MessageTimer_ShortDays_many: String
    private let _MessageTimer_ShortDays_other: String
    public func MessageTimer_ShortDays(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._MessageTimer_ShortDays_zero, "\(value)")
            case .one:
                return String(format: self._MessageTimer_ShortDays_one, "\(value)")
            case .two:
                return String(format: self._MessageTimer_ShortDays_two, "\(value)")
            case .few:
                return String(format: self._MessageTimer_ShortDays_few, "\(value)")
            case .many:
                return String(format: self._MessageTimer_ShortDays_many, "\(value)")
            case .other:
                return String(format: self._MessageTimer_ShortDays_other, "\(value)")
        }
    }
    private let _GroupInfo_ParticipantCount_zero: String
    private let _GroupInfo_ParticipantCount_one: String
    private let _GroupInfo_ParticipantCount_two: String
    private let _GroupInfo_ParticipantCount_few: String
    private let _GroupInfo_ParticipantCount_many: String
    private let _GroupInfo_ParticipantCount_other: String
    public func GroupInfo_ParticipantCount(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._GroupInfo_ParticipantCount_zero, "\(value)")
            case .one:
                return String(format: self._GroupInfo_ParticipantCount_one, "\(value)")
            case .two:
                return String(format: self._GroupInfo_ParticipantCount_two, "\(value)")
            case .few:
                return String(format: self._GroupInfo_ParticipantCount_few, "\(value)")
            case .many:
                return String(format: self._GroupInfo_ParticipantCount_many, "\(value)")
            case .other:
                return String(format: self._GroupInfo_ParticipantCount_other, "\(value)")
        }
    }
    private let _ForwardedPhotos_zero: String
    private let _ForwardedPhotos_one: String
    private let _ForwardedPhotos_two: String
    private let _ForwardedPhotos_few: String
    private let _ForwardedPhotos_many: String
    private let _ForwardedPhotos_other: String
    public func ForwardedPhotos(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._ForwardedPhotos_zero, "\(value)")
            case .one:
                return String(format: self._ForwardedPhotos_one, "\(value)")
            case .two:
                return String(format: self._ForwardedPhotos_two, "\(value)")
            case .few:
                return String(format: self._ForwardedPhotos_few, "\(value)")
            case .many:
                return String(format: self._ForwardedPhotos_many, "\(value)")
            case .other:
                return String(format: self._ForwardedPhotos_other, "\(value)")
        }
    }
    private let _ServiceMessage_GameScoreSelfExtended_zero: String
    private let _ServiceMessage_GameScoreSelfExtended_one: String
    private let _ServiceMessage_GameScoreSelfExtended_two: String
    private let _ServiceMessage_GameScoreSelfExtended_few: String
    private let _ServiceMessage_GameScoreSelfExtended_many: String
    private let _ServiceMessage_GameScoreSelfExtended_other: String
    public func ServiceMessage_GameScoreSelfExtended(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._ServiceMessage_GameScoreSelfExtended_zero, "\(value)")
            case .one:
                return String(format: self._ServiceMessage_GameScoreSelfExtended_one, "\(value)")
            case .two:
                return String(format: self._ServiceMessage_GameScoreSelfExtended_two, "\(value)")
            case .few:
                return String(format: self._ServiceMessage_GameScoreSelfExtended_few, "\(value)")
            case .many:
                return String(format: self._ServiceMessage_GameScoreSelfExtended_many, "\(value)")
            case .other:
                return String(format: self._ServiceMessage_GameScoreSelfExtended_other, "\(value)")
        }
    }
    private let _Call_ShortSeconds_zero: String
    private let _Call_ShortSeconds_one: String
    private let _Call_ShortSeconds_two: String
    private let _Call_ShortSeconds_few: String
    private let _Call_ShortSeconds_many: String
    private let _Call_ShortSeconds_other: String
    public func Call_ShortSeconds(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._Call_ShortSeconds_zero, "\(value)")
            case .one:
                return String(format: self._Call_ShortSeconds_one, "\(value)")
            case .two:
                return String(format: self._Call_ShortSeconds_two, "\(value)")
            case .few:
                return String(format: self._Call_ShortSeconds_few, "\(value)")
            case .many:
                return String(format: self._Call_ShortSeconds_many, "\(value)")
            case .other:
                return String(format: self._Call_ShortSeconds_other, "\(value)")
        }
    }
    private let _Time_PreciseDate_zero: String
    private let _Time_PreciseDate_one: String
    private let _Time_PreciseDate_two: String
    private let _Time_PreciseDate_few: String
    private let _Time_PreciseDate_many: String
    private let _Time_PreciseDate_other: String
    public func Time_PreciseDate(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._Time_PreciseDate_zero, "\(value)")
            case .one:
                return String(format: self._Time_PreciseDate_one, "\(value)")
            case .two:
                return String(format: self._Time_PreciseDate_two, "\(value)")
            case .few:
                return String(format: self._Time_PreciseDate_few, "\(value)")
            case .many:
                return String(format: self._Time_PreciseDate_many, "\(value)")
            case .other:
                return String(format: self._Time_PreciseDate_other, "\(value)")
        }
    }
    private let _SharedMedia_File_zero: String
    private let _SharedMedia_File_one: String
    private let _SharedMedia_File_two: String
    private let _SharedMedia_File_few: String
    private let _SharedMedia_File_many: String
    private let _SharedMedia_File_other: String
    public func SharedMedia_File(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._SharedMedia_File_zero, "\(value)")
            case .one:
                return String(format: self._SharedMedia_File_one, "\(value)")
            case .two:
                return String(format: self._SharedMedia_File_two, "\(value)")
            case .few:
                return String(format: self._SharedMedia_File_few, "\(value)")
            case .many:
                return String(format: self._SharedMedia_File_many, "\(value)")
            case .other:
                return String(format: self._SharedMedia_File_other, "\(value)")
        }
    }
    private let _PasscodeSettings_AutoLock_IfAwayFor_zero: String
    private let _PasscodeSettings_AutoLock_IfAwayFor_one: String
    private let _PasscodeSettings_AutoLock_IfAwayFor_two: String
    private let _PasscodeSettings_AutoLock_IfAwayFor_few: String
    private let _PasscodeSettings_AutoLock_IfAwayFor_many: String
    private let _PasscodeSettings_AutoLock_IfAwayFor_other: String
    public func PasscodeSettings_AutoLock_IfAwayFor(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._PasscodeSettings_AutoLock_IfAwayFor_zero, "\(value)")
            case .one:
                return String(format: self._PasscodeSettings_AutoLock_IfAwayFor_one, "\(value)")
            case .two:
                return String(format: self._PasscodeSettings_AutoLock_IfAwayFor_two, "\(value)")
            case .few:
                return String(format: self._PasscodeSettings_AutoLock_IfAwayFor_few, "\(value)")
            case .many:
                return String(format: self._PasscodeSettings_AutoLock_IfAwayFor_many, "\(value)")
            case .other:
                return String(format: self._PasscodeSettings_AutoLock_IfAwayFor_other, "\(value)")
        }
    }
    private let _ForwardedAudios_zero: String
    private let _ForwardedAudios_one: String
    private let _ForwardedAudios_two: String
    private let _ForwardedAudios_few: String
    private let _ForwardedAudios_many: String
    private let _ForwardedAudios_other: String
    public func ForwardedAudios(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._ForwardedAudios_zero, "\(value)")
            case .one:
                return String(format: self._ForwardedAudios_one, "\(value)")
            case .two:
                return String(format: self._ForwardedAudios_two, "\(value)")
            case .few:
                return String(format: self._ForwardedAudios_few, "\(value)")
            case .many:
                return String(format: self._ForwardedAudios_many, "\(value)")
            case .other:
                return String(format: self._ForwardedAudios_other, "\(value)")
        }
    }
    private let _PrivacyLastSeenSettings_AddUsers_zero: String
    private let _PrivacyLastSeenSettings_AddUsers_one: String
    private let _PrivacyLastSeenSettings_AddUsers_two: String
    private let _PrivacyLastSeenSettings_AddUsers_few: String
    private let _PrivacyLastSeenSettings_AddUsers_many: String
    private let _PrivacyLastSeenSettings_AddUsers_other: String
    public func PrivacyLastSeenSettings_AddUsers(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._PrivacyLastSeenSettings_AddUsers_zero, "\(value)")
            case .one:
                return String(format: self._PrivacyLastSeenSettings_AddUsers_one, "\(value)")
            case .two:
                return String(format: self._PrivacyLastSeenSettings_AddUsers_two, "\(value)")
            case .few:
                return String(format: self._PrivacyLastSeenSettings_AddUsers_few, "\(value)")
            case .many:
                return String(format: self._PrivacyLastSeenSettings_AddUsers_many, "\(value)")
            case .other:
                return String(format: self._PrivacyLastSeenSettings_AddUsers_other, "\(value)")
        }
    }
    private let _MuteFor_Weeks_zero: String
    private let _MuteFor_Weeks_one: String
    private let _MuteFor_Weeks_two: String
    private let _MuteFor_Weeks_few: String
    private let _MuteFor_Weeks_many: String
    private let _MuteFor_Weeks_other: String
    public func MuteFor_Weeks(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._MuteFor_Weeks_zero, "\(value)")
            case .one:
                return String(format: self._MuteFor_Weeks_one, "\(value)")
            case .two:
                return String(format: self._MuteFor_Weeks_two, "\(value)")
            case .few:
                return String(format: self._MuteFor_Weeks_few, "\(value)")
            case .many:
                return String(format: self._MuteFor_Weeks_many, "\(value)")
            case .other:
                return String(format: self._MuteFor_Weeks_other, "\(value)")
        }
    }
    private let _ForwardedVideoMessages_zero: String
    private let _ForwardedVideoMessages_one: String
    private let _ForwardedVideoMessages_two: String
    private let _ForwardedVideoMessages_few: String
    private let _ForwardedVideoMessages_many: String
    private let _ForwardedVideoMessages_other: String
    public func ForwardedVideoMessages(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._ForwardedVideoMessages_zero, "\(value)")
            case .one:
                return String(format: self._ForwardedVideoMessages_one, "\(value)")
            case .two:
                return String(format: self._ForwardedVideoMessages_two, "\(value)")
            case .few:
                return String(format: self._ForwardedVideoMessages_few, "\(value)")
            case .many:
                return String(format: self._ForwardedVideoMessages_many, "\(value)")
            case .other:
                return String(format: self._ForwardedVideoMessages_other, "\(value)")
        }
    }
    private let _SharedMedia_Generic_zero: String
    private let _SharedMedia_Generic_one: String
    private let _SharedMedia_Generic_two: String
    private let _SharedMedia_Generic_few: String
    private let _SharedMedia_Generic_many: String
    private let _SharedMedia_Generic_other: String
    public func SharedMedia_Generic(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._SharedMedia_Generic_zero, "\(value)")
            case .one:
                return String(format: self._SharedMedia_Generic_one, "\(value)")
            case .two:
                return String(format: self._SharedMedia_Generic_two, "\(value)")
            case .few:
                return String(format: self._SharedMedia_Generic_few, "\(value)")
            case .many:
                return String(format: self._SharedMedia_Generic_many, "\(value)")
            case .other:
                return String(format: self._SharedMedia_Generic_other, "\(value)")
        }
    }
    private let _Conversation_StatusMembers_zero: String
    private let _Conversation_StatusMembers_one: String
    private let _Conversation_StatusMembers_two: String
    private let _Conversation_StatusMembers_few: String
    private let _Conversation_StatusMembers_many: String
    private let _Conversation_StatusMembers_other: String
    public func Conversation_StatusMembers(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._Conversation_StatusMembers_zero, "\(value)")
            case .one:
                return String(format: self._Conversation_StatusMembers_one, "\(value)")
            case .two:
                return String(format: self._Conversation_StatusMembers_two, "\(value)")
            case .few:
                return String(format: self._Conversation_StatusMembers_few, "\(value)")
            case .many:
                return String(format: self._Conversation_StatusMembers_many, "\(value)")
            case .other:
                return String(format: self._Conversation_StatusMembers_other, "\(value)")
        }
    }
    private let _Invitation_Members_zero: String
    private let _Invitation_Members_one: String
    private let _Invitation_Members_two: String
    private let _Invitation_Members_few: String
    private let _Invitation_Members_many: String
    private let _Invitation_Members_other: String
    public func Invitation_Members(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._Invitation_Members_zero, "\(value)")
            case .one:
                return String(format: self._Invitation_Members_one, "\(value)")
            case .two:
                return String(format: self._Invitation_Members_two, "\(value)")
            case .few:
                return String(format: self._Invitation_Members_few, "\(value)")
            case .many:
                return String(format: self._Invitation_Members_many, "\(value)")
            case .other:
                return String(format: self._Invitation_Members_other, "\(value)")
        }
    }
    private let _ForwardedFiles_zero: String
    private let _ForwardedFiles_one: String
    private let _ForwardedFiles_two: String
    private let _ForwardedFiles_few: String
    private let _ForwardedFiles_many: String
    private let _ForwardedFiles_other: String
    public func ForwardedFiles(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._ForwardedFiles_zero, "\(value)")
            case .one:
                return String(format: self._ForwardedFiles_one, "\(value)")
            case .two:
                return String(format: self._ForwardedFiles_two, "\(value)")
            case .few:
                return String(format: self._ForwardedFiles_few, "\(value)")
            case .many:
                return String(format: self._ForwardedFiles_many, "\(value)")
            case .other:
                return String(format: self._ForwardedFiles_other, "\(value)")
        }
    }
    private let _ForwardedStickers_zero: String
    private let _ForwardedStickers_one: String
    private let _ForwardedStickers_two: String
    private let _ForwardedStickers_few: String
    private let _ForwardedStickers_many: String
    private let _ForwardedStickers_other: String
    public func ForwardedStickers(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._ForwardedStickers_zero, "\(value)")
            case .one:
                return String(format: self._ForwardedStickers_one, "\(value)")
            case .two:
                return String(format: self._ForwardedStickers_two, "\(value)")
            case .few:
                return String(format: self._ForwardedStickers_few, "\(value)")
            case .many:
                return String(format: self._ForwardedStickers_many, "\(value)")
            case .other:
                return String(format: self._ForwardedStickers_other, "\(value)")
        }
    }
    private let _StickerPack_StickerCount_zero: String
    private let _StickerPack_StickerCount_one: String
    private let _StickerPack_StickerCount_two: String
    private let _StickerPack_StickerCount_few: String
    private let _StickerPack_StickerCount_many: String
    private let _StickerPack_StickerCount_other: String
    public func StickerPack_StickerCount(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._StickerPack_StickerCount_zero, "\(value)")
            case .one:
                return String(format: self._StickerPack_StickerCount_one, "\(value)")
            case .two:
                return String(format: self._StickerPack_StickerCount_two, "\(value)")
            case .few:
                return String(format: self._StickerPack_StickerCount_few, "\(value)")
            case .many:
                return String(format: self._StickerPack_StickerCount_many, "\(value)")
            case .other:
                return String(format: self._StickerPack_StickerCount_other, "\(value)")
        }
    }
    private let _SharedMedia_Video_zero: String
    private let _SharedMedia_Video_one: String
    private let _SharedMedia_Video_two: String
    private let _SharedMedia_Video_few: String
    private let _SharedMedia_Video_many: String
    private let _SharedMedia_Video_other: String
    public func SharedMedia_Video(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._SharedMedia_Video_zero, "\(value)")
            case .one:
                return String(format: self._SharedMedia_Video_one, "\(value)")
            case .two:
                return String(format: self._SharedMedia_Video_two, "\(value)")
            case .few:
                return String(format: self._SharedMedia_Video_few, "\(value)")
            case .many:
                return String(format: self._SharedMedia_Video_many, "\(value)")
            case .other:
                return String(format: self._SharedMedia_Video_other, "\(value)")
        }
    }
    private let _ForwardedAuthorsOthers_zero: String
    private let _ForwardedAuthorsOthers_one: String
    private let _ForwardedAuthorsOthers_two: String
    private let _ForwardedAuthorsOthers_few: String
    private let _ForwardedAuthorsOthers_many: String
    private let _ForwardedAuthorsOthers_other: String
    public func ForwardedAuthorsOthers(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._ForwardedAuthorsOthers_zero, "\(value)")
            case .one:
                return String(format: self._ForwardedAuthorsOthers_one, "\(value)")
            case .two:
                return String(format: self._ForwardedAuthorsOthers_two, "\(value)")
            case .few:
                return String(format: self._ForwardedAuthorsOthers_few, "\(value)")
            case .many:
                return String(format: self._ForwardedAuthorsOthers_many, "\(value)")
            case .other:
                return String(format: self._ForwardedAuthorsOthers_other, "\(value)")
        }
    }
    private let _MuteFor_Minutes_zero: String
    private let _MuteFor_Minutes_one: String
    private let _MuteFor_Minutes_two: String
    private let _MuteFor_Minutes_few: String
    private let _MuteFor_Minutes_many: String
    private let _MuteFor_Minutes_other: String
    public func MuteFor_Minutes(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._MuteFor_Minutes_zero, "\(value)")
            case .one:
                return String(format: self._MuteFor_Minutes_one, "\(value)")
            case .two:
                return String(format: self._MuteFor_Minutes_two, "\(value)")
            case .few:
                return String(format: self._MuteFor_Minutes_few, "\(value)")
            case .many:
                return String(format: self._MuteFor_Minutes_many, "\(value)")
            case .other:
                return String(format: self._MuteFor_Minutes_other, "\(value)")
        }
    }
    private let _AttachmentMenu_SendVideo_zero: String
    private let _AttachmentMenu_SendVideo_one: String
    private let _AttachmentMenu_SendVideo_two: String
    private let _AttachmentMenu_SendVideo_few: String
    private let _AttachmentMenu_SendVideo_many: String
    private let _AttachmentMenu_SendVideo_other: String
    public func AttachmentMenu_SendVideo(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._AttachmentMenu_SendVideo_zero, "\(value)")
            case .one:
                return String(format: self._AttachmentMenu_SendVideo_one, "\(value)")
            case .two:
                return String(format: self._AttachmentMenu_SendVideo_two, "\(value)")
            case .few:
                return String(format: self._AttachmentMenu_SendVideo_few, "\(value)")
            case .many:
                return String(format: self._AttachmentMenu_SendVideo_many, "\(value)")
            case .other:
                return String(format: self._AttachmentMenu_SendVideo_other, "\(value)")
        }
    }
    private let _Call_Minutes_zero: String
    private let _Call_Minutes_one: String
    private let _Call_Minutes_two: String
    private let _Call_Minutes_few: String
    private let _Call_Minutes_many: String
    private let _Call_Minutes_other: String
    public func Call_Minutes(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._Call_Minutes_zero, "\(value)")
            case .one:
                return String(format: self._Call_Minutes_one, "\(value)")
            case .two:
                return String(format: self._Call_Minutes_two, "\(value)")
            case .few:
                return String(format: self._Call_Minutes_few, "\(value)")
            case .many:
                return String(format: self._Call_Minutes_many, "\(value)")
            case .other:
                return String(format: self._Call_Minutes_other, "\(value)")
        }
    }
    private let _ForwardedContacts_zero: String
    private let _ForwardedContacts_one: String
    private let _ForwardedContacts_two: String
    private let _ForwardedContacts_few: String
    private let _ForwardedContacts_many: String
    private let _ForwardedContacts_other: String
    public func ForwardedContacts(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._ForwardedContacts_zero, "\(value)")
            case .one:
                return String(format: self._ForwardedContacts_one, "\(value)")
            case .two:
                return String(format: self._ForwardedContacts_two, "\(value)")
            case .few:
                return String(format: self._ForwardedContacts_few, "\(value)")
            case .many:
                return String(format: self._ForwardedContacts_many, "\(value)")
            case .other:
                return String(format: self._ForwardedContacts_other, "\(value)")
        }
    }
    private let _Channel_NotificationComments_zero: String
    private let _Channel_NotificationComments_one: String
    private let _Channel_NotificationComments_two: String
    private let _Channel_NotificationComments_few: String
    private let _Channel_NotificationComments_many: String
    private let _Channel_NotificationComments_other: String
    public func Channel_NotificationComments(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._Channel_NotificationComments_zero, "\(value)")
            case .one:
                return String(format: self._Channel_NotificationComments_one, "\(value)")
            case .two:
                return String(format: self._Channel_NotificationComments_two, "\(value)")
            case .few:
                return String(format: self._Channel_NotificationComments_few, "\(value)")
            case .many:
                return String(format: self._Channel_NotificationComments_many, "\(value)")
            case .other:
                return String(format: self._Channel_NotificationComments_other, "\(value)")
        }
    }
    private let _UserCount_zero: String
    private let _UserCount_one: String
    private let _UserCount_two: String
    private let _UserCount_few: String
    private let _UserCount_many: String
    private let _UserCount_other: String
    public func UserCount(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._UserCount_zero, "\(value)")
            case .one:
                return String(format: self._UserCount_one, "\(value)")
            case .two:
                return String(format: self._UserCount_two, "\(value)")
            case .few:
                return String(format: self._UserCount_few, "\(value)")
            case .many:
                return String(format: self._UserCount_many, "\(value)")
            case .other:
                return String(format: self._UserCount_other, "\(value)")
        }
    }
    private let _ForwardedGifs_zero: String
    private let _ForwardedGifs_one: String
    private let _ForwardedGifs_two: String
    private let _ForwardedGifs_few: String
    private let _ForwardedGifs_many: String
    private let _ForwardedGifs_other: String
    public func ForwardedGifs(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._ForwardedGifs_zero, "\(value)")
            case .one:
                return String(format: self._ForwardedGifs_one, "\(value)")
            case .two:
                return String(format: self._ForwardedGifs_two, "\(value)")
            case .few:
                return String(format: self._ForwardedGifs_few, "\(value)")
            case .many:
                return String(format: self._ForwardedGifs_many, "\(value)")
            case .other:
                return String(format: self._ForwardedGifs_other, "\(value)")
        }
    }
    private let _MessageTimer_ShortHours_zero: String
    private let _MessageTimer_ShortHours_one: String
    private let _MessageTimer_ShortHours_two: String
    private let _MessageTimer_ShortHours_few: String
    private let _MessageTimer_ShortHours_many: String
    private let _MessageTimer_ShortHours_other: String
    public func MessageTimer_ShortHours(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._MessageTimer_ShortHours_zero, "\(value)")
            case .one:
                return String(format: self._MessageTimer_ShortHours_one, "\(value)")
            case .two:
                return String(format: self._MessageTimer_ShortHours_two, "\(value)")
            case .few:
                return String(format: self._MessageTimer_ShortHours_few, "\(value)")
            case .many:
                return String(format: self._MessageTimer_ShortHours_many, "\(value)")
            case .other:
                return String(format: self._MessageTimer_ShortHours_other, "\(value)")
        }
    }
    private let _ServiceMessage_GameScoreExtended_zero: String
    private let _ServiceMessage_GameScoreExtended_one: String
    private let _ServiceMessage_GameScoreExtended_two: String
    private let _ServiceMessage_GameScoreExtended_few: String
    private let _ServiceMessage_GameScoreExtended_many: String
    private let _ServiceMessage_GameScoreExtended_other: String
    public func ServiceMessage_GameScoreExtended(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._ServiceMessage_GameScoreExtended_zero, "\(value)")
            case .one:
                return String(format: self._ServiceMessage_GameScoreExtended_one, "\(value)")
            case .two:
                return String(format: self._ServiceMessage_GameScoreExtended_two, "\(value)")
            case .few:
                return String(format: self._ServiceMessage_GameScoreExtended_few, "\(value)")
            case .many:
                return String(format: self._ServiceMessage_GameScoreExtended_many, "\(value)")
            case .other:
                return String(format: self._ServiceMessage_GameScoreExtended_other, "\(value)")
        }
    }
    private let _StickerPack_AddStickerCount_zero: String
    private let _StickerPack_AddStickerCount_one: String
    private let _StickerPack_AddStickerCount_two: String
    private let _StickerPack_AddStickerCount_few: String
    private let _StickerPack_AddStickerCount_many: String
    private let _StickerPack_AddStickerCount_other: String
    public func StickerPack_AddStickerCount(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._StickerPack_AddStickerCount_zero, "\(value)")
            case .one:
                return String(format: self._StickerPack_AddStickerCount_one, "\(value)")
            case .two:
                return String(format: self._StickerPack_AddStickerCount_two, "\(value)")
            case .few:
                return String(format: self._StickerPack_AddStickerCount_few, "\(value)")
            case .many:
                return String(format: self._StickerPack_AddStickerCount_many, "\(value)")
            case .other:
                return String(format: self._StickerPack_AddStickerCount_other, "\(value)")
        }
    }
    private let _AttachmentMenu_SendPhoto_zero: String
    private let _AttachmentMenu_SendPhoto_one: String
    private let _AttachmentMenu_SendPhoto_two: String
    private let _AttachmentMenu_SendPhoto_few: String
    private let _AttachmentMenu_SendPhoto_many: String
    private let _AttachmentMenu_SendPhoto_other: String
    public func AttachmentMenu_SendPhoto(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._AttachmentMenu_SendPhoto_zero, "\(value)")
            case .one:
                return String(format: self._AttachmentMenu_SendPhoto_one, "\(value)")
            case .two:
                return String(format: self._AttachmentMenu_SendPhoto_two, "\(value)")
            case .few:
                return String(format: self._AttachmentMenu_SendPhoto_few, "\(value)")
            case .many:
                return String(format: self._AttachmentMenu_SendPhoto_many, "\(value)")
            case .other:
                return String(format: self._AttachmentMenu_SendPhoto_other, "\(value)")
        }
    }
    private let _Conversation_StatusRecipients_zero: String
    private let _Conversation_StatusRecipients_one: String
    private let _Conversation_StatusRecipients_two: String
    private let _Conversation_StatusRecipients_few: String
    private let _Conversation_StatusRecipients_many: String
    private let _Conversation_StatusRecipients_other: String
    public func Conversation_StatusRecipients(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._Conversation_StatusRecipients_zero, "\(value)")
            case .one:
                return String(format: self._Conversation_StatusRecipients_one, "\(value)")
            case .two:
                return String(format: self._Conversation_StatusRecipients_two, "\(value)")
            case .few:
                return String(format: self._Conversation_StatusRecipients_few, "\(value)")
            case .many:
                return String(format: self._Conversation_StatusRecipients_many, "\(value)")
            case .other:
                return String(format: self._Conversation_StatusRecipients_other, "\(value)")
        }
    }
    private let _Channel_Management_LabelRights_zero: String
    private let _Channel_Management_LabelRights_one: String
    private let _Channel_Management_LabelRights_two: String
    private let _Channel_Management_LabelRights_few: String
    private let _Channel_Management_LabelRights_many: String
    private let _Channel_Management_LabelRights_other: String
    public func Channel_Management_LabelRights(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._Channel_Management_LabelRights_zero, "\(value)")
            case .one:
                return String(format: self._Channel_Management_LabelRights_one, "\(value)")
            case .two:
                return String(format: self._Channel_Management_LabelRights_two, "\(value)")
            case .few:
                return String(format: self._Channel_Management_LabelRights_few, "\(value)")
            case .many:
                return String(format: self._Channel_Management_LabelRights_many, "\(value)")
            case .other:
                return String(format: self._Channel_Management_LabelRights_other, "\(value)")
        }
    }
    private let _ServiceMessage_GameScoreSelfSimple_zero: String
    private let _ServiceMessage_GameScoreSelfSimple_one: String
    private let _ServiceMessage_GameScoreSelfSimple_two: String
    private let _ServiceMessage_GameScoreSelfSimple_few: String
    private let _ServiceMessage_GameScoreSelfSimple_many: String
    private let _ServiceMessage_GameScoreSelfSimple_other: String
    public func ServiceMessage_GameScoreSelfSimple(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._ServiceMessage_GameScoreSelfSimple_zero, "\(value)")
            case .one:
                return String(format: self._ServiceMessage_GameScoreSelfSimple_one, "\(value)")
            case .two:
                return String(format: self._ServiceMessage_GameScoreSelfSimple_two, "\(value)")
            case .few:
                return String(format: self._ServiceMessage_GameScoreSelfSimple_few, "\(value)")
            case .many:
                return String(format: self._ServiceMessage_GameScoreSelfSimple_many, "\(value)")
            case .other:
                return String(format: self._ServiceMessage_GameScoreSelfSimple_other, "\(value)")
        }
    }
    private let _SharedMedia_Photo_zero: String
    private let _SharedMedia_Photo_one: String
    private let _SharedMedia_Photo_two: String
    private let _SharedMedia_Photo_few: String
    private let _SharedMedia_Photo_many: String
    private let _SharedMedia_Photo_other: String
    public func SharedMedia_Photo(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._SharedMedia_Photo_zero, "\(value)")
            case .one:
                return String(format: self._SharedMedia_Photo_one, "\(value)")
            case .two:
                return String(format: self._SharedMedia_Photo_two, "\(value)")
            case .few:
                return String(format: self._SharedMedia_Photo_few, "\(value)")
            case .many:
                return String(format: self._SharedMedia_Photo_many, "\(value)")
            case .other:
                return String(format: self._SharedMedia_Photo_other, "\(value)")
        }
    }
    private let _MessageTimer_Weeks_zero: String
    private let _MessageTimer_Weeks_one: String
    private let _MessageTimer_Weeks_two: String
    private let _MessageTimer_Weeks_few: String
    private let _MessageTimer_Weeks_many: String
    private let _MessageTimer_Weeks_other: String
    public func MessageTimer_Weeks(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._MessageTimer_Weeks_zero, "\(value)")
            case .one:
                return String(format: self._MessageTimer_Weeks_one, "\(value)")
            case .two:
                return String(format: self._MessageTimer_Weeks_two, "\(value)")
            case .few:
                return String(format: self._MessageTimer_Weeks_few, "\(value)")
            case .many:
                return String(format: self._MessageTimer_Weeks_many, "\(value)")
            case .other:
                return String(format: self._MessageTimer_Weeks_other, "\(value)")
        }
    }
    private let _StickerPack_AddMaskCount_zero: String
    private let _StickerPack_AddMaskCount_one: String
    private let _StickerPack_AddMaskCount_two: String
    private let _StickerPack_AddMaskCount_few: String
    private let _StickerPack_AddMaskCount_many: String
    private let _StickerPack_AddMaskCount_other: String
    public func StickerPack_AddMaskCount(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._StickerPack_AddMaskCount_zero, "\(value)")
            case .one:
                return String(format: self._StickerPack_AddMaskCount_one, "\(value)")
            case .two:
                return String(format: self._StickerPack_AddMaskCount_two, "\(value)")
            case .few:
                return String(format: self._StickerPack_AddMaskCount_few, "\(value)")
            case .many:
                return String(format: self._StickerPack_AddMaskCount_many, "\(value)")
            case .other:
                return String(format: self._StickerPack_AddMaskCount_other, "\(value)")
        }
    }
    private let _LastSeen_MinutesAgo_zero: String
    private let _LastSeen_MinutesAgo_one: String
    private let _LastSeen_MinutesAgo_two: String
    private let _LastSeen_MinutesAgo_few: String
    private let _LastSeen_MinutesAgo_many: String
    private let _LastSeen_MinutesAgo_other: String
    public func LastSeen_MinutesAgo(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._LastSeen_MinutesAgo_zero, "\(value)")
            case .one:
                return String(format: self._LastSeen_MinutesAgo_one, "\(value)")
            case .two:
                return String(format: self._LastSeen_MinutesAgo_two, "\(value)")
            case .few:
                return String(format: self._LastSeen_MinutesAgo_few, "\(value)")
            case .many:
                return String(format: self._LastSeen_MinutesAgo_many, "\(value)")
            case .other:
                return String(format: self._LastSeen_MinutesAgo_other, "\(value)")
        }
    }
    private let _LastSeen_HoursAgo_zero: String
    private let _LastSeen_HoursAgo_one: String
    private let _LastSeen_HoursAgo_two: String
    private let _LastSeen_HoursAgo_few: String
    private let _LastSeen_HoursAgo_many: String
    private let _LastSeen_HoursAgo_other: String
    public func LastSeen_HoursAgo(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._LastSeen_HoursAgo_zero, "\(value)")
            case .one:
                return String(format: self._LastSeen_HoursAgo_one, "\(value)")
            case .two:
                return String(format: self._LastSeen_HoursAgo_two, "\(value)")
            case .few:
                return String(format: self._LastSeen_HoursAgo_few, "\(value)")
            case .many:
                return String(format: self._LastSeen_HoursAgo_many, "\(value)")
            case .other:
                return String(format: self._LastSeen_HoursAgo_other, "\(value)")
        }
    }
    private let _MuteExpires_Days_zero: String
    private let _MuteExpires_Days_one: String
    private let _MuteExpires_Days_two: String
    private let _MuteExpires_Days_few: String
    private let _MuteExpires_Days_many: String
    private let _MuteExpires_Days_other: String
    public func MuteExpires_Days(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._MuteExpires_Days_zero, "\(value)")
            case .one:
                return String(format: self._MuteExpires_Days_one, "\(value)")
            case .two:
                return String(format: self._MuteExpires_Days_two, "\(value)")
            case .few:
                return String(format: self._MuteExpires_Days_few, "\(value)")
            case .many:
                return String(format: self._MuteExpires_Days_many, "\(value)")
            case .other:
                return String(format: self._MuteExpires_Days_other, "\(value)")
        }
    }
    private let _MuteExpires_Hours_zero: String
    private let _MuteExpires_Hours_one: String
    private let _MuteExpires_Hours_two: String
    private let _MuteExpires_Hours_few: String
    private let _MuteExpires_Hours_many: String
    private let _MuteExpires_Hours_other: String
    public func MuteExpires_Hours(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._MuteExpires_Hours_zero, "\(value)")
            case .one:
                return String(format: self._MuteExpires_Hours_one, "\(value)")
            case .two:
                return String(format: self._MuteExpires_Hours_two, "\(value)")
            case .few:
                return String(format: self._MuteExpires_Hours_few, "\(value)")
            case .many:
                return String(format: self._MuteExpires_Hours_many, "\(value)")
            case .other:
                return String(format: self._MuteExpires_Hours_other, "\(value)")
        }
    }
    private let _Watch_LastSeen_HoursAgo_zero: String
    private let _Watch_LastSeen_HoursAgo_one: String
    private let _Watch_LastSeen_HoursAgo_two: String
    private let _Watch_LastSeen_HoursAgo_few: String
    private let _Watch_LastSeen_HoursAgo_many: String
    private let _Watch_LastSeen_HoursAgo_other: String
    public func Watch_LastSeen_HoursAgo(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._Watch_LastSeen_HoursAgo_zero, "\(value)")
            case .one:
                return String(format: self._Watch_LastSeen_HoursAgo_one, "\(value)")
            case .two:
                return String(format: self._Watch_LastSeen_HoursAgo_two, "\(value)")
            case .few:
                return String(format: self._Watch_LastSeen_HoursAgo_few, "\(value)")
            case .many:
                return String(format: self._Watch_LastSeen_HoursAgo_many, "\(value)")
            case .other:
                return String(format: self._Watch_LastSeen_HoursAgo_other, "\(value)")
        }
    }
    private let _Forward_ConfirmMultipleFiles_zero: String
    private let _Forward_ConfirmMultipleFiles_one: String
    private let _Forward_ConfirmMultipleFiles_two: String
    private let _Forward_ConfirmMultipleFiles_few: String
    private let _Forward_ConfirmMultipleFiles_many: String
    private let _Forward_ConfirmMultipleFiles_other: String
    public func Forward_ConfirmMultipleFiles(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._Forward_ConfirmMultipleFiles_zero, "\(value)")
            case .one:
                return String(format: self._Forward_ConfirmMultipleFiles_one, "\(value)")
            case .two:
                return String(format: self._Forward_ConfirmMultipleFiles_two, "\(value)")
            case .few:
                return String(format: self._Forward_ConfirmMultipleFiles_few, "\(value)")
            case .many:
                return String(format: self._Forward_ConfirmMultipleFiles_many, "\(value)")
            case .other:
                return String(format: self._Forward_ConfirmMultipleFiles_other, "\(value)")
        }
    }
    private let _AttachmentMenu_SendGif_zero: String
    private let _AttachmentMenu_SendGif_one: String
    private let _AttachmentMenu_SendGif_two: String
    private let _AttachmentMenu_SendGif_few: String
    private let _AttachmentMenu_SendGif_many: String
    private let _AttachmentMenu_SendGif_other: String
    public func AttachmentMenu_SendGif(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._AttachmentMenu_SendGif_zero, "\(value)")
            case .one:
                return String(format: self._AttachmentMenu_SendGif_one, "\(value)")
            case .two:
                return String(format: self._AttachmentMenu_SendGif_two, "\(value)")
            case .few:
                return String(format: self._AttachmentMenu_SendGif_few, "\(value)")
            case .many:
                return String(format: self._AttachmentMenu_SendGif_many, "\(value)")
            case .other:
                return String(format: self._AttachmentMenu_SendGif_other, "\(value)")
        }
    }
    private let _StickerPack_RemoveStickerCount_zero: String
    private let _StickerPack_RemoveStickerCount_one: String
    private let _StickerPack_RemoveStickerCount_two: String
    private let _StickerPack_RemoveStickerCount_few: String
    private let _StickerPack_RemoveStickerCount_many: String
    private let _StickerPack_RemoveStickerCount_other: String
    public func StickerPack_RemoveStickerCount(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._StickerPack_RemoveStickerCount_zero, "\(value)")
            case .one:
                return String(format: self._StickerPack_RemoveStickerCount_one, "\(value)")
            case .two:
                return String(format: self._StickerPack_RemoveStickerCount_two, "\(value)")
            case .few:
                return String(format: self._StickerPack_RemoveStickerCount_few, "\(value)")
            case .many:
                return String(format: self._StickerPack_RemoveStickerCount_many, "\(value)")
            case .other:
                return String(format: self._StickerPack_RemoveStickerCount_other, "\(value)")
        }
    }
    private let _SharedMedia_Link_zero: String
    private let _SharedMedia_Link_one: String
    private let _SharedMedia_Link_two: String
    private let _SharedMedia_Link_few: String
    private let _SharedMedia_Link_many: String
    private let _SharedMedia_Link_other: String
    public func SharedMedia_Link(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._SharedMedia_Link_zero, "\(value)")
            case .one:
                return String(format: self._SharedMedia_Link_one, "\(value)")
            case .two:
                return String(format: self._SharedMedia_Link_two, "\(value)")
            case .few:
                return String(format: self._SharedMedia_Link_few, "\(value)")
            case .many:
                return String(format: self._SharedMedia_Link_many, "\(value)")
            case .other:
                return String(format: self._SharedMedia_Link_other, "\(value)")
        }
    }
    private let _Map_ETAHours_zero: String
    private let _Map_ETAHours_one: String
    private let _Map_ETAHours_two: String
    private let _Map_ETAHours_few: String
    private let _Map_ETAHours_many: String
    private let _Map_ETAHours_other: String
    public func Map_ETAHours(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._Map_ETAHours_zero, "\(value)")
            case .one:
                return String(format: self._Map_ETAHours_one, "\(value)")
            case .two:
                return String(format: self._Map_ETAHours_two, "\(value)")
            case .few:
                return String(format: self._Map_ETAHours_few, "\(value)")
            case .many:
                return String(format: self._Map_ETAHours_many, "\(value)")
            case .other:
                return String(format: self._Map_ETAHours_other, "\(value)")
        }
    }
    private let _SharedMedia_DeleteItemsConfirmation_zero: String
    private let _SharedMedia_DeleteItemsConfirmation_one: String
    private let _SharedMedia_DeleteItemsConfirmation_two: String
    private let _SharedMedia_DeleteItemsConfirmation_few: String
    private let _SharedMedia_DeleteItemsConfirmation_many: String
    private let _SharedMedia_DeleteItemsConfirmation_other: String
    public func SharedMedia_DeleteItemsConfirmation(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._SharedMedia_DeleteItemsConfirmation_zero, "\(value)")
            case .one:
                return String(format: self._SharedMedia_DeleteItemsConfirmation_one, "\(value)")
            case .two:
                return String(format: self._SharedMedia_DeleteItemsConfirmation_two, "\(value)")
            case .few:
                return String(format: self._SharedMedia_DeleteItemsConfirmation_few, "\(value)")
            case .many:
                return String(format: self._SharedMedia_DeleteItemsConfirmation_many, "\(value)")
            case .other:
                return String(format: self._SharedMedia_DeleteItemsConfirmation_other, "\(value)")
        }
    }
    private let _Watch_LastSeen_MinutesAgo_zero: String
    private let _Watch_LastSeen_MinutesAgo_one: String
    private let _Watch_LastSeen_MinutesAgo_two: String
    private let _Watch_LastSeen_MinutesAgo_few: String
    private let _Watch_LastSeen_MinutesAgo_many: String
    private let _Watch_LastSeen_MinutesAgo_other: String
    public func Watch_LastSeen_MinutesAgo(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._Watch_LastSeen_MinutesAgo_zero, "\(value)")
            case .one:
                return String(format: self._Watch_LastSeen_MinutesAgo_one, "\(value)")
            case .two:
                return String(format: self._Watch_LastSeen_MinutesAgo_two, "\(value)")
            case .few:
                return String(format: self._Watch_LastSeen_MinutesAgo_few, "\(value)")
            case .many:
                return String(format: self._Watch_LastSeen_MinutesAgo_many, "\(value)")
            case .other:
                return String(format: self._Watch_LastSeen_MinutesAgo_other, "\(value)")
        }
    }
    private let _ForwardedMessages_zero: String
    private let _ForwardedMessages_one: String
    private let _ForwardedMessages_two: String
    private let _ForwardedMessages_few: String
    private let _ForwardedMessages_many: String
    private let _ForwardedMessages_other: String
    public func ForwardedMessages(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._ForwardedMessages_zero, "\(value)")
            case .one:
                return String(format: self._ForwardedMessages_one, "\(value)")
            case .two:
                return String(format: self._ForwardedMessages_two, "\(value)")
            case .few:
                return String(format: self._ForwardedMessages_few, "\(value)")
            case .many:
                return String(format: self._ForwardedMessages_many, "\(value)")
            case .other:
                return String(format: self._ForwardedMessages_other, "\(value)")
        }
    }
    private let _SharedMedia_ItemsSelected_zero: String
    private let _SharedMedia_ItemsSelected_one: String
    private let _SharedMedia_ItemsSelected_two: String
    private let _SharedMedia_ItemsSelected_few: String
    private let _SharedMedia_ItemsSelected_many: String
    private let _SharedMedia_ItemsSelected_other: String
    public func SharedMedia_ItemsSelected(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._SharedMedia_ItemsSelected_zero, "\(value)")
            case .one:
                return String(format: self._SharedMedia_ItemsSelected_one, "\(value)")
            case .two:
                return String(format: self._SharedMedia_ItemsSelected_two, "\(value)")
            case .few:
                return String(format: self._SharedMedia_ItemsSelected_few, "\(value)")
            case .many:
                return String(format: self._SharedMedia_ItemsSelected_many, "\(value)")
            case .other:
                return String(format: self._SharedMedia_ItemsSelected_other, "\(value)")
        }
    }
    private let _MessageTimer_Hours_zero: String
    private let _MessageTimer_Hours_one: String
    private let _MessageTimer_Hours_two: String
    private let _MessageTimer_Hours_few: String
    private let _MessageTimer_Hours_many: String
    private let _MessageTimer_Hours_other: String
    public func MessageTimer_Hours(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._MessageTimer_Hours_zero, "\(value)")
            case .one:
                return String(format: self._MessageTimer_Hours_one, "\(value)")
            case .two:
                return String(format: self._MessageTimer_Hours_two, "\(value)")
            case .few:
                return String(format: self._MessageTimer_Hours_few, "\(value)")
            case .many:
                return String(format: self._MessageTimer_Hours_many, "\(value)")
            case .other:
                return String(format: self._MessageTimer_Hours_other, "\(value)")
        }
    }
    private let _MessageTimer_Years_zero: String
    private let _MessageTimer_Years_one: String
    private let _MessageTimer_Years_two: String
    private let _MessageTimer_Years_few: String
    private let _MessageTimer_Years_many: String
    private let _MessageTimer_Years_other: String
    public func MessageTimer_Years(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._MessageTimer_Years_zero, "\(value)")
            case .one:
                return String(format: self._MessageTimer_Years_one, "\(value)")
            case .two:
                return String(format: self._MessageTimer_Years_two, "\(value)")
            case .few:
                return String(format: self._MessageTimer_Years_few, "\(value)")
            case .many:
                return String(format: self._MessageTimer_Years_many, "\(value)")
            case .other:
                return String(format: self._MessageTimer_Years_other, "\(value)")
        }
    }
    private let _Map_ETAMinutes_zero: String
    private let _Map_ETAMinutes_one: String
    private let _Map_ETAMinutes_two: String
    private let _Map_ETAMinutes_few: String
    private let _Map_ETAMinutes_many: String
    private let _Map_ETAMinutes_other: String
    public func Map_ETAMinutes(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._Map_ETAMinutes_zero, "\(value)")
            case .one:
                return String(format: self._Map_ETAMinutes_one, "\(value)")
            case .two:
                return String(format: self._Map_ETAMinutes_two, "\(value)")
            case .few:
                return String(format: self._Map_ETAMinutes_few, "\(value)")
            case .many:
                return String(format: self._Map_ETAMinutes_many, "\(value)")
            case .other:
                return String(format: self._Map_ETAMinutes_other, "\(value)")
        }
    }
    private let _ForwardedVideos_zero: String
    private let _ForwardedVideos_one: String
    private let _ForwardedVideos_two: String
    private let _ForwardedVideos_few: String
    private let _ForwardedVideos_many: String
    private let _ForwardedVideos_other: String
    public func ForwardedVideos(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._ForwardedVideos_zero, "\(value)")
            case .one:
                return String(format: self._ForwardedVideos_one, "\(value)")
            case .two:
                return String(format: self._ForwardedVideos_two, "\(value)")
            case .few:
                return String(format: self._ForwardedVideos_few, "\(value)")
            case .many:
                return String(format: self._ForwardedVideos_many, "\(value)")
            case .other:
                return String(format: self._ForwardedVideos_other, "\(value)")
        }
    }
    private let _Notification_GameScoreSelfSimple_zero: String
    private let _Notification_GameScoreSelfSimple_one: String
    private let _Notification_GameScoreSelfSimple_two: String
    private let _Notification_GameScoreSelfSimple_few: String
    private let _Notification_GameScoreSelfSimple_many: String
    private let _Notification_GameScoreSelfSimple_other: String
    public func Notification_GameScoreSelfSimple(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._Notification_GameScoreSelfSimple_zero, "\(value)")
            case .one:
                return String(format: self._Notification_GameScoreSelfSimple_one, "\(value)")
            case .two:
                return String(format: self._Notification_GameScoreSelfSimple_two, "\(value)")
            case .few:
                return String(format: self._Notification_GameScoreSelfSimple_few, "\(value)")
            case .many:
                return String(format: self._Notification_GameScoreSelfSimple_many, "\(value)")
            case .other:
                return String(format: self._Notification_GameScoreSelfSimple_other, "\(value)")
        }
    }
    private let _ServiceMessage_GameScoreSimple_zero: String
    private let _ServiceMessage_GameScoreSimple_one: String
    private let _ServiceMessage_GameScoreSimple_two: String
    private let _ServiceMessage_GameScoreSimple_few: String
    private let _ServiceMessage_GameScoreSimple_many: String
    private let _ServiceMessage_GameScoreSimple_other: String
    public func ServiceMessage_GameScoreSimple(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._ServiceMessage_GameScoreSimple_zero, "\(value)")
            case .one:
                return String(format: self._ServiceMessage_GameScoreSimple_one, "\(value)")
            case .two:
                return String(format: self._ServiceMessage_GameScoreSimple_two, "\(value)")
            case .few:
                return String(format: self._ServiceMessage_GameScoreSimple_few, "\(value)")
            case .many:
                return String(format: self._ServiceMessage_GameScoreSimple_many, "\(value)")
            case .other:
                return String(format: self._ServiceMessage_GameScoreSimple_other, "\(value)")
        }
    }
    private let _QuickSend_Photos_zero: String
    private let _QuickSend_Photos_one: String
    private let _QuickSend_Photos_two: String
    private let _QuickSend_Photos_few: String
    private let _QuickSend_Photos_many: String
    private let _QuickSend_Photos_other: String
    public func QuickSend_Photos(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._QuickSend_Photos_zero, "\(value)")
            case .one:
                return String(format: self._QuickSend_Photos_one, "\(value)")
            case .two:
                return String(format: self._QuickSend_Photos_two, "\(value)")
            case .few:
                return String(format: self._QuickSend_Photos_few, "\(value)")
            case .many:
                return String(format: self._QuickSend_Photos_many, "\(value)")
            case .other:
                return String(format: self._QuickSend_Photos_other, "\(value)")
        }
    }
    private let _MuteFor_Days_zero: String
    private let _MuteFor_Days_one: String
    private let _MuteFor_Days_two: String
    private let _MuteFor_Days_few: String
    private let _MuteFor_Days_many: String
    private let _MuteFor_Days_other: String
    public func MuteFor_Days(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._MuteFor_Days_zero, "\(value)")
            case .one:
                return String(format: self._MuteFor_Days_one, "\(value)")
            case .two:
                return String(format: self._MuteFor_Days_two, "\(value)")
            case .few:
                return String(format: self._MuteFor_Days_few, "\(value)")
            case .many:
                return String(format: self._MuteFor_Days_many, "\(value)")
            case .other:
                return String(format: self._MuteFor_Days_other, "\(value)")
        }
    }
    private let _Conversation_StatusOnline_zero: String
    private let _Conversation_StatusOnline_one: String
    private let _Conversation_StatusOnline_two: String
    private let _Conversation_StatusOnline_few: String
    private let _Conversation_StatusOnline_many: String
    private let _Conversation_StatusOnline_other: String
    public func Conversation_StatusOnline(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._Conversation_StatusOnline_zero, "\(value)")
            case .one:
                return String(format: self._Conversation_StatusOnline_one, "\(value)")
            case .two:
                return String(format: self._Conversation_StatusOnline_two, "\(value)")
            case .few:
                return String(format: self._Conversation_StatusOnline_few, "\(value)")
            case .many:
                return String(format: self._Conversation_StatusOnline_many, "\(value)")
            case .other:
                return String(format: self._Conversation_StatusOnline_other, "\(value)")
        }
    }
    private let _AttachmentMenu_SendItem_zero: String
    private let _AttachmentMenu_SendItem_one: String
    private let _AttachmentMenu_SendItem_two: String
    private let _AttachmentMenu_SendItem_few: String
    private let _AttachmentMenu_SendItem_many: String
    private let _AttachmentMenu_SendItem_other: String
    public func AttachmentMenu_SendItem(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._AttachmentMenu_SendItem_zero, "\(value)")
            case .one:
                return String(format: self._AttachmentMenu_SendItem_one, "\(value)")
            case .two:
                return String(format: self._AttachmentMenu_SendItem_two, "\(value)")
            case .few:
                return String(format: self._AttachmentMenu_SendItem_few, "\(value)")
            case .many:
                return String(format: self._AttachmentMenu_SendItem_many, "\(value)")
            case .other:
                return String(format: self._AttachmentMenu_SendItem_other, "\(value)")
        }
    }
    private let _Time_MonthOfYear_zero: String
    private let _Time_MonthOfYear_one: String
    private let _Time_MonthOfYear_two: String
    private let _Time_MonthOfYear_few: String
    private let _Time_MonthOfYear_many: String
    private let _Time_MonthOfYear_other: String
    public func Time_MonthOfYear(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._Time_MonthOfYear_zero, "\(value)")
            case .one:
                return String(format: self._Time_MonthOfYear_one, "\(value)")
            case .two:
                return String(format: self._Time_MonthOfYear_two, "\(value)")
            case .few:
                return String(format: self._Time_MonthOfYear_few, "\(value)")
            case .many:
                return String(format: self._Time_MonthOfYear_many, "\(value)")
            case .other:
                return String(format: self._Time_MonthOfYear_other, "\(value)")
        }
    }
    private let _Watch_UserInfo_Mute_zero: String
    private let _Watch_UserInfo_Mute_one: String
    private let _Watch_UserInfo_Mute_two: String
    private let _Watch_UserInfo_Mute_few: String
    private let _Watch_UserInfo_Mute_many: String
    private let _Watch_UserInfo_Mute_other: String
    public func Watch_UserInfo_Mute(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._Watch_UserInfo_Mute_zero, "\(value)")
            case .one:
                return String(format: self._Watch_UserInfo_Mute_one, "\(value)")
            case .two:
                return String(format: self._Watch_UserInfo_Mute_two, "\(value)")
            case .few:
                return String(format: self._Watch_UserInfo_Mute_few, "\(value)")
            case .many:
                return String(format: self._Watch_UserInfo_Mute_many, "\(value)")
            case .other:
                return String(format: self._Watch_UserInfo_Mute_other, "\(value)")
        }
    }
    private let _StickerPack_MaskCount_zero: String
    private let _StickerPack_MaskCount_one: String
    private let _StickerPack_MaskCount_two: String
    private let _StickerPack_MaskCount_few: String
    private let _StickerPack_MaskCount_many: String
    private let _StickerPack_MaskCount_other: String
    public func StickerPack_MaskCount(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._StickerPack_MaskCount_zero, "\(value)")
            case .one:
                return String(format: self._StickerPack_MaskCount_one, "\(value)")
            case .two:
                return String(format: self._StickerPack_MaskCount_two, "\(value)")
            case .few:
                return String(format: self._StickerPack_MaskCount_few, "\(value)")
            case .many:
                return String(format: self._StickerPack_MaskCount_many, "\(value)")
            case .other:
                return String(format: self._StickerPack_MaskCount_other, "\(value)")
        }
    }
    private let _Call_ShortMinutes_zero: String
    private let _Call_ShortMinutes_one: String
    private let _Call_ShortMinutes_two: String
    private let _Call_ShortMinutes_few: String
    private let _Call_ShortMinutes_many: String
    private let _Call_ShortMinutes_other: String
    public func Call_ShortMinutes(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._Call_ShortMinutes_zero, "\(value)")
            case .one:
                return String(format: self._Call_ShortMinutes_one, "\(value)")
            case .two:
                return String(format: self._Call_ShortMinutes_two, "\(value)")
            case .few:
                return String(format: self._Call_ShortMinutes_few, "\(value)")
            case .many:
                return String(format: self._Call_ShortMinutes_many, "\(value)")
            case .other:
                return String(format: self._Call_ShortMinutes_other, "\(value)")
        }
    }
    private let _StickerPack_RemoveMaskCount_zero: String
    private let _StickerPack_RemoveMaskCount_one: String
    private let _StickerPack_RemoveMaskCount_two: String
    private let _StickerPack_RemoveMaskCount_few: String
    private let _StickerPack_RemoveMaskCount_many: String
    private let _StickerPack_RemoveMaskCount_other: String
    public func StickerPack_RemoveMaskCount(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._StickerPack_RemoveMaskCount_zero, "\(value)")
            case .one:
                return String(format: self._StickerPack_RemoveMaskCount_one, "\(value)")
            case .two:
                return String(format: self._StickerPack_RemoveMaskCount_two, "\(value)")
            case .few:
                return String(format: self._StickerPack_RemoveMaskCount_few, "\(value)")
            case .many:
                return String(format: self._StickerPack_RemoveMaskCount_many, "\(value)")
            case .other:
                return String(format: self._StickerPack_RemoveMaskCount_other, "\(value)")
        }
    }
    private let _ForwardedLocations_zero: String
    private let _ForwardedLocations_one: String
    private let _ForwardedLocations_two: String
    private let _ForwardedLocations_few: String
    private let _ForwardedLocations_many: String
    private let _ForwardedLocations_other: String
    public func ForwardedLocations(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._ForwardedLocations_zero, "\(value)")
            case .one:
                return String(format: self._ForwardedLocations_one, "\(value)")
            case .two:
                return String(format: self._ForwardedLocations_two, "\(value)")
            case .few:
                return String(format: self._ForwardedLocations_few, "\(value)")
            case .many:
                return String(format: self._ForwardedLocations_many, "\(value)")
            case .other:
                return String(format: self._ForwardedLocations_other, "\(value)")
        }
    }
    private let _MessageTimer_ShortWeeks_zero: String
    private let _MessageTimer_ShortWeeks_one: String
    private let _MessageTimer_ShortWeeks_two: String
    private let _MessageTimer_ShortWeeks_few: String
    private let _MessageTimer_ShortWeeks_many: String
    private let _MessageTimer_ShortWeeks_other: String
    public func MessageTimer_ShortWeeks(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._MessageTimer_ShortWeeks_zero, "\(value)")
            case .one:
                return String(format: self._MessageTimer_ShortWeeks_one, "\(value)")
            case .two:
                return String(format: self._MessageTimer_ShortWeeks_two, "\(value)")
            case .few:
                return String(format: self._MessageTimer_ShortWeeks_few, "\(value)")
            case .many:
                return String(format: self._MessageTimer_ShortWeeks_many, "\(value)")
            case .other:
                return String(format: self._MessageTimer_ShortWeeks_other, "\(value)")
        }
    }
    private let _MessageTimer_Minutes_zero: String
    private let _MessageTimer_Minutes_one: String
    private let _MessageTimer_Minutes_two: String
    private let _MessageTimer_Minutes_few: String
    private let _MessageTimer_Minutes_many: String
    private let _MessageTimer_Minutes_other: String
    public func MessageTimer_Minutes(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._MessageTimer_Minutes_zero, "\(value)")
            case .one:
                return String(format: self._MessageTimer_Minutes_one, "\(value)")
            case .two:
                return String(format: self._MessageTimer_Minutes_two, "\(value)")
            case .few:
                return String(format: self._MessageTimer_Minutes_few, "\(value)")
            case .many:
                return String(format: self._MessageTimer_Minutes_many, "\(value)")
            case .other:
                return String(format: self._MessageTimer_Minutes_other, "\(value)")
        }
    }
    private let _MessageTimer_Months_zero: String
    private let _MessageTimer_Months_one: String
    private let _MessageTimer_Months_two: String
    private let _MessageTimer_Months_few: String
    private let _MessageTimer_Months_many: String
    private let _MessageTimer_Months_other: String
    public func MessageTimer_Months(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._MessageTimer_Months_zero, "\(value)")
            case .one:
                return String(format: self._MessageTimer_Months_one, "\(value)")
            case .two:
                return String(format: self._MessageTimer_Months_two, "\(value)")
            case .few:
                return String(format: self._MessageTimer_Months_few, "\(value)")
            case .many:
                return String(format: self._MessageTimer_Months_many, "\(value)")
            case .other:
                return String(format: self._MessageTimer_Months_other, "\(value)")
        }
    }
    private let _MessageTimer_Days_zero: String
    private let _MessageTimer_Days_one: String
    private let _MessageTimer_Days_two: String
    private let _MessageTimer_Days_few: String
    private let _MessageTimer_Days_many: String
    private let _MessageTimer_Days_other: String
    public func MessageTimer_Days(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._MessageTimer_Days_zero, "\(value)")
            case .one:
                return String(format: self._MessageTimer_Days_one, "\(value)")
            case .two:
                return String(format: self._MessageTimer_Days_two, "\(value)")
            case .few:
                return String(format: self._MessageTimer_Days_few, "\(value)")
            case .many:
                return String(format: self._MessageTimer_Days_many, "\(value)")
            case .other:
                return String(format: self._MessageTimer_Days_other, "\(value)")
        }
    }
    private let _MuteExpires_Minutes_zero: String
    private let _MuteExpires_Minutes_one: String
    private let _MuteExpires_Minutes_two: String
    private let _MuteExpires_Minutes_few: String
    private let _MuteExpires_Minutes_many: String
    private let _MuteExpires_Minutes_other: String
    public func MuteExpires_Minutes(_ value: Int32) -> String {
        switch presentationStringsPluralizationForm(self.lc, value) {
            case .zero:
                return String(format: self._MuteExpires_Minutes_zero, "\(value)")
            case .one:
                return String(format: self._MuteExpires_Minutes_one, "\(value)")
            case .two:
                return String(format: self._MuteExpires_Minutes_two, "\(value)")
            case .few:
                return String(format: self._MuteExpires_Minutes_few, "\(value)")
            case .many:
                return String(format: self._MuteExpires_Minutes_many, "\(value)")
            case .other:
                return String(format: self._MuteExpires_Minutes_other, "\(value)")
        }
    }


    init(languageCode: String, dict: [String: String]) {
        self.languageCode = languageCode
        var rawCode = languageCode as NSString
        let range = rawCode.range(of: "_")
        if range.location != NSNotFound {
            rawCode = rawCode.substring(to: range.location) as NSString
        }
        rawCode = rawCode.lowercased as NSString
        var lc: UInt32 = 0
        for i in 0 ..< rawCode.length {
            lc = (lc << 8) + UInt32(rawCode.character(at: i))
        }
        self.lc = lc
        self.Channel_BanUser_Title = getValue(dict, "Channel.BanUser.Title")
        self.Preview_SaveGif = getValue(dict, "Preview.SaveGif")
        self.EnterPasscode_EnterNewPasscodeNew = getValue(dict, "EnterPasscode.EnterNewPasscodeNew")
        self.Privacy_Calls_WhoCanCallMe = getValue(dict, "Privacy.Calls.WhoCanCallMe")
        self.Watch_NoConnection = getValue(dict, "Watch.NoConnection")
        self._Group_Username_LinkHint = getValue(dict, "Group.Username.LinkHint")
        self._Group_Username_LinkHint_r = extractArgumentRanges(self._Group_Username_LinkHint)
        self.Activity_UploadingPhoto = getValue(dict, "Activity.UploadingPhoto")
        self.PrivacySettings_PrivacyTitle = getValue(dict, "PrivacySettings.PrivacyTitle")
        self._DialogList_PinLimitError = getValue(dict, "DialogList.PinLimitError")
        self._DialogList_PinLimitError_r = extractArgumentRanges(self._DialogList_PinLimitError)
        self.Settings_LogoutError = getValue(dict, "Settings.LogoutError")
        self.Cache_ClearCache = getValue(dict, "Cache.ClearCache")
        self.Common_Close = getValue(dict, "Common.Close")
        self.ChangePhoneNumberCode_Called = getValue(dict, "ChangePhoneNumberCode.Called")
        self.Login_PhoneTitle = getValue(dict, "Login.PhoneTitle")
        self._Cache_Clear = getValue(dict, "Cache.Clear")
        self._Cache_Clear_r = extractArgumentRanges(self._Cache_Clear)
        self.EnterPasscode_EnterNewPasscodeChange = getValue(dict, "EnterPasscode.EnterNewPasscodeChange")
        self.Watch_ChatList_Compose = getValue(dict, "Watch.ChatList.Compose")
        self.DialogList_SearchSectionDialogs = getValue(dict, "DialogList.SearchSectionDialogs")
        self.Contacts_TabTitle = getValue(dict, "Contacts.TabTitle")
        self.TwoStepAuth_SetupPasswordConfirmPassword = getValue(dict, "TwoStepAuth.SetupPasswordConfirmPassword")
        self.ChannelIntro_Text = getValue(dict, "ChannelIntro.Text")
        self.PrivacySettings_SecurityTitle = getValue(dict, "PrivacySettings.SecurityTitle")
        self._Login_SmsRequestState1 = getValue(dict, "Login.SmsRequestState1")
        self._Login_SmsRequestState1_r = extractArgumentRanges(self._Login_SmsRequestState1)
        self.Conversation_Download = getValue(dict, "Conversation.Download")
        self._Call_StatusOngoing = getValue(dict, "Call.StatusOngoing")
        self._Call_StatusOngoing_r = extractArgumentRanges(self._Call_StatusOngoing)
        self.Settings_LogoutConfirmationText = getValue(dict, "Settings.LogoutConfirmationText")
        self.BlockedUsers_Info = getValue(dict, "BlockedUsers.Info")
        self.ChatSettings_AutomaticAudioDownload = getValue(dict, "ChatSettings.AutomaticAudioDownload")
        self.Map_OpenInFoursquare = getValue(dict, "Map.OpenInFoursquare")
        self.Privacy_Calls_CustomShareHelp = getValue(dict, "Privacy.Calls.CustomShareHelp")
        self.Group_MessagePhotoUpdated = getValue(dict, "Group.MessagePhotoUpdated")
        self.Message_PinnedInvoice = getValue(dict, "Message.PinnedInvoice")
        self.Login_InfoAvatarAdd = getValue(dict, "Login.InfoAvatarAdd")
        self.WebSearch_RecentSectionTitle = getValue(dict, "WebSearch.RecentSectionTitle")
        self._CHAT_MESSAGE_TEXT = getValue(dict, "CHAT_MESSAGE_TEXT")
        self._CHAT_MESSAGE_TEXT_r = extractArgumentRanges(self._CHAT_MESSAGE_TEXT)
        self.Message_Sticker = getValue(dict, "Message.Sticker")
        self.Channel_Management_Remove = getValue(dict, "Channel.Management.Remove")
        self.Paint_Regular = getValue(dict, "Paint.Regular")
        self.Channel_Username_Help = getValue(dict, "Channel.Username.Help")
        self._Profile_CreateEncryptedChatOutdatedError = getValue(dict, "Profile.CreateEncryptedChatOutdatedError")
        self._Profile_CreateEncryptedChatOutdatedError_r = extractArgumentRanges(self._Profile_CreateEncryptedChatOutdatedError)
        self.Login_InactiveHelp = getValue(dict, "Login.InactiveHelp")
        self.ChatSettings_Security = getValue(dict, "ChatSettings.Security")
        self._Time_PreciseDate_9 = getValue(dict, "Time.PreciseDate_9")
        self._Time_PreciseDate_9_r = extractArgumentRanges(self._Time_PreciseDate_9)
        self._PINNED_STICKER = getValue(dict, "PINNED_STICKER")
        self._PINNED_STICKER_r = extractArgumentRanges(self._PINNED_STICKER)
        self.Conversation_ShareInlineBotLocationConfirmation = getValue(dict, "Conversation.ShareInlineBotLocationConfirmation")
        self._Channel_AdminLog_MessageEdited = getValue(dict, "Channel.AdminLog.MessageEdited")
        self._Channel_AdminLog_MessageEdited_r = extractArgumentRanges(self._Channel_AdminLog_MessageEdited)
        self._PHONE_CALL_REQUEST = getValue(dict, "PHONE_CALL_REQUEST")
        self._PHONE_CALL_REQUEST_r = extractArgumentRanges(self._PHONE_CALL_REQUEST)
        self.AccessDenied_MicrophoneRestricted = getValue(dict, "AccessDenied.MicrophoneRestricted")
        self.Your_cards_expiration_year_is_invalid = getValue(dict, "Your_cards_expiration_year_is_invalid")
        self.GroupInfo_InviteByLink = getValue(dict, "GroupInfo.InviteByLink")
        self._Notification_LeftChat = getValue(dict, "Notification.LeftChat")
        self._Notification_LeftChat_r = extractArgumentRanges(self._Notification_LeftChat)
        self._Channel_AdminLog_MessageAdmin = getValue(dict, "Channel.AdminLog.MessageAdmin")
        self._Channel_AdminLog_MessageAdmin_r = extractArgumentRanges(self._Channel_AdminLog_MessageAdmin)
        self.PrivacyLastSeenSettings_NeverShareWith_Placeholder = getValue(dict, "PrivacyLastSeenSettings.NeverShareWith.Placeholder")
        self.TwoStepAuth_SetupEmail = getValue(dict, "TwoStepAuth.SetupEmail")
        self.Login_ResetAccountProtected_Reset = getValue(dict, "Login.ResetAccountProtected.Reset")
        self._MESSAGE_CONTACT = getValue(dict, "MESSAGE_CONTACT")
        self._MESSAGE_CONTACT_r = extractArgumentRanges(self._MESSAGE_CONTACT)
        self._Group_Management_ErrorNotMember = getValue(dict, "Group.Management.ErrorNotMember")
        self._Group_Management_ErrorNotMember_r = extractArgumentRanges(self._Group_Management_ErrorNotMember)
        self.MediaPicker_MomentsDateRangeSameMonthYearFormat = getValue(dict, "MediaPicker.MomentsDateRangeSameMonthYearFormat")
        self.Notification_MessageLifetime1w = getValue(dict, "Notification.MessageLifetime1w")
        self.PasscodeSettings_AutoLock_IfAwayFor_5minutes = getValue(dict, "PasscodeSettings.AutoLock.IfAwayFor_5minutes")
        self.ChatSettings_Groups = getValue(dict, "ChatSettings.Groups")
        self.State_Connecting = getValue(dict, "State.Connecting")
        self._Message_ForwardedMessageShort = getValue(dict, "Message.ForwardedMessageShort")
        self._Message_ForwardedMessageShort_r = extractArgumentRanges(self._Message_ForwardedMessageShort)
        self.Watch_ConnectionDescription = getValue(dict, "Watch.ConnectionDescription")
        self._Notification_CallTimeFormat = getValue(dict, "Notification.CallTimeFormat")
        self._Notification_CallTimeFormat_r = extractArgumentRanges(self._Notification_CallTimeFormat)
        self.Paint_Delete = getValue(dict, "Paint.Delete")
        self.Channel_MessagePhotoUpdated = getValue(dict, "Channel.MessagePhotoUpdated")
        self.SharedMedia_All = getValue(dict, "SharedMedia.All")
        self.Cache_Help = getValue(dict, "Cache.Help")
        self._Login_EmailPhoneBody = getValue(dict, "Login.EmailPhoneBody")
        self._Login_EmailPhoneBody_r = extractArgumentRanges(self._Login_EmailPhoneBody)
        self.Checkout_ShippingAddress = getValue(dict, "Checkout.ShippingAddress")
        self.Channel_BanList_RestrictedTitle = getValue(dict, "Channel.BanList.RestrictedTitle")
        self.Checkout_TotalAmount = getValue(dict, "Checkout.TotalAmount")
        self.Conversation_MessageEditedLabel = getValue(dict, "Conversation.MessageEditedLabel")
        self.SharedMedia_EmptyLinksText = getValue(dict, "SharedMedia.EmptyLinksText")
        self.Channel_Members_Kick = getValue(dict, "Channel.Members.Kick")
        self.GoogleDrive_FolderIsEmpty = getValue(dict, "GoogleDrive.FolderIsEmpty")
        self.Calls_NoCallsPlaceholder = getValue(dict, "Calls.NoCallsPlaceholder")
        self.Message_PinnedDeletedMessage = getValue(dict, "Message.PinnedDeletedMessage")
        self.Conversation_PinMessageAlert_OnlyPin = getValue(dict, "Conversation.PinMessageAlert.OnlyPin")
        self.ReportPeer_ReasonOther_Send = getValue(dict, "ReportPeer.ReasonOther.Send")
        self.Conversation_InstantPagePreview = getValue(dict, "Conversation.InstantPagePreview")
        self.PasscodeSettings_SimplePasscodeHelp = getValue(dict, "PasscodeSettings.SimplePasscodeHelp")
        self.Group_ErrorAddTooMuch = getValue(dict, "Group.ErrorAddTooMuch")
        self.GroupInfo_Title = getValue(dict, "GroupInfo.Title")
        self.State_Updating = getValue(dict, "State.Updating")
        self.StickerSettings_ContextShow = getValue(dict, "StickerSettings.ContextShow")
        self.Map_GetDirections = getValue(dict, "Map.GetDirections")
        self._TwoStepAuth_PendingEmailHelp = getValue(dict, "TwoStepAuth.PendingEmailHelp")
        self._TwoStepAuth_PendingEmailHelp_r = extractArgumentRanges(self._TwoStepAuth_PendingEmailHelp)
        self.UserInfo_PhoneCall = getValue(dict, "UserInfo.PhoneCall")
        self.MusicPlayer_VoiceNote = getValue(dict, "MusicPlayer.VoiceNote")
        self.Paint_Duplicate = getValue(dict, "Paint.Duplicate")
        self.Channel_Username_InvalidTaken = getValue(dict, "Channel.Username.InvalidTaken")
        self._Profile_ShareContactGroupFormat = getValue(dict, "Profile.ShareContactGroupFormat")
        self._Profile_ShareContactGroupFormat_r = extractArgumentRanges(self._Profile_ShareContactGroupFormat)
        self.SecretChat_Title = getValue(dict, "SecretChat.Title")
        self.Group_UpgradeConfirmation = getValue(dict, "Group.UpgradeConfirmation")
        self.Checkout_LiabilityAlertTitle = getValue(dict, "Checkout.LiabilityAlertTitle")
        self.GroupInfo_GroupNamePlaceholder = getValue(dict, "GroupInfo.GroupNamePlaceholder")
        self.Conversation_InfoBroadcastList = getValue(dict, "Conversation.InfoBroadcastList")
        self._Notification_JoinedGroupByLink = getValue(dict, "Notification.JoinedGroupByLink")
        self._Notification_JoinedGroupByLink_r = extractArgumentRanges(self._Notification_JoinedGroupByLink)
        self._Time_PreciseDate_8 = getValue(dict, "Time.PreciseDate_8")
        self._Time_PreciseDate_8_r = extractArgumentRanges(self._Time_PreciseDate_8)
        self.Login_HaveNotReceivedCodeInternal = getValue(dict, "Login.HaveNotReceivedCodeInternal")
        self.LoginPassword_Title = getValue(dict, "LoginPassword.Title")
        self.Conversation_PlayVideo = getValue(dict, "Conversation.PlayVideo")
        self.PasscodeSettings_SimplePasscode = getValue(dict, "PasscodeSettings.SimplePasscode")
        self.Conversation_MicrophoneAccessDisabled = getValue(dict, "Conversation.MicrophoneAccessDisabled")
        self.NewContact_Title = getValue(dict, "NewContact.Title")
        self.Username_CheckingUsername = getValue(dict, "Username.CheckingUsername")
        self.Login_ResetAccountProtected_TimerTitle = getValue(dict, "Login.ResetAccountProtected.TimerTitle")
        self.UserInfo_InviteBotToGroup = getValue(dict, "UserInfo.InviteBotToGroup")
        self.Checkout_Email = getValue(dict, "Checkout.Email")
        self.CheckoutInfo_SaveInfo = getValue(dict, "CheckoutInfo.SaveInfo")
        self._ChangePhoneNumberCode_CallTimer = getValue(dict, "ChangePhoneNumberCode.CallTimer")
        self._ChangePhoneNumberCode_CallTimer_r = extractArgumentRanges(self._ChangePhoneNumberCode_CallTimer)
        self.TwoStepAuth_SetupPasswordEnterPasswordNew = getValue(dict, "TwoStepAuth.SetupPasswordEnterPasswordNew")
        self.Weekday_Wednesday = getValue(dict, "Weekday.Wednesday")
        self._Channel_AdminLog_MessageToggleSignaturesOff = getValue(dict, "Channel.AdminLog.MessageToggleSignaturesOff")
        self._Channel_AdminLog_MessageToggleSignaturesOff_r = extractArgumentRanges(self._Channel_AdminLog_MessageToggleSignaturesOff)
        self.Month_ShortDecember = getValue(dict, "Month.ShortDecember")
        self.Channel_SignMessages = getValue(dict, "Channel.SignMessages")
        self.Conversation_Moderate_Delete = getValue(dict, "Conversation.Moderate.Delete")
        self.Conversation_CloudStorage_ChatStatus = getValue(dict, "Conversation.CloudStorage.ChatStatus")
        self.Login_InfoTitle = getValue(dict, "Login.InfoTitle")
        self.Privacy_GroupsAndChannels_NeverAllow_Placeholder = getValue(dict, "Privacy.GroupsAndChannels.NeverAllow.Placeholder")
        self.Message_Video = getValue(dict, "Message.Video")
        self.Notification_ChannelInviterSelf = getValue(dict, "Notification.ChannelInviterSelf")
        self._VideoPreview_OptionSD = getValue(dict, "VideoPreview.OptionSD")
        self._VideoPreview_OptionSD_r = extractArgumentRanges(self._VideoPreview_OptionSD)
        self.Conversation_SecretLinkPreviewAlert = getValue(dict, "Conversation.SecretLinkPreviewAlert")
        self.Channel_AdminLog_BanEmbedLinks = getValue(dict, "Channel.AdminLog.BanEmbedLinks")
        self.Cache_Videos = getValue(dict, "Cache.Videos")
        self.NetworkUsageSettings_MediaImageDataSection = getValue(dict, "NetworkUsageSettings.MediaImageDataSection")
        self.TwoStepAuth_GenericHelp = getValue(dict, "TwoStepAuth.GenericHelp")
        self._DialogList_SingleRecordingAudioSuffix = getValue(dict, "DialogList.SingleRecordingAudioSuffix")
        self._DialogList_SingleRecordingAudioSuffix_r = extractArgumentRanges(self._DialogList_SingleRecordingAudioSuffix)
        self.Checkout_NewCard_CardholderNameTitle = getValue(dict, "Checkout.NewCard.CardholderNameTitle")
        self.Settings_FAQ_Button = getValue(dict, "Settings.FAQ_Button")
        self._GroupInfo_AddParticipantConfirmation = getValue(dict, "GroupInfo.AddParticipantConfirmation")
        self._GroupInfo_AddParticipantConfirmation_r = extractArgumentRanges(self._GroupInfo_AddParticipantConfirmation)
        self.AccessDenied_PhotosRestricted = getValue(dict, "AccessDenied.PhotosRestricted")
        self.Map_Locating = getValue(dict, "Map.Locating")
        self._SearchImages_Downloading_Kb = getValue(dict, "SearchImages.Downloading#Kb")
        self._SearchImages_Downloading_Kb_r = extractArgumentRanges(self._SearchImages_Downloading_Kb)
        self._Profile_ShareBotPersonFormat = getValue(dict, "Profile.ShareBotPersonFormat")
        self._Profile_ShareBotPersonFormat_r = extractArgumentRanges(self._Profile_ShareBotPersonFormat)
        self.SearchImages_SearchImages = getValue(dict, "SearchImages.SearchImages")
        self.SharedMedia_EmptyMusicText = getValue(dict, "SharedMedia.EmptyMusicText")
        self.Cache_ByPeerHeader = getValue(dict, "Cache.ByPeerHeader")
        self.Bot_GroupStatusReadsHistory = getValue(dict, "Bot.GroupStatusReadsHistory")
        self.TwoStepAuth_ResetAccountConfirmation = getValue(dict, "TwoStepAuth.ResetAccountConfirmation")
        self.CallSettings_Always = getValue(dict, "CallSettings.Always")
        self.SearchImages_DownloadCancelled = getValue(dict, "SearchImages.DownloadCancelled")
        self.Settings_LogoutConfirmationTitle = getValue(dict, "Settings.LogoutConfirmationTitle")
        self.UserInfo_FirstNamePlaceholder = getValue(dict, "UserInfo.FirstNamePlaceholder")
        self.ChatSettings_AutoPlayAudio = getValue(dict, "ChatSettings.AutoPlayAudio")
        self.LoginPassword_ResetAccount = getValue(dict, "LoginPassword.ResetAccount")
        self.Privacy_GroupsAndChannels_AlwaysAllow = getValue(dict, "Privacy.GroupsAndChannels.AlwaysAllow")
        self._Notification_JoinedChat = getValue(dict, "Notification.JoinedChat")
        self._Notification_JoinedChat_r = extractArgumentRanges(self._Notification_JoinedChat)
        self.ChannelInfo_DeleteChannel = getValue(dict, "ChannelInfo.DeleteChannel")
        self.NetworkUsageSettings_BytesReceived = getValue(dict, "NetworkUsageSettings.BytesReceived")
        self.BlockedUsers_BlockTitle = getValue(dict, "BlockedUsers.BlockTitle")
        self.AccessDenied_PhotosAndVideos = getValue(dict, "AccessDenied.PhotosAndVideos")
        self.Channel_Username_Title = getValue(dict, "Channel.Username.Title")
        self._Channel_AdminLog_MessageToggleSignaturesOn = getValue(dict, "Channel.AdminLog.MessageToggleSignaturesOn")
        self._Channel_AdminLog_MessageToggleSignaturesOn_r = extractArgumentRanges(self._Channel_AdminLog_MessageToggleSignaturesOn)
        self._Conversation_EncryptionWaiting = getValue(dict, "Conversation.EncryptionWaiting")
        self._Conversation_EncryptionWaiting_r = extractArgumentRanges(self._Conversation_EncryptionWaiting)
        self.Calls_NotNow = getValue(dict, "Calls.NotNow")
        self.Conversation_Report = getValue(dict, "Conversation.Report")
        self._CHANNEL_MESSAGE_DOC = getValue(dict, "CHANNEL_MESSAGE_DOC")
        self._CHANNEL_MESSAGE_DOC_r = extractArgumentRanges(self._CHANNEL_MESSAGE_DOC)
        self.Channel_AdminLogFilter_EventsAll = getValue(dict, "Channel.AdminLogFilter.EventsAll")
        self.Call_ConnectionErrorTitle = getValue(dict, "Call.ConnectionErrorTitle")
        self.Settings_ChatSettings = getValue(dict, "Settings.ChatSettings")
        self.Group_About_Help = getValue(dict, "Group.About.Help")
        self._CHANNEL_MESSAGE_NOTEXT = getValue(dict, "CHANNEL_MESSAGE_NOTEXT")
        self._CHANNEL_MESSAGE_NOTEXT_r = extractArgumentRanges(self._CHANNEL_MESSAGE_NOTEXT)
        self.Month_GenSeptember = getValue(dict, "Month.GenSeptember")
        self.PrivacySettings_LastSeenEverybody = getValue(dict, "PrivacySettings.LastSeenEverybody")
        self.PhotoEditor_BlurToolRadial = getValue(dict, "PhotoEditor.BlurToolRadial")
        self.TwoStepAuth_PasswordRemoveConfirmation = getValue(dict, "TwoStepAuth.PasswordRemoveConfirmation")
        self.Channel_EditAdmin_PermissionEditMessages = getValue(dict, "Channel.EditAdmin.PermissionEditMessages")
        self.TwoStepAuth_ChangePassword = getValue(dict, "TwoStepAuth.ChangePassword")
        self.Watch_MessageView_Title = getValue(dict, "Watch.MessageView.Title")
        self._Notification_PinnedRoundMessage = getValue(dict, "Notification.PinnedRoundMessage")
        self._Notification_PinnedRoundMessage_r = extractArgumentRanges(self._Notification_PinnedRoundMessage)
        self.Conversation_DeleteGroup = getValue(dict, "Conversation.DeleteGroup")
        self._Time_PreciseDate_7 = getValue(dict, "Time.PreciseDate_7")
        self._Time_PreciseDate_7_r = extractArgumentRanges(self._Time_PreciseDate_7)
        self.Channel_Management_LabelCreator = getValue(dict, "Channel.Management.LabelCreator")
        self._Notification_PinnedStickerMessage = getValue(dict, "Notification.PinnedStickerMessage")
        self._Notification_PinnedStickerMessage_r = extractArgumentRanges(self._Notification_PinnedStickerMessage)
        self.Settings_SaveEditedPhotos = getValue(dict, "Settings.SaveEditedPhotos")
        self.PhotoEditor_QualityTool = getValue(dict, "PhotoEditor.QualityTool")
        self.Login_NetworkError = getValue(dict, "Login.NetworkError")
        self.TwoStepAuth_EnterPasswordForgot = getValue(dict, "TwoStepAuth.EnterPasswordForgot")
        self.Compose_ChannelMembers = getValue(dict, "Compose.ChannelMembers")
        self.Common_Yes = getValue(dict, "Common.Yes")
        self.KeyCommand_JumpToPreviousUnreadChat = getValue(dict, "KeyCommand.JumpToPreviousUnreadChat")
        self.CheckoutInfo_ReceiverInfoPhone = getValue(dict, "CheckoutInfo.ReceiverInfoPhone")
        self.GroupInfo_AddParticipantTitle = getValue(dict, "GroupInfo.AddParticipantTitle")
        self._CHANNEL_MESSAGE_TEXT = getValue(dict, "CHANNEL_MESSAGE_TEXT")
        self._CHANNEL_MESSAGE_TEXT_r = extractArgumentRanges(self._CHANNEL_MESSAGE_TEXT)
        self.Checkout_PayNone = getValue(dict, "Checkout.PayNone")
        self.CheckoutInfo_ErrorNameInvalid = getValue(dict, "CheckoutInfo.ErrorNameInvalid")
        self.Channel_Share = getValue(dict, "Channel.Share")
        self.Notification_PaymentSent = getValue(dict, "Notification.PaymentSent")
        self.Settings_Username = getValue(dict, "Settings.Username")
        self.Notification_CallMissedShort = getValue(dict, "Notification.CallMissedShort")
        self.Call_CallInProgressTitle = getValue(dict, "Call.CallInProgressTitle")
        self.PhotoEditor_Skip = getValue(dict, "PhotoEditor.Skip")
        self.AuthSessions_TerminateOtherSessionsHelp = getValue(dict, "AuthSessions.TerminateOtherSessionsHelp")
        self.Call_AudioRouteHeadphones = getValue(dict, "Call.AudioRouteHeadphones")
        self.Contacts_InviteFriends = getValue(dict, "Contacts.InviteFriends")
        self.Channel_BanUser_PermissionSendMessages = getValue(dict, "Channel.BanUser.PermissionSendMessages")
        self.Notifications_InAppNotificationsVibrate = getValue(dict, "Notifications.InAppNotificationsVibrate")
        self.StickerPack_Share = getValue(dict, "StickerPack.Share")
        self.Watch_MessageView_Reply = getValue(dict, "Watch.MessageView.Reply")
        self.Call_AudioRouteSpeaker = getValue(dict, "Call.AudioRouteSpeaker")
        self.PrivacySettings_DeleteAccountNever = getValue(dict, "PrivacySettings.DeleteAccountNever")
        self._WelcomeScreen_ContactsAccessHelp = getValue(dict, "WelcomeScreen.ContactsAccessHelp")
        self._WelcomeScreen_ContactsAccessHelp_r = extractArgumentRanges(self._WelcomeScreen_ContactsAccessHelp)
        self._MESSAGE_GEO = getValue(dict, "MESSAGE_GEO")
        self._MESSAGE_GEO_r = extractArgumentRanges(self._MESSAGE_GEO)
        self.Checkout_Title = getValue(dict, "Checkout.Title")
        self.Privacy_Calls = getValue(dict, "Privacy.Calls")
        self.Channel_AdminLogFilter_EventsInfo = getValue(dict, "Channel.AdminLogFilter.EventsInfo")
        self._Channel_AdminLog_MessagePinned = getValue(dict, "Channel.AdminLog.MessagePinned")
        self._Channel_AdminLog_MessagePinned_r = extractArgumentRanges(self._Channel_AdminLog_MessagePinned)
        self._Channel_AdminLog_MessageToggleInvitesOn = getValue(dict, "Channel.AdminLog.MessageToggleInvitesOn")
        self._Channel_AdminLog_MessageToggleInvitesOn_r = extractArgumentRanges(self._Channel_AdminLog_MessageToggleInvitesOn)
        self.Conversation_SearchWebImages = getValue(dict, "Conversation.SearchWebImages")
        self.KeyCommand_ScrollDown = getValue(dict, "KeyCommand.ScrollDown")
        self.Conversation_LinkDialogSave = getValue(dict, "Conversation.LinkDialogSave")
        self.Presence_offline = getValue(dict, "Presence.offline")
        self.Conversation_SendMessageErrorFlood = getValue(dict, "Conversation.SendMessageErrorFlood")
        self._Conversation_ForwardToPersonFormat = getValue(dict, "Conversation.ForwardToPersonFormat")
        self._Conversation_ForwardToPersonFormat_r = extractArgumentRanges(self._Conversation_ForwardToPersonFormat)
        self.CheckoutInfo_ErrorShippingNotAvailable = getValue(dict, "CheckoutInfo.ErrorShippingNotAvailable")
        self.SharedMedia_Incoming = getValue(dict, "SharedMedia.Incoming")
        self._Checkout_SavePasswordTimeoutAndTouchId = getValue(dict, "Checkout.SavePasswordTimeoutAndTouchId")
        self._Checkout_SavePasswordTimeoutAndTouchId_r = extractArgumentRanges(self._Checkout_SavePasswordTimeoutAndTouchId)
        self.CheckoutInfo_ShippingInfoCountry = getValue(dict, "CheckoutInfo.ShippingInfoCountry")
        self.Map_ShowPlaces = getValue(dict, "Map.ShowPlaces")
        self.Camera_VideoMode = getValue(dict, "Camera.VideoMode")
        self._Watch_Time_ShortFullAt = getValue(dict, "Watch.Time.ShortFullAt")
        self._Watch_Time_ShortFullAt_r = extractArgumentRanges(self._Watch_Time_ShortFullAt)
        self.UserInfo_TelegramCall = getValue(dict, "UserInfo.TelegramCall")
        self.PrivacyLastSeenSettings_CustomShareSettingsHelp = getValue(dict, "PrivacyLastSeenSettings.CustomShareSettingsHelp")
        self.Channel_AdminLog_InfoPanelAlertText = getValue(dict, "Channel.AdminLog.InfoPanelAlertText")
        self.Watch_State_WaitingForNetwork = getValue(dict, "Watch.State.WaitingForNetwork")
        self.Cache_Photos = getValue(dict, "Cache.Photos")
        self.Message_PinnedStickerMessage = getValue(dict, "Message.PinnedStickerMessage")
        self.PhotoEditor_QualityMedium = getValue(dict, "PhotoEditor.QualityMedium")
        self.Privacy_PaymentsClearInfo = getValue(dict, "Privacy.PaymentsClearInfo")
        self.PhotoEditor_CurvesRed = getValue(dict, "PhotoEditor.CurvesRed")
        self.Privacy_PaymentsTitle = getValue(dict, "Privacy.PaymentsTitle")
        self.Login_PhoneNumberHelp = getValue(dict, "Login.PhoneNumberHelp")
        self.User_DeletedAccount = getValue(dict, "User.DeletedAccount")
        self.Call_StatusFailed = getValue(dict, "Call.StatusFailed")
        self._Notification_GroupInviter = getValue(dict, "Notification.GroupInviter")
        self._Notification_GroupInviter_r = extractArgumentRanges(self._Notification_GroupInviter)
        self.Localization_ChooseLanguage = getValue(dict, "Localization.ChooseLanguage")
        self.CheckoutInfo_ShippingInfoAddress2Placeholder = getValue(dict, "CheckoutInfo.ShippingInfoAddress2Placeholder")
        self._Notification_SecretChatMessageScreenshot = getValue(dict, "Notification.SecretChatMessageScreenshot")
        self._Notification_SecretChatMessageScreenshot_r = extractArgumentRanges(self._Notification_SecretChatMessageScreenshot)
        self._DialogList_SingleUploadingPhotoSuffix = getValue(dict, "DialogList.SingleUploadingPhotoSuffix")
        self._DialogList_SingleUploadingPhotoSuffix_r = extractArgumentRanges(self._DialogList_SingleUploadingPhotoSuffix)
        self.Channel_LeaveChannel = getValue(dict, "Channel.LeaveChannel")
        self.Compose_NewGroup = getValue(dict, "Compose.NewGroup")
        self.TwoStepAuth_EmailPlaceholder = getValue(dict, "TwoStepAuth.EmailPlaceholder")
        self.PhotoEditor_ExposureTool = getValue(dict, "PhotoEditor.ExposureTool")
        self.ChatAdmins_AdminLabel = getValue(dict, "ChatAdmins.AdminLabel")
        self.Contacts_FailedToSendInvitesMessage = getValue(dict, "Contacts.FailedToSendInvitesMessage")
        self.Login_Code = getValue(dict, "Login.Code")
        self.Channel_Username_InvalidCharacters = getValue(dict, "Channel.Username.InvalidCharacters")
        self.Calls_CallTabTitle = getValue(dict, "Calls.CallTabTitle")
        self.FeatureDisabled_Oops = getValue(dict, "FeatureDisabled.Oops")
        self.Login_InviteButton = getValue(dict, "Login.InviteButton")
        self.ShareMenu_Send = getValue(dict, "ShareMenu.Send")
        self.Conversation_InfoGroup = getValue(dict, "Conversation.InfoGroup")
        self.WatchRemote_AlertTitle = getValue(dict, "WatchRemote.AlertTitle")
        self.Preview_ProfilePhotoTitle = getValue(dict, "Preview.ProfilePhotoTitle")
        self.Checkout_Phone = getValue(dict, "Checkout.Phone")
        self.Channel_SignMessages_Help = getValue(dict, "Channel.SignMessages.Help")
        self.Calls_SubmitRating = getValue(dict, "Calls.SubmitRating")
        self.Camera_FlashOn = getValue(dict, "Camera.FlashOn")
        self.Watch_MessageView_Forward = getValue(dict, "Watch.MessageView.Forward")
        self._Time_PreciseDate_6 = getValue(dict, "Time.PreciseDate_6")
        self._Time_PreciseDate_6_r = extractArgumentRanges(self._Time_PreciseDate_6)
        self.DialogList_You = getValue(dict, "DialogList.You")
        self.Weekday_Monday = getValue(dict, "Weekday.Monday")
        self.Watch_Suggestion_Yes = getValue(dict, "Watch.Suggestion.Yes")
        self.AccessDenied_Camera = getValue(dict, "AccessDenied.Camera")
        self.WatchRemote_NotificationText = getValue(dict, "WatchRemote.NotificationText")
        self.Activity_Location = getValue(dict, "Activity.Location")
        self.SharedMedia_ViewInChat = getValue(dict, "SharedMedia.ViewInChat")
        self.Activity_RecordingAudio = getValue(dict, "Activity.RecordingAudio")
        self.Watch_Stickers_StickerPacks = getValue(dict, "Watch.Stickers.StickerPacks")
        self._Target_ShareGameConfirmationPrivate = getValue(dict, "Target.ShareGameConfirmationPrivate")
        self._Target_ShareGameConfirmationPrivate_r = extractArgumentRanges(self._Target_ShareGameConfirmationPrivate)
        self.Checkout_NewCard_PostcodePlaceholder = getValue(dict, "Checkout.NewCard.PostcodePlaceholder")
        self.Conversation_SearchImages = getValue(dict, "Conversation.SearchImages")
        self.DialogList_DeleteConversationConfirmation = getValue(dict, "DialogList.DeleteConversationConfirmation")
        self.AttachmentMenu_SendAsFile = getValue(dict, "AttachmentMenu.SendAsFile")
        self.Message_GamePreviewLabel = getValue(dict, "Message.GamePreviewLabel")
        self.Checkout_ShippingOption_Header = getValue(dict, "Checkout.ShippingOption.Header")
        self.Watch_Conversation_Unblock = getValue(dict, "Watch.Conversation.Unblock")
        self.Channel_AdminLog_MessagePreviousLink = getValue(dict, "Channel.AdminLog.MessagePreviousLink")
        self.CallSettings_PrivacyDescription = getValue(dict, "CallSettings.PrivacyDescription")
        self.Conversation_ContextMenuCopy = getValue(dict, "Conversation.ContextMenuCopy")
        self.GroupInfo_UpgradeButton = getValue(dict, "GroupInfo.UpgradeButton")
        self.PrivacyLastSeenSettings_NeverShareWith = getValue(dict, "PrivacyLastSeenSettings.NeverShareWith")
        self.ConvertToSupergroup_HelpText = getValue(dict, "ConvertToSupergroup.HelpText")
        self.MediaPicker_VideoMuteDescription = getValue(dict, "MediaPicker.VideoMuteDescription")
        self._SearchImages_Downloading_Mb = getValue(dict, "SearchImages.Downloading#Mb")
        self._SearchImages_Downloading_Mb_r = extractArgumentRanges(self._SearchImages_Downloading_Mb)
        self.UserInfo_ShareMyContactInfo = getValue(dict, "UserInfo.ShareMyContactInfo")
        self._FileSize_GB = getValue(dict, "FileSize.GB")
        self._FileSize_GB_r = extractArgumentRanges(self._FileSize_GB)
        self.Month_ShortJanuary = getValue(dict, "Month.ShortJanuary")
        self.Channel_BanUser_PermissionsHeader = getValue(dict, "Channel.BanUser.PermissionsHeader")
        self.PhotoEditor_QualityVeryHigh = getValue(dict, "PhotoEditor.QualityVeryHigh")
        self.Login_TermsOfServiceLabel = getValue(dict, "Login.TermsOfServiceLabel")
        self._MESSAGE_TEXT = getValue(dict, "MESSAGE_TEXT")
        self._MESSAGE_TEXT_r = extractArgumentRanges(self._MESSAGE_TEXT)
        self.DialogList_NoMessagesTitle = getValue(dict, "DialogList.NoMessagesTitle")
        self.AccessDenied_Contacts = getValue(dict, "AccessDenied.Contacts")
        self.Your_cards_security_code_is_invalid = getValue(dict, "Your_cards_security_code_is_invalid")
        self.Tour_StartButton = getValue(dict, "Tour.StartButton")
        self.CheckoutInfo_Title = getValue(dict, "CheckoutInfo.Title")
        self.ChangePhoneNumberCode_Help = getValue(dict, "ChangePhoneNumberCode.Help")
        self.Web_Error = getValue(dict, "Web.Error")
        self.ShareFileTip_Title = getValue(dict, "ShareFileTip.Title")
        self.Username_InvalidStartsWithNumber = getValue(dict, "Username.InvalidStartsWithNumber")
        self.ChatSettings_RevertLanguage = getValue(dict, "ChatSettings.RevertLanguage")
        self.Conversation_ReportSpamAndLeave = getValue(dict, "Conversation.ReportSpamAndLeave")
        self._DialogList_EncryptedChatStartedIncoming = getValue(dict, "DialogList.EncryptedChatStartedIncoming")
        self._DialogList_EncryptedChatStartedIncoming_r = extractArgumentRanges(self._DialogList_EncryptedChatStartedIncoming)
        self.Calls_AddTab = getValue(dict, "Calls.AddTab")
        self.ChannelMembers_WhoCanAddMembers_Admins = getValue(dict, "ChannelMembers.WhoCanAddMembers.Admins")
        self.Tour_Text5 = getValue(dict, "Tour.Text5")
        self.Watch_Stickers_RecentPlaceholder = getValue(dict, "Watch.Stickers.RecentPlaceholder")
        self.Common_Select = getValue(dict, "Common.Select")
        self._Notification_MessageLifetimeRemoved = getValue(dict, "Notification.MessageLifetimeRemoved")
        self._Notification_MessageLifetimeRemoved_r = extractArgumentRanges(self._Notification_MessageLifetimeRemoved)
        self._PINNED_INVOICE = getValue(dict, "PINNED_INVOICE")
        self._PINNED_INVOICE_r = extractArgumentRanges(self._PINNED_INVOICE)
        self.Month_GenFebruary = getValue(dict, "Month.GenFebruary")
        self.Contacts_SelectAll = getValue(dict, "Contacts.SelectAll")
        self.Month_GenOctober = getValue(dict, "Month.GenOctober")
        self.CheckoutInfo_ErrorPhoneInvalid = getValue(dict, "CheckoutInfo.ErrorPhoneInvalid")
        self.SharedMedia_TitleVideo = getValue(dict, "SharedMedia.TitleVideo")
        self.Checkout_PaymentMethod_New = getValue(dict, "Checkout.PaymentMethod.New")
        self.ShareMenu_Comment = getValue(dict, "ShareMenu.Comment")
        self.Channel_Management_LabelEditor = getValue(dict, "Channel.Management.LabelEditor")
        self.TwoStepAuth_SetPasswordHelp = getValue(dict, "TwoStepAuth.SetPasswordHelp")
        self.Channel_AdminLogFilter_EventsTitle = getValue(dict, "Channel.AdminLogFilter.EventsTitle")
        self.Username_LinkCopied = getValue(dict, "Username.LinkCopied")
        self.DialogList_Conversations = getValue(dict, "DialogList.Conversations")
        self.Channel_EditAdmin_PermissionAddAdmins = getValue(dict, "Channel.EditAdmin.PermissionAddAdmins")
        self.Conversation_SendMessage = getValue(dict, "Conversation.SendMessage")
        self.Notification_CallIncoming = getValue(dict, "Notification.CallIncoming")
        self._MESSAGE_FWDS = getValue(dict, "MESSAGE_FWDS")
        self._MESSAGE_FWDS_r = extractArgumentRanges(self._MESSAGE_FWDS)
        self._Time_PreciseDate_5 = getValue(dict, "Time.PreciseDate_5")
        self._Time_PreciseDate_5_r = extractArgumentRanges(self._Time_PreciseDate_5)
        self.Conversation_InputTextCommentPlaceholder = getValue(dict, "Conversation.InputTextCommentPlaceholder")
        self.Map_OpenInYandexMaps = getValue(dict, "Map.OpenInYandexMaps")
        self.Month_ShortNovember = getValue(dict, "Month.ShortNovember")
        self.AccessDenied_Settings = getValue(dict, "AccessDenied.Settings")
        self.EncryptionKey_Title = getValue(dict, "EncryptionKey.Title")
        self.Profile_MessageLifetime1h = getValue(dict, "Profile.MessageLifetime1h")
        self._Map_DistanceAway = getValue(dict, "Map.DistanceAway")
        self._Map_DistanceAway_r = extractArgumentRanges(self._Map_DistanceAway)
        self.Compose_NewMessage = getValue(dict, "Compose.NewMessage")
        self.Checkout_ErrorPaymentFailed = getValue(dict, "Checkout.ErrorPaymentFailed")
        self.Map_OpenInWaze = getValue(dict, "Map.OpenInWaze")
        self.Common_ChooseVideo = getValue(dict, "Common.ChooseVideo")
        self.Checkout_ShippingMethod = getValue(dict, "Checkout.ShippingMethod")
        self.Login_InfoFirstNamePlaceholder = getValue(dict, "Login.InfoFirstNamePlaceholder")
        self.DialogList_Broadcast = getValue(dict, "DialogList.Broadcast")
        self.Checkout_ErrorProviderAccountInvalid = getValue(dict, "Checkout.ErrorProviderAccountInvalid")
        self.CallSettings_TabIconDescription = getValue(dict, "CallSettings.TabIconDescription")
        self.Checkout_WebConfirmation_Title = getValue(dict, "Checkout.WebConfirmation.Title")
        self.PasscodeSettings_AutoLock = getValue(dict, "PasscodeSettings.AutoLock")
        self.Notifications_MessageNotificationsPreview = getValue(dict, "Notifications.MessageNotificationsPreview")
        self.Conversation_BlockUser = getValue(dict, "Conversation.BlockUser")
        self.MessageTimer_Custom = getValue(dict, "MessageTimer.Custom")
        self.Conversation_SilentBroadcastTooltipOff = getValue(dict, "Conversation.SilentBroadcastTooltipOff")
        self.Conversation_Mute = getValue(dict, "Conversation.Mute")
        self.Call_CallBack = getValue(dict, "Call.CallBack")
        self.CreateGroup_SoftUserLimitAlert = getValue(dict, "CreateGroup.SoftUserLimitAlert")
        self.AccessDenied_LocationDenied = getValue(dict, "AccessDenied.LocationDenied")
        self.Tour_Title6 = getValue(dict, "Tour.Title6")
        self.Settings_UsernameEmpty = getValue(dict, "Settings.UsernameEmpty")
        self.PrivacySettings_TwoStepAuth = getValue(dict, "PrivacySettings.TwoStepAuth")
        self.Conversation_FileICloudDrive = getValue(dict, "Conversation.FileICloudDrive")
        self.KeyCommand_SendMessage = getValue(dict, "KeyCommand.SendMessage")
        self._Channel_AdminLog_MessageDeleted = getValue(dict, "Channel.AdminLog.MessageDeleted")
        self._Channel_AdminLog_MessageDeleted_r = extractArgumentRanges(self._Channel_AdminLog_MessageDeleted)
        self.DialogList_DeleteBotConfirmation = getValue(dict, "DialogList.DeleteBotConfirmation")
        self.Common_TakePhotoOrVideo = getValue(dict, "Common.TakePhotoOrVideo")
        self.Notification_MessageLifetime2s = getValue(dict, "Notification.MessageLifetime2s")
        self.Checkout_ErrorGeneric = getValue(dict, "Checkout.ErrorGeneric")
        self.Conversation_FileGoogleDrive = getValue(dict, "Conversation.FileGoogleDrive")
        self._MediaPicker_Processing = getValue(dict, "MediaPicker.Processing")
        self._MediaPicker_Processing_r = extractArgumentRanges(self._MediaPicker_Processing)
        self.Channel_AdminLog_CanBanUsers = getValue(dict, "Channel.AdminLog.CanBanUsers")
        self.Cache_Indexing = getValue(dict, "Cache.Indexing")
        self._ENCRYPTION_REQUEST = getValue(dict, "ENCRYPTION_REQUEST")
        self._ENCRYPTION_REQUEST_r = extractArgumentRanges(self._ENCRYPTION_REQUEST)
        self.StickerSettings_ContextInfo = getValue(dict, "StickerSettings.ContextInfo")
        self.Message_SharedContact = getValue(dict, "Message.SharedContact")
        self.Channel_BanUser_PermissionEmbedLinks = getValue(dict, "Channel.BanUser.PermissionEmbedLinks")
        self.Channel_Username_CreateCommentsEnabled = getValue(dict, "Channel.Username.CreateCommentsEnabled")
        self.GroupInfo_InviteLink_LinkSection = getValue(dict, "GroupInfo.InviteLink.LinkSection")
        self.Privacy_Calls_AlwaysAllow_Placeholder = getValue(dict, "Privacy.Calls.AlwaysAllow.Placeholder")
        self.CheckoutInfo_ShippingInfoPostcode = getValue(dict, "CheckoutInfo.ShippingInfoPostcode")
        self.PasscodeSettings_EncryptDataHelp = getValue(dict, "PasscodeSettings.EncryptDataHelp")
        self.KeyCommand_FocusOnInputField = getValue(dict, "KeyCommand.FocusOnInputField")
        self.Cache_KeepMedia = getValue(dict, "Cache.KeepMedia")
        self.WebPreview_GettingLinkInfo = getValue(dict, "WebPreview.GettingLinkInfo")
        self.Group_Setup_TypePublicHelp = getValue(dict, "Group.Setup.TypePublicHelp")
        self.Channel_Moderator_AccessLevelModeratorHelp = getValue(dict, "Channel.Moderator.AccessLevelModeratorHelp")
        self.Map_Satellite = getValue(dict, "Map.Satellite")
        self.Username_InvalidTaken = getValue(dict, "Username.InvalidTaken")
        self._Notification_PinnedAudioMessage = getValue(dict, "Notification.PinnedAudioMessage")
        self._Notification_PinnedAudioMessage_r = extractArgumentRanges(self._Notification_PinnedAudioMessage)
        self.Notification_MessageLifetime1d = getValue(dict, "Notification.MessageLifetime1d")
        self.Profile_MessageLifetime2s = getValue(dict, "Profile.MessageLifetime2s")
        self._TwoStepAuth_RecoveryEmailUnavailable = getValue(dict, "TwoStepAuth.RecoveryEmailUnavailable")
        self._TwoStepAuth_RecoveryEmailUnavailable_r = extractArgumentRanges(self._TwoStepAuth_RecoveryEmailUnavailable)
        self.Calls_RatingFeedback = getValue(dict, "Calls.RatingFeedback")
        self.Profile_EncryptionKey = getValue(dict, "Profile.EncryptionKey")
        self.Watch_Suggestion_WhatsUp = getValue(dict, "Watch.Suggestion.WhatsUp")
        self.LoginPassword_PasswordPlaceholder = getValue(dict, "LoginPassword.PasswordPlaceholder")
        self.TwoStepAuth_EnterPasswordPassword = getValue(dict, "TwoStepAuth.EnterPasswordPassword")
        self._CHANNEL_MESSAGE_CONTACT = getValue(dict, "CHANNEL_MESSAGE_CONTACT")
        self._CHANNEL_MESSAGE_CONTACT_r = extractArgumentRanges(self._CHANNEL_MESSAGE_CONTACT)
        self.PrivacySettings_DeleteAccountHelp = getValue(dict, "PrivacySettings.DeleteAccountHelp")
        self._Time_PreciseDate_4 = getValue(dict, "Time.PreciseDate_4")
        self._Time_PreciseDate_4_r = extractArgumentRanges(self._Time_PreciseDate_4)
        self.Channel_Info_Banned = getValue(dict, "Channel.Info.Banned")
        self.Conversation_ShareBotContactConfirmationTitle = getValue(dict, "Conversation.ShareBotContactConfirmationTitle")
        self.ConversationProfile_UsersTooMuchError = getValue(dict, "ConversationProfile.UsersTooMuchError")
        self.ChatAdmins_AllMembersAreAdminsOffHelp = getValue(dict, "ChatAdmins.AllMembersAreAdminsOffHelp")
        self.Privacy_GroupsAndChannels_WhoCanAddMe = getValue(dict, "Privacy.GroupsAndChannels.WhoCanAddMe")
        self.Settings_PhoneNumber = getValue(dict, "Settings.PhoneNumber")
        self.Login_CodeExpiredError = getValue(dict, "Login.CodeExpiredError")
        self._DialogList_MultipleTypingSuffix = getValue(dict, "DialogList.MultipleTypingSuffix")
        self._DialogList_MultipleTypingSuffix_r = extractArgumentRanges(self._DialogList_MultipleTypingSuffix)
        self.ChannelMembers_Blacklist_EmptyText = getValue(dict, "ChannelMembers.Blacklist.EmptyText")
        self.Bot_GenericBotStatus = getValue(dict, "Bot.GenericBotStatus")
        self.Common_edit = getValue(dict, "Common.edit")
        self.Settings_AppLanguage = getValue(dict, "Settings.AppLanguage")
        self.PrivacyLastSeenSettings_WhoCanSeeMyTimestamp = getValue(dict, "PrivacyLastSeenSettings.WhoCanSeeMyTimestamp")
        self._Notification_Kicked = getValue(dict, "Notification.Kicked")
        self._Notification_Kicked_r = extractArgumentRanges(self._Notification_Kicked)
        self.Conversation_Send = getValue(dict, "Conversation.Send")
        self.ChannelInfo_DeleteChannelConfirmation = getValue(dict, "ChannelInfo.DeleteChannelConfirmation")
        self.Weekday_ShortSaturday = getValue(dict, "Weekday.ShortSaturday")
        self.Map_SendThisLocation = getValue(dict, "Map.SendThisLocation")
        self.DialogList_RecentTitleBots = getValue(dict, "DialogList.RecentTitleBots")
        self._Notification_PinnedDocumentMessage = getValue(dict, "Notification.PinnedDocumentMessage")
        self._Notification_PinnedDocumentMessage_r = extractArgumentRanges(self._Notification_PinnedDocumentMessage)
        self.Conversation_ContextMenuReply = getValue(dict, "Conversation.ContextMenuReply")
        self.Channel_BanUser_PermissionSendMedia = getValue(dict, "Channel.BanUser.PermissionSendMedia")
        self.NetworkUsageSettings_Wifi = getValue(dict, "NetworkUsageSettings.Wifi")
        self.Call_Accept = getValue(dict, "Call.Accept")
        self.GroupInfo_SetGroupPhotoDelete = getValue(dict, "GroupInfo.SetGroupPhotoDelete")
        self.PhotoEditor_CropAuto = getValue(dict, "PhotoEditor.CropAuto")
        self.PhotoEditor_ContrastTool = getValue(dict, "PhotoEditor.ContrastTool")
        self.MediaPicker_MomentsDateYearFormat = getValue(dict, "MediaPicker.MomentsDateYearFormat")
        self.CheckoutInfo_ReceiverInfoNamePlaceholder = getValue(dict, "CheckoutInfo.ReceiverInfoNamePlaceholder")
        self.Privacy_PaymentsClear_ShippingInfo = getValue(dict, "Privacy.PaymentsClear.ShippingInfo")
        self.TwoStepAuth_GenericError = getValue(dict, "TwoStepAuth.GenericError")
        self.Channel_Moderator_AccessLevelEditorHelp = getValue(dict, "Channel.Moderator.AccessLevelEditorHelp")
        self.Compose_NewChannelButton = getValue(dict, "Compose.NewChannelButton")
        self.ConversationMedia_EmptyTitle = getValue(dict, "ConversationMedia.EmptyTitle")
        self.Date_DialogDateFormat = getValue(dict, "Date.DialogDateFormat")
        self.ReportPeer_ReasonSpam = getValue(dict, "ReportPeer.ReasonSpam")
        self.Compose_TokenListPlaceholder = getValue(dict, "Compose.TokenListPlaceholder")
        self._PINNED_VIDEO = getValue(dict, "PINNED_VIDEO")
        self._PINNED_VIDEO_r = extractArgumentRanges(self._PINNED_VIDEO)
        self.StickerPacksSettings_Title = getValue(dict, "StickerPacksSettings.Title")
        self.Privacy_Calls_NeverAllow_Placeholder = getValue(dict, "Privacy.Calls.NeverAllow.Placeholder")
        self.Settings_Support = getValue(dict, "Settings.Support")
        self.Notification_GroupInviterSelf = getValue(dict, "Notification.GroupInviterSelf")
        self.MaskStickerSettings_Title = getValue(dict, "MaskStickerSettings.Title")
        self.Watch_Suggestion_ThankYou = getValue(dict, "Watch.Suggestion.ThankYou")
        self.TwoStepAuth_SetPassword = getValue(dict, "TwoStepAuth.SetPassword")
        self.GoogleDrive_LoadErrorMessage = getValue(dict, "GoogleDrive.LoadErrorMessage")
        self.GroupInfo_InviteLink_ShareLink = getValue(dict, "GroupInfo.InviteLink.ShareLink")
        self.ChannelMembers_AllMembersMayInviteOnHelp = getValue(dict, "ChannelMembers.AllMembersMayInviteOnHelp")
        self.Common_Cancel = getValue(dict, "Common.Cancel")
        self.Preview_LoadingImages = getValue(dict, "Preview.LoadingImages")
        self.ChangePhoneNumberCode_RequestingACall = getValue(dict, "ChangePhoneNumberCode.RequestingACall")
        self.PrivacyLastSeenSettings_NeverShareWith_Title = getValue(dict, "PrivacyLastSeenSettings.NeverShareWith.Title")
        self.KeyCommand_JumpToNextChat = getValue(dict, "KeyCommand.JumpToNextChat")
        self.Tour_Text1 = getValue(dict, "Tour.Text1")
        self.StickerPack_Remove = getValue(dict, "StickerPack.Remove")
        self.Conversation_HoldForVideo = getValue(dict, "Conversation.HoldForVideo")
        self.Checkout_NewCard_Title = getValue(dict, "Checkout.NewCard.Title")
        self.Channel_TitleInfo = getValue(dict, "Channel.TitleInfo")
        self.Settings_About_Help = getValue(dict, "Settings.About.Help")
        self._Time_PreciseDate_3 = getValue(dict, "Time.PreciseDate_3")
        self._Time_PreciseDate_3_r = extractArgumentRanges(self._Time_PreciseDate_3)
        self.Watch_Conversation_Reply = getValue(dict, "Watch.Conversation.Reply")
        self.ShareMenu_CopyShareLink = getValue(dict, "ShareMenu.CopyShareLink")
        self.Channel_Setup_TypePrivateHelp = getValue(dict, "Channel.Setup.TypePrivateHelp")
        self.PhotoEditor_GrainTool = getValue(dict, "PhotoEditor.GrainTool")
        self.Watch_Suggestion_TalkLater = getValue(dict, "Watch.Suggestion.TalkLater")
        self.TwoStepAuth_ChangeEmail = getValue(dict, "TwoStepAuth.ChangeEmail")
        self._ENCRYPTION_ACCEPT = getValue(dict, "ENCRYPTION_ACCEPT")
        self._ENCRYPTION_ACCEPT_r = extractArgumentRanges(self._ENCRYPTION_ACCEPT)
        self.Conversation_ShareBotLocationConfirmationTitle = getValue(dict, "Conversation.ShareBotLocationConfirmationTitle")
        self.NetworkUsageSettings_BytesSent = getValue(dict, "NetworkUsageSettings.BytesSent")
        self.Conversation_ForwardContacts = getValue(dict, "Conversation.ForwardContacts")
        self._Notification_ChangedGroupName = getValue(dict, "Notification.ChangedGroupName")
        self._Notification_ChangedGroupName_r = extractArgumentRanges(self._Notification_ChangedGroupName)
        self._MESSAGE_VIDEO = getValue(dict, "MESSAGE_VIDEO")
        self._MESSAGE_VIDEO_r = extractArgumentRanges(self._MESSAGE_VIDEO)
        self._Checkout_PayPrice = getValue(dict, "Checkout.PayPrice")
        self._Checkout_PayPrice_r = extractArgumentRanges(self._Checkout_PayPrice)
        self._Notification_PinnedTextMessage = getValue(dict, "Notification.PinnedTextMessage")
        self._Notification_PinnedTextMessage_r = extractArgumentRanges(self._Notification_PinnedTextMessage)
        self.GroupInfo_InvitationLinkDoesNotExist = getValue(dict, "GroupInfo.InvitationLinkDoesNotExist")
        self.ReportPeer_ReasonOther_Placeholder = getValue(dict, "ReportPeer.ReasonOther.Placeholder")
        self.PasscodeSettings_AutoLock_Disabled = getValue(dict, "PasscodeSettings.AutoLock.Disabled")
        self.Wallpaper_Title = getValue(dict, "Wallpaper.Title")
        self.Watch_Compose_CreateMessage = getValue(dict, "Watch.Compose.CreateMessage")
        self.Message_Audio = getValue(dict, "Message.Audio")
        self.Notification_CreatedGroup = getValue(dict, "Notification.CreatedGroup")
        self.Conversation_SearchNoResults = getValue(dict, "Conversation.SearchNoResults")
        self.ChannelMembers_BanList_EmptyText = getValue(dict, "ChannelMembers.BanList.EmptyText")
        self.ReportPeer_ReasonViolence = getValue(dict, "ReportPeer.ReasonViolence")
        self.Group_Username_RemoveExistingUsernamesInfo = getValue(dict, "Group.Username.RemoveExistingUsernamesInfo")
        self.Message_InvoiceLabel = getValue(dict, "Message.InvoiceLabel")
        self._LastSeen_AtWeekday = getValue(dict, "LastSeen.AtWeekday")
        self._LastSeen_AtWeekday_r = extractArgumentRanges(self._LastSeen_AtWeekday)
        self.Contacts_SearchLabel = getValue(dict, "Contacts.SearchLabel")
        self.Group_Username_InvalidStartsWithNumber = getValue(dict, "Group.Username.InvalidStartsWithNumber")
        self.Channel_AdminLogFilter_Title = getValue(dict, "Channel.AdminLogFilter.Title")
        self.ChatAdmins_AllMembersAreAdminsOnHelp = getValue(dict, "ChatAdmins.AllMembersAreAdminsOnHelp")
        self.Month_ShortSeptember = getValue(dict, "Month.ShortSeptember")
        self.Group_Username_CreatePublicLinkHelp = getValue(dict, "Group.Username.CreatePublicLinkHelp")
        self.Login_CallRequestState2 = getValue(dict, "Login.CallRequestState2")
        self.TwoStepAuth_RecoveryUnavailable = getValue(dict, "TwoStepAuth.RecoveryUnavailable")
        self.Bot_Unblock = getValue(dict, "Bot.Unblock")
        self.SharedMedia_CategoryMedia = getValue(dict, "SharedMedia.CategoryMedia")
        self.Conversation_HoldForAudio = getValue(dict, "Conversation.HoldForAudio")
        self.Conversation_ClousStorageInfo_Description1 = getValue(dict, "Conversation.ClousStorageInfo.Description1")
        self.Channel_Members_InviteLink = getValue(dict, "Channel.Members.InviteLink")
        self.WebSearch_RecentClearConfirmation = getValue(dict, "WebSearch.RecentClearConfirmation")
        self.Core_ServiceUserStatus = getValue(dict, "Core.ServiceUserStatus")
        self.Notification_ChannelMigratedFrom = getValue(dict, "Notification.ChannelMigratedFrom")
        self.Settings_Title = getValue(dict, "Settings.Title")
        self.Call_StatusBusy = getValue(dict, "Call.StatusBusy")
        self.ArchivedPacksAlert_Title = getValue(dict, "ArchivedPacksAlert.Title")
        self.ConversationMedia_Title = getValue(dict, "ConversationMedia.Title")
        self._Conversation_MessageViaUser = getValue(dict, "Conversation.MessageViaUser")
        self._Conversation_MessageViaUser_r = extractArgumentRanges(self._Conversation_MessageViaUser)
        self.Presence_invisible = getValue(dict, "Presence.invisible")
        self.DialogList_Create = getValue(dict, "DialogList.Create")
        self.Tour_Title4 = getValue(dict, "Tour.Title4")
        self.Call_StatusEnded = getValue(dict, "Call.StatusEnded")
        self.Conversation_UnpinMessageAlert = getValue(dict, "Conversation.UnpinMessageAlert")
        self._Conversation_MessageDialogRetryAll = getValue(dict, "Conversation.MessageDialogRetryAll")
        self._Conversation_MessageDialogRetryAll_r = extractArgumentRanges(self._Conversation_MessageDialogRetryAll)
        self._Checkout_PasswordEntry_Text = getValue(dict, "Checkout.PasswordEntry.Text")
        self._Checkout_PasswordEntry_Text_r = extractArgumentRanges(self._Checkout_PasswordEntry_Text)
        self.Call_Message = getValue(dict, "Call.Message")
        self.Contacts_MemberSearchSectionTitleGroup = getValue(dict, "Contacts.MemberSearchSectionTitleGroup")
        self._Conversation_BotInteractiveUrlAlert = getValue(dict, "Conversation.BotInteractiveUrlAlert")
        self._Conversation_BotInteractiveUrlAlert_r = extractArgumentRanges(self._Conversation_BotInteractiveUrlAlert)
        self.GroupInfo_SharedMedia = getValue(dict, "GroupInfo.SharedMedia")
        self.Channel_Username_InvalidStartsWithNumber = getValue(dict, "Channel.Username.InvalidStartsWithNumber")
        self.KeyCommand_JumpToPreviousChat = getValue(dict, "KeyCommand.JumpToPreviousChat")
        self.Conversation_Call = getValue(dict, "Conversation.Call")
        self.KeyCommand_ScrollUp = getValue(dict, "KeyCommand.ScrollUp")
        self._Privacy_GroupsAndChannels_InviteToChannelError = getValue(dict, "Privacy.GroupsAndChannels.InviteToChannelError")
        self._Privacy_GroupsAndChannels_InviteToChannelError_r = extractArgumentRanges(self._Privacy_GroupsAndChannels_InviteToChannelError)
        self.Document_TargetConfirmationFormat = getValue(dict, "Document.TargetConfirmationFormat")
        self.Group_Setup_TypeHeader = getValue(dict, "Group.Setup.TypeHeader")
        self._DialogList_SinglePlayingGameSuffix = getValue(dict, "DialogList.SinglePlayingGameSuffix")
        self._DialogList_SinglePlayingGameSuffix_r = extractArgumentRanges(self._DialogList_SinglePlayingGameSuffix)
        self.AttachmentMenu_SendAsFiles = getValue(dict, "AttachmentMenu.SendAsFiles")
        self.Profile_MessageLifetime1m = getValue(dict, "Profile.MessageLifetime1m")
        self.DialogList_SelectContact = getValue(dict, "DialogList.SelectContact")
        self.Settings_AppleWatch = getValue(dict, "Settings.AppleWatch")
        self.Conversation_View = getValue(dict, "Conversation.View")
        self.Contacts_Invite = getValue(dict, "Contacts.Invite")
        self.Channel_AdminLog_MessagePreviousDescription = getValue(dict, "Channel.AdminLog.MessagePreviousDescription")
        self.Your_card_was_declined = getValue(dict, "Your_card_was_declined")
        self.PhoneNumberHelp_ChangeNumber = getValue(dict, "PhoneNumberHelp.ChangeNumber")
        self.ReportPeer_ReasonPornography = getValue(dict, "ReportPeer.ReasonPornography")
        self.Notification_CreatedChannel = getValue(dict, "Notification.CreatedChannel")
        self.PhotoEditor_Original = getValue(dict, "PhotoEditor.Original")
        self.Target_SelectGroup = getValue(dict, "Target.SelectGroup")
        self.Channel_AdminLog_InfoPanelAlertTitle = getValue(dict, "Channel.AdminLog.InfoPanelAlertTitle")
        self.Notifications_GroupNotificationsPreview = getValue(dict, "Notifications.GroupNotificationsPreview")
        self.Message_PinnedLocationMessage = getValue(dict, "Message.PinnedLocationMessage")
        self.Settings_Logout = getValue(dict, "Settings.Logout")
        self.Profile_Username = getValue(dict, "Profile.Username")
        self.Group_Username_InvalidTooShort = getValue(dict, "Group.Username.InvalidTooShort")
        self.AuthSessions_TerminateOtherSessions = getValue(dict, "AuthSessions.TerminateOtherSessions")
        self.PasscodeSettings_TryAgainIn1Minute = getValue(dict, "PasscodeSettings.TryAgainIn1Minute")
        self.Notifications_InAppNotifications = getValue(dict, "Notifications.InAppNotifications")
        self.Channels_Title = getValue(dict, "Channels.Title")
        self.StickerPack_ViewPack = getValue(dict, "StickerPack.ViewPack")
        self.EnterPasscode_ChangeTitle = getValue(dict, "EnterPasscode.ChangeTitle")
        self.Call_Decline = getValue(dict, "Call.Decline")
        self.UserInfo_AddPhone = getValue(dict, "UserInfo.AddPhone")
        self.Web_CopyLink = getValue(dict, "Web.CopyLink")
        self.Activity_PlayingGame = getValue(dict, "Activity.PlayingGame")
        self.CheckoutInfo_ShippingInfoStatePlaceholder = getValue(dict, "CheckoutInfo.ShippingInfoStatePlaceholder")
        self.Notifications_MessageNotificationsSound = getValue(dict, "Notifications.MessageNotificationsSound")
        self.Call_StatusWaiting = getValue(dict, "Call.StatusWaiting")
        self.Weekday_ShortWednesday = getValue(dict, "Weekday.ShortWednesday")
        self.DC_UPDATE = getValue(dict, "DC_UPDATE")
        self.PasscodeSettings_AutoLock_IfAwayFor_5hours = getValue(dict, "PasscodeSettings.AutoLock.IfAwayFor_5hours")
        self.Notifications_Title = getValue(dict, "Notifications.Title")
        self.Conversation_PinnedMessage = getValue(dict, "Conversation.PinnedMessage")
        self.Channel_AdminLog_MessagePreviousMessage = getValue(dict, "Channel.AdminLog.MessagePreviousMessage")
        self.ConversationProfile_LeaveDeleteAndExit = getValue(dict, "ConversationProfile.LeaveDeleteAndExit")
        self.State_connecting = getValue(dict, "State.connecting")
        self.WebPreview_LinkPreview = getValue(dict, "WebPreview.LinkPreview")
        self.Map_OpenInHereMaps = getValue(dict, "Map.OpenInHereMaps")
        self.CheckoutInfo_Pay = getValue(dict, "CheckoutInfo.Pay")
        self.DialogList_Messages = getValue(dict, "DialogList.Messages")
        self.Login_CountryCode = getValue(dict, "Login.CountryCode")
        self.CheckoutInfo_ShippingInfoState = getValue(dict, "CheckoutInfo.ShippingInfoState")
        self.Map_OpenInGooglePlus = getValue(dict, "Map.OpenInGooglePlus")
        self._CHAT_MESSAGE_AUDIO = getValue(dict, "CHAT_MESSAGE_AUDIO")
        self._CHAT_MESSAGE_AUDIO_r = extractArgumentRanges(self._CHAT_MESSAGE_AUDIO)
        self.Login_SmsRequestState2 = getValue(dict, "Login.SmsRequestState2")
        self.Preview_SaveToCameraRoll = getValue(dict, "Preview.SaveToCameraRoll")
        self.PasscodeSettings_ChangePasscode = getValue(dict, "PasscodeSettings.ChangePasscode")
        self.TwoStepAuth_RecoveryCodeInvalid = getValue(dict, "TwoStepAuth.RecoveryCodeInvalid")
        self._Message_PaymentSent = getValue(dict, "Message.PaymentSent")
        self._Message_PaymentSent_r = extractArgumentRanges(self._Message_PaymentSent)
        self.Message_PinnedAudioMessage = getValue(dict, "Message.PinnedAudioMessage")
        self.Login_InfoDeletePhoto = getValue(dict, "Login.InfoDeletePhoto")
        self.Settings_SaveIncomingPhotosHelp = getValue(dict, "Settings.SaveIncomingPhotosHelp")
        self.TwoStepAuth_RecoveryCodeExpired = getValue(dict, "TwoStepAuth.RecoveryCodeExpired")
        self.TwoStepAuth_EmailTitle = getValue(dict, "TwoStepAuth.EmailTitle")
        self.Privacy_GroupsAndChannels_NeverAllow = getValue(dict, "Privacy.GroupsAndChannels.NeverAllow")
        self.Conversation_AddContact = getValue(dict, "Conversation.AddContact")
        self.PhotoEditor_QualityLow = getValue(dict, "PhotoEditor.QualityLow")
        self.Paint_Outlined = getValue(dict, "Paint.Outlined")
        self.Checkout_PasswordEntry_Title = getValue(dict, "Checkout.PasswordEntry.Title")
        self.Common_Done = getValue(dict, "Common.Done")
        self.PrivacySettings_LastSeenContacts = getValue(dict, "PrivacySettings.LastSeenContacts")
        self.CheckoutInfo_ShippingInfoAddress1 = getValue(dict, "CheckoutInfo.ShippingInfoAddress1")
        self.UserInfo_LastNamePlaceholder = getValue(dict, "UserInfo.LastNamePlaceholder")
        self.Conversation_StatusKickedFromChannel = getValue(dict, "Conversation.StatusKickedFromChannel")
        self.GroupInfo_InviteLink_RevokeAlert_Text = getValue(dict, "GroupInfo.InviteLink.RevokeAlert.Text")
        self._DialogList_SingleTypingSuffix = getValue(dict, "DialogList.SingleTypingSuffix")
        self._DialogList_SingleTypingSuffix_r = extractArgumentRanges(self._DialogList_SingleTypingSuffix)
        self.LastSeen_JustNow = getValue(dict, "LastSeen.JustNow")
        self.CheckoutInfo_ShippingInfoAddress2 = getValue(dict, "CheckoutInfo.ShippingInfoAddress2")
        self.Watch_Suggestion_No = getValue(dict, "Watch.Suggestion.No")
        self.BroadcastListInfo_AddRecipient = getValue(dict, "BroadcastListInfo.AddRecipient")
        self._Channel_Management_ErrorNotMember = getValue(dict, "Channel.Management.ErrorNotMember")
        self._Channel_Management_ErrorNotMember_r = extractArgumentRanges(self._Channel_Management_ErrorNotMember)
        self.Privacy_Calls_NeverAllow = getValue(dict, "Privacy.Calls.NeverAllow")
        self.Settings_About_Title = getValue(dict, "Settings.About.Title")
        self.PhoneNumberHelp_Help = getValue(dict, "PhoneNumberHelp.Help")
        self.Service_NetworkConfigurationUpdatedMessage = getValue(dict, "Service.NetworkConfigurationUpdatedMessage")
        self._Time_MonthOfYear_9 = getValue(dict, "Time.MonthOfYear_9")
        self._Time_MonthOfYear_9_r = extractArgumentRanges(self._Time_MonthOfYear_9)
        self.Channel_LinkItem = getValue(dict, "Channel.LinkItem")
        self.Camera_Retake = getValue(dict, "Camera.Retake")
        self.StickerPack_ShowStickers = getValue(dict, "StickerPack.ShowStickers")
        self._CHAT_CREATED = getValue(dict, "CHAT_CREATED")
        self._CHAT_CREATED_r = extractArgumentRanges(self._CHAT_CREATED)
        self.LastSeen_WithinAMonth = getValue(dict, "LastSeen.WithinAMonth")
        self._PrivacySettings_LastSeenContactsPlus = getValue(dict, "PrivacySettings.LastSeenContactsPlus")
        self._PrivacySettings_LastSeenContactsPlus_r = extractArgumentRanges(self._PrivacySettings_LastSeenContactsPlus)
        self.Conversation_FileHowTo = getValue(dict, "Conversation.FileHowTo")
        self.ChangePhoneNumberNumber_NewNumber = getValue(dict, "ChangePhoneNumberNumber.NewNumber")
        self.Compose_NewChannel = getValue(dict, "Compose.NewChannel")
        self.Channel_AdminLog_CanChangeInviteLink = getValue(dict, "Channel.AdminLog.CanChangeInviteLink")
        self._Call_CallInProgressMessage = getValue(dict, "Call.CallInProgressMessage")
        self._Call_CallInProgressMessage_r = extractArgumentRanges(self._Call_CallInProgressMessage)
        self.Conversation_InputTextBroadcastPlaceholder = getValue(dict, "Conversation.InputTextBroadcastPlaceholder")
        self._ShareFileTip_Text = getValue(dict, "ShareFileTip.Text")
        self._ShareFileTip_Text_r = extractArgumentRanges(self._ShareFileTip_Text)
        self._CancelResetAccount_TextSMS = getValue(dict, "CancelResetAccount.TextSMS")
        self._CancelResetAccount_TextSMS_r = extractArgumentRanges(self._CancelResetAccount_TextSMS)
        self.Channel_EditAdmin_PermissionInviteUsers = getValue(dict, "Channel.EditAdmin.PermissionInviteUsers")
        self.Conversation_Document = getValue(dict, "Conversation.Document")
        self.SearchImages_RetryDownload = getValue(dict, "SearchImages.RetryDownload")
        self.GroupInfo_DeleteAndExit = getValue(dict, "GroupInfo.DeleteAndExit")
        self.GroupInfo_InviteLink_CopyLink = getValue(dict, "GroupInfo.InviteLink.CopyLink")
        self.Weekday_Friday = getValue(dict, "Weekday.Friday")
        self.Login_ResetAccountProtected_Title = getValue(dict, "Login.ResetAccountProtected.Title")
        self.Settings_SetProfilePhoto = getValue(dict, "Settings.SetProfilePhoto")
        self.Compose_ChannelTokenListPlaceholder = getValue(dict, "Compose.ChannelTokenListPlaceholder")
        self.Channel_EditAdmin_PermissionPinMessages = getValue(dict, "Channel.EditAdmin.PermissionPinMessages")
        self.Your_card_has_expired = getValue(dict, "Your_card_has_expired")
        self._CHAT_MESSAGE_INVOICE = getValue(dict, "CHAT_MESSAGE_INVOICE")
        self._CHAT_MESSAGE_INVOICE_r = extractArgumentRanges(self._CHAT_MESSAGE_INVOICE)
        self.ChannelInfo_ConfirmLeave = getValue(dict, "ChannelInfo.ConfirmLeave")
        self.ShareMenu_CopyShareLinkGame = getValue(dict, "ShareMenu.CopyShareLinkGame")
        self.ReportPeer_ReasonOther = getValue(dict, "ReportPeer.ReasonOther")
        self._Username_UsernameIsAvailable = getValue(dict, "Username.UsernameIsAvailable")
        self._Username_UsernameIsAvailable_r = extractArgumentRanges(self._Username_UsernameIsAvailable)
        self.KeyCommand_JumpToNextUnreadChat = getValue(dict, "KeyCommand.JumpToNextUnreadChat")
        self.Conversation_EncryptedDescriptionTitle = getValue(dict, "Conversation.EncryptedDescriptionTitle")
        self.DialogList_Pin = getValue(dict, "DialogList.Pin")
        self._Notification_RemovedGroupPhoto = getValue(dict, "Notification.RemovedGroupPhoto")
        self._Notification_RemovedGroupPhoto_r = extractArgumentRanges(self._Notification_RemovedGroupPhoto)
        self.Channel_ErrorAddTooMuch = getValue(dict, "Channel.ErrorAddTooMuch")
        self.GroupInfo_SharedMediaNone = getValue(dict, "GroupInfo.SharedMediaNone")
        self.ChatSettings_TextSizeUnits = getValue(dict, "ChatSettings.TextSizeUnits")
        self.ChatSettings_AutoPlayAnimations = getValue(dict, "ChatSettings.AutoPlayAnimations")
        self.Conversation_FileOpenIn = getValue(dict, "Conversation.FileOpenIn")
        self.Channel_Setup_TypePublic = getValue(dict, "Channel.Setup.TypePublic")
        self._ChangePhone_ErrorOccupied = getValue(dict, "ChangePhone.ErrorOccupied")
        self._ChangePhone_ErrorOccupied_r = extractArgumentRanges(self._ChangePhone_ErrorOccupied)
        self.DialogList_RecentTitleGroups = getValue(dict, "DialogList.RecentTitleGroups")
        self.Privacy_GroupsAndChannels_CustomShareHelp = getValue(dict, "Privacy.GroupsAndChannels.CustomShareHelp")
        self.KeyCommand_ChatInfo = getValue(dict, "KeyCommand.ChatInfo")
        self.Notification_CreatedBroadcastList = getValue(dict, "Notification.CreatedBroadcastList")
        self.PhotoEditor_HighlightsTint = getValue(dict, "PhotoEditor.HighlightsTint")
        self.Watch_Compose_AddContact = getValue(dict, "Watch.Compose.AddContact")
        self.Coub_TapForSound = getValue(dict, "Coub.TapForSound")
        self.Compose_NewEncryptedChat = getValue(dict, "Compose.NewEncryptedChat")
        self.PhotoEditor_CropReset = getValue(dict, "PhotoEditor.CropReset")
        self.Login_InvalidLastNameError = getValue(dict, "Login.InvalidLastNameError")
        self.Channel_Members_AddMembers = getValue(dict, "Channel.Members.AddMembers")
        self.Tour_Title2 = getValue(dict, "Tour.Title2")
        self.Login_TermsOfServiceHeader = getValue(dict, "Login.TermsOfServiceHeader")
        self.AuthSessions_OtherSessions = getValue(dict, "AuthSessions.OtherSessions")
        self.Watch_UserInfo_Title = getValue(dict, "Watch.UserInfo.Title")
        self.InstantPage_FeedbackButton = getValue(dict, "InstantPage.FeedbackButton")
        self._Generic_OpenHiddenLinkAlert = getValue(dict, "Generic.OpenHiddenLinkAlert")
        self._Generic_OpenHiddenLinkAlert_r = extractArgumentRanges(self._Generic_OpenHiddenLinkAlert)
        self.Conversation_Contact = getValue(dict, "Conversation.Contact")
        self.NetworkUsageSettings_GeneralDataSection = getValue(dict, "NetworkUsageSettings.GeneralDataSection")
        self.Service_ApplyLocalization = getValue(dict, "Service.ApplyLocalization")
        self._StickerPack_RemovePrompt = getValue(dict, "StickerPack.RemovePrompt")
        self._StickerPack_RemovePrompt_r = extractArgumentRanges(self._StickerPack_RemovePrompt)
        self.Channel_NotificationCommentsDisabled = getValue(dict, "Channel.NotificationCommentsDisabled")
        self.EnterPasscode_RepeatNewPasscode = getValue(dict, "EnterPasscode.RepeatNewPasscode")
        self.InstantPage_AutoNightTheme = getValue(dict, "InstantPage.AutoNightTheme")
        self.CloudStorage_Title = getValue(dict, "CloudStorage.Title")
        self.Month_ShortOctober = getValue(dict, "Month.ShortOctober")
        self.Settings_FAQ = getValue(dict, "Settings.FAQ")
        self.PrivacySettings_LastSeen = getValue(dict, "PrivacySettings.LastSeen")
        self.DialogList_SearchSectionRecent = getValue(dict, "DialogList.SearchSectionRecent")
        self.ChatSettings_AutomaticVideoMessageDownload = getValue(dict, "ChatSettings.AutomaticVideoMessageDownload")
        self.Conversation_ContextMenuDelete = getValue(dict, "Conversation.ContextMenuDelete")
        self.Tour_Text6 = getValue(dict, "Tour.Text6")
        self.PhotoEditor_WarmthTool = getValue(dict, "PhotoEditor.WarmthTool")
        self._Time_MonthOfYear_8 = getValue(dict, "Time.MonthOfYear_8")
        self._Time_MonthOfYear_8_r = extractArgumentRanges(self._Time_MonthOfYear_8)
        self.Common_TakePhoto = getValue(dict, "Common.TakePhoto")
        self.PhotoEditor_Current = getValue(dict, "PhotoEditor.Current")
        self.UserInfo_CreateNewContact = getValue(dict, "UserInfo.CreateNewContact")
        self.NetworkUsageSettings_MediaDocumentDataSection = getValue(dict, "NetworkUsageSettings.MediaDocumentDataSection")
        self.Login_CodeSentCall = getValue(dict, "Login.CodeSentCall")
        self.Watch_PhotoView_Title = getValue(dict, "Watch.PhotoView.Title")
        self._PrivacySettings_LastSeenContactsMinus = getValue(dict, "PrivacySettings.LastSeenContactsMinus")
        self._PrivacySettings_LastSeenContactsMinus_r = extractArgumentRanges(self._PrivacySettings_LastSeenContactsMinus)
        self.Login_InfoUpdatePhoto = getValue(dict, "Login.InfoUpdatePhoto")
        self.ShareMenu_SelectChats = getValue(dict, "ShareMenu.SelectChats")
        self.Group_ErrorSendRestrictedMedia = getValue(dict, "Group.ErrorSendRestrictedMedia")
        self.Channel_EditAdmin_PermissinAddAdminOff = getValue(dict, "Channel.EditAdmin.PermissinAddAdminOff")
        self.Cache_Files = getValue(dict, "Cache.Files")
        self.PhotoEditor_EnhanceTool = getValue(dict, "PhotoEditor.EnhanceTool")
        self.Conversation_SearchPlaceholder = getValue(dict, "Conversation.SearchPlaceholder")
        self.Calls_Search = getValue(dict, "Calls.Search")
        self.BroadcastListInfo_Title = getValue(dict, "BroadcastListInfo.Title")
        self.WatchRemote_AlertText = getValue(dict, "WatchRemote.AlertText")
        self.Channel_AdminLog_CanInviteUsers = getValue(dict, "Channel.AdminLog.CanInviteUsers")
        self.Conversation_Block = getValue(dict, "Conversation.Block")
        self.AttachmentMenu_PhotoOrVideo = getValue(dict, "AttachmentMenu.PhotoOrVideo")
        self.Channel_BanUser_PermissionReadMessages = getValue(dict, "Channel.BanUser.PermissionReadMessages")
        self.Month_ShortMarch = getValue(dict, "Month.ShortMarch")
        self.GroupInfo_InviteLink_Title = getValue(dict, "GroupInfo.InviteLink.Title")
        self.Watch_LastSeen_JustNow = getValue(dict, "Watch.LastSeen.JustNow")
        self.BroadcastLists_Title = getValue(dict, "BroadcastLists.Title")
        self.PhoneLabel_Title = getValue(dict, "PhoneLabel.Title")
        self.PrivacySettings_Passcode = getValue(dict, "PrivacySettings.Passcode")
        self.Paint_ClearConfirm = getValue(dict, "Paint.ClearConfirm")
        self._Checkout_SavePasswordTimeout = getValue(dict, "Checkout.SavePasswordTimeout")
        self._Checkout_SavePasswordTimeout_r = extractArgumentRanges(self._Checkout_SavePasswordTimeout)
        self.PhotoEditor_BlurToolOff = getValue(dict, "PhotoEditor.BlurToolOff")
        self.AccessDenied_VideoMicrophone = getValue(dict, "AccessDenied.VideoMicrophone")
        self.Weekday_ShortThursday = getValue(dict, "Weekday.ShortThursday")
        self.UserInfo_ShareContact = getValue(dict, "UserInfo.ShareContact")
        self.LoginPassword_InvalidPasswordError = getValue(dict, "LoginPassword.InvalidPasswordError")
        self.Login_PhoneAndCountryHelp = getValue(dict, "Login.PhoneAndCountryHelp")
        self.CheckoutInfo_ReceiverInfoName = getValue(dict, "CheckoutInfo.ReceiverInfoName")
        self._LastSeen_TodayAt = getValue(dict, "LastSeen.TodayAt")
        self._LastSeen_TodayAt_r = extractArgumentRanges(self._LastSeen_TodayAt)
        self._Time_YesterdayAt = getValue(dict, "Time.YesterdayAt")
        self._Time_YesterdayAt_r = extractArgumentRanges(self._Time_YesterdayAt)
        self.Weekday_Yesterday = getValue(dict, "Weekday.Yesterday")
        self.Conversation_InputTextSilentBroadcastPlaceholder = getValue(dict, "Conversation.InputTextSilentBroadcastPlaceholder")
        self.Embed_PlayingInPIP = getValue(dict, "Embed.PlayingInPIP")
        self.Call_StatusIncoming = getValue(dict, "Call.StatusIncoming")
        self.Conversation_Play = getValue(dict, "Conversation.Play")
        self.Settings_PrivacySettings = getValue(dict, "Settings.PrivacySettings")
        self.Conversation_SilentBroadcastTooltipOn = getValue(dict, "Conversation.SilentBroadcastTooltipOn")
        self._CHAT_MESSAGE_GEO = getValue(dict, "CHAT_MESSAGE_GEO")
        self._CHAT_MESSAGE_GEO_r = extractArgumentRanges(self._CHAT_MESSAGE_GEO)
        self.DialogList_SearchLabel = getValue(dict, "DialogList.SearchLabel")
        self.Login_CodeSentInternal = getValue(dict, "Login.CodeSentInternal")
        self.Channel_AdminLog_BanSendMessages = getValue(dict, "Channel.AdminLog.BanSendMessages")
        self.Channel_MessagePhotoRemoved = getValue(dict, "Channel.MessagePhotoRemoved")
        self.Conversation_StatusKickedFromGroup = getValue(dict, "Conversation.StatusKickedFromGroup")
        self.Compose_NewChannel_AddMemberHelp = getValue(dict, "Compose.NewChannel.AddMemberHelp")
        self.GroupInfo_ChatAdmins = getValue(dict, "GroupInfo.ChatAdmins")
        self.PhotoEditor_CurvesAll = getValue(dict, "PhotoEditor.CurvesAll")
        self.Compose_Create = getValue(dict, "Compose.Create")
        self._LOCKED_MESSAGE = getValue(dict, "LOCKED_MESSAGE")
        self._LOCKED_MESSAGE_r = extractArgumentRanges(self._LOCKED_MESSAGE)
        self.Conversation_ContextMenuShare = getValue(dict, "Conversation.ContextMenuShare")
        self._Call_GroupFormat = getValue(dict, "Call.GroupFormat")
        self._Call_GroupFormat_r = extractArgumentRanges(self._Call_GroupFormat)
        self.Forward_ChannelReadOnly = getValue(dict, "Forward.ChannelReadOnly")
        self.Privacy_GroupsAndChannels_NeverAllow_Title = getValue(dict, "Privacy.GroupsAndChannels.NeverAllow.Title")
        self.Conversation_StatusGroupDeactivated = getValue(dict, "Conversation.StatusGroupDeactivated")
        self._CHAT_JOINED = getValue(dict, "CHAT_JOINED")
        self._CHAT_JOINED_r = extractArgumentRanges(self._CHAT_JOINED)
        self.Conversation_Moderate_Ban = getValue(dict, "Conversation.Moderate.Ban")
        self.Group_Status = getValue(dict, "Group.Status")
        self.Watch_Suggestion_Absolutely = getValue(dict, "Watch.Suggestion.Absolutely")
        self.Conversation_InputTextPlaceholder = getValue(dict, "Conversation.InputTextPlaceholder")
        self._Time_MonthOfYear_7 = getValue(dict, "Time.MonthOfYear_7")
        self._Time_MonthOfYear_7_r = extractArgumentRanges(self._Time_MonthOfYear_7)
        self.SharedMedia_TitleAudio = getValue(dict, "SharedMedia.TitleAudio")
        self.TwoStepAuth_RecoveryCode = getValue(dict, "TwoStepAuth.RecoveryCode")
        self.SharedMedia_CategoryDocs = getValue(dict, "SharedMedia.CategoryDocs")
        self.Channel_AdminLog_CanChangeInfo = getValue(dict, "Channel.AdminLog.CanChangeInfo")
        self.Channel_AdminLogFilter_EventsAdmins = getValue(dict, "Channel.AdminLogFilter.EventsAdmins")
        self._AuthSessions_AppUnofficial = getValue(dict, "AuthSessions.AppUnofficial")
        self._AuthSessions_AppUnofficial_r = extractArgumentRanges(self._AuthSessions_AppUnofficial)
        self.Channel_EditAdmin_PermissionsHeader = getValue(dict, "Channel.EditAdmin.PermissionsHeader")
        self._DialogList_SingleUploadingVideoSuffix = getValue(dict, "DialogList.SingleUploadingVideoSuffix")
        self._DialogList_SingleUploadingVideoSuffix_r = extractArgumentRanges(self._DialogList_SingleUploadingVideoSuffix)
        self.Group_UpgradeNoticeHeader = getValue(dict, "Group.UpgradeNoticeHeader")
        self._CHAT_DELETE_YOU = getValue(dict, "CHAT_DELETE_YOU")
        self._CHAT_DELETE_YOU_r = extractArgumentRanges(self._CHAT_DELETE_YOU)
        self._MESSAGE_NOTEXT = getValue(dict, "MESSAGE_NOTEXT")
        self._MESSAGE_NOTEXT_r = extractArgumentRanges(self._MESSAGE_NOTEXT)
        self._CHAT_MESSAGE_GIF = getValue(dict, "CHAT_MESSAGE_GIF")
        self._CHAT_MESSAGE_GIF_r = extractArgumentRanges(self._CHAT_MESSAGE_GIF)
        self.GroupInfo_InviteLink_CopyAlert_Success = getValue(dict, "GroupInfo.InviteLink.CopyAlert.Success")
        self.Channel_Info_Members = getValue(dict, "Channel.Info.Members")
        self.ShareFileTip_CloseTip = getValue(dict, "ShareFileTip.CloseTip")
        self.KeyCommand_Find = getValue(dict, "KeyCommand.Find")
        self.Preview_VideoNotYetDownloaded = getValue(dict, "Preview.VideoNotYetDownloaded")
        self.Checkout_NewCard_PostcodeTitle = getValue(dict, "Checkout.NewCard.PostcodeTitle")
        self._Channel_AdminLog_MessageRestricted = getValue(dict, "Channel.AdminLog.MessageRestricted")
        self._Channel_AdminLog_MessageRestricted_r = extractArgumentRanges(self._Channel_AdminLog_MessageRestricted)
        self.Channel_EditAdmin_PermissinAddAdminOn = getValue(dict, "Channel.EditAdmin.PermissinAddAdminOn")
        self.WebSearch_GIFs = getValue(dict, "WebSearch.GIFs")
        self.TwoStepAuth_EnterPasswordTitle = getValue(dict, "TwoStepAuth.EnterPasswordTitle")
        self._CHANNEL_MESSAGE_GAME = getValue(dict, "CHANNEL_MESSAGE_GAME")
        self._CHANNEL_MESSAGE_GAME_r = extractArgumentRanges(self._CHANNEL_MESSAGE_GAME)
        self.AccessDenied_CallMicrophone = getValue(dict, "AccessDenied.CallMicrophone")
        self.Conversation_DeleteMessagesForEveryone = getValue(dict, "Conversation.DeleteMessagesForEveryone")
        self.UserInfo_TapToCall = getValue(dict, "UserInfo.TapToCall")
        self.Common_Edit = getValue(dict, "Common.Edit")
        self.Conversation_OpenFile = getValue(dict, "Conversation.OpenFile")
        self.Message_PinnedDocumentMessage = getValue(dict, "Message.PinnedDocumentMessage")
        self.Channel_ShareChannel = getValue(dict, "Channel.ShareChannel")
        self.PrivacySettings_DeleteAccountNowConfirmation = getValue(dict, "PrivacySettings.DeleteAccountNowConfirmation")
        self.Checkout_TotalPaidAmount = getValue(dict, "Checkout.TotalPaidAmount")
        self.Conversation_UnsupportedMedia = getValue(dict, "Conversation.UnsupportedMedia")
        self._Message_ForwardedMessage = getValue(dict, "Message.ForwardedMessage")
        self._Message_ForwardedMessage_r = extractArgumentRanges(self._Message_ForwardedMessage)
        self.Checkout_NewCard_SaveInfoEnableHelp = getValue(dict, "Checkout.NewCard.SaveInfoEnableHelp")
        self.Call_AudioRouteHide = getValue(dict, "Call.AudioRouteHide")
        self.CallSettings_OnMobile = getValue(dict, "CallSettings.OnMobile")
        self.Conversation_GifTooltip = getValue(dict, "Conversation.GifTooltip")
        self.CheckoutInfo_ErrorCityInvalid = getValue(dict, "CheckoutInfo.ErrorCityInvalid")
        self.Profile_CreateEncryptedChatError = getValue(dict, "Profile.CreateEncryptedChatError")
        self.Map_LocationTitle = getValue(dict, "Map.LocationTitle")
        self.Compose_Recipients = getValue(dict, "Compose.Recipients")
        self.Message_ReplyActionButtonShowReceipt = getValue(dict, "Message.ReplyActionButtonShowReceipt")
        self.PhotoEditor_ShadowsTool = getValue(dict, "PhotoEditor.ShadowsTool")
        self.Checkout_NewCard_CardholderNamePlaceholder = getValue(dict, "Checkout.NewCard.CardholderNamePlaceholder")
        self.Cache_Title = getValue(dict, "Cache.Title")
        self.Month_GenMay = getValue(dict, "Month.GenMay")
        self._Notification_CreatedChat = getValue(dict, "Notification.CreatedChat")
        self._Notification_CreatedChat_r = extractArgumentRanges(self._Notification_CreatedChat)
        self.Calls_NoMissedCallsPlacehoder = getValue(dict, "Calls.NoMissedCallsPlacehoder")
        self.Watch_UserInfo_Block = getValue(dict, "Watch.UserInfo.Block")
        self.Watch_LastSeen_ALongTimeAgo = getValue(dict, "Watch.LastSeen.ALongTimeAgo")
        self.StickerPacksSettings_ManagingHelp = getValue(dict, "StickerPacksSettings.ManagingHelp")
        self.Privacy_GroupsAndChannels_InviteToChannelMultipleError = getValue(dict, "Privacy.GroupsAndChannels.InviteToChannelMultipleError")
        self.PrivacySettings_TouchIdEnable = getValue(dict, "PrivacySettings.TouchIdEnable")
        self.SearchImages_Title = getValue(dict, "SearchImages.Title")
        self.Channel_BlackList_Title = getValue(dict, "Channel.BlackList.Title")
        self.Checkout_NewCard_SaveInfo = getValue(dict, "Checkout.NewCard.SaveInfo")
        self.Notification_CallMissed = getValue(dict, "Notification.CallMissed")
        self.Profile_ShareContactButton = getValue(dict, "Profile.ShareContactButton")
        self.Group_ErrorSendRestrictedStickers = getValue(dict, "Group.ErrorSendRestrictedStickers")
        self.Bot_GroupStatusDoesNotReadHistory = getValue(dict, "Bot.GroupStatusDoesNotReadHistory")
        self.Notification_Mute1h = getValue(dict, "Notification.Mute1h")
        self.Cache_ClearCacheAlert = getValue(dict, "Cache.ClearCacheAlert")
        self.BroadcastLists_NoListsYet = getValue(dict, "BroadcastLists.NoListsYet")
        self.Settings_TabTitle = getValue(dict, "Settings.TabTitle")
        self._Time_MonthOfYear_6 = getValue(dict, "Time.MonthOfYear_6")
        self._Time_MonthOfYear_6_r = extractArgumentRanges(self._Time_MonthOfYear_6)
        self.NetworkUsageSettings_MediaAudioDataSection = getValue(dict, "NetworkUsageSettings.MediaAudioDataSection")
        self.GroupInfo_DeactivatedStatus = getValue(dict, "GroupInfo.DeactivatedStatus")
        self._CHAT_PHOTO_EDITED = getValue(dict, "CHAT_PHOTO_EDITED")
        self._CHAT_PHOTO_EDITED_r = extractArgumentRanges(self._CHAT_PHOTO_EDITED)
        self.Conversation_ContextMenuMore = getValue(dict, "Conversation.ContextMenuMore")
        self._PrivacySettings_LastSeenEverybodyMinus = getValue(dict, "PrivacySettings.LastSeenEverybodyMinus")
        self._PrivacySettings_LastSeenEverybodyMinus_r = extractArgumentRanges(self._PrivacySettings_LastSeenEverybodyMinus)
        self.Weekday_Today = getValue(dict, "Weekday.Today")
        self.Login_InvalidFirstNameError = getValue(dict, "Login.InvalidFirstNameError")
        self._Notification_Joined = getValue(dict, "Notification.Joined")
        self._Notification_Joined_r = extractArgumentRanges(self._Notification_Joined)
        self._VideoPreview_OptionHD = getValue(dict, "VideoPreview.OptionHD")
        self._VideoPreview_OptionHD_r = extractArgumentRanges(self._VideoPreview_OptionHD)
        self.Paint_Clear = getValue(dict, "Paint.Clear")
        self.TwoStepAuth_RecoveryFailed = getValue(dict, "TwoStepAuth.RecoveryFailed")
        self._MESSAGE_AUDIO = getValue(dict, "MESSAGE_AUDIO")
        self._MESSAGE_AUDIO_r = extractArgumentRanges(self._MESSAGE_AUDIO)
        self.Checkout_PasswordEntry_Pay = getValue(dict, "Checkout.PasswordEntry.Pay")
        self.Notifications_MessageNotificationsHelp = getValue(dict, "Notifications.MessageNotificationsHelp")
        self.Notification_EncryptedChatRequested = getValue(dict, "Notification.EncryptedChatRequested")
        self.EnterPasscode_EnterCurrentPasscode = getValue(dict, "EnterPasscode.EnterCurrentPasscode")
        self.Channel_Management_LabelModerator = getValue(dict, "Channel.Management.LabelModerator")
        self._MESSAGE_GAME = getValue(dict, "MESSAGE_GAME")
        self._MESSAGE_GAME_r = extractArgumentRanges(self._MESSAGE_GAME)
        self.Conversation_Moderate_Report = getValue(dict, "Conversation.Moderate.Report")
        self.MessageTimer_Forever = getValue(dict, "MessageTimer.Forever")
        self._Conversation_EncryptedPlaceholderTitleIncoming = getValue(dict, "Conversation.EncryptedPlaceholderTitleIncoming")
        self._Conversation_EncryptedPlaceholderTitleIncoming_r = extractArgumentRanges(self._Conversation_EncryptedPlaceholderTitleIncoming)
        self._Map_AccurateTo = getValue(dict, "Map.AccurateTo")
        self._Map_AccurateTo_r = extractArgumentRanges(self._Map_AccurateTo)
        self._Call_ParticipantVersionOutdatedError = getValue(dict, "Call.ParticipantVersionOutdatedError")
        self._Call_ParticipantVersionOutdatedError_r = extractArgumentRanges(self._Call_ParticipantVersionOutdatedError)
        self.Tour_Text2 = getValue(dict, "Tour.Text2")
        self.Preview_ViewStickerPack = getValue(dict, "Preview.ViewStickerPack")
        self.Conversation_MessageDialogDelete = getValue(dict, "Conversation.MessageDialogDelete")
        self.Calls_Clear = getValue(dict, "Calls.Clear")
        self.Username_Placeholder = getValue(dict, "Username.Placeholder")
        self._Notification_PinnedDeletedMessage = getValue(dict, "Notification.PinnedDeletedMessage")
        self._Notification_PinnedDeletedMessage_r = extractArgumentRanges(self._Notification_PinnedDeletedMessage)
        self.UserInfo_BotHelp = getValue(dict, "UserInfo.BotHelp")
        self.Contacts_contact = getValue(dict, "Contacts.contact")
        self.TwoStepAuth_PasswordSet = getValue(dict, "TwoStepAuth.PasswordSet")
        self.Channel_Moderator_AccessLevelEditor = getValue(dict, "Channel.Moderator.AccessLevelEditor")
        self.EnterPasscode_TouchId = getValue(dict, "EnterPasscode.TouchId")
        self._CHANNEL_MESSAGE_VIDEO = getValue(dict, "CHANNEL_MESSAGE_VIDEO")
        self._CHANNEL_MESSAGE_VIDEO_r = extractArgumentRanges(self._CHANNEL_MESSAGE_VIDEO)
        self.Checkout_ErrorInvoiceAlreadyPaid = getValue(dict, "Checkout.ErrorInvoiceAlreadyPaid")
        self.ChatAdmins_Title = getValue(dict, "ChatAdmins.Title")
        self.BroadcastLists_NoListsText = getValue(dict, "BroadcastLists.NoListsText")
        self.ChannelMembers_WhoCanAddMembers = getValue(dict, "ChannelMembers.WhoCanAddMembers")
        self.ChannelMembers_AllMembersMayInviteOffHelp = getValue(dict, "ChannelMembers.AllMembersMayInviteOffHelp")
        self.Conversation_InfoPrivate = getValue(dict, "Conversation.InfoPrivate")
        self.PasscodeSettings_Help = getValue(dict, "PasscodeSettings.Help")
        self.Conversation_EditingMessagePanelTitle = getValue(dict, "Conversation.EditingMessagePanelTitle")
        self._NetworkUsageSettings_CellularUsageSince = getValue(dict, "NetworkUsageSettings.CellularUsageSince")
        self._NetworkUsageSettings_CellularUsageSince_r = extractArgumentRanges(self._NetworkUsageSettings_CellularUsageSince)
        self.GroupInfo_ConvertToSupergroup = getValue(dict, "GroupInfo.ConvertToSupergroup")
        self._Notification_PinnedContactMessage = getValue(dict, "Notification.PinnedContactMessage")
        self._Notification_PinnedContactMessage_r = extractArgumentRanges(self._Notification_PinnedContactMessage)
        self.CallSettings_UseLessDataLongDescription = getValue(dict, "CallSettings.UseLessDataLongDescription")
        self.Conversation_SecretChatContextBotAlert = getValue(dict, "Conversation.SecretChatContextBotAlert")
        self.Channel_Moderator_AccessLevelRevoke = getValue(dict, "Channel.Moderator.AccessLevelRevoke")
        self.CheckoutInfo_ReceiverInfoTitle = getValue(dict, "CheckoutInfo.ReceiverInfoTitle")
        self.Channel_AdminLogFilter_EventsRestrictions = getValue(dict, "Channel.AdminLogFilter.EventsRestrictions")
        self.GroupInfo_InviteLink_RevokeLink = getValue(dict, "GroupInfo.InviteLink.RevokeLink")
        self.Conversation_Unmute = getValue(dict, "Conversation.Unmute")
        self.Checkout_PaymentMethod_Title = getValue(dict, "Checkout.PaymentMethod.Title")
        self._AppLanguage_LanguageSuggested = getValue(dict, "AppLanguage.LanguageSuggested")
        self._AppLanguage_LanguageSuggested_r = extractArgumentRanges(self._AppLanguage_LanguageSuggested)
        self.Notifications_MessageNotifications = getValue(dict, "Notifications.MessageNotifications")
        self.ChannelMembers_WhoCanAddMembersAdminsHelp = getValue(dict, "ChannelMembers.WhoCanAddMembersAdminsHelp")
        self.DialogList_DeleteBotConversationConfirmation = getValue(dict, "DialogList.DeleteBotConversationConfirmation")
        self._MediaPicker_AccessDeniedHelp = getValue(dict, "MediaPicker.AccessDeniedHelp")
        self._MediaPicker_AccessDeniedHelp_r = extractArgumentRanges(self._MediaPicker_AccessDeniedHelp)
        self._GroupInfo_InvitationLinkAccept = getValue(dict, "GroupInfo.InvitationLinkAccept")
        self._GroupInfo_InvitationLinkAccept_r = extractArgumentRanges(self._GroupInfo_InvitationLinkAccept)
        self.Conversation_ClousStorageInfo_Description2 = getValue(dict, "Conversation.ClousStorageInfo.Description2")
        self.Map_Hybrid = getValue(dict, "Map.Hybrid")
        self.Channel_Setup_Title = getValue(dict, "Channel.Setup.Title")
        self.Activity_UploadingVideo = getValue(dict, "Activity.UploadingVideo")
        self.Channel_Info_Management = getValue(dict, "Channel.Info.Management")
        self._Notification_MessageLifetimeChangedOutgoing = getValue(dict, "Notification.MessageLifetimeChangedOutgoing")
        self._Notification_MessageLifetimeChangedOutgoing_r = extractArgumentRanges(self._Notification_MessageLifetimeChangedOutgoing)
        self.Conversation_DeleteOneMessage = getValue(dict, "Conversation.DeleteOneMessage")
        self.PhotoEditor_QualityVeryLow = getValue(dict, "PhotoEditor.QualityVeryLow")
        self.Month_ShortFebruary = getValue(dict, "Month.ShortFebruary")
        self.Compose_NewBroadcast = getValue(dict, "Compose.NewBroadcast")
        self.Conversation_ForwardTitle = getValue(dict, "Conversation.ForwardTitle")
        self.Settings_FAQ_URL = getValue(dict, "Settings.FAQ_URL")
        self.TwoStepAuth_ConfirmationChangeEmail = getValue(dict, "TwoStepAuth.ConfirmationChangeEmail")
        self.Activity_RecordingVideoMessage = getValue(dict, "Activity.RecordingVideoMessage")
        self.WelcomeScreen_ContactsAccessSettings = getValue(dict, "WelcomeScreen.ContactsAccessSettings")
        self.SharedMedia_EmptyFilesText = getValue(dict, "SharedMedia.EmptyFilesText")
        self._Contacts_AccessDeniedHelpLandscape = getValue(dict, "Contacts.AccessDeniedHelpLandscape")
        self._Contacts_AccessDeniedHelpLandscape_r = extractArgumentRanges(self._Contacts_AccessDeniedHelpLandscape)
        self.Channel_NotificationCommentsEnabled = getValue(dict, "Channel.NotificationCommentsEnabled")
        self.PasscodeSettings_UnlockWithTouchId = getValue(dict, "PasscodeSettings.UnlockWithTouchId")
        self.Contacts_AccessDeniedHelpON = getValue(dict, "Contacts.AccessDeniedHelpON")
        self._Time_MonthOfYear_5 = getValue(dict, "Time.MonthOfYear_5")
        self._Time_MonthOfYear_5_r = extractArgumentRanges(self._Time_MonthOfYear_5)
        self._PrivacySettings_LastSeenContactsMinusPlus = getValue(dict, "PrivacySettings.LastSeenContactsMinusPlus")
        self._PrivacySettings_LastSeenContactsMinusPlus_r = extractArgumentRanges(self._PrivacySettings_LastSeenContactsMinusPlus)
        self.NetworkUsageSettings_ResetStats = getValue(dict, "NetworkUsageSettings.ResetStats")
        self._Notification_ChannelInviter = getValue(dict, "Notification.ChannelInviter")
        self._Notification_ChannelInviter_r = extractArgumentRanges(self._Notification_ChannelInviter)
        self.Profile_MessageLifetimeForever = getValue(dict, "Profile.MessageLifetimeForever")
        self.Conversation_Edit = getValue(dict, "Conversation.Edit")
        self.TwoStepAuth_ResetAccountHelp = getValue(dict, "TwoStepAuth.ResetAccountHelp")
        self.Month_GenDecember = getValue(dict, "Month.GenDecember")
        self._Watch_LastSeen_YesterdayAt = getValue(dict, "Watch.LastSeen.YesterdayAt")
        self._Watch_LastSeen_YesterdayAt_r = extractArgumentRanges(self._Watch_LastSeen_YesterdayAt)
        self.Channel_ErrorAddBlocked = getValue(dict, "Channel.ErrorAddBlocked")
        self.Conversation_Unpin = getValue(dict, "Conversation.Unpin")
        self.Call_RecordingDisabledMessage = getValue(dict, "Call.RecordingDisabledMessage")
        self.Conversation_Stop = getValue(dict, "Conversation.Stop")
        self.Conversation_UnblockUser = getValue(dict, "Conversation.UnblockUser")
        self.Conversation_Unblock = getValue(dict, "Conversation.Unblock")
        self._CHANNEL_MESSAGE_GIF = getValue(dict, "CHANNEL_MESSAGE_GIF")
        self._CHANNEL_MESSAGE_GIF_r = extractArgumentRanges(self._CHANNEL_MESSAGE_GIF)
        self.Channel_AdminLogFilter_EventsEditedMessages = getValue(dict, "Channel.AdminLogFilter.EventsEditedMessages")
        self.Channel_Username_InvalidTooShort = getValue(dict, "Channel.Username.InvalidTooShort")
        self.Watch_LastSeen_WithinAWeek = getValue(dict, "Watch.LastSeen.WithinAWeek")
        self.BlockedUsers_SelectUserTitle = getValue(dict, "BlockedUsers.SelectUserTitle")
        self.Profile_MessageLifetime1w = getValue(dict, "Profile.MessageLifetime1w")
        self.DialogList_TabTitle = getValue(dict, "DialogList.TabTitle")
        self.UserInfo_GenericPhoneLabel = getValue(dict, "UserInfo.GenericPhoneLabel")
        self.MediaPicker_MomentsDateFormat = getValue(dict, "MediaPicker.MomentsDateFormat")
        self._Conversation_DownloadKilobytes = getValue(dict, "Conversation.DownloadKilobytes")
        self._Conversation_DownloadKilobytes_r = extractArgumentRanges(self._Conversation_DownloadKilobytes)
        self._Username_LinkHint = getValue(dict, "Username.LinkHint")
        self._Username_LinkHint_r = extractArgumentRanges(self._Username_LinkHint)
        self.NetworkUsageSettings_Title = getValue(dict, "NetworkUsageSettings.Title")
        self.CheckoutInfo_ShippingInfoPostcodePlaceholder = getValue(dict, "CheckoutInfo.ShippingInfoPostcodePlaceholder")
        self.Wallpaper_Wallpaper = getValue(dict, "Wallpaper.Wallpaper")
        self.GroupInfo_InviteLink_RevokeAlert_Revoke = getValue(dict, "GroupInfo.InviteLink.RevokeAlert.Revoke")
        self.SharedMedia_TitleLink = getValue(dict, "SharedMedia.TitleLink")
        self.Channel_JoinChannel = getValue(dict, "Channel.JoinChannel")
        self.StickerPack_Add = getValue(dict, "StickerPack.Add")
        self.Group_ErrorNotMutualContact = getValue(dict, "Group.ErrorNotMutualContact")
        self.AccessDenied_LocationDisabled = getValue(dict, "AccessDenied.LocationDisabled")
        self.Conversation_DownloadPhoto = getValue(dict, "Conversation.DownloadPhoto")
        self.Login_UnknownError = getValue(dict, "Login.UnknownError")
        self.Presence_online = getValue(dict, "Presence.online")
        self.DialogList_Title = getValue(dict, "DialogList.Title")
        self.Stickers_Install = getValue(dict, "Stickers.Install")
        self.SearchImages_NoImagesFound = getValue(dict, "SearchImages.NoImagesFound")
        self._Notification_RemovedUserPhoto = getValue(dict, "Notification.RemovedUserPhoto")
        self._Notification_RemovedUserPhoto_r = extractArgumentRanges(self._Notification_RemovedUserPhoto)
        self._Watch_Time_ShortTodayAt = getValue(dict, "Watch.Time.ShortTodayAt")
        self._Watch_Time_ShortTodayAt_r = extractArgumentRanges(self._Watch_Time_ShortTodayAt)
        self.UserInfo_GroupsInCommon = getValue(dict, "UserInfo.GroupsInCommon")
        self.ChatSettings_Language = getValue(dict, "ChatSettings.Language")
        self.AccessDenied_CameraDisabled = getValue(dict, "AccessDenied.CameraDisabled")
        self.Message_PinnedContactMessage = getValue(dict, "Message.PinnedContactMessage")
        self.UserInfo_Call = getValue(dict, "UserInfo.Call")
        self.Conversation_InputTextDisabledPlaceholder = getValue(dict, "Conversation.InputTextDisabledPlaceholder")
        self.Map_ForwardViaTelegram = getValue(dict, "Map.ForwardViaTelegram")
        self.Month_GenMarch = getValue(dict, "Month.GenMarch")
        self.Watch_UserInfo_Unmute = getValue(dict, "Watch.UserInfo.Unmute")
        self.PhotoEditor_BlurTool = getValue(dict, "PhotoEditor.BlurTool")
        self.Common_Delete = getValue(dict, "Common.Delete")
        self.Username_Title = getValue(dict, "Username.Title")
        self.Login_PhoneFloodError = getValue(dict, "Login.PhoneFloodError")
        self.CheckoutInfo_ErrorPostcodeInvalid = getValue(dict, "CheckoutInfo.ErrorPostcodeInvalid")
        self._CHANNEL_MESSAGE_PHOTO = getValue(dict, "CHANNEL_MESSAGE_PHOTO")
        self._CHANNEL_MESSAGE_PHOTO_r = extractArgumentRanges(self._CHANNEL_MESSAGE_PHOTO)
        self.Channel_AdminLog_InfoPanelTitle = getValue(dict, "Channel.AdminLog.InfoPanelTitle")
        self.Group_ErrorAddTooMuchBots = getValue(dict, "Group.ErrorAddTooMuchBots")
        self._Notification_CallFormat = getValue(dict, "Notification.CallFormat")
        self._Notification_CallFormat_r = extractArgumentRanges(self._Notification_CallFormat)
        self._CHAT_MESSAGE_PHOTO = getValue(dict, "CHAT_MESSAGE_PHOTO")
        self._CHAT_MESSAGE_PHOTO_r = extractArgumentRanges(self._CHAT_MESSAGE_PHOTO)
        self._Channel_AdminLog_MessageToggleInvitesOff = getValue(dict, "Channel.AdminLog.MessageToggleInvitesOff")
        self._Channel_AdminLog_MessageToggleInvitesOff_r = extractArgumentRanges(self._Channel_AdminLog_MessageToggleInvitesOff)
        self.UserInfo_ShareBot = getValue(dict, "UserInfo.ShareBot")
        self.TwoStepAuth_EmailSkip = getValue(dict, "TwoStepAuth.EmailSkip")
        self.Conversation_JumpToDate = getValue(dict, "Conversation.JumpToDate")
        self.CheckoutInfo_ReceiverInfoEmailPlaceholder = getValue(dict, "CheckoutInfo.ReceiverInfoEmailPlaceholder")
        self.Message_Photo = getValue(dict, "Message.Photo")
        self.Conversation_ReportSpam = getValue(dict, "Conversation.ReportSpam")
        self.Camera_FlashAuto = getValue(dict, "Camera.FlashAuto")
        self._Time_MonthOfYear_4 = getValue(dict, "Time.MonthOfYear_4")
        self._Time_MonthOfYear_4_r = extractArgumentRanges(self._Time_MonthOfYear_4)
        self.Call_ConnectionErrorMessage = getValue(dict, "Call.ConnectionErrorMessage")
        self.Compose_NewChannel_AddMember = getValue(dict, "Compose.NewChannel.AddMember")
        self.Watch_State_Updating = getValue(dict, "Watch.State.Updating")
        self.LastSeen_ALongTimeAgo = getValue(dict, "LastSeen.ALongTimeAgo")
        self.DialogList_SearchSectionGlobal = getValue(dict, "DialogList.SearchSectionGlobal")
        self.ChangePhoneNumberNumber_NumberPlaceholder = getValue(dict, "ChangePhoneNumberNumber.NumberPlaceholder")
        self.GroupInfo_AddUserLeftError = getValue(dict, "GroupInfo.AddUserLeftError")
        self.GroupInfo_GroupType = getValue(dict, "GroupInfo.GroupType")
        self.Watch_Suggestion_OnMyWay = getValue(dict, "Watch.Suggestion.OnMyWay")
        self.Checkout_NewCard_PaymentCard = getValue(dict, "Checkout.NewCard.PaymentCard")
        self.PhotoEditor_CropAspectRatioOriginal = getValue(dict, "PhotoEditor.CropAspectRatioOriginal")
        self.MediaPicker_MomentsDateRangeFormat = getValue(dict, "MediaPicker.MomentsDateRangeFormat")
        self.UserInfo_NotificationsDisabled = getValue(dict, "UserInfo.NotificationsDisabled")
        self._CONTACT_JOINED = getValue(dict, "CONTACT_JOINED")
        self._CONTACT_JOINED_r = extractArgumentRanges(self._CONTACT_JOINED)
        self.PrivacyLastSeenSettings_AlwaysShareWith_Title = getValue(dict, "PrivacyLastSeenSettings.AlwaysShareWith.Title")
        self.BlockedUsers_LeavePrefix = getValue(dict, "BlockedUsers.LeavePrefix")
        self.NetworkUsageSettings_ResetStatsConfirmation = getValue(dict, "NetworkUsageSettings.ResetStatsConfirmation")
        self.Channel_EditAdmin_PermissionPostMessages = getValue(dict, "Channel.EditAdmin.PermissionPostMessages")
        self.DialogList_EncryptionProcessing = getValue(dict, "DialogList.EncryptionProcessing")
        self.Conversation_ApplyLocalization = getValue(dict, "Conversation.ApplyLocalization")
        self.Conversation_DeleteManyMessages = getValue(dict, "Conversation.DeleteManyMessages")
        self.CancelResetAccount_Title = getValue(dict, "CancelResetAccount.Title")
        self.Notification_CallOutgoingShort = getValue(dict, "Notification.CallOutgoingShort")
        self.Channel_Moderator_AccessLevelHeader = getValue(dict, "Channel.Moderator.AccessLevelHeader")
        self.SharedMedia_TitleAll = getValue(dict, "SharedMedia.TitleAll")
        self.Conversation_SlideToCancel = getValue(dict, "Conversation.SlideToCancel")
        self.AuthSessions_TerminateSession = getValue(dict, "AuthSessions.TerminateSession")
        self.Channel_AdminLogFilter_EventsDeletedMessages = getValue(dict, "Channel.AdminLogFilter.EventsDeletedMessages")
        self.PrivacyLastSeenSettings_AlwaysShareWith_Placeholder = getValue(dict, "PrivacyLastSeenSettings.AlwaysShareWith.Placeholder")
        self.Channel_Members_Title = getValue(dict, "Channel.Members.Title")
        self.Channel_AdminLog_CanDeleteMessages = getValue(dict, "Channel.AdminLog.CanDeleteMessages")
        self.Group_Setup_TypePrivateHelp = getValue(dict, "Group.Setup.TypePrivateHelp")
        self._Notification_PinnedVideoMessage = getValue(dict, "Notification.PinnedVideoMessage")
        self._Notification_PinnedVideoMessage_r = extractArgumentRanges(self._Notification_PinnedVideoMessage)
        self.Conversation_ContextMenuStickerPackAdd = getValue(dict, "Conversation.ContextMenuStickerPackAdd")
        self.Channel_AdminLogFilter_EventsNewMembers = getValue(dict, "Channel.AdminLogFilter.EventsNewMembers")
        self.Channel_AdminLogFilter_EventsPinned = getValue(dict, "Channel.AdminLogFilter.EventsPinned")
        self._Conversation_Moderate_DeleteAllMessages = getValue(dict, "Conversation.Moderate.DeleteAllMessages")
        self._Conversation_Moderate_DeleteAllMessages_r = extractArgumentRanges(self._Conversation_Moderate_DeleteAllMessages)
        self.SharedMedia_CategoryOther = getValue(dict, "SharedMedia.CategoryOther")
        self.GoogleDrive_LogoutMessage = getValue(dict, "GoogleDrive.LogoutMessage")
        self.Preview_DeletePhoto = getValue(dict, "Preview.DeletePhoto")
        self.PasscodeSettings_TurnPasscodeOn = getValue(dict, "PasscodeSettings.TurnPasscodeOn")
        self.GroupInfo_ChannelListNamePlaceholder = getValue(dict, "GroupInfo.ChannelListNamePlaceholder")
        self.DialogList_Unpin = getValue(dict, "DialogList.Unpin")
        self.GroupInfo_SetGroupPhoto = getValue(dict, "GroupInfo.SetGroupPhoto")
        self.StickerPacksSettings_ArchivedPacks_Info = getValue(dict, "StickerPacksSettings.ArchivedPacks.Info")
        self.ConvertToSupergroup_Title = getValue(dict, "ConvertToSupergroup.Title")
        self._CHAT_MESSAGE_NOTEXT = getValue(dict, "CHAT_MESSAGE_NOTEXT")
        self._CHAT_MESSAGE_NOTEXT_r = extractArgumentRanges(self._CHAT_MESSAGE_NOTEXT)
        self.Channel_Setup_TypeHeader = getValue(dict, "Channel.Setup.TypeHeader")
        self._Notification_NewAuthDetected = getValue(dict, "Notification.NewAuthDetected")
        self._Notification_NewAuthDetected_r = extractArgumentRanges(self._Notification_NewAuthDetected)
        self.Notification_CallCanceledShort = getValue(dict, "Notification.CallCanceledShort")
        self.PhotoEditor_RevertMessage = getValue(dict, "PhotoEditor.RevertMessage")
        self.AccessDenied_VideoMessageCamera = getValue(dict, "AccessDenied.VideoMessageCamera")
        self.Conversation_Search = getValue(dict, "Conversation.Search")
        self._Channel_Management_PromotedBy = getValue(dict, "Channel.Management.PromotedBy")
        self._Channel_Management_PromotedBy_r = extractArgumentRanges(self._Channel_Management_PromotedBy)
        self._PrivacySettings_LastSeenNobodyPlus = getValue(dict, "PrivacySettings.LastSeenNobodyPlus")
        self._PrivacySettings_LastSeenNobodyPlus_r = extractArgumentRanges(self._PrivacySettings_LastSeenNobodyPlus)
        self.Preview_ForwardViaTelegram = getValue(dict, "Preview.ForwardViaTelegram")
        self.Notifications_InAppNotificationsSounds = getValue(dict, "Notifications.InAppNotificationsSounds")
        self.Call_StatusRequesting = getValue(dict, "Call.StatusRequesting")
        self._CHAT_MESSAGE_CONTACT = getValue(dict, "CHAT_MESSAGE_CONTACT")
        self._CHAT_MESSAGE_CONTACT_r = extractArgumentRanges(self._CHAT_MESSAGE_CONTACT)
        self.Group_UpgradeNoticeText1 = getValue(dict, "Group.UpgradeNoticeText1")
        self.ChatSettings_Other = getValue(dict, "ChatSettings.Other")
        self._Channel_AdminLog_MessageChangedChannelAbout = getValue(dict, "Channel.AdminLog.MessageChangedChannelAbout")
        self._Channel_AdminLog_MessageChangedChannelAbout_r = extractArgumentRanges(self._Channel_AdminLog_MessageChangedChannelAbout)
        self._Call_EmojiDescription = getValue(dict, "Call.EmojiDescription")
        self._Call_EmojiDescription_r = extractArgumentRanges(self._Call_EmojiDescription)
        self.Settings_SaveIncomingPhotos = getValue(dict, "Settings.SaveIncomingPhotos")
        self._Conversation_Bytes = getValue(dict, "Conversation.Bytes")
        self._Conversation_Bytes_r = extractArgumentRanges(self._Conversation_Bytes)
        self.GroupInfo_InviteLink_Help = getValue(dict, "GroupInfo.InviteLink.Help")
        self._Time_MonthOfYear_3 = getValue(dict, "Time.MonthOfYear_3")
        self._Time_MonthOfYear_3_r = extractArgumentRanges(self._Time_MonthOfYear_3)
        self.Conversation_ContextMenuForward = getValue(dict, "Conversation.ContextMenuForward")
        self.Calls_Missed = getValue(dict, "Calls.Missed")
        self.Call_StatusRinging = getValue(dict, "Call.StatusRinging")
        self.Invitation_JoinGroup = getValue(dict, "Invitation.JoinGroup")
        self.Notification_PinnedMessage = getValue(dict, "Notification.PinnedMessage")
        self.Message_Location = getValue(dict, "Message.Location")
        self._Notification_MessageLifetimeChanged = getValue(dict, "Notification.MessageLifetimeChanged")
        self._Notification_MessageLifetimeChanged_r = extractArgumentRanges(self._Notification_MessageLifetimeChanged)
        self.Message_Contact = getValue(dict, "Message.Contact")
        self._Watch_LastSeen_TodayAt = getValue(dict, "Watch.LastSeen.TodayAt")
        self._Watch_LastSeen_TodayAt_r = extractArgumentRanges(self._Watch_LastSeen_TodayAt)
        self.Channel_Moderator_AccessLevelModerator = getValue(dict, "Channel.Moderator.AccessLevelModerator")
        self.GoogleDrive_Logout = getValue(dict, "GoogleDrive.Logout")
        self.PhotoEditor_RevertToOriginal = getValue(dict, "PhotoEditor.RevertToOriginal")
        self.Common_More = getValue(dict, "Common.More")
        self.Preview_OpenInInstagram = getValue(dict, "Preview.OpenInInstagram")
        self.PhotoEditor_HighlightsTool = getValue(dict, "PhotoEditor.HighlightsTool")
        self._Channel_Username_UsernameIsAvailable = getValue(dict, "Channel.Username.UsernameIsAvailable")
        self._Channel_Username_UsernameIsAvailable_r = extractArgumentRanges(self._Channel_Username_UsernameIsAvailable)
        self._PINNED_GAME = getValue(dict, "PINNED_GAME")
        self._PINNED_GAME_r = extractArgumentRanges(self._PINNED_GAME)
        self.GroupInfo_BroadcastListNamePlaceholder = getValue(dict, "GroupInfo.BroadcastListNamePlaceholder")
        self.Conversation_ShareBotContactConfirmation = getValue(dict, "Conversation.ShareBotContactConfirmation")
        self.Login_CodeSentSms = getValue(dict, "Login.CodeSentSms")
        self.Conversation_ReportSpamConfirmation = getValue(dict, "Conversation.ReportSpamConfirmation")
        self.ChannelMembers_ChannelAdminsTitle = getValue(dict, "ChannelMembers.ChannelAdminsTitle")
        self.CallSettings_UseLessData = getValue(dict, "CallSettings.UseLessData")
        self._TwoStepAuth_EnterPasswordHint = getValue(dict, "TwoStepAuth.EnterPasswordHint")
        self._TwoStepAuth_EnterPasswordHint_r = extractArgumentRanges(self._TwoStepAuth_EnterPasswordHint)
        self.CallSettings_TabIcon = getValue(dict, "CallSettings.TabIcon")
        self.Conversation_EditForward = getValue(dict, "Conversation.EditForward")
        self.ConversationProfile_UnknownAddMemberError = getValue(dict, "ConversationProfile.UnknownAddMemberError")
        self._Conversation_FileHowToText = getValue(dict, "Conversation.FileHowToText")
        self._Conversation_FileHowToText_r = extractArgumentRanges(self._Conversation_FileHowToText)
        self.Channel_AdminLog_BanSendMedia = getValue(dict, "Channel.AdminLog.BanSendMedia")
        self.Tour_Text7 = getValue(dict, "Tour.Text7")
        self.Contacts_contactsvar = getValue(dict, "Contacts.contactsvar")
        self.Watch_UserInfo_Unblock = getValue(dict, "Watch.UserInfo.Unblock")
        self.Conversation_EditDelete = getValue(dict, "Conversation.EditDelete")
        self.Conversation_ViewPhoto = getValue(dict, "Conversation.ViewPhoto")
        self.StickerPacksSettings_ArchivedMasks = getValue(dict, "StickerPacksSettings.ArchivedMasks")
        self.Message_Animation = getValue(dict, "Message.Animation")
        self.Checkout_PaymentMethod = getValue(dict, "Checkout.PaymentMethod")
        self.Channel_AdminLog_TitleSelectedEvents = getValue(dict, "Channel.AdminLog.TitleSelectedEvents")
        self.Privacy_Calls_NeverAllow_Title = getValue(dict, "Privacy.Calls.NeverAllow.Title")
        self.Cache_Music = getValue(dict, "Cache.Music")
        self._Login_CallRequestState1 = getValue(dict, "Login.CallRequestState1")
        self._Login_CallRequestState1_r = extractArgumentRanges(self._Login_CallRequestState1)
        self._SearchImages_ImageNofM = getValue(dict, "SearchImages.ImageNofM")
        self._SearchImages_ImageNofM_r = extractArgumentRanges(self._SearchImages_ImageNofM)
        self.Channel_Username_CreatePrivateLinkHelp = getValue(dict, "Channel.Username.CreatePrivateLinkHelp")
        self._FileSize_B = getValue(dict, "FileSize.B")
        self._FileSize_B_r = extractArgumentRanges(self._FileSize_B)
        self._Target_ShareGameConfirmationGroup = getValue(dict, "Target.ShareGameConfirmationGroup")
        self._Target_ShareGameConfirmationGroup_r = extractArgumentRanges(self._Target_ShareGameConfirmationGroup)
        self.PhotoEditor_SaturationTool = getValue(dict, "PhotoEditor.SaturationTool")
        self.ImagePicker_NoPhotos = getValue(dict, "ImagePicker.NoPhotos")
        self.Call_StatusConnecting = getValue(dict, "Call.StatusConnecting")
        self.Channel_BanUser_BlockFor = getValue(dict, "Channel.BanUser.BlockFor")
        self.Preview_DeleteVideo = getValue(dict, "Preview.DeleteVideo")
        self.Bot_Start = getValue(dict, "Bot.Start")
        self._Channel_AdminLog_MessageChangedGroupAbout = getValue(dict, "Channel.AdminLog.MessageChangedGroupAbout")
        self._Channel_AdminLog_MessageChangedGroupAbout_r = extractArgumentRanges(self._Channel_AdminLog_MessageChangedGroupAbout)
        self.Notifications_TextTone = getValue(dict, "Notifications.TextTone")
        self.DialogList_Draft = getValue(dict, "DialogList.Draft")
        self._Watch_Time_ShortYesterdayAt = getValue(dict, "Watch.Time.ShortYesterdayAt")
        self._Watch_Time_ShortYesterdayAt_r = extractArgumentRanges(self._Watch_Time_ShortYesterdayAt)
        self.Contacts_InviteToTelegram = getValue(dict, "Contacts.InviteToTelegram")
        self._PINNED_DOC = getValue(dict, "PINNED_DOC")
        self._PINNED_DOC_r = extractArgumentRanges(self._PINNED_DOC)
        self._ConversationProfile_UserLeftChatError = getValue(dict, "ConversationProfile.UserLeftChatError")
        self._ConversationProfile_UserLeftChatError_r = extractArgumentRanges(self._ConversationProfile_UserLeftChatError)
        self.ChatSettings_PrivateChats = getValue(dict, "ChatSettings.PrivateChats")
        self.Settings_CallSettings = getValue(dict, "Settings.CallSettings")
        self.Channel_EditAdmin_PermissionDeleteMessages = getValue(dict, "Channel.EditAdmin.PermissionDeleteMessages")
        self.Conversation_CloudStorageInfo_Title = getValue(dict, "Conversation.CloudStorageInfo.Title")
        self.Channel_BanUser_PermissionSendStickersAndGifs = getValue(dict, "Channel.BanUser.PermissionSendStickersAndGifs")
        self.Channel_AdminLog_Status = getValue(dict, "Channel.AdminLog.Status")
        self.Notification_RenamedChannel = getValue(dict, "Notification.RenamedChannel")
        self.BlockedUsers_BlockUser = getValue(dict, "BlockedUsers.BlockUser")
        self.ChatSettings_TextSize = getValue(dict, "ChatSettings.TextSize")
        self.MediaPicker_AccessDeniedError = getValue(dict, "MediaPicker.AccessDeniedError")
        self.ChannelInfo_DeleteGroup = getValue(dict, "ChannelInfo.DeleteGroup")
        self._BlockedUsers_BlockFormat = getValue(dict, "BlockedUsers.BlockFormat")
        self._BlockedUsers_BlockFormat_r = extractArgumentRanges(self._BlockedUsers_BlockFormat)
        self.PhoneNumberHelp_Alert = getValue(dict, "PhoneNumberHelp.Alert")
        self._PINNED_TEXT = getValue(dict, "PINNED_TEXT")
        self._PINNED_TEXT_r = extractArgumentRanges(self._PINNED_TEXT)
        self.Watch_ChannelInfo_Title = getValue(dict, "Watch.ChannelInfo.Title")
        self.WebSearch_RecentSectionClear = getValue(dict, "WebSearch.RecentSectionClear")
        self.Channel_AdminLogFilter_AdminsAll = getValue(dict, "Channel.AdminLogFilter.AdminsAll")
        self.StickerPack_AddStickers = getValue(dict, "StickerPack.AddStickers")
        self.Channel_Setup_TypePrivate = getValue(dict, "Channel.Setup.TypePrivate")
        self.PhotoEditor_TintTool = getValue(dict, "PhotoEditor.TintTool")
        self.Watch_Suggestion_CantTalk = getValue(dict, "Watch.Suggestion.CantTalk")
        self.PhotoEditor_QualityHigh = getValue(dict, "PhotoEditor.QualityHigh")
        self._CHAT_MESSAGE_STICKER = getValue(dict, "CHAT_MESSAGE_STICKER")
        self._CHAT_MESSAGE_STICKER_r = extractArgumentRanges(self._CHAT_MESSAGE_STICKER)
        self.Map_ChooseAPlace = getValue(dict, "Map.ChooseAPlace")
        self.Tour_Title7 = getValue(dict, "Tour.Title7")
        self.Watch_Bot_Restart = getValue(dict, "Watch.Bot.Restart")
        self.StickerPack_ShareStickers = getValue(dict, "StickerPack.ShareStickers")
        self.ChannelMembers_AllMembersMayInvite = getValue(dict, "ChannelMembers.AllMembersMayInvite")
        self.Channel_About_Help = getValue(dict, "Channel.About.Help")
        self.Web_OpenExternal = getValue(dict, "Web.OpenExternal")
        self.UserInfo_AddContact = getValue(dict, "UserInfo.AddContact")
        self.Call_EncryptionKey_Title = getValue(dict, "Call.EncryptionKey.Title")
        self.PhotoEditor_BlurToolLinear = getValue(dict, "PhotoEditor.BlurToolLinear")
        self.AuthSessions_EmptyText = getValue(dict, "AuthSessions.EmptyText")
        self.Notification_MessageLifetime1m = getValue(dict, "Notification.MessageLifetime1m")
        self._Call_StatusBar = getValue(dict, "Call.StatusBar")
        self._Call_StatusBar_r = extractArgumentRanges(self._Call_StatusBar)
        self.Month_ShortJuly = getValue(dict, "Month.ShortJuly")
        self.Watch_MessageView_ViewOnPhone = getValue(dict, "Watch.MessageView.ViewOnPhone")
        self.CheckoutInfo_ShippingInfoAddress1Placeholder = getValue(dict, "CheckoutInfo.ShippingInfoAddress1Placeholder")
        self.CallSettings_Never = getValue(dict, "CallSettings.Never")
        self.DialogList_SelectContacts = getValue(dict, "DialogList.SelectContacts")
        self.Conversation_DownloadProgressMegabytes = getValue(dict, "Conversation.DownloadProgressMegabytes")
        self.TwoStepAuth_EmailSent = getValue(dict, "TwoStepAuth.EmailSent")
        self._Notification_PinnedAnimationMessage = getValue(dict, "Notification.PinnedAnimationMessage")
        self._Notification_PinnedAnimationMessage_r = extractArgumentRanges(self._Notification_PinnedAnimationMessage)
        self.TwoStepAuth_RecoveryTitle = getValue(dict, "TwoStepAuth.RecoveryTitle")
        self.WatchRemote_AlertOpen = getValue(dict, "WatchRemote.AlertOpen")
        self.ExplicitContent_AlertChannel = getValue(dict, "ExplicitContent.AlertChannel")
        self.TwoStepAuth_ConfirmationText = getValue(dict, "TwoStepAuth.ConfirmationText")
        self.Widget_AuthRequired = getValue(dict, "Widget.AuthRequired")
        self._ForwardedAuthors2 = getValue(dict, "ForwardedAuthors2")
        self._ForwardedAuthors2_r = extractArgumentRanges(self._ForwardedAuthors2)
        self.ChannelInfo_DeleteGroupConfirmation = getValue(dict, "ChannelInfo.DeleteGroupConfirmation")
        self.Login_SmsRequestState3 = getValue(dict, "Login.SmsRequestState3")
        self.Notifications_AlertTones = getValue(dict, "Notifications.AlertTones")
        self.Calls_TabTitle = getValue(dict, "Calls.TabTitle")
        self.Login_InfoAvatarPhoto = getValue(dict, "Login.InfoAvatarPhoto")
        self.Contacts_MemberSearchSectionTitleChannel = getValue(dict, "Contacts.MemberSearchSectionTitleChannel")
        self.PhotoEditor_CurvesTool = getValue(dict, "PhotoEditor.CurvesTool")
        self.Preview_LoadingVideo = getValue(dict, "Preview.LoadingVideo")
        self.State_updating = getValue(dict, "State.updating")
        self.TwoStepAuth_ResetAccount = getValue(dict, "TwoStepAuth.ResetAccount")
        self.Checkout_ShippingOption_Title = getValue(dict, "Checkout.ShippingOption.Title")
        self.Weekday_Tuesday = getValue(dict, "Weekday.Tuesday")
        self.Preview_Tooltip = getValue(dict, "Preview.Tooltip")
        self.Conversation_EncryptionProcessing = getValue(dict, "Conversation.EncryptionProcessing")
        self._CHAT_ADD_MEMBER = getValue(dict, "CHAT_ADD_MEMBER")
        self._CHAT_ADD_MEMBER_r = extractArgumentRanges(self._CHAT_ADD_MEMBER)
        self.Weekday_ShortSunday = getValue(dict, "Weekday.ShortSunday")
        self.Month_ShortJune = getValue(dict, "Month.ShortJune")
        self.Month_GenApril = getValue(dict, "Month.GenApril")
        self.StickerPacksSettings_ShowStickersButton = getValue(dict, "StickerPacksSettings.ShowStickersButton")
        self.MediaPicker_MomentsDateRangeSameMonthFormat = getValue(dict, "MediaPicker.MomentsDateRangeSameMonthFormat")
        self.CheckoutInfo_ShippingInfoTitle = getValue(dict, "CheckoutInfo.ShippingInfoTitle")
        self.StickerPacksSettings_ShowStickersButtonHelp = getValue(dict, "StickerPacksSettings.ShowStickersButtonHelp")
        self._Compatibility_SecretMediaVersionTooLow = getValue(dict, "Compatibility.SecretMediaVersionTooLow")
        self._Compatibility_SecretMediaVersionTooLow_r = extractArgumentRanges(self._Compatibility_SecretMediaVersionTooLow)
        self.CallSettings_RecentCalls = getValue(dict, "CallSettings.RecentCalls")
        self.Conversation_Megabytes = getValue(dict, "Conversation.Megabytes")
        self.TwoStepAuth_FloodError = getValue(dict, "TwoStepAuth.FloodError")
        self.Paint_Stickers = getValue(dict, "Paint.Stickers")
        self.Login_InvalidCountryCode = getValue(dict, "Login.InvalidCountryCode")
        self.Privacy_Calls_AlwaysAllow_Title = getValue(dict, "Privacy.Calls.AlwaysAllow.Title")
        self.Username_InvalidTooShort = getValue(dict, "Username.InvalidTooShort")
        self.Weekday_ShortFriday = getValue(dict, "Weekday.ShortFriday")
        self.Conversation_ClearAll = getValue(dict, "Conversation.ClearAll")
        self.MediaPicker_Moments = getValue(dict, "MediaPicker.Moments")
        self.Call_PhoneCallInProgressMessage = getValue(dict, "Call.PhoneCallInProgressMessage")
        self.SharedMedia_EmptyTitle = getValue(dict, "SharedMedia.EmptyTitle")
        self.Checkout_Name = getValue(dict, "Checkout.Name")
        self.Preview_GroupPhotoTitle = getValue(dict, "Preview.GroupPhotoTitle")
        self._AUTH_REGION = getValue(dict, "AUTH_REGION")
        self._AUTH_REGION_r = extractArgumentRanges(self._AUTH_REGION)
        self.Settings_NotificationsAndSounds = getValue(dict, "Settings.NotificationsAndSounds")
        self._GroupInfo_InvitationLinkAcceptChannel = getValue(dict, "GroupInfo.InvitationLinkAcceptChannel")
        self._GroupInfo_InvitationLinkAcceptChannel_r = extractArgumentRanges(self._GroupInfo_InvitationLinkAcceptChannel)
        self.Conversation_EncryptionCanceled = getValue(dict, "Conversation.EncryptionCanceled")
        self.AccessDenied_SaveMedia = getValue(dict, "AccessDenied.SaveMedia")
        self.Channel_Username_InvalidTooManyUsernames = getValue(dict, "Channel.Username.InvalidTooManyUsernames")
        self.Compose_GroupTokenListPlaceholder = getValue(dict, "Compose.GroupTokenListPlaceholder")
        self.Profile_ImageUploadError = getValue(dict, "Profile.ImageUploadError")
        self.Conversation_MessageDeliveryFailed = getValue(dict, "Conversation.MessageDeliveryFailed")
        self.Privacy_PaymentsClear_PaymentInfo = getValue(dict, "Privacy.PaymentsClear.PaymentInfo")
        self.Notification_Mute1hMin = getValue(dict, "Notification.Mute1hMin")
        self.Notifications_GroupNotifications = getValue(dict, "Notifications.GroupNotifications")
        self.CheckoutInfo_SaveInfoHelp = getValue(dict, "CheckoutInfo.SaveInfoHelp")
        self.StickerPacksSettings_ArchivedMasks_Info = getValue(dict, "StickerPacksSettings.ArchivedMasks.Info")
        self.ChannelMembers_WhoCanAddMembers_AllMembers = getValue(dict, "ChannelMembers.WhoCanAddMembers.AllMembers")
        self.Channel_Edit_PrivatePublicLinkAlert = getValue(dict, "Channel.Edit.PrivatePublicLinkAlert")
        self.Watch_Conversation_UserInfo = getValue(dict, "Watch.Conversation.UserInfo")
        self.Application_Name = getValue(dict, "Application.Name")
        self.Conversation_AddToReadingList = getValue(dict, "Conversation.AddToReadingList")
        self.Conversation_FileDropbox = getValue(dict, "Conversation.FileDropbox")
        self.Login_PhonePlaceholder = getValue(dict, "Login.PhonePlaceholder")
        self.ExplicitContent_AlertUser = getValue(dict, "ExplicitContent.AlertUser")
        self.Profile_MessageLifetime1d = getValue(dict, "Profile.MessageLifetime1d")
        self.Calls_CallTabDescription = getValue(dict, "Calls.CallTabDescription")
        self.CheckoutInfo_ShippingInfoCityPlaceholder = getValue(dict, "CheckoutInfo.ShippingInfoCityPlaceholder")
        self.Resolve_ErrorNotFound = getValue(dict, "Resolve.ErrorNotFound")
        self.PhotoEditor_FadeTool = getValue(dict, "PhotoEditor.FadeTool")
        self.Channel_TitleShowDiscussion = getValue(dict, "Channel.TitleShowDiscussion")
        self.Channel_Setup_TypePublicHelp = getValue(dict, "Channel.Setup.TypePublicHelp")
        self.GroupInfo_InviteLink_RevokeAlert_Success = getValue(dict, "GroupInfo.InviteLink.RevokeAlert.Success")
        self.Channel_Setup_PublicNoLink = getValue(dict, "Channel.Setup.PublicNoLink")
        self.Conversation_Info = getValue(dict, "Conversation.Info")
        self.ChannelInfo_InvitationLinkDoesNotExist = getValue(dict, "ChannelInfo.InvitationLinkDoesNotExist")
        self._Time_TodayAt = getValue(dict, "Time.TodayAt")
        self._Time_TodayAt_r = extractArgumentRanges(self._Time_TodayAt)
        self.Conversation_Processing = getValue(dict, "Conversation.Processing")
        self._InstantPage_AuthorAndDateTitle = getValue(dict, "InstantPage.AuthorAndDateTitle")
        self._InstantPage_AuthorAndDateTitle_r = extractArgumentRanges(self._InstantPage_AuthorAndDateTitle)
        self._Watch_LastSeen_AtDate = getValue(dict, "Watch.LastSeen.AtDate")
        self._Watch_LastSeen_AtDate_r = extractArgumentRanges(self._Watch_LastSeen_AtDate)
        self.Conversation_Location = getValue(dict, "Conversation.Location")
        self.DialogList_PasscodeLockHelp = getValue(dict, "DialogList.PasscodeLockHelp")
        self.Channel_Management_Title = getValue(dict, "Channel.Management.Title")
        self.Notifications_InAppNotificationsPreview = getValue(dict, "Notifications.InAppNotificationsPreview")
        self.PrivacySettings_FloodControlError = getValue(dict, "PrivacySettings.FloodControlError")
        self.EnterPasscode_EnterTitle = getValue(dict, "EnterPasscode.EnterTitle")
        self.ReportPeer_ReasonOther_Title = getValue(dict, "ReportPeer.ReasonOther.Title")
        self.Month_GenJanuary = getValue(dict, "Month.GenJanuary")
        self.Conversation_ForwardChats = getValue(dict, "Conversation.ForwardChats")
        self.SharedMedia_TitlePhoto = getValue(dict, "SharedMedia.TitlePhoto")
        self.Channel_UpdatePhotoItem = getValue(dict, "Channel.UpdatePhotoItem")
        self.GroupInfo_InvitationLinkAlreadyAccepted = getValue(dict, "GroupInfo.InvitationLinkAlreadyAccepted")
        self.UserInfo_StartSecretChat = getValue(dict, "UserInfo.StartSecretChat")
        self.Watch_State_Connecting = getValue(dict, "Watch.State.Connecting")
        self.PrivacySettings_LastSeenNobody = getValue(dict, "PrivacySettings.LastSeenNobody")
        self._FileSize_MB = getValue(dict, "FileSize.MB")
        self._FileSize_MB_r = extractArgumentRanges(self._FileSize_MB)
        self.ChatSearch_SearchPlaceholder = getValue(dict, "ChatSearch.SearchPlaceholder")
        self.TwoStepAuth_ConfirmationAbort = getValue(dict, "TwoStepAuth.ConfirmationAbort")
        self.GroupInfo_KickedStatus = getValue(dict, "GroupInfo.KickedStatus")
        self.TwoStepAuth_SetupPasswordConfirmFailed = getValue(dict, "TwoStepAuth.SetupPasswordConfirmFailed")
        self._LastSeen_YesterdayAt = getValue(dict, "LastSeen.YesterdayAt")
        self._LastSeen_YesterdayAt_r = extractArgumentRanges(self._LastSeen_YesterdayAt)
        self.AppleWatch_ReplyPresetsHelp = getValue(dict, "AppleWatch.ReplyPresetsHelp")
        self.Localization_LanguageName = getValue(dict, "Localization.LanguageName")
        self.Map_OpenIn = getValue(dict, "Map.OpenIn")
        self.Message_File = getValue(dict, "Message.File")
        self._Channel_AdminLog_MessageChangedGroupUsername = getValue(dict, "Channel.AdminLog.MessageChangedGroupUsername")
        self._Channel_AdminLog_MessageChangedGroupUsername_r = extractArgumentRanges(self._Channel_AdminLog_MessageChangedGroupUsername)
        self._CHAT_MESSAGE_GAME = getValue(dict, "CHAT_MESSAGE_GAME")
        self._CHAT_MESSAGE_GAME_r = extractArgumentRanges(self._CHAT_MESSAGE_GAME)
        self.Month_ShortMay = getValue(dict, "Month.ShortMay")
        self._WelcomeScreen_Greeting = getValue(dict, "WelcomeScreen.Greeting")
        self._WelcomeScreen_Greeting_r = extractArgumentRanges(self._WelcomeScreen_Greeting)
        self.Tour_Text3 = getValue(dict, "Tour.Text3")
        self.Contacts_GlobalSearch = getValue(dict, "Contacts.GlobalSearch")
        self.Watch_Suggestion_CallSoon = getValue(dict, "Watch.Suggestion.CallSoon")
        self.DialogList_LanguageTooltip = getValue(dict, "DialogList.LanguageTooltip")
        self.Map_LoadError = getValue(dict, "Map.LoadError")
        self.WelcomeScreen_Logout = getValue(dict, "WelcomeScreen.Logout")
        self._Service_ApplyLocalizationWithWarnings = getValue(dict, "Service.ApplyLocalizationWithWarnings")
        self._Service_ApplyLocalizationWithWarnings_r = extractArgumentRanges(self._Service_ApplyLocalizationWithWarnings)
        self.AccessDenied_VoiceMicrophone = getValue(dict, "AccessDenied.VoiceMicrophone")
        self._CHANNEL_MESSAGE_STICKER = getValue(dict, "CHANNEL_MESSAGE_STICKER")
        self._CHANNEL_MESSAGE_STICKER_r = extractArgumentRanges(self._CHANNEL_MESSAGE_STICKER)
        self.PrivacySettings_Title = getValue(dict, "PrivacySettings.Title")
        self.PasscodeSettings_TurnPasscodeOff = getValue(dict, "PasscodeSettings.TurnPasscodeOff")
        self.MediaPicker_AddCaption = getValue(dict, "MediaPicker.AddCaption")
        self.Channel_AdminLog_BanReadMessages = getValue(dict, "Channel.AdminLog.BanReadMessages")
        self.SharedMedia_Outgoing = getValue(dict, "SharedMedia.Outgoing")
        self.Channel_About_Error = getValue(dict, "Channel.About.Error")
        self.Channel_Status = getValue(dict, "Channel.Status")
        self.Map_ChooseLocationTitle = getValue(dict, "Map.ChooseLocationTitle")
        self.Map_OpenInYandexNavigator = getValue(dict, "Map.OpenInYandexNavigator")
        self.SearchImages_SkipImage = getValue(dict, "SearchImages.SkipImage")
        self.State_WaitingForNetwork = getValue(dict, "State.WaitingForNetwork")
        self.TwoStepAuth_EmailHelp = getValue(dict, "TwoStepAuth.EmailHelp")
        self.PhotoEditor_SharpenTool = getValue(dict, "PhotoEditor.SharpenTool")
        self.Common_of = getValue(dict, "Common.of")
        self.AuthSessions_Title = getValue(dict, "AuthSessions.Title")
        self.PrivacyLastSeenSettings_AlwaysShareWith = getValue(dict, "PrivacyLastSeenSettings.AlwaysShareWith")
        self.EnterPasscode_EnterPasscode = getValue(dict, "EnterPasscode.EnterPasscode")
        self.Notifications_Reset = getValue(dict, "Notifications.Reset")
        self.GroupInfo_InvitationLinkGroupFull = getValue(dict, "GroupInfo.InvitationLinkGroupFull")
        self._Channel_AdminLog_MessageChangedChannelUsername = getValue(dict, "Channel.AdminLog.MessageChangedChannelUsername")
        self._Channel_AdminLog_MessageChangedChannelUsername_r = extractArgumentRanges(self._Channel_AdminLog_MessageChangedChannelUsername)
        self.GoogleDrive_LogoutLogout = getValue(dict, "GoogleDrive.LogoutLogout")
        self._CHAT_MESSAGE_DOC = getValue(dict, "CHAT_MESSAGE_DOC")
        self._CHAT_MESSAGE_DOC_r = extractArgumentRanges(self._CHAT_MESSAGE_DOC)
        self.Watch_AppName = getValue(dict, "Watch.AppName")
        self._Channel_NotificationSelfAdded = getValue(dict, "Channel.NotificationSelfAdded")
        self._Channel_NotificationSelfAdded_r = extractArgumentRanges(self._Channel_NotificationSelfAdded)
        self.ConvertToSupergroup_HelpTitle = getValue(dict, "ConvertToSupergroup.HelpTitle")
        self.Conversation_TapAndHoldToRecord = getValue(dict, "Conversation.TapAndHoldToRecord")
        self.Channel_ShareNoLink = getValue(dict, "Channel.ShareNoLink")
        self._MESSAGE_GIF = getValue(dict, "MESSAGE_GIF")
        self._MESSAGE_GIF_r = extractArgumentRanges(self._MESSAGE_GIF)
        self._DialogList_EncryptedChatStartedOutgoing = getValue(dict, "DialogList.EncryptedChatStartedOutgoing")
        self._DialogList_EncryptedChatStartedOutgoing_r = extractArgumentRanges(self._DialogList_EncryptedChatStartedOutgoing)
        self.Checkout_PayWithTouchId = getValue(dict, "Checkout.PayWithTouchId")
        self._Notification_InvitedMany = getValue(dict, "Notification.InvitedMany")
        self._Notification_InvitedMany_r = extractArgumentRanges(self._Notification_InvitedMany)
        self._CHAT_ADD_YOU = getValue(dict, "CHAT_ADD_YOU")
        self._CHAT_ADD_YOU_r = extractArgumentRanges(self._CHAT_ADD_YOU)
        self.CheckoutInfo_ShippingInfoCity = getValue(dict, "CheckoutInfo.ShippingInfoCity")
        self.Conversation_DiscardVoiceMessageTitle = getValue(dict, "Conversation.DiscardVoiceMessageTitle")
        self.Conversation_ClousStorageInfo_Description3 = getValue(dict, "Conversation.ClousStorageInfo.Description3")
        self.Profile_MessageLifetime = getValue(dict, "Profile.MessageLifetime")
        self.GoogleDrive_LogoutTitle = getValue(dict, "GoogleDrive.LogoutTitle")
        self.Conversation_PinMessageAlertGroup = getValue(dict, "Conversation.PinMessageAlertGroup")
        self.Settings_FAQ_Intro = getValue(dict, "Settings.FAQ_Intro")
        self.PrivacySettings_AuthSessions = getValue(dict, "PrivacySettings.AuthSessions")
        self.Tour_Title5 = getValue(dict, "Tour.Title5")
        self.ChatAdmins_AllMembersAreAdmins = getValue(dict, "ChatAdmins.AllMembersAreAdmins")
        self.Group_Management_AddModeratorHelp = getValue(dict, "Group.Management.AddModeratorHelp")
        self.Channel_Username_CheckingUsername = getValue(dict, "Channel.Username.CheckingUsername")
        self.Activity_UploadingAudio = getValue(dict, "Activity.UploadingAudio")
        self._DialogList_SingleRecordingVideoMessageSuffix = getValue(dict, "DialogList.SingleRecordingVideoMessageSuffix")
        self._DialogList_SingleRecordingVideoMessageSuffix_r = extractArgumentRanges(self._DialogList_SingleRecordingVideoMessageSuffix)
        self._Contacts_AccessDeniedHelpPortrait = getValue(dict, "Contacts.AccessDeniedHelpPortrait")
        self._Contacts_AccessDeniedHelpPortrait_r = extractArgumentRanges(self._Contacts_AccessDeniedHelpPortrait)
        self.Channel_Info_BlackList = getValue(dict, "Channel.Info.BlackList")
        self._Checkout_LiabilityAlert = getValue(dict, "Checkout.LiabilityAlert")
        self._Checkout_LiabilityAlert_r = extractArgumentRanges(self._Checkout_LiabilityAlert)
        self.Profile_BotInfo = getValue(dict, "Profile.BotInfo")
        self.StickerPack_RemoveStickers = getValue(dict, "StickerPack.RemoveStickers")
        self.Compose_NewChannel_Members = getValue(dict, "Compose.NewChannel.Members")
        self.Notification_Reply = getValue(dict, "Notification.Reply")
        self.Watch_Stickers_Recents = getValue(dict, "Watch.Stickers.Recents")
        self.GroupInfo_SetGroupPhotoStop = getValue(dict, "GroupInfo.SetGroupPhotoStop")
        self.Conversation_PinMessageAlertChannel = getValue(dict, "Conversation.PinMessageAlertChannel")
        self.AttachmentMenu_File = getValue(dict, "AttachmentMenu.File")
        self._MESSAGE_STICKER = getValue(dict, "MESSAGE_STICKER")
        self._MESSAGE_STICKER_r = extractArgumentRanges(self._MESSAGE_STICKER)
        self.Profile_MessageLifetime5s = getValue(dict, "Profile.MessageLifetime5s")
        self._PINNED_PHOTO = getValue(dict, "PINNED_PHOTO")
        self._PINNED_PHOTO_r = extractArgumentRanges(self._PINNED_PHOTO)
        self.Channel_EditAdmin_PermissionChangeInviteLink = getValue(dict, "Channel.EditAdmin.PermissionChangeInviteLink")
        self.Channel_AdminLog_CanAddAdmins = getValue(dict, "Channel.AdminLog.CanAddAdmins")
        self.WelcomeScreen_Title = getValue(dict, "WelcomeScreen.Title")
        self.TwoStepAuth_SetupHint = getValue(dict, "TwoStepAuth.SetupHint")
        self.Conversation_StatusLeftGroup = getValue(dict, "Conversation.StatusLeftGroup")
        self.Conversation_ShareBotLocationConfirmation = getValue(dict, "Conversation.ShareBotLocationConfirmation")
        self.Conversation_DeleteMessagesForMe = getValue(dict, "Conversation.DeleteMessagesForMe")
        self.Message_PinnedAnimationMessage = getValue(dict, "Message.PinnedAnimationMessage")
        self.Checkout_ErrorPrecheckoutFailed = getValue(dict, "Checkout.ErrorPrecheckoutFailed")
        self.Camera_PhotoMode = getValue(dict, "Camera.PhotoMode")
        self.Channel_About_Placeholder = getValue(dict, "Channel.About.Placeholder")
        self.Channel_About_Title = getValue(dict, "Channel.About.Title")
        self._MESSAGE_PHOTO = getValue(dict, "MESSAGE_PHOTO")
        self._MESSAGE_PHOTO_r = extractArgumentRanges(self._MESSAGE_PHOTO)
        self.Calls_RatingTitle = getValue(dict, "Calls.RatingTitle")
        self.SharedMedia_EmptyText = getValue(dict, "SharedMedia.EmptyText")
        self.Channel_Username_CreateCommentsHelp = getValue(dict, "Channel.Username.CreateCommentsHelp")
        self.Login_PadPhoneHelp = getValue(dict, "Login.PadPhoneHelp")
        self.StickerPacksSettings_ArchivedPacks = getValue(dict, "StickerPacksSettings.ArchivedPacks")
        self.Channel_ErrorAccessDenied = getValue(dict, "Channel.ErrorAccessDenied")
        self.Generic_ErrorMoreInfo = getValue(dict, "Generic.ErrorMoreInfo")
        self.Notification_GroupDeactivated = getValue(dict, "Notification.GroupDeactivated")
        self.Channel_AdminLog_TitleAllEvents = getValue(dict, "Channel.AdminLog.TitleAllEvents")
        self.PrivacySettings_TouchIdTitle = getValue(dict, "PrivacySettings.TouchIdTitle")
        self.ChannelMembers_WhoCanAddMembersAllHelp = getValue(dict, "ChannelMembers.WhoCanAddMembersAllHelp")
        self.ChangePhoneNumberCode_CodePlaceholder = getValue(dict, "ChangePhoneNumberCode.CodePlaceholder")
        self.Camera_SquareMode = getValue(dict, "Camera.SquareMode")
        self._Conversation_EncryptedPlaceholderTitleOutgoing = getValue(dict, "Conversation.EncryptedPlaceholderTitleOutgoing")
        self._Conversation_EncryptedPlaceholderTitleOutgoing_r = extractArgumentRanges(self._Conversation_EncryptedPlaceholderTitleOutgoing)
        self.NetworkUsageSettings_CallDataSection = getValue(dict, "NetworkUsageSettings.CallDataSection")
        self.Login_PadPhoneHelpTitle = getValue(dict, "Login.PadPhoneHelpTitle")
        self.Profile_CreateNewContact = getValue(dict, "Profile.CreateNewContact")
        self.AccessDenied_VideoMessageMicrophone = getValue(dict, "AccessDenied.VideoMessageMicrophone")
        self.PhotoEditor_VignetteTool = getValue(dict, "PhotoEditor.VignetteTool")
        self.LastSeen_WithinAWeek = getValue(dict, "LastSeen.WithinAWeek")
        self.Widget_NoUsers = getValue(dict, "Widget.NoUsers")
        self.Channel_Edit_EnableComments = getValue(dict, "Channel.Edit.EnableComments")
        self.DialogList_NoMessagesText = getValue(dict, "DialogList.NoMessagesText")
        self._CHANNEL_MESSAGE_AUDIO = getValue(dict, "CHANNEL_MESSAGE_AUDIO")
        self._CHANNEL_MESSAGE_AUDIO_r = extractArgumentRanges(self._CHANNEL_MESSAGE_AUDIO)
        self.Calls_NewCall = getValue(dict, "Calls.NewCall")
        self.SharedMedia_TitleFile = getValue(dict, "SharedMedia.TitleFile")
        self.MaskStickerSettings_Info = getValue(dict, "MaskStickerSettings.Info")
        self.Conversation_FilePhotoOrVideo = getValue(dict, "Conversation.FilePhotoOrVideo")
        self._Watch_LastSeen_AtWeekday = getValue(dict, "Watch.LastSeen.AtWeekday")
        self._Watch_LastSeen_AtWeekday_r = extractArgumentRanges(self._Watch_LastSeen_AtWeekday)
        self.Channel_AdminLog_BanSendStickers = getValue(dict, "Channel.AdminLog.BanSendStickers")
        self.Common_Next = getValue(dict, "Common.Next")
        self.Watch_Notification_Joined = getValue(dict, "Watch.Notification.Joined")
        self.ImagePicker_NoVideos = getValue(dict, "ImagePicker.NoVideos")
        self.GroupInfo_DeleteAndExitConfirmation = getValue(dict, "GroupInfo.DeleteAndExitConfirmation")
        self.ChatSettings_Cache = getValue(dict, "ChatSettings.Cache")
        self.TwoStepAuth_EmailInvalid = getValue(dict, "TwoStepAuth.EmailInvalid")
        self._CHAT_MESSAGE_VIDEO = getValue(dict, "CHAT_MESSAGE_VIDEO")
        self._CHAT_MESSAGE_VIDEO_r = extractArgumentRanges(self._CHAT_MESSAGE_VIDEO)
        self.Month_GenJune = getValue(dict, "Month.GenJune")
        self._Login_EmailCodeSubject = getValue(dict, "Login.EmailCodeSubject")
        self._Login_EmailCodeSubject_r = extractArgumentRanges(self._Login_EmailCodeSubject)
        self._CHAT_TITLE_EDITED = getValue(dict, "CHAT_TITLE_EDITED")
        self._CHAT_TITLE_EDITED_r = extractArgumentRanges(self._CHAT_TITLE_EDITED)
        self.Watch_UnlockRequired = getValue(dict, "Watch.UnlockRequired")
        self._NetworkUsageSettings_WifiUsageSince = getValue(dict, "NetworkUsageSettings.WifiUsageSince")
        self._NetworkUsageSettings_WifiUsageSince_r = extractArgumentRanges(self._NetworkUsageSettings_WifiUsageSince)
        self.Watch_LastSeen_Lately = getValue(dict, "Watch.LastSeen.Lately")
        self.Watch_Compose_CurrentLocation = getValue(dict, "Watch.Compose.CurrentLocation")
        self._CHANNEL_MESSAGE_FWDS = getValue(dict, "CHANNEL_MESSAGE_FWDS")
        self._CHANNEL_MESSAGE_FWDS_r = extractArgumentRanges(self._CHANNEL_MESSAGE_FWDS)
        self.DialogList_RecentTitlePeople = getValue(dict, "DialogList.RecentTitlePeople")
        self.Conversation_ViewLocation = getValue(dict, "Conversation.ViewLocation")
        self.GroupInfo_Notifications = getValue(dict, "GroupInfo.Notifications")
        self._MESSAGE_DOC = getValue(dict, "MESSAGE_DOC")
        self._MESSAGE_DOC_r = extractArgumentRanges(self._MESSAGE_DOC)
        self.Group_Username_CreatePrivateLinkHelp = getValue(dict, "Group.Username.CreatePrivateLinkHelp")
        self.Notifications_GroupNotificationsSound = getValue(dict, "Notifications.GroupNotificationsSound")
        self.AuthSessions_EmptyTitle = getValue(dict, "AuthSessions.EmptyTitle")
        self.Privacy_GroupsAndChannels_AlwaysAllow_Title = getValue(dict, "Privacy.GroupsAndChannels.AlwaysAllow.Title")
        self._MediaPicker_Nof = getValue(dict, "MediaPicker.Nof")
        self._MediaPicker_Nof_r = extractArgumentRanges(self._MediaPicker_Nof)
        self.Common_Create = getValue(dict, "Common.Create")
        self.Message_InvoiceShipmentLabel = getValue(dict, "Message.InvoiceShipmentLabel")
        self.Contacts_TopSection = getValue(dict, "Contacts.TopSection")
        self.Your_cards_number_is_invalid = getValue(dict, "Your_cards_number_is_invalid")
        self._MESSAGE_INVOICE = getValue(dict, "MESSAGE_INVOICE")
        self._MESSAGE_INVOICE_r = extractArgumentRanges(self._MESSAGE_INVOICE)
        self._Channel_AdminLog_MessageRemovedChannelUsername = getValue(dict, "Channel.AdminLog.MessageRemovedChannelUsername")
        self._Channel_AdminLog_MessageRemovedChannelUsername_r = extractArgumentRanges(self._Channel_AdminLog_MessageRemovedChannelUsername)
        self.Group_MessagePhotoRemoved = getValue(dict, "Group.MessagePhotoRemoved")
        self.UserInfo_AddToExisting = getValue(dict, "UserInfo.AddToExisting")
        self._LastSeen_AtDate = getValue(dict, "LastSeen.AtDate")
        self._LastSeen_AtDate_r = extractArgumentRanges(self._LastSeen_AtDate)
        self.Conversation_MessageDialogRetry = getValue(dict, "Conversation.MessageDialogRetry")
        self.Watch_ChatList_NoConversationsTitle = getValue(dict, "Watch.ChatList.NoConversationsTitle")
        self.BlockedUsers_Title = getValue(dict, "BlockedUsers.Title")
        self.MediaPicker_MomentsDateRangeYearFormat = getValue(dict, "MediaPicker.MomentsDateRangeYearFormat")
        self.Cache_ClearNone = getValue(dict, "Cache.ClearNone")
        self.Login_InvalidCodeError = getValue(dict, "Login.InvalidCodeError")
        self.Contacts_contacts = getValue(dict, "Contacts.contacts")
        self.Channel_BanList_BlockedTitle = getValue(dict, "Channel.BanList.BlockedTitle")
        self.NetworkUsageSettings_Cellular = getValue(dict, "NetworkUsageSettings.Cellular")
        self.Watch_Location_Access = getValue(dict, "Watch.Location.Access")
        self._CONTACT_ACTIVATED = getValue(dict, "CONTACT_ACTIVATED")
        self._CONTACT_ACTIVATED_r = extractArgumentRanges(self._CONTACT_ACTIVATED)
        self.BlockedUsers_AlreadyBlocked = getValue(dict, "BlockedUsers.AlreadyBlocked")
        self.PrivacySettings_DeleteAccountIfAwayFor = getValue(dict, "PrivacySettings.DeleteAccountIfAwayFor")
        self.PrivacySettings_DeleteAccountTitle = getValue(dict, "PrivacySettings.DeleteAccountTitle")
        self.PrivacyLastSeenSettings_CustomShareSettings_Delete = getValue(dict, "PrivacyLastSeenSettings.CustomShareSettings.Delete")
        self._ENCRYPTED_MESSAGE = getValue(dict, "ENCRYPTED_MESSAGE")
        self._ENCRYPTED_MESSAGE_r = extractArgumentRanges(self._ENCRYPTED_MESSAGE)
        self.Watch_LastSeen_WithinAMonth = getValue(dict, "Watch.LastSeen.WithinAMonth")
        self.PrivacyLastSeenSettings_CustomHelp = getValue(dict, "PrivacyLastSeenSettings.CustomHelp")
        self.TwoStepAuth_EnterPasswordHelp = getValue(dict, "TwoStepAuth.EnterPasswordHelp")
        self.Bot_Stop = getValue(dict, "Bot.Stop")
        self.Privacy_GroupsAndChannels_AlwaysAllow_Placeholder = getValue(dict, "Privacy.GroupsAndChannels.AlwaysAllow.Placeholder")
        self._AUTH_UNKNOWN = getValue(dict, "AUTH_UNKNOWN")
        self._AUTH_UNKNOWN_r = extractArgumentRanges(self._AUTH_UNKNOWN)
        self.UserInfo_BotSettings = getValue(dict, "UserInfo.BotSettings")
        self.Your_cards_expiration_month_is_invalid = getValue(dict, "Your_cards_expiration_month_is_invalid")
        self.PrivacyLastSeenSettings_EmpryUsersPlaceholder = getValue(dict, "PrivacyLastSeenSettings.EmpryUsersPlaceholder")
        self._CHANNEL_MESSAGE_ROUND = getValue(dict, "CHANNEL_MESSAGE_ROUND")
        self._CHANNEL_MESSAGE_ROUND_r = extractArgumentRanges(self._CHANNEL_MESSAGE_ROUND)
        self.GoogleDrive_FolderLoadError = getValue(dict, "GoogleDrive.FolderLoadError")
        self.Message_VideoMessage = getValue(dict, "Message.VideoMessage")
        self.Conversation_ContextMenuStickerPackInfo = getValue(dict, "Conversation.ContextMenuStickerPackInfo")
        self.Login_ResetAccountProtected_LimitExceeded = getValue(dict, "Login.ResetAccountProtected.LimitExceeded")
        self.Watch_Suggestion_TextInABit = getValue(dict, "Watch.Suggestion.TextInABit")
        self._CHAT_DELETE_MEMBER = getValue(dict, "CHAT_DELETE_MEMBER")
        self._CHAT_DELETE_MEMBER_r = extractArgumentRanges(self._CHAT_DELETE_MEMBER)
        self.Conversation_EncryptedForwardingAlert = getValue(dict, "Conversation.EncryptedForwardingAlert")
        self.Conversation_DiscardVoiceMessageAction = getValue(dict, "Conversation.DiscardVoiceMessageAction")
        self.PhotoEditor_CurvesBlue = getValue(dict, "PhotoEditor.CurvesBlue")
        self.Message_PinnedVideoMessage = getValue(dict, "Message.PinnedVideoMessage")
        self._Settings_OpenSystemPrivacySettings = getValue(dict, "Settings.OpenSystemPrivacySettings")
        self._Settings_OpenSystemPrivacySettings_r = extractArgumentRanges(self._Settings_OpenSystemPrivacySettings)
        self._Login_EmailPhoneSubject = getValue(dict, "Login.EmailPhoneSubject")
        self._Login_EmailPhoneSubject_r = extractArgumentRanges(self._Login_EmailPhoneSubject)
        self.Group_EditAdmin_PermissionChangeInfo = getValue(dict, "Group.EditAdmin.PermissionChangeInfo")
        self.TwoStepAuth_Email = getValue(dict, "TwoStepAuth.Email")
        self.Map_SendMyCurrentLocation = getValue(dict, "Map.SendMyCurrentLocation")
        self._MESSAGE_ROUND = getValue(dict, "MESSAGE_ROUND")
        self._MESSAGE_ROUND_r = extractArgumentRanges(self._MESSAGE_ROUND)
        self.Map_Unknown = getValue(dict, "Map.Unknown")
        self.Wallpaper_Set = getValue(dict, "Wallpaper.Set")
        self.SharedMedia_CategoryLinks = getValue(dict, "SharedMedia.CategoryLinks")
        self.AccessDenied_Title = getValue(dict, "AccessDenied.Title")
        self.Conversation_ClearAllConfirmation = getValue(dict, "Conversation.ClearAllConfirmation")
        self.TwoStepAuth_EmailSkipAlert = getValue(dict, "TwoStepAuth.EmailSkipAlert")
        self.ChatSettings_Stickers = getValue(dict, "ChatSettings.Stickers")
        self.Camera_FlashOff = getValue(dict, "Camera.FlashOff")
        self.TwoStepAuth_Title = getValue(dict, "TwoStepAuth.Title")
        self.TwoStepAuth_SetupPasswordEnterPasswordChange = getValue(dict, "TwoStepAuth.SetupPasswordEnterPasswordChange")
        self.WebSearch_Images = getValue(dict, "WebSearch.Images")
        self.Checkout_ErrorProviderAccountTimeout = getValue(dict, "Checkout.ErrorProviderAccountTimeout")
        self.Conversation_typing = getValue(dict, "Conversation.typing")
        self.Common_Back = getValue(dict, "Common.Back")
        self.Common_Search = getValue(dict, "Common.Search")
        self._CancelResetAccount_Success = getValue(dict, "CancelResetAccount.Success")
        self._CancelResetAccount_Success_r = extractArgumentRanges(self._CancelResetAccount_Success)
        self.Common_No = getValue(dict, "Common.No")
        self.Login_EmailNotConfiguredError = getValue(dict, "Login.EmailNotConfiguredError")
        self.Watch_Suggestion_OK = getValue(dict, "Watch.Suggestion.OK")
        self.Profile_AddToExisting = getValue(dict, "Profile.AddToExisting")
        self._PINNED_NOTEXT = getValue(dict, "PINNED_NOTEXT")
        self._PINNED_NOTEXT_r = extractArgumentRanges(self._PINNED_NOTEXT)
        self._Login_EmailCodeBody = getValue(dict, "Login.EmailCodeBody")
        self._Login_EmailCodeBody_r = extractArgumentRanges(self._Login_EmailCodeBody)
        self.Profile_About = getValue(dict, "Profile.About")
        self._EncryptionKey_Description = getValue(dict, "EncryptionKey.Description")
        self._EncryptionKey_Description_r = extractArgumentRanges(self._EncryptionKey_Description)
        self.Conversation_UnreadMessages = getValue(dict, "Conversation.UnreadMessages")
        self.Tour_Title3 = getValue(dict, "Tour.Title3")
        self.PrivacyLastSeenSettings_GroupsAndChannelsHelp = getValue(dict, "PrivacyLastSeenSettings.GroupsAndChannelsHelp")
        self.Watch_Contacts_NoResults = getValue(dict, "Watch.Contacts.NoResults")
        self.Watch_UserInfo_MuteTitle = getValue(dict, "Watch.UserInfo.MuteTitle")
        self.MediaPicker_Choose = getValue(dict, "MediaPicker.Choose")
        self.Conversation_DownloadMegabytes = getValue(dict, "Conversation.DownloadMegabytes")
        self._Privacy_GroupsAndChannels_InviteToGroupError = getValue(dict, "Privacy.GroupsAndChannels.InviteToGroupError")
        self._Privacy_GroupsAndChannels_InviteToGroupError_r = extractArgumentRanges(self._Privacy_GroupsAndChannels_InviteToGroupError)
        self._Message_PinnedTextMessage = getValue(dict, "Message.PinnedTextMessage")
        self._Message_PinnedTextMessage_r = extractArgumentRanges(self._Message_PinnedTextMessage)
        self._Watch_Time_ShortWeekdayAt = getValue(dict, "Watch.Time.ShortWeekdayAt")
        self._Watch_Time_ShortWeekdayAt_r = extractArgumentRanges(self._Watch_Time_ShortWeekdayAt)
        self.DialogList_Typing = getValue(dict, "DialogList.Typing")
        self.Notification_CallBack = getValue(dict, "Notification.CallBack")
        self.Map_LocatingError = getValue(dict, "Map.LocatingError")
        self.MediaPicker_Send = getValue(dict, "MediaPicker.Send")
        self.ChannelIntro_Title = getValue(dict, "ChannelIntro.Title")
        self.SearchImages_ErrorDownloadingImage = getValue(dict, "SearchImages.ErrorDownloadingImage")
        self._PINNED_GIF = getValue(dict, "PINNED_GIF")
        self._PINNED_GIF_r = extractArgumentRanges(self._PINNED_GIF)
        self.Profile_PhonebookAccessDisabled = getValue(dict, "Profile.PhonebookAccessDisabled")
        self.LoginPassword_PasswordHelp = getValue(dict, "LoginPassword.PasswordHelp")
        self.BlockedUsers_Unblock = getValue(dict, "BlockedUsers.Unblock")
        self.Conversation_ViewFile = getValue(dict, "Conversation.ViewFile")
        self.Notifications_GroupNotificationsAlert = getValue(dict, "Notifications.GroupNotificationsAlert")
        self.Paint_Masks = getValue(dict, "Paint.Masks")
        self.StickerPack_ErrorNotFound = getValue(dict, "StickerPack.ErrorNotFound")
        self._PINNED_CONTACT = getValue(dict, "PINNED_CONTACT")
        self._PINNED_CONTACT_r = extractArgumentRanges(self._PINNED_CONTACT)
        self._Conversation_ForwardToGroupFormat = getValue(dict, "Conversation.ForwardToGroupFormat")
        self._Conversation_ForwardToGroupFormat_r = extractArgumentRanges(self._Conversation_ForwardToGroupFormat)
        self._FileSize_KB = getValue(dict, "FileSize.KB")
        self._FileSize_KB_r = extractArgumentRanges(self._FileSize_KB)
        self.Watch_GroupInfo_Title = getValue(dict, "Watch.GroupInfo.Title")
        self.PhotoEditor_Set = getValue(dict, "PhotoEditor.Set")
        self._Notification_Invited = getValue(dict, "Notification.Invited")
        self._Notification_Invited_r = extractArgumentRanges(self._Notification_Invited)
        self.Watch_AuthRequired = getValue(dict, "Watch.AuthRequired")
        self.Conversation_EncryptedDescription1 = getValue(dict, "Conversation.EncryptedDescription1")
        self.AppleWatch_ReplyPresets = getValue(dict, "AppleWatch.ReplyPresets")
        self.Conversation_EncryptedDescription2 = getValue(dict, "Conversation.EncryptedDescription2")
        self.NetworkUsageSettings_MediaVideoDataSection = getValue(dict, "NetworkUsageSettings.MediaVideoDataSection")
        self.Paint_Edit = getValue(dict, "Paint.Edit")
        self.Conversation_EncryptedDescription3 = getValue(dict, "Conversation.EncryptedDescription3")
        self.Login_CodeFloodError = getValue(dict, "Login.CodeFloodError")
        self._Call_EncryptionKey_Description = getValue(dict, "Call.EncryptionKey.Description")
        self._Call_EncryptionKey_Description_r = extractArgumentRanges(self._Call_EncryptionKey_Description)
        self.Conversation_EncryptedDescription4 = getValue(dict, "Conversation.EncryptedDescription4")
        self.AppleWatch_Title = getValue(dict, "AppleWatch.Title")
        self.Conversation_StatusTyping = getValue(dict, "Conversation.StatusTyping")
        self.Contacts_AccessDeniedError = getValue(dict, "Contacts.AccessDeniedError")
        self.GoogleDrive_LoadErrorTitle = getValue(dict, "GoogleDrive.LoadErrorTitle")
        self.Share_Title = getValue(dict, "Share.Title")
        self.Map_Send = getValue(dict, "Map.Send")
        self.TwoStepAuth_ConfirmationTitle = getValue(dict, "TwoStepAuth.ConfirmationTitle")
        self.Conversation_SupportPlaceholder = getValue(dict, "Conversation.SupportPlaceholder")
        self.ChatSettings_Title = getValue(dict, "ChatSettings.Title")
        self.AuthSessions_CurrentSession = getValue(dict, "AuthSessions.CurrentSession")
        self.Watch_Microphone_Access = getValue(dict, "Watch.Microphone.Access")
        self._Notification_RenamedChat = getValue(dict, "Notification.RenamedChat")
        self._Notification_RenamedChat_r = extractArgumentRanges(self._Notification_RenamedChat)
        self.Watch_Conversation_GroupInfo = getValue(dict, "Watch.Conversation.GroupInfo")
        self.UserInfo_Title = getValue(dict, "UserInfo.Title")
        self.Service_LocalizationDownloadError = getValue(dict, "Service.LocalizationDownloadError")
        self.Login_InfoHelp = getValue(dict, "Login.InfoHelp")
        self.ShareMenu_ShareTo = getValue(dict, "ShareMenu.ShareTo")
        self.Message_PinnedGame = getValue(dict, "Message.PinnedGame")
        self.Channel_AdminLog_CanSendMessages = getValue(dict, "Channel.AdminLog.CanSendMessages")
        self.Notification_RenamedGroup = getValue(dict, "Notification.RenamedGroup")
        self.Weekday_Thursday = getValue(dict, "Weekday.Thursday")
        self._Call_PrivacyErrorMessage = getValue(dict, "Call.PrivacyErrorMessage")
        self._Call_PrivacyErrorMessage_r = extractArgumentRanges(self._Call_PrivacyErrorMessage)
        self.ChangePhoneNumberNumber_Title = getValue(dict, "ChangePhoneNumberNumber.Title")
        self.TwoStepAuth_EnterPasswordInvalid = getValue(dict, "TwoStepAuth.EnterPasswordInvalid")
        self.DialogList_SearchSectionMessages = getValue(dict, "DialogList.SearchSectionMessages")
        self._Profile_ShareBotGroupFormat = getValue(dict, "Profile.ShareBotGroupFormat")
        self._Profile_ShareBotGroupFormat_r = extractArgumentRanges(self._Profile_ShareBotGroupFormat)
        self.Preview_DeleteGif = getValue(dict, "Preview.DeleteGif")
        self.Weekday_Saturday = getValue(dict, "Weekday.Saturday")
        self.UserInfo_DeleteContact = getValue(dict, "UserInfo.DeleteContact")
        self.Notifications_ResetAllNotifications = getValue(dict, "Notifications.ResetAllNotifications")
        self.Notification_MessageLifetimeRemovedOutgoing = getValue(dict, "Notification.MessageLifetimeRemovedOutgoing")
        self.Map_More = getValue(dict, "Map.More")
        self.Login_ContinueWithLocalization = getValue(dict, "Login.ContinueWithLocalization")
        self.GroupInfo_AddParticipant = getValue(dict, "GroupInfo.AddParticipant")
        self.Watch_Location_Current = getValue(dict, "Watch.Location.Current")
        self.Map_MapTitle = getValue(dict, "Map.MapTitle")
        self.Checkout_NewCard_SaveInfoHelp = getValue(dict, "Checkout.NewCard.SaveInfoHelp")
        self.MediaPicker_CameraRoll = getValue(dict, "MediaPicker.CameraRoll")
        self._TwoStepAuth_RecoverySent = getValue(dict, "TwoStepAuth.RecoverySent")
        self._TwoStepAuth_RecoverySent_r = extractArgumentRanges(self._TwoStepAuth_RecoverySent)
        self.Channel_AdminLog_CanPinMessages = getValue(dict, "Channel.AdminLog.CanPinMessages")
        self.KeyCommand_NewMessage = getValue(dict, "KeyCommand.NewMessage")
        self.Compose_NewBroadcastButton = getValue(dict, "Compose.NewBroadcastButton")
        self.NetworkUsageSettings_TotalSection = getValue(dict, "NetworkUsageSettings.TotalSection")
        self._PINNED_AUDIO = getValue(dict, "PINNED_AUDIO")
        self._PINNED_AUDIO_r = extractArgumentRanges(self._PINNED_AUDIO)
        self.Privacy_GroupsAndChannels = getValue(dict, "Privacy.GroupsAndChannels")
        self.Conversation_DiscardVoiceMessageDescription = getValue(dict, "Conversation.DiscardVoiceMessageDescription")
        self._Notification_ChangedGroupPhoto = getValue(dict, "Notification.ChangedGroupPhoto")
        self._Notification_ChangedGroupPhoto_r = extractArgumentRanges(self._Notification_ChangedGroupPhoto)
        self.TwoStepAuth_RemovePassword = getValue(dict, "TwoStepAuth.RemovePassword")
        self.Privacy_GroupsAndChannels_CustomHelp = getValue(dict, "Privacy.GroupsAndChannels.CustomHelp")
        self.Notification_GroupMigratedToChannel = getValue(dict, "Notification.GroupMigratedToChannel")
        self.UserInfo_NotificationsDisable = getValue(dict, "UserInfo.NotificationsDisable")
        self.Watch_UserInfo_Service = getValue(dict, "Watch.UserInfo.Service")
        self.Privacy_Calls_CustomHelp = getValue(dict, "Privacy.Calls.CustomHelp")
        self.ChangePhoneNumberCode_Code = getValue(dict, "ChangePhoneNumberCode.Code")
        self.UserInfo_Invite = getValue(dict, "UserInfo.Invite")
        self.CheckoutInfo_ErrorStateInvalid = getValue(dict, "CheckoutInfo.ErrorStateInvalid")
        self.DialogList_ClearHistoryConfirmation = getValue(dict, "DialogList.ClearHistoryConfirmation")
        self.CheckoutInfo_ErrorEmailInvalid = getValue(dict, "CheckoutInfo.ErrorEmailInvalid")
        self.Month_GenNovember = getValue(dict, "Month.GenNovember")
        self.PhotoEditor_TintIntensity = getValue(dict, "PhotoEditor.TintIntensity")
        self.UserInfo_NotificationsEnable = getValue(dict, "UserInfo.NotificationsEnable")
        self._Target_InviteToGroupConfirmation = getValue(dict, "Target.InviteToGroupConfirmation")
        self._Target_InviteToGroupConfirmation_r = extractArgumentRanges(self._Target_InviteToGroupConfirmation)
        self.Map_Map = getValue(dict, "Map.Map")
        self.Map_OpenInMaps = getValue(dict, "Map.OpenInMaps")
        self.Common_OK = getValue(dict, "Common.OK")
        self.TwoStepAuth_SetupHintTitle = getValue(dict, "TwoStepAuth.SetupHintTitle")
        self.Watch_Suggestion_Nope = getValue(dict, "Watch.Suggestion.Nope")
        self.GroupInfo_LeftStatus = getValue(dict, "GroupInfo.LeftStatus")
        self.Cache_ClearProgress = getValue(dict, "Cache.ClearProgress")
        self.Login_InvalidPhoneError = getValue(dict, "Login.InvalidPhoneError")
        self.Cache_ClearEmpty = getValue(dict, "Cache.ClearEmpty")
        self.Map_Search = getValue(dict, "Map.Search")
        self.ChannelMembers_GroupAdminsTitle = getValue(dict, "ChannelMembers.GroupAdminsTitle")
        self._Channel_AdminLog_MessageRemovedGroupUsername = getValue(dict, "Channel.AdminLog.MessageRemovedGroupUsername")
        self._Channel_AdminLog_MessageRemovedGroupUsername_r = extractArgumentRanges(self._Channel_AdminLog_MessageRemovedGroupUsername)
        self.ChatSettings_AutomaticPhotoDownload = getValue(dict, "ChatSettings.AutomaticPhotoDownload")
        self.Update_Update = getValue(dict, "Update.Update")
        self.Group_ErrorAddTooMuchAdmins = getValue(dict, "Group.ErrorAddTooMuchAdmins")
        self.Login_SelectCountry_Title = getValue(dict, "Login.SelectCountry.Title")
        self.Notification_EncryptedChatAccepted = getValue(dict, "Notification.EncryptedChatAccepted")
        self.Notifications_GroupNotificationsHelp = getValue(dict, "Notifications.GroupNotificationsHelp")
        self.PhotoEditor_CropAspectRatioSquare = getValue(dict, "PhotoEditor.CropAspectRatioSquare")
        self.Notification_CallOutgoing = getValue(dict, "Notification.CallOutgoing")
        self.Weekday_ShortMonday = getValue(dict, "Weekday.ShortMonday")
        self.Channel_Edit_AboutItem = getValue(dict, "Channel.Edit.AboutItem")
        self.Checkout_Receipt_Title = getValue(dict, "Checkout.Receipt.Title")
        self.Login_InfoLastNamePlaceholder = getValue(dict, "Login.InfoLastNamePlaceholder")
        self.Contacts_InvitationText = getValue(dict, "Contacts.InvitationText")
        self.Channel_Members_AddMembersHelp = getValue(dict, "Channel.Members.AddMembersHelp")
        self.ReportPeer_Report = getValue(dict, "ReportPeer.Report")
        self.Channel_EditMessageErrorGeneric = getValue(dict, "Channel.EditMessageErrorGeneric")
        self.LoginPassword_FloodError = getValue(dict, "LoginPassword.FloodError")
        self.EncryptionKey_TapToEmojify = getValue(dict, "EncryptionKey.TapToEmojify")
        self.Conversation_InfoChannel = getValue(dict, "Conversation.InfoChannel")
        self.TwoStepAuth_SetupPasswordTitle = getValue(dict, "TwoStepAuth.SetupPasswordTitle")
        self.PhotoEditor_DiscardChanges = getValue(dict, "PhotoEditor.DiscardChanges")
        self.Group_UpgradeNoticeText2 = getValue(dict, "Group.UpgradeNoticeText2")
        self._PINNED_ROUND = getValue(dict, "PINNED_ROUND")
        self._PINNED_ROUND_r = extractArgumentRanges(self._PINNED_ROUND)
        self._ChannelInfo_ChannelForbidden = getValue(dict, "ChannelInfo.ChannelForbidden")
        self._ChannelInfo_ChannelForbidden_r = extractArgumentRanges(self._ChannelInfo_ChannelForbidden)
        self.Conversation_ShareMyContactInfo = getValue(dict, "Conversation.ShareMyContactInfo")
        self._Profile_ShareContactPersonFormat = getValue(dict, "Profile.ShareContactPersonFormat")
        self._Profile_ShareContactPersonFormat_r = extractArgumentRanges(self._Profile_ShareContactPersonFormat)
        self._CHANNEL_MESSAGE_GEO = getValue(dict, "CHANNEL_MESSAGE_GEO")
        self._CHANNEL_MESSAGE_GEO_r = extractArgumentRanges(self._CHANNEL_MESSAGE_GEO)
        self.Group_Info_AdminLog = getValue(dict, "Group.Info.AdminLog")
        self.StickerPacksSettings_FeaturedPacks = getValue(dict, "StickerPacksSettings.FeaturedPacks")
        self.Month_GenAugust = getValue(dict, "Month.GenAugust")
        self.Channel_Username_CreatePublicLinkHelp = getValue(dict, "Channel.Username.CreatePublicLinkHelp")
        self.StickerPack_Send = getValue(dict, "StickerPack.Send")
        self.Watch_Suggestion_HoldOn = getValue(dict, "Watch.Suggestion.HoldOn")
        self.StickerSettings_MaskContextInfo = getValue(dict, "StickerSettings.MaskContextInfo")
        self.AttachmentMenu_ImageSearch = getValue(dict, "AttachmentMenu.ImageSearch")
        self._PINNED_GEO = getValue(dict, "PINNED_GEO")
        self._PINNED_GEO_r = extractArgumentRanges(self._PINNED_GEO)
        self.PasscodeSettings_EncryptData = getValue(dict, "PasscodeSettings.EncryptData")
        self.Notification_CallCanceled = getValue(dict, "Notification.CallCanceled")
        self.Common_NotNow = getValue(dict, "Common.NotNow")
        self.PasscodeSettings_Title = getValue(dict, "PasscodeSettings.Title")
        self.StickerPack_BuiltinPackName = getValue(dict, "StickerPack.BuiltinPackName")
        self.Watch_Suggestion_BRB = getValue(dict, "Watch.Suggestion.BRB")
        self.Login_CodeTitle = getValue(dict, "Login.CodeTitle")
        self._CHAT_MESSAGE_ROUND = getValue(dict, "CHAT_MESSAGE_ROUND")
        self._CHAT_MESSAGE_ROUND_r = extractArgumentRanges(self._CHAT_MESSAGE_ROUND)
        self.Notifications_MessageNotificationsAlert = getValue(dict, "Notifications.MessageNotificationsAlert")
        self.Username_InvalidCharacters = getValue(dict, "Username.InvalidCharacters")
        self.GroupInfo_LabelAdmin = getValue(dict, "GroupInfo.LabelAdmin")
        self.GroupInfo_Sound = getValue(dict, "GroupInfo.Sound")
        self.Channel_EditAdmin_PermissionBanUsers = getValue(dict, "Channel.EditAdmin.PermissionBanUsers")
        self.Wallpaper_PhotoLibrary = getValue(dict, "Wallpaper.PhotoLibrary")
        self.Settings_About = getValue(dict, "Settings.About")
        self._CHAT_LEFT = getValue(dict, "CHAT_LEFT")
        self._CHAT_LEFT_r = extractArgumentRanges(self._CHAT_LEFT)
        self.LoginPassword_ForgotPassword = getValue(dict, "LoginPassword.ForgotPassword")
        self._DialogList_AwaitingEncryption = getValue(dict, "DialogList.AwaitingEncryption")
        self._DialogList_AwaitingEncryption_r = extractArgumentRanges(self._DialogList_AwaitingEncryption)
        self.ChatSettings_Appearance = getValue(dict, "ChatSettings.Appearance")
        self.Tour_Title1 = getValue(dict, "Tour.Title1")
        self._Notification_ChangedUserPhoto = getValue(dict, "Notification.ChangedUserPhoto")
        self._Notification_ChangedUserPhoto_r = extractArgumentRanges(self._Notification_ChangedUserPhoto)
        self.Conversation_LinkDialogCopy = getValue(dict, "Conversation.LinkDialogCopy")
        self._Notification_PinnedLocationMessage = getValue(dict, "Notification.PinnedLocationMessage")
        self._Notification_PinnedLocationMessage_r = extractArgumentRanges(self._Notification_PinnedLocationMessage)
        self._Notification_PinnedPhotoMessage = getValue(dict, "Notification.PinnedPhotoMessage")
        self._Notification_PinnedPhotoMessage_r = extractArgumentRanges(self._Notification_PinnedPhotoMessage)
        self._DownloadingStatus = getValue(dict, "DownloadingStatus")
        self._DownloadingStatus_r = extractArgumentRanges(self._DownloadingStatus)
        self.Calls_All = getValue(dict, "Calls.All")
        self._Channel_MessageTitleUpdated = getValue(dict, "Channel.MessageTitleUpdated")
        self._Channel_MessageTitleUpdated_r = extractArgumentRanges(self._Channel_MessageTitleUpdated)
        self.Call_CallAgain = getValue(dict, "Call.CallAgain")
        self.TwoStepAuth_RecoveryCodeHelp = getValue(dict, "TwoStepAuth.RecoveryCodeHelp")
        self.UserInfo_SendMessage = getValue(dict, "UserInfo.SendMessage")
        self._Channel_Username_LinkHint = getValue(dict, "Channel.Username.LinkHint")
        self._Channel_Username_LinkHint_r = extractArgumentRanges(self._Channel_Username_LinkHint)
        self.Paint_RecentStickers = getValue(dict, "Paint.RecentStickers")
        self.Login_CallRequestState3 = getValue(dict, "Login.CallRequestState3")
        self.Channel_Edit_LinkItem = getValue(dict, "Channel.Edit.LinkItem")
        self.CallSettings_Title = getValue(dict, "CallSettings.Title")
        self.ChangePhoneNumberNumber_Help = getValue(dict, "ChangePhoneNumberNumber.Help")
        self.Watch_Suggestion_Thanks = getValue(dict, "Watch.Suggestion.Thanks")
        self.Channel_Moderator_Title = getValue(dict, "Channel.Moderator.Title")
        self.Message_PinnedPhotoMessage = getValue(dict, "Message.PinnedPhotoMessage")
        self.Notification_SecretChatScreenshot = getValue(dict, "Notification.SecretChatScreenshot")
        self._Conversation_DeleteMessagesFor = getValue(dict, "Conversation.DeleteMessagesFor")
        self._Conversation_DeleteMessagesFor_r = extractArgumentRanges(self._Conversation_DeleteMessagesFor)
        self.Activity_UploadingDocument = getValue(dict, "Activity.UploadingDocument")
        self.Watch_ChatList_NoConversationsText = getValue(dict, "Watch.ChatList.NoConversationsText")
        self.ReportPeer_AlertSuccess = getValue(dict, "ReportPeer.AlertSuccess")
        self.Tour_Text4 = getValue(dict, "Tour.Text4")
        self.Channel_Info_Description = getValue(dict, "Channel.Info.Description")
        self.AccessDenied_LocationTracking = getValue(dict, "AccessDenied.LocationTracking")
        self.MessageTimer_Title = getValue(dict, "MessageTimer.Title")
        self.Watch_Compose_Send = getValue(dict, "Watch.Compose.Send")
        self.Preview_CopyAddress = getValue(dict, "Preview.CopyAddress")
        self.Settings_BlockedUsers = getValue(dict, "Settings.BlockedUsers")
        self.Month_ShortAugust = getValue(dict, "Month.ShortAugust")
        self.Channel_AdminLogFilter_AdminsTitle = getValue(dict, "Channel.AdminLogFilter.AdminsTitle")
        self.Channel_EditAdmin_PermissionChangeInfo = getValue(dict, "Channel.EditAdmin.PermissionChangeInfo")
        self.Notifications_ResetAllNotificationsHelp = getValue(dict, "Notifications.ResetAllNotificationsHelp")
        self.DialogList_EncryptionRejected = getValue(dict, "DialogList.EncryptionRejected")
        self.AccessDenied_CameraRestricted = getValue(dict, "AccessDenied.CameraRestricted")
        self.Target_InviteToGroupErrorAlreadyInvited = getValue(dict, "Target.InviteToGroupErrorAlreadyInvited")
        self.Watch_Message_ForwardedFrom = getValue(dict, "Watch.Message.ForwardedFrom")
        self.Channel_AboutItem = getValue(dict, "Channel.AboutItem")
        self.PhotoEditor_CurvesGreen = getValue(dict, "PhotoEditor.CurvesGreen")
        self.CheckoutInfo_ShippingInfoCountryPlaceholder = getValue(dict, "CheckoutInfo.ShippingInfoCountryPlaceholder")
        self.Month_GenJuly = getValue(dict, "Month.GenJuly")
        self.Conversation_DeleteChat = getValue(dict, "Conversation.DeleteChat")
        self._DialogList_SingleUploadingFileSuffix = getValue(dict, "DialogList.SingleUploadingFileSuffix")
        self._DialogList_SingleUploadingFileSuffix_r = extractArgumentRanges(self._DialogList_SingleUploadingFileSuffix)
        self.ChannelIntro_CreateChannel = getValue(dict, "ChannelIntro.CreateChannel")
        self.WelcomeScreen_ContactsAccessDisabled = getValue(dict, "WelcomeScreen.ContactsAccessDisabled")
        self.Channel_Management_AddModerator = getValue(dict, "Channel.Management.AddModerator")
        self.Common_ChoosePhoto = getValue(dict, "Common.ChoosePhoto")
        self.Group_Username_Help = getValue(dict, "Group.Username.Help")
        self.Conversation_Pin = getValue(dict, "Conversation.Pin")
        self.Channel_AdminLog_CanStartCalls = getValue(dict, "Channel.AdminLog.CanStartCalls")
        self._Login_ResetAccountProtected_Text = getValue(dict, "Login.ResetAccountProtected.Text")
        self._Login_ResetAccountProtected_Text_r = extractArgumentRanges(self._Login_ResetAccountProtected_Text)
        self.Camera_TapAndHoldForVideo = getValue(dict, "Camera.TapAndHoldForVideo")
        self.Bot_DescriptionTitle = getValue(dict, "Bot.DescriptionTitle")
        self.FeaturedStickerPacks_Title = getValue(dict, "FeaturedStickerPacks.Title")
        self.Map_OpenInGoogleMaps = getValue(dict, "Map.OpenInGoogleMaps")
        self.Notification_MessageLifetime5s = getValue(dict, "Notification.MessageLifetime5s")
        self.EnterPasscode_SetupTitle = getValue(dict, "EnterPasscode.SetupTitle")
        self.Contacts_Title = getValue(dict, "Contacts.Title")
        self.Channel_Management_AddModeratorHelp = getValue(dict, "Channel.Management.AddModeratorHelp")
        self._CHAT_MESSAGE_FWDS = getValue(dict, "CHAT_MESSAGE_FWDS")
        self._CHAT_MESSAGE_FWDS_r = extractArgumentRanges(self._CHAT_MESSAGE_FWDS)
        self.WelcomeScreen_UpdatingTitle = getValue(dict, "WelcomeScreen.UpdatingTitle")
        self._Login_CodeHelp = getValue(dict, "Login.CodeHelp")
        self._Login_CodeHelp_r = extractArgumentRanges(self._Login_CodeHelp)
        self.Conversation_MessageDialogEdit = getValue(dict, "Conversation.MessageDialogEdit")
        self.PrivacyLastSeenSettings_Title = getValue(dict, "PrivacyLastSeenSettings.Title")
        self.Notifications_ClassicTones = getValue(dict, "Notifications.ClassicTones")
        self.GoogleDrive_Title = getValue(dict, "GoogleDrive.Title")
        self.Conversation_LinkDialogOpen = getValue(dict, "Conversation.LinkDialogOpen")
        self.Conversation_ClousStorageInfo_Description4 = getValue(dict, "Conversation.ClousStorageInfo.Description4")
        self.Privacy_Calls_AlwaysAllow = getValue(dict, "Privacy.Calls.AlwaysAllow")
        self.Privacy_PaymentsClearInfoHelp = getValue(dict, "Privacy.PaymentsClearInfoHelp")
        self.Notification_MessageLifetime1h = getValue(dict, "Notification.MessageLifetime1h")
        self._Notification_CreatedChatWithTitle = getValue(dict, "Notification.CreatedChatWithTitle")
        self._Notification_CreatedChatWithTitle_r = extractArgumentRanges(self._Notification_CreatedChatWithTitle)
        self.CheckoutInfo_ReceiverInfoEmail = getValue(dict, "CheckoutInfo.ReceiverInfoEmail")
        self.LastSeen_Lately = getValue(dict, "LastSeen.Lately")
        self.Month_ShortApril = getValue(dict, "Month.ShortApril")
        self.ConversationProfile_ErrorCreatingConversation = getValue(dict, "ConversationProfile.ErrorCreatingConversation")
        self._PHONE_CALL_MISSED = getValue(dict, "PHONE_CALL_MISSED")
        self._PHONE_CALL_MISSED_r = extractArgumentRanges(self._PHONE_CALL_MISSED)
        self.Map_AccessDeniedError = getValue(dict, "Map.AccessDeniedError")
        self._Conversation_Kilobytes = getValue(dict, "Conversation.Kilobytes")
        self._Conversation_Kilobytes_r = extractArgumentRanges(self._Conversation_Kilobytes)
        self.Group_ErrorAddBlocked = getValue(dict, "Group.ErrorAddBlocked")
        self.MediaPicker_Videos = getValue(dict, "MediaPicker.Videos")
        self.BlockedUsers_AddNew = getValue(dict, "BlockedUsers.AddNew")
        self.StickerPacksSettings_StickerPacksSection = getValue(dict, "StickerPacksSettings.StickerPacksSection")
        self.Channel_NotificationLoading = getValue(dict, "Channel.NotificationLoading")
        self._CHAT_RETURNED = getValue(dict, "CHAT_RETURNED")
        self._CHAT_RETURNED_r = extractArgumentRanges(self._CHAT_RETURNED)
        self.PhotoEditor_ShadowsTint = getValue(dict, "PhotoEditor.ShadowsTint")
        self.ExplicitContent_AlertTitle = getValue(dict, "ExplicitContent.AlertTitle")
        self.Channel_AdminLogFilter_EventsLeaving = getValue(dict, "Channel.AdminLogFilter.EventsLeaving")
        self.StickerPack_HideStickers = getValue(dict, "StickerPack.HideStickers")
        self._Group_MessageTitleUpdated = getValue(dict, "Group.MessageTitleUpdated")
        self._Group_MessageTitleUpdated_r = extractArgumentRanges(self._Group_MessageTitleUpdated)
        self.Checkout_EnterPassword = getValue(dict, "Checkout.EnterPassword")
        self.UserInfo_NotificationsEnabled = getValue(dict, "UserInfo.NotificationsEnabled")
        self.Weekday_ShortTuesday = getValue(dict, "Weekday.ShortTuesday")
        self.Notification_CallIncomingShort = getValue(dict, "Notification.CallIncomingShort")
        self.ConvertToSupergroup_Note = getValue(dict, "ConvertToSupergroup.Note")
        self.Conversation_EmptyPlaceholder = getValue(dict, "Conversation.EmptyPlaceholder")
        self.Conversation_BroadcastTitle = getValue(dict, "Conversation.BroadcastTitle")
        self.Username_Help = getValue(dict, "Username.Help")
        self.StickerSettings_ContextHide = getValue(dict, "StickerSettings.ContextHide")
        self.Weekday_Sunday = getValue(dict, "Weekday.Sunday")
        self.Preview_LoadingImage = getValue(dict, "Preview.LoadingImage")
        self._Conversation_DownloadProgressKilobytes = getValue(dict, "Conversation.DownloadProgressKilobytes")
        self._Conversation_DownloadProgressKilobytes_r = extractArgumentRanges(self._Conversation_DownloadProgressKilobytes)
        self.Settings_ChatBackground = getValue(dict, "Settings.ChatBackground")
    self._MessageTimer_Seconds_zero = getValueWithForm(dict, "MessageTimer.Seconds", .zero)
    self._MessageTimer_Seconds_one = getValueWithForm(dict, "MessageTimer.Seconds", .one)
    self._MessageTimer_Seconds_two = getValueWithForm(dict, "MessageTimer.Seconds", .two)
    self._MessageTimer_Seconds_few = getValueWithForm(dict, "MessageTimer.Seconds", .few)
    self._MessageTimer_Seconds_many = getValueWithForm(dict, "MessageTimer.Seconds", .many)
    self._MessageTimer_Seconds_other = getValueWithForm(dict, "MessageTimer.Seconds", .other)
    self._Call_Seconds_zero = getValueWithForm(dict, "Call.Seconds", .zero)
    self._Call_Seconds_one = getValueWithForm(dict, "Call.Seconds", .one)
    self._Call_Seconds_two = getValueWithForm(dict, "Call.Seconds", .two)
    self._Call_Seconds_few = getValueWithForm(dict, "Call.Seconds", .few)
    self._Call_Seconds_many = getValueWithForm(dict, "Call.Seconds", .many)
    self._Call_Seconds_other = getValueWithForm(dict, "Call.Seconds", .other)
    self._MessageTimer_ShortSeconds_zero = getValueWithForm(dict, "MessageTimer.ShortSeconds", .zero)
    self._MessageTimer_ShortSeconds_one = getValueWithForm(dict, "MessageTimer.ShortSeconds", .one)
    self._MessageTimer_ShortSeconds_two = getValueWithForm(dict, "MessageTimer.ShortSeconds", .two)
    self._MessageTimer_ShortSeconds_few = getValueWithForm(dict, "MessageTimer.ShortSeconds", .few)
    self._MessageTimer_ShortSeconds_many = getValueWithForm(dict, "MessageTimer.ShortSeconds", .many)
    self._MessageTimer_ShortSeconds_other = getValueWithForm(dict, "MessageTimer.ShortSeconds", .other)
    self._Notification_GameScoreSimple_zero = getValueWithForm(dict, "Notification.GameScoreSimple", .zero)
    self._Notification_GameScoreSimple_one = getValueWithForm(dict, "Notification.GameScoreSimple", .one)
    self._Notification_GameScoreSimple_two = getValueWithForm(dict, "Notification.GameScoreSimple", .two)
    self._Notification_GameScoreSimple_few = getValueWithForm(dict, "Notification.GameScoreSimple", .few)
    self._Notification_GameScoreSimple_many = getValueWithForm(dict, "Notification.GameScoreSimple", .many)
    self._Notification_GameScoreSimple_other = getValueWithForm(dict, "Notification.GameScoreSimple", .other)
    self._Notification_GameScoreExtended_zero = getValueWithForm(dict, "Notification.GameScoreExtended", .zero)
    self._Notification_GameScoreExtended_one = getValueWithForm(dict, "Notification.GameScoreExtended", .one)
    self._Notification_GameScoreExtended_two = getValueWithForm(dict, "Notification.GameScoreExtended", .two)
    self._Notification_GameScoreExtended_few = getValueWithForm(dict, "Notification.GameScoreExtended", .few)
    self._Notification_GameScoreExtended_many = getValueWithForm(dict, "Notification.GameScoreExtended", .many)
    self._Notification_GameScoreExtended_other = getValueWithForm(dict, "Notification.GameScoreExtended", .other)
    self._PasscodeSettings_FailedAttempts_zero = getValueWithForm(dict, "PasscodeSettings.FailedAttempts", .zero)
    self._PasscodeSettings_FailedAttempts_one = getValueWithForm(dict, "PasscodeSettings.FailedAttempts", .one)
    self._PasscodeSettings_FailedAttempts_two = getValueWithForm(dict, "PasscodeSettings.FailedAttempts", .two)
    self._PasscodeSettings_FailedAttempts_few = getValueWithForm(dict, "PasscodeSettings.FailedAttempts", .few)
    self._PasscodeSettings_FailedAttempts_many = getValueWithForm(dict, "PasscodeSettings.FailedAttempts", .many)
    self._PasscodeSettings_FailedAttempts_other = getValueWithForm(dict, "PasscodeSettings.FailedAttempts", .other)
    self._MuteFor_Hours_zero = getValueWithForm(dict, "MuteFor.Hours", .zero)
    self._MuteFor_Hours_one = getValueWithForm(dict, "MuteFor.Hours", .one)
    self._MuteFor_Hours_two = getValueWithForm(dict, "MuteFor.Hours", .two)
    self._MuteFor_Hours_few = getValueWithForm(dict, "MuteFor.Hours", .few)
    self._MuteFor_Hours_many = getValueWithForm(dict, "MuteFor.Hours", .many)
    self._MuteFor_Hours_other = getValueWithForm(dict, "MuteFor.Hours", .other)
    self._MessageTimer_ShortMinutes_zero = getValueWithForm(dict, "MessageTimer.ShortMinutes", .zero)
    self._MessageTimer_ShortMinutes_one = getValueWithForm(dict, "MessageTimer.ShortMinutes", .one)
    self._MessageTimer_ShortMinutes_two = getValueWithForm(dict, "MessageTimer.ShortMinutes", .two)
    self._MessageTimer_ShortMinutes_few = getValueWithForm(dict, "MessageTimer.ShortMinutes", .few)
    self._MessageTimer_ShortMinutes_many = getValueWithForm(dict, "MessageTimer.ShortMinutes", .many)
    self._MessageTimer_ShortMinutes_other = getValueWithForm(dict, "MessageTimer.ShortMinutes", .other)
    self._Notification_GameScoreSelfExtended_zero = getValueWithForm(dict, "Notification.GameScoreSelfExtended", .zero)
    self._Notification_GameScoreSelfExtended_one = getValueWithForm(dict, "Notification.GameScoreSelfExtended", .one)
    self._Notification_GameScoreSelfExtended_two = getValueWithForm(dict, "Notification.GameScoreSelfExtended", .two)
    self._Notification_GameScoreSelfExtended_few = getValueWithForm(dict, "Notification.GameScoreSelfExtended", .few)
    self._Notification_GameScoreSelfExtended_many = getValueWithForm(dict, "Notification.GameScoreSelfExtended", .many)
    self._Notification_GameScoreSelfExtended_other = getValueWithForm(dict, "Notification.GameScoreSelfExtended", .other)
    self._MessageTimer_ShortDays_zero = getValueWithForm(dict, "MessageTimer.ShortDays", .zero)
    self._MessageTimer_ShortDays_one = getValueWithForm(dict, "MessageTimer.ShortDays", .one)
    self._MessageTimer_ShortDays_two = getValueWithForm(dict, "MessageTimer.ShortDays", .two)
    self._MessageTimer_ShortDays_few = getValueWithForm(dict, "MessageTimer.ShortDays", .few)
    self._MessageTimer_ShortDays_many = getValueWithForm(dict, "MessageTimer.ShortDays", .many)
    self._MessageTimer_ShortDays_other = getValueWithForm(dict, "MessageTimer.ShortDays", .other)
    self._GroupInfo_ParticipantCount_zero = getValueWithForm(dict, "GroupInfo.ParticipantCount", .zero)
    self._GroupInfo_ParticipantCount_one = getValueWithForm(dict, "GroupInfo.ParticipantCount", .one)
    self._GroupInfo_ParticipantCount_two = getValueWithForm(dict, "GroupInfo.ParticipantCount", .two)
    self._GroupInfo_ParticipantCount_few = getValueWithForm(dict, "GroupInfo.ParticipantCount", .few)
    self._GroupInfo_ParticipantCount_many = getValueWithForm(dict, "GroupInfo.ParticipantCount", .many)
    self._GroupInfo_ParticipantCount_other = getValueWithForm(dict, "GroupInfo.ParticipantCount", .other)
    self._ForwardedPhotos_zero = getValueWithForm(dict, "ForwardedPhotos", .zero)
    self._ForwardedPhotos_one = getValueWithForm(dict, "ForwardedPhotos", .one)
    self._ForwardedPhotos_two = getValueWithForm(dict, "ForwardedPhotos", .two)
    self._ForwardedPhotos_few = getValueWithForm(dict, "ForwardedPhotos", .few)
    self._ForwardedPhotos_many = getValueWithForm(dict, "ForwardedPhotos", .many)
    self._ForwardedPhotos_other = getValueWithForm(dict, "ForwardedPhotos", .other)
    self._ServiceMessage_GameScoreSelfExtended_zero = getValueWithForm(dict, "ServiceMessage.GameScoreSelfExtended", .zero)
    self._ServiceMessage_GameScoreSelfExtended_one = getValueWithForm(dict, "ServiceMessage.GameScoreSelfExtended", .one)
    self._ServiceMessage_GameScoreSelfExtended_two = getValueWithForm(dict, "ServiceMessage.GameScoreSelfExtended", .two)
    self._ServiceMessage_GameScoreSelfExtended_few = getValueWithForm(dict, "ServiceMessage.GameScoreSelfExtended", .few)
    self._ServiceMessage_GameScoreSelfExtended_many = getValueWithForm(dict, "ServiceMessage.GameScoreSelfExtended", .many)
    self._ServiceMessage_GameScoreSelfExtended_other = getValueWithForm(dict, "ServiceMessage.GameScoreSelfExtended", .other)
    self._Call_ShortSeconds_zero = getValueWithForm(dict, "Call.ShortSeconds", .zero)
    self._Call_ShortSeconds_one = getValueWithForm(dict, "Call.ShortSeconds", .one)
    self._Call_ShortSeconds_two = getValueWithForm(dict, "Call.ShortSeconds", .two)
    self._Call_ShortSeconds_few = getValueWithForm(dict, "Call.ShortSeconds", .few)
    self._Call_ShortSeconds_many = getValueWithForm(dict, "Call.ShortSeconds", .many)
    self._Call_ShortSeconds_other = getValueWithForm(dict, "Call.ShortSeconds", .other)
    self._Time_PreciseDate_zero = getValueWithForm(dict, "Time.PreciseDate", .zero)
    self._Time_PreciseDate_one = getValueWithForm(dict, "Time.PreciseDate", .one)
    self._Time_PreciseDate_two = getValueWithForm(dict, "Time.PreciseDate", .two)
    self._Time_PreciseDate_few = getValueWithForm(dict, "Time.PreciseDate", .few)
    self._Time_PreciseDate_many = getValueWithForm(dict, "Time.PreciseDate", .many)
    self._Time_PreciseDate_other = getValueWithForm(dict, "Time.PreciseDate", .other)
    self._SharedMedia_File_zero = getValueWithForm(dict, "SharedMedia.File", .zero)
    self._SharedMedia_File_one = getValueWithForm(dict, "SharedMedia.File", .one)
    self._SharedMedia_File_two = getValueWithForm(dict, "SharedMedia.File", .two)
    self._SharedMedia_File_few = getValueWithForm(dict, "SharedMedia.File", .few)
    self._SharedMedia_File_many = getValueWithForm(dict, "SharedMedia.File", .many)
    self._SharedMedia_File_other = getValueWithForm(dict, "SharedMedia.File", .other)
    self._PasscodeSettings_AutoLock_IfAwayFor_zero = getValueWithForm(dict, "PasscodeSettings.AutoLock.IfAwayFor", .zero)
    self._PasscodeSettings_AutoLock_IfAwayFor_one = getValueWithForm(dict, "PasscodeSettings.AutoLock.IfAwayFor", .one)
    self._PasscodeSettings_AutoLock_IfAwayFor_two = getValueWithForm(dict, "PasscodeSettings.AutoLock.IfAwayFor", .two)
    self._PasscodeSettings_AutoLock_IfAwayFor_few = getValueWithForm(dict, "PasscodeSettings.AutoLock.IfAwayFor", .few)
    self._PasscodeSettings_AutoLock_IfAwayFor_many = getValueWithForm(dict, "PasscodeSettings.AutoLock.IfAwayFor", .many)
    self._PasscodeSettings_AutoLock_IfAwayFor_other = getValueWithForm(dict, "PasscodeSettings.AutoLock.IfAwayFor", .other)
    self._ForwardedAudios_zero = getValueWithForm(dict, "ForwardedAudios", .zero)
    self._ForwardedAudios_one = getValueWithForm(dict, "ForwardedAudios", .one)
    self._ForwardedAudios_two = getValueWithForm(dict, "ForwardedAudios", .two)
    self._ForwardedAudios_few = getValueWithForm(dict, "ForwardedAudios", .few)
    self._ForwardedAudios_many = getValueWithForm(dict, "ForwardedAudios", .many)
    self._ForwardedAudios_other = getValueWithForm(dict, "ForwardedAudios", .other)
    self._PrivacyLastSeenSettings_AddUsers_zero = getValueWithForm(dict, "PrivacyLastSeenSettings.AddUsers", .zero)
    self._PrivacyLastSeenSettings_AddUsers_one = getValueWithForm(dict, "PrivacyLastSeenSettings.AddUsers", .one)
    self._PrivacyLastSeenSettings_AddUsers_two = getValueWithForm(dict, "PrivacyLastSeenSettings.AddUsers", .two)
    self._PrivacyLastSeenSettings_AddUsers_few = getValueWithForm(dict, "PrivacyLastSeenSettings.AddUsers", .few)
    self._PrivacyLastSeenSettings_AddUsers_many = getValueWithForm(dict, "PrivacyLastSeenSettings.AddUsers", .many)
    self._PrivacyLastSeenSettings_AddUsers_other = getValueWithForm(dict, "PrivacyLastSeenSettings.AddUsers", .other)
    self._MuteFor_Weeks_zero = getValueWithForm(dict, "MuteFor.Weeks", .zero)
    self._MuteFor_Weeks_one = getValueWithForm(dict, "MuteFor.Weeks", .one)
    self._MuteFor_Weeks_two = getValueWithForm(dict, "MuteFor.Weeks", .two)
    self._MuteFor_Weeks_few = getValueWithForm(dict, "MuteFor.Weeks", .few)
    self._MuteFor_Weeks_many = getValueWithForm(dict, "MuteFor.Weeks", .many)
    self._MuteFor_Weeks_other = getValueWithForm(dict, "MuteFor.Weeks", .other)
    self._ForwardedVideoMessages_zero = getValueWithForm(dict, "ForwardedVideoMessages", .zero)
    self._ForwardedVideoMessages_one = getValueWithForm(dict, "ForwardedVideoMessages", .one)
    self._ForwardedVideoMessages_two = getValueWithForm(dict, "ForwardedVideoMessages", .two)
    self._ForwardedVideoMessages_few = getValueWithForm(dict, "ForwardedVideoMessages", .few)
    self._ForwardedVideoMessages_many = getValueWithForm(dict, "ForwardedVideoMessages", .many)
    self._ForwardedVideoMessages_other = getValueWithForm(dict, "ForwardedVideoMessages", .other)
    self._SharedMedia_Generic_zero = getValueWithForm(dict, "SharedMedia.Generic", .zero)
    self._SharedMedia_Generic_one = getValueWithForm(dict, "SharedMedia.Generic", .one)
    self._SharedMedia_Generic_two = getValueWithForm(dict, "SharedMedia.Generic", .two)
    self._SharedMedia_Generic_few = getValueWithForm(dict, "SharedMedia.Generic", .few)
    self._SharedMedia_Generic_many = getValueWithForm(dict, "SharedMedia.Generic", .many)
    self._SharedMedia_Generic_other = getValueWithForm(dict, "SharedMedia.Generic", .other)
    self._Conversation_StatusMembers_zero = getValueWithForm(dict, "Conversation.StatusMembers", .zero)
    self._Conversation_StatusMembers_one = getValueWithForm(dict, "Conversation.StatusMembers", .one)
    self._Conversation_StatusMembers_two = getValueWithForm(dict, "Conversation.StatusMembers", .two)
    self._Conversation_StatusMembers_few = getValueWithForm(dict, "Conversation.StatusMembers", .few)
    self._Conversation_StatusMembers_many = getValueWithForm(dict, "Conversation.StatusMembers", .many)
    self._Conversation_StatusMembers_other = getValueWithForm(dict, "Conversation.StatusMembers", .other)
    self._Invitation_Members_zero = getValueWithForm(dict, "Invitation.Members", .zero)
    self._Invitation_Members_one = getValueWithForm(dict, "Invitation.Members", .one)
    self._Invitation_Members_two = getValueWithForm(dict, "Invitation.Members", .two)
    self._Invitation_Members_few = getValueWithForm(dict, "Invitation.Members", .few)
    self._Invitation_Members_many = getValueWithForm(dict, "Invitation.Members", .many)
    self._Invitation_Members_other = getValueWithForm(dict, "Invitation.Members", .other)
    self._ForwardedFiles_zero = getValueWithForm(dict, "ForwardedFiles", .zero)
    self._ForwardedFiles_one = getValueWithForm(dict, "ForwardedFiles", .one)
    self._ForwardedFiles_two = getValueWithForm(dict, "ForwardedFiles", .two)
    self._ForwardedFiles_few = getValueWithForm(dict, "ForwardedFiles", .few)
    self._ForwardedFiles_many = getValueWithForm(dict, "ForwardedFiles", .many)
    self._ForwardedFiles_other = getValueWithForm(dict, "ForwardedFiles", .other)
    self._ForwardedStickers_zero = getValueWithForm(dict, "ForwardedStickers", .zero)
    self._ForwardedStickers_one = getValueWithForm(dict, "ForwardedStickers", .one)
    self._ForwardedStickers_two = getValueWithForm(dict, "ForwardedStickers", .two)
    self._ForwardedStickers_few = getValueWithForm(dict, "ForwardedStickers", .few)
    self._ForwardedStickers_many = getValueWithForm(dict, "ForwardedStickers", .many)
    self._ForwardedStickers_other = getValueWithForm(dict, "ForwardedStickers", .other)
    self._StickerPack_StickerCount_zero = getValueWithForm(dict, "StickerPack.StickerCount", .zero)
    self._StickerPack_StickerCount_one = getValueWithForm(dict, "StickerPack.StickerCount", .one)
    self._StickerPack_StickerCount_two = getValueWithForm(dict, "StickerPack.StickerCount", .two)
    self._StickerPack_StickerCount_few = getValueWithForm(dict, "StickerPack.StickerCount", .few)
    self._StickerPack_StickerCount_many = getValueWithForm(dict, "StickerPack.StickerCount", .many)
    self._StickerPack_StickerCount_other = getValueWithForm(dict, "StickerPack.StickerCount", .other)
    self._SharedMedia_Video_zero = getValueWithForm(dict, "SharedMedia.Video", .zero)
    self._SharedMedia_Video_one = getValueWithForm(dict, "SharedMedia.Video", .one)
    self._SharedMedia_Video_two = getValueWithForm(dict, "SharedMedia.Video", .two)
    self._SharedMedia_Video_few = getValueWithForm(dict, "SharedMedia.Video", .few)
    self._SharedMedia_Video_many = getValueWithForm(dict, "SharedMedia.Video", .many)
    self._SharedMedia_Video_other = getValueWithForm(dict, "SharedMedia.Video", .other)
    self._ForwardedAuthorsOthers_zero = getValueWithForm(dict, "ForwardedAuthorsOthers", .zero)
    self._ForwardedAuthorsOthers_one = getValueWithForm(dict, "ForwardedAuthorsOthers", .one)
    self._ForwardedAuthorsOthers_two = getValueWithForm(dict, "ForwardedAuthorsOthers", .two)
    self._ForwardedAuthorsOthers_few = getValueWithForm(dict, "ForwardedAuthorsOthers", .few)
    self._ForwardedAuthorsOthers_many = getValueWithForm(dict, "ForwardedAuthorsOthers", .many)
    self._ForwardedAuthorsOthers_other = getValueWithForm(dict, "ForwardedAuthorsOthers", .other)
    self._MuteFor_Minutes_zero = getValueWithForm(dict, "MuteFor.Minutes", .zero)
    self._MuteFor_Minutes_one = getValueWithForm(dict, "MuteFor.Minutes", .one)
    self._MuteFor_Minutes_two = getValueWithForm(dict, "MuteFor.Minutes", .two)
    self._MuteFor_Minutes_few = getValueWithForm(dict, "MuteFor.Minutes", .few)
    self._MuteFor_Minutes_many = getValueWithForm(dict, "MuteFor.Minutes", .many)
    self._MuteFor_Minutes_other = getValueWithForm(dict, "MuteFor.Minutes", .other)
    self._AttachmentMenu_SendVideo_zero = getValueWithForm(dict, "AttachmentMenu.SendVideo", .zero)
    self._AttachmentMenu_SendVideo_one = getValueWithForm(dict, "AttachmentMenu.SendVideo", .one)
    self._AttachmentMenu_SendVideo_two = getValueWithForm(dict, "AttachmentMenu.SendVideo", .two)
    self._AttachmentMenu_SendVideo_few = getValueWithForm(dict, "AttachmentMenu.SendVideo", .few)
    self._AttachmentMenu_SendVideo_many = getValueWithForm(dict, "AttachmentMenu.SendVideo", .many)
    self._AttachmentMenu_SendVideo_other = getValueWithForm(dict, "AttachmentMenu.SendVideo", .other)
    self._Call_Minutes_zero = getValueWithForm(dict, "Call.Minutes", .zero)
    self._Call_Minutes_one = getValueWithForm(dict, "Call.Minutes", .one)
    self._Call_Minutes_two = getValueWithForm(dict, "Call.Minutes", .two)
    self._Call_Minutes_few = getValueWithForm(dict, "Call.Minutes", .few)
    self._Call_Minutes_many = getValueWithForm(dict, "Call.Minutes", .many)
    self._Call_Minutes_other = getValueWithForm(dict, "Call.Minutes", .other)
    self._ForwardedContacts_zero = getValueWithForm(dict, "ForwardedContacts", .zero)
    self._ForwardedContacts_one = getValueWithForm(dict, "ForwardedContacts", .one)
    self._ForwardedContacts_two = getValueWithForm(dict, "ForwardedContacts", .two)
    self._ForwardedContacts_few = getValueWithForm(dict, "ForwardedContacts", .few)
    self._ForwardedContacts_many = getValueWithForm(dict, "ForwardedContacts", .many)
    self._ForwardedContacts_other = getValueWithForm(dict, "ForwardedContacts", .other)
    self._Channel_NotificationComments_zero = getValueWithForm(dict, "Channel.NotificationComments", .zero)
    self._Channel_NotificationComments_one = getValueWithForm(dict, "Channel.NotificationComments", .one)
    self._Channel_NotificationComments_two = getValueWithForm(dict, "Channel.NotificationComments", .two)
    self._Channel_NotificationComments_few = getValueWithForm(dict, "Channel.NotificationComments", .few)
    self._Channel_NotificationComments_many = getValueWithForm(dict, "Channel.NotificationComments", .many)
    self._Channel_NotificationComments_other = getValueWithForm(dict, "Channel.NotificationComments", .other)
    self._UserCount_zero = getValueWithForm(dict, "UserCount", .zero)
    self._UserCount_one = getValueWithForm(dict, "UserCount", .one)
    self._UserCount_two = getValueWithForm(dict, "UserCount", .two)
    self._UserCount_few = getValueWithForm(dict, "UserCount", .few)
    self._UserCount_many = getValueWithForm(dict, "UserCount", .many)
    self._UserCount_other = getValueWithForm(dict, "UserCount", .other)
    self._ForwardedGifs_zero = getValueWithForm(dict, "ForwardedGifs", .zero)
    self._ForwardedGifs_one = getValueWithForm(dict, "ForwardedGifs", .one)
    self._ForwardedGifs_two = getValueWithForm(dict, "ForwardedGifs", .two)
    self._ForwardedGifs_few = getValueWithForm(dict, "ForwardedGifs", .few)
    self._ForwardedGifs_many = getValueWithForm(dict, "ForwardedGifs", .many)
    self._ForwardedGifs_other = getValueWithForm(dict, "ForwardedGifs", .other)
    self._MessageTimer_ShortHours_zero = getValueWithForm(dict, "MessageTimer.ShortHours", .zero)
    self._MessageTimer_ShortHours_one = getValueWithForm(dict, "MessageTimer.ShortHours", .one)
    self._MessageTimer_ShortHours_two = getValueWithForm(dict, "MessageTimer.ShortHours", .two)
    self._MessageTimer_ShortHours_few = getValueWithForm(dict, "MessageTimer.ShortHours", .few)
    self._MessageTimer_ShortHours_many = getValueWithForm(dict, "MessageTimer.ShortHours", .many)
    self._MessageTimer_ShortHours_other = getValueWithForm(dict, "MessageTimer.ShortHours", .other)
    self._ServiceMessage_GameScoreExtended_zero = getValueWithForm(dict, "ServiceMessage.GameScoreExtended", .zero)
    self._ServiceMessage_GameScoreExtended_one = getValueWithForm(dict, "ServiceMessage.GameScoreExtended", .one)
    self._ServiceMessage_GameScoreExtended_two = getValueWithForm(dict, "ServiceMessage.GameScoreExtended", .two)
    self._ServiceMessage_GameScoreExtended_few = getValueWithForm(dict, "ServiceMessage.GameScoreExtended", .few)
    self._ServiceMessage_GameScoreExtended_many = getValueWithForm(dict, "ServiceMessage.GameScoreExtended", .many)
    self._ServiceMessage_GameScoreExtended_other = getValueWithForm(dict, "ServiceMessage.GameScoreExtended", .other)
    self._StickerPack_AddStickerCount_zero = getValueWithForm(dict, "StickerPack.AddStickerCount", .zero)
    self._StickerPack_AddStickerCount_one = getValueWithForm(dict, "StickerPack.AddStickerCount", .one)
    self._StickerPack_AddStickerCount_two = getValueWithForm(dict, "StickerPack.AddStickerCount", .two)
    self._StickerPack_AddStickerCount_few = getValueWithForm(dict, "StickerPack.AddStickerCount", .few)
    self._StickerPack_AddStickerCount_many = getValueWithForm(dict, "StickerPack.AddStickerCount", .many)
    self._StickerPack_AddStickerCount_other = getValueWithForm(dict, "StickerPack.AddStickerCount", .other)
    self._AttachmentMenu_SendPhoto_zero = getValueWithForm(dict, "AttachmentMenu.SendPhoto", .zero)
    self._AttachmentMenu_SendPhoto_one = getValueWithForm(dict, "AttachmentMenu.SendPhoto", .one)
    self._AttachmentMenu_SendPhoto_two = getValueWithForm(dict, "AttachmentMenu.SendPhoto", .two)
    self._AttachmentMenu_SendPhoto_few = getValueWithForm(dict, "AttachmentMenu.SendPhoto", .few)
    self._AttachmentMenu_SendPhoto_many = getValueWithForm(dict, "AttachmentMenu.SendPhoto", .many)
    self._AttachmentMenu_SendPhoto_other = getValueWithForm(dict, "AttachmentMenu.SendPhoto", .other)
    self._Conversation_StatusRecipients_zero = getValueWithForm(dict, "Conversation.StatusRecipients", .zero)
    self._Conversation_StatusRecipients_one = getValueWithForm(dict, "Conversation.StatusRecipients", .one)
    self._Conversation_StatusRecipients_two = getValueWithForm(dict, "Conversation.StatusRecipients", .two)
    self._Conversation_StatusRecipients_few = getValueWithForm(dict, "Conversation.StatusRecipients", .few)
    self._Conversation_StatusRecipients_many = getValueWithForm(dict, "Conversation.StatusRecipients", .many)
    self._Conversation_StatusRecipients_other = getValueWithForm(dict, "Conversation.StatusRecipients", .other)
    self._Channel_Management_LabelRights_zero = getValueWithForm(dict, "Channel.Management.LabelRights", .zero)
    self._Channel_Management_LabelRights_one = getValueWithForm(dict, "Channel.Management.LabelRights", .one)
    self._Channel_Management_LabelRights_two = getValueWithForm(dict, "Channel.Management.LabelRights", .two)
    self._Channel_Management_LabelRights_few = getValueWithForm(dict, "Channel.Management.LabelRights", .few)
    self._Channel_Management_LabelRights_many = getValueWithForm(dict, "Channel.Management.LabelRights", .many)
    self._Channel_Management_LabelRights_other = getValueWithForm(dict, "Channel.Management.LabelRights", .other)
    self._ServiceMessage_GameScoreSelfSimple_zero = getValueWithForm(dict, "ServiceMessage.GameScoreSelfSimple", .zero)
    self._ServiceMessage_GameScoreSelfSimple_one = getValueWithForm(dict, "ServiceMessage.GameScoreSelfSimple", .one)
    self._ServiceMessage_GameScoreSelfSimple_two = getValueWithForm(dict, "ServiceMessage.GameScoreSelfSimple", .two)
    self._ServiceMessage_GameScoreSelfSimple_few = getValueWithForm(dict, "ServiceMessage.GameScoreSelfSimple", .few)
    self._ServiceMessage_GameScoreSelfSimple_many = getValueWithForm(dict, "ServiceMessage.GameScoreSelfSimple", .many)
    self._ServiceMessage_GameScoreSelfSimple_other = getValueWithForm(dict, "ServiceMessage.GameScoreSelfSimple", .other)
    self._SharedMedia_Photo_zero = getValueWithForm(dict, "SharedMedia.Photo", .zero)
    self._SharedMedia_Photo_one = getValueWithForm(dict, "SharedMedia.Photo", .one)
    self._SharedMedia_Photo_two = getValueWithForm(dict, "SharedMedia.Photo", .two)
    self._SharedMedia_Photo_few = getValueWithForm(dict, "SharedMedia.Photo", .few)
    self._SharedMedia_Photo_many = getValueWithForm(dict, "SharedMedia.Photo", .many)
    self._SharedMedia_Photo_other = getValueWithForm(dict, "SharedMedia.Photo", .other)
    self._MessageTimer_Weeks_zero = getValueWithForm(dict, "MessageTimer.Weeks", .zero)
    self._MessageTimer_Weeks_one = getValueWithForm(dict, "MessageTimer.Weeks", .one)
    self._MessageTimer_Weeks_two = getValueWithForm(dict, "MessageTimer.Weeks", .two)
    self._MessageTimer_Weeks_few = getValueWithForm(dict, "MessageTimer.Weeks", .few)
    self._MessageTimer_Weeks_many = getValueWithForm(dict, "MessageTimer.Weeks", .many)
    self._MessageTimer_Weeks_other = getValueWithForm(dict, "MessageTimer.Weeks", .other)
    self._StickerPack_AddMaskCount_zero = getValueWithForm(dict, "StickerPack.AddMaskCount", .zero)
    self._StickerPack_AddMaskCount_one = getValueWithForm(dict, "StickerPack.AddMaskCount", .one)
    self._StickerPack_AddMaskCount_two = getValueWithForm(dict, "StickerPack.AddMaskCount", .two)
    self._StickerPack_AddMaskCount_few = getValueWithForm(dict, "StickerPack.AddMaskCount", .few)
    self._StickerPack_AddMaskCount_many = getValueWithForm(dict, "StickerPack.AddMaskCount", .many)
    self._StickerPack_AddMaskCount_other = getValueWithForm(dict, "StickerPack.AddMaskCount", .other)
    self._LastSeen_MinutesAgo_zero = getValueWithForm(dict, "LastSeen.MinutesAgo", .zero)
    self._LastSeen_MinutesAgo_one = getValueWithForm(dict, "LastSeen.MinutesAgo", .one)
    self._LastSeen_MinutesAgo_two = getValueWithForm(dict, "LastSeen.MinutesAgo", .two)
    self._LastSeen_MinutesAgo_few = getValueWithForm(dict, "LastSeen.MinutesAgo", .few)
    self._LastSeen_MinutesAgo_many = getValueWithForm(dict, "LastSeen.MinutesAgo", .many)
    self._LastSeen_MinutesAgo_other = getValueWithForm(dict, "LastSeen.MinutesAgo", .other)
    self._LastSeen_HoursAgo_zero = getValueWithForm(dict, "LastSeen.HoursAgo", .zero)
    self._LastSeen_HoursAgo_one = getValueWithForm(dict, "LastSeen.HoursAgo", .one)
    self._LastSeen_HoursAgo_two = getValueWithForm(dict, "LastSeen.HoursAgo", .two)
    self._LastSeen_HoursAgo_few = getValueWithForm(dict, "LastSeen.HoursAgo", .few)
    self._LastSeen_HoursAgo_many = getValueWithForm(dict, "LastSeen.HoursAgo", .many)
    self._LastSeen_HoursAgo_other = getValueWithForm(dict, "LastSeen.HoursAgo", .other)
    self._MuteExpires_Days_zero = getValueWithForm(dict, "MuteExpires.Days", .zero)
    self._MuteExpires_Days_one = getValueWithForm(dict, "MuteExpires.Days", .one)
    self._MuteExpires_Days_two = getValueWithForm(dict, "MuteExpires.Days", .two)
    self._MuteExpires_Days_few = getValueWithForm(dict, "MuteExpires.Days", .few)
    self._MuteExpires_Days_many = getValueWithForm(dict, "MuteExpires.Days", .many)
    self._MuteExpires_Days_other = getValueWithForm(dict, "MuteExpires.Days", .other)
    self._MuteExpires_Hours_zero = getValueWithForm(dict, "MuteExpires.Hours", .zero)
    self._MuteExpires_Hours_one = getValueWithForm(dict, "MuteExpires.Hours", .one)
    self._MuteExpires_Hours_two = getValueWithForm(dict, "MuteExpires.Hours", .two)
    self._MuteExpires_Hours_few = getValueWithForm(dict, "MuteExpires.Hours", .few)
    self._MuteExpires_Hours_many = getValueWithForm(dict, "MuteExpires.Hours", .many)
    self._MuteExpires_Hours_other = getValueWithForm(dict, "MuteExpires.Hours", .other)
    self._Watch_LastSeen_HoursAgo_zero = getValueWithForm(dict, "Watch.LastSeen.HoursAgo", .zero)
    self._Watch_LastSeen_HoursAgo_one = getValueWithForm(dict, "Watch.LastSeen.HoursAgo", .one)
    self._Watch_LastSeen_HoursAgo_two = getValueWithForm(dict, "Watch.LastSeen.HoursAgo", .two)
    self._Watch_LastSeen_HoursAgo_few = getValueWithForm(dict, "Watch.LastSeen.HoursAgo", .few)
    self._Watch_LastSeen_HoursAgo_many = getValueWithForm(dict, "Watch.LastSeen.HoursAgo", .many)
    self._Watch_LastSeen_HoursAgo_other = getValueWithForm(dict, "Watch.LastSeen.HoursAgo", .other)
    self._Forward_ConfirmMultipleFiles_zero = getValueWithForm(dict, "Forward.ConfirmMultipleFiles", .zero)
    self._Forward_ConfirmMultipleFiles_one = getValueWithForm(dict, "Forward.ConfirmMultipleFiles", .one)
    self._Forward_ConfirmMultipleFiles_two = getValueWithForm(dict, "Forward.ConfirmMultipleFiles", .two)
    self._Forward_ConfirmMultipleFiles_few = getValueWithForm(dict, "Forward.ConfirmMultipleFiles", .few)
    self._Forward_ConfirmMultipleFiles_many = getValueWithForm(dict, "Forward.ConfirmMultipleFiles", .many)
    self._Forward_ConfirmMultipleFiles_other = getValueWithForm(dict, "Forward.ConfirmMultipleFiles", .other)
    self._AttachmentMenu_SendGif_zero = getValueWithForm(dict, "AttachmentMenu.SendGif", .zero)
    self._AttachmentMenu_SendGif_one = getValueWithForm(dict, "AttachmentMenu.SendGif", .one)
    self._AttachmentMenu_SendGif_two = getValueWithForm(dict, "AttachmentMenu.SendGif", .two)
    self._AttachmentMenu_SendGif_few = getValueWithForm(dict, "AttachmentMenu.SendGif", .few)
    self._AttachmentMenu_SendGif_many = getValueWithForm(dict, "AttachmentMenu.SendGif", .many)
    self._AttachmentMenu_SendGif_other = getValueWithForm(dict, "AttachmentMenu.SendGif", .other)
    self._StickerPack_RemoveStickerCount_zero = getValueWithForm(dict, "StickerPack.RemoveStickerCount", .zero)
    self._StickerPack_RemoveStickerCount_one = getValueWithForm(dict, "StickerPack.RemoveStickerCount", .one)
    self._StickerPack_RemoveStickerCount_two = getValueWithForm(dict, "StickerPack.RemoveStickerCount", .two)
    self._StickerPack_RemoveStickerCount_few = getValueWithForm(dict, "StickerPack.RemoveStickerCount", .few)
    self._StickerPack_RemoveStickerCount_many = getValueWithForm(dict, "StickerPack.RemoveStickerCount", .many)
    self._StickerPack_RemoveStickerCount_other = getValueWithForm(dict, "StickerPack.RemoveStickerCount", .other)
    self._SharedMedia_Link_zero = getValueWithForm(dict, "SharedMedia.Link", .zero)
    self._SharedMedia_Link_one = getValueWithForm(dict, "SharedMedia.Link", .one)
    self._SharedMedia_Link_two = getValueWithForm(dict, "SharedMedia.Link", .two)
    self._SharedMedia_Link_few = getValueWithForm(dict, "SharedMedia.Link", .few)
    self._SharedMedia_Link_many = getValueWithForm(dict, "SharedMedia.Link", .many)
    self._SharedMedia_Link_other = getValueWithForm(dict, "SharedMedia.Link", .other)
    self._Map_ETAHours_zero = getValueWithForm(dict, "Map.ETAHours", .zero)
    self._Map_ETAHours_one = getValueWithForm(dict, "Map.ETAHours", .one)
    self._Map_ETAHours_two = getValueWithForm(dict, "Map.ETAHours", .two)
    self._Map_ETAHours_few = getValueWithForm(dict, "Map.ETAHours", .few)
    self._Map_ETAHours_many = getValueWithForm(dict, "Map.ETAHours", .many)
    self._Map_ETAHours_other = getValueWithForm(dict, "Map.ETAHours", .other)
    self._SharedMedia_DeleteItemsConfirmation_zero = getValueWithForm(dict, "SharedMedia.DeleteItemsConfirmation", .zero)
    self._SharedMedia_DeleteItemsConfirmation_one = getValueWithForm(dict, "SharedMedia.DeleteItemsConfirmation", .one)
    self._SharedMedia_DeleteItemsConfirmation_two = getValueWithForm(dict, "SharedMedia.DeleteItemsConfirmation", .two)
    self._SharedMedia_DeleteItemsConfirmation_few = getValueWithForm(dict, "SharedMedia.DeleteItemsConfirmation", .few)
    self._SharedMedia_DeleteItemsConfirmation_many = getValueWithForm(dict, "SharedMedia.DeleteItemsConfirmation", .many)
    self._SharedMedia_DeleteItemsConfirmation_other = getValueWithForm(dict, "SharedMedia.DeleteItemsConfirmation", .other)
    self._Watch_LastSeen_MinutesAgo_zero = getValueWithForm(dict, "Watch.LastSeen.MinutesAgo", .zero)
    self._Watch_LastSeen_MinutesAgo_one = getValueWithForm(dict, "Watch.LastSeen.MinutesAgo", .one)
    self._Watch_LastSeen_MinutesAgo_two = getValueWithForm(dict, "Watch.LastSeen.MinutesAgo", .two)
    self._Watch_LastSeen_MinutesAgo_few = getValueWithForm(dict, "Watch.LastSeen.MinutesAgo", .few)
    self._Watch_LastSeen_MinutesAgo_many = getValueWithForm(dict, "Watch.LastSeen.MinutesAgo", .many)
    self._Watch_LastSeen_MinutesAgo_other = getValueWithForm(dict, "Watch.LastSeen.MinutesAgo", .other)
    self._ForwardedMessages_zero = getValueWithForm(dict, "ForwardedMessages", .zero)
    self._ForwardedMessages_one = getValueWithForm(dict, "ForwardedMessages", .one)
    self._ForwardedMessages_two = getValueWithForm(dict, "ForwardedMessages", .two)
    self._ForwardedMessages_few = getValueWithForm(dict, "ForwardedMessages", .few)
    self._ForwardedMessages_many = getValueWithForm(dict, "ForwardedMessages", .many)
    self._ForwardedMessages_other = getValueWithForm(dict, "ForwardedMessages", .other)
    self._SharedMedia_ItemsSelected_zero = getValueWithForm(dict, "SharedMedia.ItemsSelected", .zero)
    self._SharedMedia_ItemsSelected_one = getValueWithForm(dict, "SharedMedia.ItemsSelected", .one)
    self._SharedMedia_ItemsSelected_two = getValueWithForm(dict, "SharedMedia.ItemsSelected", .two)
    self._SharedMedia_ItemsSelected_few = getValueWithForm(dict, "SharedMedia.ItemsSelected", .few)
    self._SharedMedia_ItemsSelected_many = getValueWithForm(dict, "SharedMedia.ItemsSelected", .many)
    self._SharedMedia_ItemsSelected_other = getValueWithForm(dict, "SharedMedia.ItemsSelected", .other)
    self._MessageTimer_Hours_zero = getValueWithForm(dict, "MessageTimer.Hours", .zero)
    self._MessageTimer_Hours_one = getValueWithForm(dict, "MessageTimer.Hours", .one)
    self._MessageTimer_Hours_two = getValueWithForm(dict, "MessageTimer.Hours", .two)
    self._MessageTimer_Hours_few = getValueWithForm(dict, "MessageTimer.Hours", .few)
    self._MessageTimer_Hours_many = getValueWithForm(dict, "MessageTimer.Hours", .many)
    self._MessageTimer_Hours_other = getValueWithForm(dict, "MessageTimer.Hours", .other)
    self._MessageTimer_Years_zero = getValueWithForm(dict, "MessageTimer.Years", .zero)
    self._MessageTimer_Years_one = getValueWithForm(dict, "MessageTimer.Years", .one)
    self._MessageTimer_Years_two = getValueWithForm(dict, "MessageTimer.Years", .two)
    self._MessageTimer_Years_few = getValueWithForm(dict, "MessageTimer.Years", .few)
    self._MessageTimer_Years_many = getValueWithForm(dict, "MessageTimer.Years", .many)
    self._MessageTimer_Years_other = getValueWithForm(dict, "MessageTimer.Years", .other)
    self._Map_ETAMinutes_zero = getValueWithForm(dict, "Map.ETAMinutes", .zero)
    self._Map_ETAMinutes_one = getValueWithForm(dict, "Map.ETAMinutes", .one)
    self._Map_ETAMinutes_two = getValueWithForm(dict, "Map.ETAMinutes", .two)
    self._Map_ETAMinutes_few = getValueWithForm(dict, "Map.ETAMinutes", .few)
    self._Map_ETAMinutes_many = getValueWithForm(dict, "Map.ETAMinutes", .many)
    self._Map_ETAMinutes_other = getValueWithForm(dict, "Map.ETAMinutes", .other)
    self._ForwardedVideos_zero = getValueWithForm(dict, "ForwardedVideos", .zero)
    self._ForwardedVideos_one = getValueWithForm(dict, "ForwardedVideos", .one)
    self._ForwardedVideos_two = getValueWithForm(dict, "ForwardedVideos", .two)
    self._ForwardedVideos_few = getValueWithForm(dict, "ForwardedVideos", .few)
    self._ForwardedVideos_many = getValueWithForm(dict, "ForwardedVideos", .many)
    self._ForwardedVideos_other = getValueWithForm(dict, "ForwardedVideos", .other)
    self._Notification_GameScoreSelfSimple_zero = getValueWithForm(dict, "Notification.GameScoreSelfSimple", .zero)
    self._Notification_GameScoreSelfSimple_one = getValueWithForm(dict, "Notification.GameScoreSelfSimple", .one)
    self._Notification_GameScoreSelfSimple_two = getValueWithForm(dict, "Notification.GameScoreSelfSimple", .two)
    self._Notification_GameScoreSelfSimple_few = getValueWithForm(dict, "Notification.GameScoreSelfSimple", .few)
    self._Notification_GameScoreSelfSimple_many = getValueWithForm(dict, "Notification.GameScoreSelfSimple", .many)
    self._Notification_GameScoreSelfSimple_other = getValueWithForm(dict, "Notification.GameScoreSelfSimple", .other)
    self._ServiceMessage_GameScoreSimple_zero = getValueWithForm(dict, "ServiceMessage.GameScoreSimple", .zero)
    self._ServiceMessage_GameScoreSimple_one = getValueWithForm(dict, "ServiceMessage.GameScoreSimple", .one)
    self._ServiceMessage_GameScoreSimple_two = getValueWithForm(dict, "ServiceMessage.GameScoreSimple", .two)
    self._ServiceMessage_GameScoreSimple_few = getValueWithForm(dict, "ServiceMessage.GameScoreSimple", .few)
    self._ServiceMessage_GameScoreSimple_many = getValueWithForm(dict, "ServiceMessage.GameScoreSimple", .many)
    self._ServiceMessage_GameScoreSimple_other = getValueWithForm(dict, "ServiceMessage.GameScoreSimple", .other)
    self._QuickSend_Photos_zero = getValueWithForm(dict, "QuickSend.Photos", .zero)
    self._QuickSend_Photos_one = getValueWithForm(dict, "QuickSend.Photos", .one)
    self._QuickSend_Photos_two = getValueWithForm(dict, "QuickSend.Photos", .two)
    self._QuickSend_Photos_few = getValueWithForm(dict, "QuickSend.Photos", .few)
    self._QuickSend_Photos_many = getValueWithForm(dict, "QuickSend.Photos", .many)
    self._QuickSend_Photos_other = getValueWithForm(dict, "QuickSend.Photos", .other)
    self._MuteFor_Days_zero = getValueWithForm(dict, "MuteFor.Days", .zero)
    self._MuteFor_Days_one = getValueWithForm(dict, "MuteFor.Days", .one)
    self._MuteFor_Days_two = getValueWithForm(dict, "MuteFor.Days", .two)
    self._MuteFor_Days_few = getValueWithForm(dict, "MuteFor.Days", .few)
    self._MuteFor_Days_many = getValueWithForm(dict, "MuteFor.Days", .many)
    self._MuteFor_Days_other = getValueWithForm(dict, "MuteFor.Days", .other)
    self._Conversation_StatusOnline_zero = getValueWithForm(dict, "Conversation.StatusOnline", .zero)
    self._Conversation_StatusOnline_one = getValueWithForm(dict, "Conversation.StatusOnline", .one)
    self._Conversation_StatusOnline_two = getValueWithForm(dict, "Conversation.StatusOnline", .two)
    self._Conversation_StatusOnline_few = getValueWithForm(dict, "Conversation.StatusOnline", .few)
    self._Conversation_StatusOnline_many = getValueWithForm(dict, "Conversation.StatusOnline", .many)
    self._Conversation_StatusOnline_other = getValueWithForm(dict, "Conversation.StatusOnline", .other)
    self._AttachmentMenu_SendItem_zero = getValueWithForm(dict, "AttachmentMenu.SendItem", .zero)
    self._AttachmentMenu_SendItem_one = getValueWithForm(dict, "AttachmentMenu.SendItem", .one)
    self._AttachmentMenu_SendItem_two = getValueWithForm(dict, "AttachmentMenu.SendItem", .two)
    self._AttachmentMenu_SendItem_few = getValueWithForm(dict, "AttachmentMenu.SendItem", .few)
    self._AttachmentMenu_SendItem_many = getValueWithForm(dict, "AttachmentMenu.SendItem", .many)
    self._AttachmentMenu_SendItem_other = getValueWithForm(dict, "AttachmentMenu.SendItem", .other)
    self._Time_MonthOfYear_zero = getValueWithForm(dict, "Time.MonthOfYear", .zero)
    self._Time_MonthOfYear_one = getValueWithForm(dict, "Time.MonthOfYear", .one)
    self._Time_MonthOfYear_two = getValueWithForm(dict, "Time.MonthOfYear", .two)
    self._Time_MonthOfYear_few = getValueWithForm(dict, "Time.MonthOfYear", .few)
    self._Time_MonthOfYear_many = getValueWithForm(dict, "Time.MonthOfYear", .many)
    self._Time_MonthOfYear_other = getValueWithForm(dict, "Time.MonthOfYear", .other)
    self._Watch_UserInfo_Mute_zero = getValueWithForm(dict, "Watch.UserInfo.Mute", .zero)
    self._Watch_UserInfo_Mute_one = getValueWithForm(dict, "Watch.UserInfo.Mute", .one)
    self._Watch_UserInfo_Mute_two = getValueWithForm(dict, "Watch.UserInfo.Mute", .two)
    self._Watch_UserInfo_Mute_few = getValueWithForm(dict, "Watch.UserInfo.Mute", .few)
    self._Watch_UserInfo_Mute_many = getValueWithForm(dict, "Watch.UserInfo.Mute", .many)
    self._Watch_UserInfo_Mute_other = getValueWithForm(dict, "Watch.UserInfo.Mute", .other)
    self._StickerPack_MaskCount_zero = getValueWithForm(dict, "StickerPack.MaskCount", .zero)
    self._StickerPack_MaskCount_one = getValueWithForm(dict, "StickerPack.MaskCount", .one)
    self._StickerPack_MaskCount_two = getValueWithForm(dict, "StickerPack.MaskCount", .two)
    self._StickerPack_MaskCount_few = getValueWithForm(dict, "StickerPack.MaskCount", .few)
    self._StickerPack_MaskCount_many = getValueWithForm(dict, "StickerPack.MaskCount", .many)
    self._StickerPack_MaskCount_other = getValueWithForm(dict, "StickerPack.MaskCount", .other)
    self._Call_ShortMinutes_zero = getValueWithForm(dict, "Call.ShortMinutes", .zero)
    self._Call_ShortMinutes_one = getValueWithForm(dict, "Call.ShortMinutes", .one)
    self._Call_ShortMinutes_two = getValueWithForm(dict, "Call.ShortMinutes", .two)
    self._Call_ShortMinutes_few = getValueWithForm(dict, "Call.ShortMinutes", .few)
    self._Call_ShortMinutes_many = getValueWithForm(dict, "Call.ShortMinutes", .many)
    self._Call_ShortMinutes_other = getValueWithForm(dict, "Call.ShortMinutes", .other)
    self._StickerPack_RemoveMaskCount_zero = getValueWithForm(dict, "StickerPack.RemoveMaskCount", .zero)
    self._StickerPack_RemoveMaskCount_one = getValueWithForm(dict, "StickerPack.RemoveMaskCount", .one)
    self._StickerPack_RemoveMaskCount_two = getValueWithForm(dict, "StickerPack.RemoveMaskCount", .two)
    self._StickerPack_RemoveMaskCount_few = getValueWithForm(dict, "StickerPack.RemoveMaskCount", .few)
    self._StickerPack_RemoveMaskCount_many = getValueWithForm(dict, "StickerPack.RemoveMaskCount", .many)
    self._StickerPack_RemoveMaskCount_other = getValueWithForm(dict, "StickerPack.RemoveMaskCount", .other)
    self._ForwardedLocations_zero = getValueWithForm(dict, "ForwardedLocations", .zero)
    self._ForwardedLocations_one = getValueWithForm(dict, "ForwardedLocations", .one)
    self._ForwardedLocations_two = getValueWithForm(dict, "ForwardedLocations", .two)
    self._ForwardedLocations_few = getValueWithForm(dict, "ForwardedLocations", .few)
    self._ForwardedLocations_many = getValueWithForm(dict, "ForwardedLocations", .many)
    self._ForwardedLocations_other = getValueWithForm(dict, "ForwardedLocations", .other)
    self._MessageTimer_ShortWeeks_zero = getValueWithForm(dict, "MessageTimer.ShortWeeks", .zero)
    self._MessageTimer_ShortWeeks_one = getValueWithForm(dict, "MessageTimer.ShortWeeks", .one)
    self._MessageTimer_ShortWeeks_two = getValueWithForm(dict, "MessageTimer.ShortWeeks", .two)
    self._MessageTimer_ShortWeeks_few = getValueWithForm(dict, "MessageTimer.ShortWeeks", .few)
    self._MessageTimer_ShortWeeks_many = getValueWithForm(dict, "MessageTimer.ShortWeeks", .many)
    self._MessageTimer_ShortWeeks_other = getValueWithForm(dict, "MessageTimer.ShortWeeks", .other)
    self._MessageTimer_Minutes_zero = getValueWithForm(dict, "MessageTimer.Minutes", .zero)
    self._MessageTimer_Minutes_one = getValueWithForm(dict, "MessageTimer.Minutes", .one)
    self._MessageTimer_Minutes_two = getValueWithForm(dict, "MessageTimer.Minutes", .two)
    self._MessageTimer_Minutes_few = getValueWithForm(dict, "MessageTimer.Minutes", .few)
    self._MessageTimer_Minutes_many = getValueWithForm(dict, "MessageTimer.Minutes", .many)
    self._MessageTimer_Minutes_other = getValueWithForm(dict, "MessageTimer.Minutes", .other)
    self._MessageTimer_Months_zero = getValueWithForm(dict, "MessageTimer.Months", .zero)
    self._MessageTimer_Months_one = getValueWithForm(dict, "MessageTimer.Months", .one)
    self._MessageTimer_Months_two = getValueWithForm(dict, "MessageTimer.Months", .two)
    self._MessageTimer_Months_few = getValueWithForm(dict, "MessageTimer.Months", .few)
    self._MessageTimer_Months_many = getValueWithForm(dict, "MessageTimer.Months", .many)
    self._MessageTimer_Months_other = getValueWithForm(dict, "MessageTimer.Months", .other)
    self._MessageTimer_Days_zero = getValueWithForm(dict, "MessageTimer.Days", .zero)
    self._MessageTimer_Days_one = getValueWithForm(dict, "MessageTimer.Days", .one)
    self._MessageTimer_Days_two = getValueWithForm(dict, "MessageTimer.Days", .two)
    self._MessageTimer_Days_few = getValueWithForm(dict, "MessageTimer.Days", .few)
    self._MessageTimer_Days_many = getValueWithForm(dict, "MessageTimer.Days", .many)
    self._MessageTimer_Days_other = getValueWithForm(dict, "MessageTimer.Days", .other)
    self._MuteExpires_Minutes_zero = getValueWithForm(dict, "MuteExpires.Minutes", .zero)
    self._MuteExpires_Minutes_one = getValueWithForm(dict, "MuteExpires.Minutes", .one)
    self._MuteExpires_Minutes_two = getValueWithForm(dict, "MuteExpires.Minutes", .two)
    self._MuteExpires_Minutes_few = getValueWithForm(dict, "MuteExpires.Minutes", .few)
    self._MuteExpires_Minutes_many = getValueWithForm(dict, "MuteExpires.Minutes", .many)
    self._MuteExpires_Minutes_other = getValueWithForm(dict, "MuteExpires.Minutes", .other)
        
    }
}

