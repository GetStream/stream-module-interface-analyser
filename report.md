- === Sources Public API - Begin (Containers: 665) ===
+ === Sources Public API - Begin (Containers: 662) ===
  
  
  Global
...
- public let dominantSpeaker: StreamSortComparator<CallParticipant>
+ public let defaultComparators: [StreamSortComparator<CallParticipant>]
- public let speaking: StreamSortComparator<CallParticipant>
+ public let livestreamComparators: [StreamSortComparator<CallParticipant>]
- @available(*, deprecated, renamed: "speaking")
+ public func combineComparators<T>(_ comparators: [StreamSortComparator<T>]) -> StreamSortComparator<T>
- public let isSpeaking
+ public func conditional<T>(_ predicate: @escaping (T, T) -> Bool)
- public let screenSharing: StreamSortComparator<CallParticipant>
+     -> (@escaping StreamSortComparator<T>) -> StreamSortComparator<T>
- public let publishingVideo: StreamSortComparator<CallParticipant>
+ public let ifInvisible
- public let publishingAudio: StreamSortComparator<CallParticipant>
+ public var dominantSpeaker: StreamSortComparator<CallParticipant>
- public let pinned: StreamSortComparator<CallParticipant>
+ public var isSpeaking: StreamSortComparator<CallParticipant>
- public func roles(_ roles: [String] = ["admin", "host", "speaker"]) -> StreamSortComparator<CallParticipant>
+ public var pinned: StreamSortComparator<CallParticipant>
- public let name: StreamSortComparator<CallParticipant>
+ public var screensharing: StreamSortComparator<CallParticipant>
- public var id: StreamSortComparator<CallParticipant>
+ public var publishingVideo: StreamSortComparator<CallParticipant>
- public var userId: StreamSortComparator<CallParticipant>
+ public var publishingAudio: StreamSortComparator<CallParticipant>
- public var joinedAt: StreamSortComparator<CallParticipant>
+ public var name: StreamSortComparator<CallParticipant>
- public func combineComparators<T>(_ comparators: StreamSortComparator<T>...) -> StreamSortComparator<T>
+ public func roles(_ priorityRoles: [String] = ["admin", "host", "speaker"]) -> StreamSortComparator<CallParticipant>
- public func combineComparators<T>(_ comparators: [StreamSortComparator<T>]) -> StreamSortComparator<T>
+ public var id: StreamSortComparator<CallParticipant>
- public func descending<T>(_ comparator: @escaping StreamSortComparator<T>) -> StreamSortComparator<T>
+ public var userId: StreamSortComparator<CallParticipant>
- public func conditional<T>(
+ public var joinedAt: StreamSortComparator<CallParticipant>
-     _ predicate: @escaping (T, T) -> Bool
+ public func callCid(from callId: String, callType: String) -> String
- ) -> (@escaping StreamSortComparator<T>) -> StreamSortComparator<T>
+ public func resignFirstResponder()
- public func noopComparator<T>() -> StreamSortComparator<T>
+ public let getStreamFirstResponderNotification
- public let ifInvisibleBy
+ 
- @available(*, deprecated, renamed: "ifInvisibleBy")
+ public class Call : @unchecked Sendable, WSEventsSubscriber
- public let ifInvisible
+ 	@MainActor public internal(set) var state
- public let defaultSortPreset
+ 	public let callId: String
- @available(*, deprecated, renamed: "defaultSortPreset")
+ 	public let callType: String
- public let defaultComparators
+ 	public var cId: String
- public let speakerLayoutSortPreset
+ 	public let microphone: MicrophoneManager
- @available(*, deprecated, renamed: "speakerLayoutSortPreset")
+ 	public let camera: CameraManager
- public let screensharing
+ 	public let speaker: SpeakerManager
- public let paginatedLayoutSortPreset
+ 	@discardableResult
- public let livestreamOrAudioRoomSortPreset
+     public func join(
- public func callCid(from callId: String, callType: String) -> String
+         create: Bool = false,
- public func resignFirstResponder()
+         options: CreateCallOptions? = nil,
- public let getStreamFirstResponderNotification
+         ring: Bool = false,
- 
+         notify: Bool = false,
- public class Call : @unchecked Sendable, WSEventsSubscriber
+         callSettings: CallSettings? = nil
- 	@MainActor public internal(set) var state
+     ) async throws -> JoinCallResponse
- 	public let callId: String
+ 	public func get(
- 	public let callType: String
+         membersLimit: Int? = nil,
- 	public var cId: String
+         ring: Bool = false,
- 	public let microphone: MicrophoneManager
+         notify: Bool = false
- 	public let camera: CameraManager
+     ) async throws -> GetCallResponse
- 	public let speaker: SpeakerManager
+ 	@discardableResult
- 	@discardableResult
+     public func ring() async throws -> CallResponse
-     public func join(
+ 	@discardableResult
-         create: Bool = false,
+     public func notify() async throws -> CallResponse
-         options: CreateCallOptions? = nil,
+ 	@discardableResult
-         ring: Bool = false,
+     public func create(
-         notify: Bool = false,
+         members: [MemberRequest]? = nil,
-         callSettings: CallSettings? = nil
+         memberIds: [String]? = nil,
-     ) async throws -> JoinCallResponse
+         custom: [String: RawJSON]? = nil,
- 	public func get(
+         startsAt: Date? = nil,
-         membersLimit: Int? = nil,
+         team: String? = nil,
-         notify: Bool = false
+         notify: Bool = false,
-     ) async throws -> GetCallResponse
+         maxDuration: Int? = nil,
- 	@discardableResult
+         maxParticipants: Int? = nil,
-     public func ring() async throws -> CallResponse
+         backstage: BackstageSettingsRequest? = nil,
- 	@discardableResult
+         video: Bool? = nil,
-     public func notify() async throws -> CallResponse
+         transcription: TranscriptionSettingsRequest? = nil
- 	@discardableResult
+     ) async throws -> CallResponse
-     public func create(
+ 	@discardableResult
-         members: [MemberRequest]? = nil,
+     public func update(
-         memberIds: [String]? = nil,
+         custom: [String: RawJSON]? = nil,
-         custom: [String: RawJSON]? = nil,
+         settingsOverride: CallSettingsRequest? = nil,
-         startsAt: Date? = nil,
+         startsAt: Date? = nil
-         team: String? = nil,
+     ) async throws -> UpdateCallResponse
-         ring: Bool = false,
+ 	@discardableResult
-         notify: Bool = false,
+     public func accept() async throws -> AcceptCallResponse
-         maxDuration: Int? = nil,
+ 	@discardableResult
-         maxParticipants: Int? = nil,
+     public func reject(reason: String? = nil) async throws -> RejectCallResponse
-         backstage: BackstageSettingsRequest? = nil,
+ 	@discardableResult
-         video: Bool? = nil,
+     public func block(user: User) async throws -> BlockUserResponse
-         transcription: TranscriptionSettingsRequest? = nil
+ 	@discardableResult
-     ) async throws -> CallResponse
+     public func unblock(user: User) async throws -> UnblockUserResponse
- 	@discardableResult
+ 	public func changeTrackVisibility(for participant: CallParticipant, isVisible: Bool) async
-     public func update(
+ 	@discardableResult
-         custom: [String: RawJSON]? = nil,
+     public func addMembers(members: [MemberRequest]) async throws -> UpdateCallMembersResponse
-         settingsOverride: CallSettingsRequest? = nil,
+ 	@discardableResult
-         startsAt: Date? = nil
+     public func updateMembers(members: [MemberRequest]) async throws -> UpdateCallMembersResponse
-     ) async throws -> UpdateCallResponse
+ 	@discardableResult
- 	@discardableResult
+     public func addMembers(ids: [String]) async throws -> UpdateCallMembersResponse
-     public func accept() async throws -> AcceptCallResponse
+ 	@discardableResult
- 	@discardableResult
+     public func removeMembers(ids: [String]) async throws -> UpdateCallMembersResponse
-     public func reject(reason: String? = nil) async throws -> RejectCallResponse
+ 	public func updateTrackSize(_ trackSize: CGSize, for participant: CallParticipant) async
- 	@discardableResult
+ 	public func setVideoFilter(_ videoFilter: VideoFilter?)
-     public func block(user: User) async throws -> BlockUserResponse
+ 	public func setAudioFilter(_ audioFilter: AudioFilter?)
- 	@discardableResult
+ 	public func startScreensharing(type: ScreensharingType) async throws
-     public func unblock(user: User) async throws -> UnblockUserResponse
+ 	public func stopScreensharing() async throws
- 	public func changeTrackVisibility(for participant: CallParticipant, isVisible: Bool) async
+ 	public func subscribe() -> AsyncStream<VideoEvent>
- 	@discardableResult
+ 	public func subscribe<WSEvent: Event>(for event: WSEvent.Type) -> AsyncStream<WSEvent>
-     public func addMembers(members: [MemberRequest]) async throws -> UpdateCallMembersResponse
+ 	public func leave()
- 	@discardableResult
+ 	public func startNoiseCancellation() async throws
-     public func updateMembers(members: [MemberRequest]) async throws -> UpdateCallMembersResponse
+ 	public func stopNoiseCancellation() async throws
- 	@discardableResult
+ 	@MainActor public func currentUserCanRequestPermissions(_ permissions: [Permission]) -> Bool
-     public func addMembers(ids: [String]) async throws -> UpdateCallMembersResponse
+ 	@discardableResult
- 	@discardableResult
+     public func request(permissions: [Permission]) async throws -> RequestPermissionResponse
-     public func removeMembers(ids: [String]) async throws -> UpdateCallMembersResponse
+ 	@MainActor public func currentUserHasCapability(_ capability: OwnCapability) -> Bool
- 	public func updateTrackSize(_ trackSize: CGSize, for participant: CallParticipant) async
+ 	@discardableResult
- 	public func setVideoFilter(_ videoFilter: VideoFilter?)
+     public func grant(
- 	public func setAudioFilter(_ audioFilter: AudioFilter?)
+         permissions: [Permission],
- 	public func startScreensharing(type: ScreensharingType) async throws
+         for userId: String
- 	public func stopScreensharing() async throws
+     ) async throws -> UpdateUserPermissionsResponse
- 	public func subscribe() -> AsyncStream<VideoEvent>
+ 	@discardableResult
- 	public func subscribe<WSEvent: Event>(for event: WSEvent.Type) -> AsyncStream<WSEvent>
+     public func grant(request: PermissionRequest) async throws -> UpdateUserPermissionsResponse
- 	public func leave()
+ 	@discardableResult
- 	public func startNoiseCancellation() async throws
+     public func revoke(
- 	public func stopNoiseCancellation() async throws
+         permissions: [Permission],
- 	@MainActor public func currentUserCanRequestPermissions(_ permissions: [Permission]) -> Bool
+         for userId: String
- 	@discardableResult
+     ) async throws -> UpdateUserPermissionsResponse
-     public func request(permissions: [Permission]) async throws -> RequestPermissionResponse
+ 	@discardableResult
- 	@MainActor public func currentUserHasCapability(_ capability: OwnCapability) -> Bool
+     public func mute(
- 	@discardableResult
+         userId: String,
-     public func grant(
+         audio: Bool = true,
-         permissions: [Permission],
+         video: Bool = true
-         for userId: String
+     ) async throws -> MuteUsersResponse
-     ) async throws -> UpdateUserPermissionsResponse
+ 	@discardableResult
- 	@discardableResult
+     public func muteAllUsers(audio: Bool = true, video: Bool = true) async throws -> MuteUsersResponse
-     public func grant(request: PermissionRequest) async throws -> UpdateUserPermissionsResponse
+ 	@discardableResult
- 	@discardableResult
+     public func end() async throws -> EndCallResponse
-     public func revoke(
+ 	@discardableResult
-         permissions: [Permission],
+     public func blockUser(with userId: String) async throws -> BlockUserResponse
-         for userId: String
+ 	@discardableResult
-     ) async throws -> UpdateUserPermissionsResponse
+     public func unblockUser(with userId: String) async throws -> UnblockUserResponse
-     public func mute(
+     public func goLive(
-         userId: String,
+         startHls: Bool? = nil,
-         audio: Bool = true,
+         startRecording: Bool? = nil,
-         video: Bool = true
+         startRtmpBroadcasts: Bool? = nil,
-     ) async throws -> MuteUsersResponse
+         startTranscription: Bool? = nil
- 	@discardableResult
+     ) async throws -> GoLiveResponse
-     public func muteAllUsers(audio: Bool = true, video: Bool = true) async throws -> MuteUsersResponse
+ 	@discardableResult
- 	@discardableResult
+     public func stopLive() async throws -> StopLiveResponse
-     public func end() async throws -> EndCallResponse
+ 	public func stopLive(request: StopLiveRequest) async throws -> StopLiveResponse
-     public func blockUser(with userId: String) async throws -> BlockUserResponse
+     public func startRecording() async throws -> StartRecordingResponse
-     public func unblockUser(with userId: String) async throws -> UnblockUserResponse
+     public func stopRecording() async throws -> StopRecordingResponse
- 	@discardableResult
+ 	public func listRecordings() async throws -> [CallRecording]
-     public func goLive(
+ 	@discardableResult
-         startHls: Bool? = nil,
+     public func startHLS() async throws -> StartHLSBroadcastingResponse
-         startRecording: Bool? = nil,
+ 	@discardableResult
-         startRtmpBroadcasts: Bool? = nil,
+     public func stopHLS() async throws -> StopHLSBroadcastingResponse
-         startTranscription: Bool? = nil
+ 	@discardableResult
-     ) async throws -> GoLiveResponse
+     public func startRTMPBroadcast(
- 	@discardableResult
+         request: StartRTMPBroadcastsRequest
-     public func stopLive() async throws -> StopLiveResponse
+     ) async throws -> StartRTMPBroadcastsResponse
- 	public func stopLive(request: StopLiveRequest) async throws -> StopLiveResponse
+ 	@discardableResult
- 	@discardableResult
+     public func stopRTMPBroadcasts(name: String) async throws -> StopRTMPBroadcastsResponse
-     public func startRecording() async throws -> StartRecordingResponse
+ 	@discardableResult
- 	@discardableResult
+     public func sendCustomEvent(_ data: [String: RawJSON]) async throws -> SendEventResponse
-     public func stopRecording() async throws -> StopRecordingResponse
+ 	@discardableResult
- 	public func listRecordings() async throws -> [CallRecording]
+     public func sendReaction(
- 	@discardableResult
+         type: String,
-     public func startHLS() async throws -> StartHLSBroadcastingResponse
+         custom: [String: RawJSON]? = nil,
- 	@discardableResult
+         emojiCode: String? = nil
-     public func stopHLS() async throws -> StopHLSBroadcastingResponse
+     ) async throws -> SendReactionResponse
- 	@discardableResult
+ 	public func queryMembers(
-     public func startRTMPBroadcast(
+         filters: [String: RawJSON]? = nil,
-         request: StartRTMPBroadcastsRequest
+         sort: [SortParamRequest] = [SortParamRequest.descending("created_at")],
-     ) async throws -> StartRTMPBroadcastsResponse
+         limit: Int = 25
- 	@discardableResult
+     ) async throws -> QueryMembersResponse
-     public func stopRTMPBroadcasts(name: String) async throws -> StopRTMPBroadcastsResponse
+ 	public func queryMembers(
- 	@discardableResult
+         filters: [String: RawJSON]? = nil,
-     public func sendCustomEvent(_ data: [String: RawJSON]) async throws -> SendEventResponse
+         sort: [SortParamRequest]? = nil,
- 	@discardableResult
+         limit: Int = 25,
-     public func sendReaction(
+         next: String
-         type: String,
+     ) async throws -> QueryMembersResponse
-         custom: [String: RawJSON]? = nil,
+ 	public func pin(
-         emojiCode: String? = nil
+         sessionId: String
-     ) async throws -> SendReactionResponse
+     ) async throws
- 	public func queryMembers(
+ 	public func unpin(
-         filters: [String: RawJSON]? = nil,
+         sessionId: String
-         sort: [SortParamRequest] = [SortParamRequest.descending("created_at")],
+     ) async throws
-         limit: Int = 25
+ 	public func pinForEveryone(
-     ) async throws -> QueryMembersResponse
+         userId: String,
- 	public func queryMembers(
+         sessionId: String
-         filters: [String: RawJSON]? = nil,
+     ) async throws -> PinResponse
-         sort: [SortParamRequest]? = nil,
+ 	public func unpinForEveryone(
-         limit: Int = 25,
+         userId: String,
-         next: String
+         sessionId: String
-     ) async throws -> QueryMembersResponse
+     ) async throws -> UnpinResponse
- 	public func pin(
+ 	public func focus(at point: CGPoint) async throws
-         sessionId: String
+ 	public func addCapturePhotoOutput(_ capturePhotoOutput: AVCapturePhotoOutput) async throws
-     ) async throws
+ 	public func removeCapturePhotoOutput(_ capturePhotoOutput: AVCapturePhotoOutput) async throws
- 	public func unpin(
+ 	@available(iOS 16.0, *)
-         sessionId: String
+     public func addVideoOutput(_ videoOutput: AVCaptureVideoDataOutput) async throws
-     ) async throws
+ 	@available(iOS 16.0, *)
- 	public func pinForEveryone(
+     public func removeVideoOutput(_ videoOutput: AVCaptureVideoDataOutput) async throws
-         userId: String,
+ 	public func zoom(by factor: CGFloat) async throws
-         sessionId: String
+ 	@discardableResult
-     ) async throws -> PinResponse
+     public func startTranscription(
- 	public func unpinForEveryone(
+         transcriptionExternalStorage: String? = nil
-         userId: String,
+     ) async throws -> StartTranscriptionResponse
-         sessionId: String
+ 	@discardableResult
-     ) async throws -> UnpinResponse
+     public func stopTranscription(
- 	public func focus(at point: CGPoint) async throws
+         stopClosedCaptions: Bool? = nil
- 	public func addCapturePhotoOutput(_ capturePhotoOutput: AVCapturePhotoOutput) async throws
+     ) async throws -> StopTranscriptionResponse
- 	public func removeCapturePhotoOutput(_ capturePhotoOutput: AVCapturePhotoOutput) async throws
+ 	@discardableResult
- 	@available(iOS 16.0, *)
+     @MainActor
-     public func addVideoOutput(_ videoOutput: AVCaptureVideoDataOutput) async throws
+     public func collectUserFeedback(
- 	@available(iOS 16.0, *)
+         rating: Int,
-     public func removeVideoOutput(_ videoOutput: AVCaptureVideoDataOutput) async throws
+         reason: String? = nil,
- 	public func zoom(by factor: CGFloat) async throws
+         custom: [String: RawJSON]? = nil
- 	@discardableResult
+     ) async throws -> CollectUserFeedbackResponse
-     public func startTranscription(
+ 	@MainActor
-         transcriptionExternalStorage: String? = nil
+     public func updateParticipantsSorting(
-     ) async throws -> StartTranscriptionResponse
+         with sortComparators: [StreamSortComparator<CallParticipant>]
- 	@discardableResult
+     )
-     public func stopTranscription(
+ 	@MainActor
-         stopClosedCaptions: Bool? = nil
+     public func setIncomingVideoQualitySettings(
-     ) async throws -> StopTranscriptionResponse
+         _ value: IncomingVideoQualitySettings
- 	@discardableResult
+     ) async
-     @MainActor
+ 	public func setDisconnectionTimeout(_ timeout: TimeInterval)
-     public func collectUserFeedback(
+ 	public func updatePublishOptions(
-         rating: Int,
+         preferredVideoCodec: VideoCodec,
-         reason: String? = nil,
+         maxBitrate: Int = .maxBitrate
-         custom: [String: RawJSON]? = nil
+     ) async
-     ) async throws -> CollectUserFeedbackResponse
+ 	@discardableResult
- 	@MainActor
+     public func startClosedCaptions(
-     public func updateParticipantsSorting(
+         _ request: StartClosedCaptionsRequest = .init()
-         with sortComparators: [StreamSortComparator<CallParticipant>]
+     ) async throws -> StartClosedCaptionsResponse
-     )
+ 	@discardableResult
- 	@MainActor
+     public func stopClosedCaptions(
-     public func setIncomingVideoQualitySettings(
+         stopTranscription: Bool? = nil
-         _ value: IncomingVideoQualitySettings
+     ) async throws -> StopClosedCaptionsResponse
-     ) async
+ 	@MainActor
- 	public func setDisconnectionTimeout(_ timeout: TimeInterval)
+     public func updateClosedCaptionsSettings(
- 	public func updatePublishOptions(
+         itemPresentationDuration: TimeInterval,
-         preferredVideoCodec: VideoCodec,
+         maxVisibleItems: Int
-         maxBitrate: Int = .maxBitrate
+     ) async
-     ) async
+ 	public func updateAudioSessionPolicy(_ policy: AudioSessionPolicy) async throws
- 	@discardableResult
+ 
-     public func startClosedCaptions(
+ public enum CallKitAvailabilityPolicy : CustomStringConvertible
-         _ request: StartClosedCaptionsRequest = .init()
+ 	case always
-     ) async throws -> StartClosedCaptionsResponse
+ 	case regionBased
- 	@discardableResult
+ 	case custom(CallKitAvailabilityPolicyProtocol)
-     public func stopClosedCaptions(
+ 	public var description: String
-         stopTranscription: Bool? = nil
+ 
-     ) async throws -> StopClosedCaptionsResponse
+ public protocol CallKitAvailabilityPolicyProtocol
- 	@MainActor
+ 	var isAvailable: Bool
-     public func updateClosedCaptionsSettings(
+ 
-         itemPresentationDuration: TimeInterval,
+ open class CallKitAdapter
-         maxVisibleItems: Int
+ 	open var iconTemplateImageData: Data?
-     ) async
+ 	open var ringtoneSound: String?
- 	public func updateAudioSessionPolicy(_ policy: AudioSessionPolicy) async throws
+ 	open var callSettings: CallSettings?
- 
+ 	public var availabilityPolicy: CallKitAvailabilityPolicy
- public enum CallKitAvailabilityPolicy : CustomStringConvertible
+ 	public var streamVideo: StreamVideo?
- 	case always
+ 	public init()
- 	case regionBased
+ 	open func registerForIncomingCalls()
- 	case custom(CallKitAvailabilityPolicyProtocol)
+ 	open func unregisterForIncomingCalls()
- 	public var description: String
+ 
- 
+ extension CallKitAdapter : InjectionKey
- public protocol CallKitAvailabilityPolicyProtocol
+ 	public static var currentValue: CallKitAdapter
- 	var isAvailable: Bool
+ 
- 
+ extension InjectedValues
- open class CallKitAdapter
+ 	public var callKitAdapter: CallKitAdapter
- 	open var iconTemplateImageData: Data?
+ 
- 	open var ringtoneSound: String?
+ open class CallKitPushNotificationAdapter : NSObject, PKPushRegistryDelegate, ObservableObject
- 	open var callSettings: CallSettings?
+ 	public enum PayloadKey : String
- 	public var availabilityPolicy: CallKitAvailabilityPolicy
+ 		case stream
- 	public var streamVideo: StreamVideo?
+ 		case callCid = "call_cid"
- 	public init()
+ 		case displayName = "call_display_name"
- 	open func registerForIncomingCalls()
+ 		case createdByName = "created_by_display_name"
- 	open func unregisterForIncomingCalls()
+ 		case createdById = "created_by_id"
- 
+ 		case video
- extension CallKitAdapter : InjectionKey
+ 	public struct Content
- 	public static var currentValue: CallKitAdapter
+ 		public init(
- 
+             cid: String,
- extension InjectedValues
+             localizedCallerName: String,
- 	public var callKitAdapter: CallKitAdapter
+             callerId: String,
- 
+             hasVideo: Bool
- open class CallKitPushNotificationAdapter : NSObject, PKPushRegistryDelegate, ObservableObject
+         )
- 	public enum PayloadKey : String
+ 	open private(set) lazy var registry: PKPushRegistry
- 		case stream
+ 	open var defaultCallText: String
- 		case callCid = "call_cid"
+ 	@Published public private(set) var deviceToken: String
- 		case displayName = "call_display_name"
+ 	open func register()
- 		case createdByName = "created_by_display_name"
+ 	open func unregister()
- 		case createdById = "created_by_id"
+ 	open func pushRegistry(
- 		case video
+         _ registry: PKPushRegistry,
- 	public struct Content
+         didUpdate pushCredentials: PKPushCredentials,
- 		public init(
+         for type: PKPushType
-             cid: String,
+     )
-             localizedCallerName: String,
+ 	open func pushRegistry(
-             callerId: String,
+         _ registry: PKPushRegistry,
-             hasVideo: Bool
+         didInvalidatePushTokenFor type: PKPushType
-         )
+     )
- 	open private(set) lazy var registry: PKPushRegistry
+ 	@MainActor
- 	open var defaultCallText: String
+     open func pushRegistry(
- 	@Published public private(set) var deviceToken: String
+         _ registry: PKPushRegistry,
- 	open func register()
+         didReceiveIncomingPushWith payload: PKPushPayload,
- 	open func unregister()
+         for type: PKPushType,
- 	open func pushRegistry(
+         completion: @escaping () -> Void
-         _ registry: PKPushRegistry,
+     )
-         didUpdate pushCredentials: PKPushCredentials,
+ 	open func decodePayload(
-         for type: PKPushType
+         _ payload: PKPushPayload
-     )
+     ) -> Content
- 	open func pushRegistry(
+ 
-         _ registry: PKPushRegistry,
+ extension CallKitPushNotificationAdapter : InjectionKey
-         didInvalidatePushTokenFor type: PKPushType
+ 	public static var currentValue: CallKitPushNotificationAdapter
-     )
+ 
- 	@MainActor
+ extension InjectedValues
-     open func pushRegistry(
+ 	public var callKitPushNotificationAdapter: CallKitPushNotificationAdapter
-         _ registry: PKPushRegistry,
+ 
-         didReceiveIncomingPushWith payload: PKPushPayload,
+ open class CallKitService : NSObject, CXProviderDelegate, @unchecked Sendable
-         for type: PKPushType,
+ 	public var streamVideo: StreamVideo?
-         completion: @escaping () -> Void
+ 	open var callId: String
-     )
+ 	open var callType: String
- 	open func decodePayload(
+ 	open var iconTemplateImageData: Data?
-         _ payload: PKPushPayload
+ 	open var ringtoneSound: String?
-     ) -> Content
+ 	open var supportsHolding: Bool
- 
+ 	open var supportsVideo: Bool
- extension CallKitPushNotificationAdapter : InjectionKey
+ 	open internal(set) lazy var callController
- 	public static var currentValue: CallKitPushNotificationAdapter
+ 	open internal(set) lazy var callProvider
- 
+ 	override public init()
- extension InjectedValues
+ 	@MainActor
- 	public var callKitPushNotificationAdapter: CallKitPushNotificationAdapter
+     open func reportIncomingCall(
- 
+         _ cid: String,
- open class CallKitService : NSObject, CXProviderDelegate, @unchecked Sendable
+         localizedCallerName: String,
- 	public var streamVideo: StreamVideo?
+         callerId: String,
- 	open var callId: String
+         hasVideo: Bool = false,
- 	open var callType: String
+         completion: @escaping (Error?) -> Void
- 	open var iconTemplateImageData: Data?
+     )
- 	open var ringtoneSound: String?
+ 	open func callAccepted(_ response: CallAcceptedEvent)
- 	open var supportsHolding: Bool
+ 	open func callRejected(_ response: CallRejectedEvent)
- 	open var supportsVideo: Bool
+ 	open func callEnded(_ cId: String)
- 	open internal(set) lazy var callController
+ 	open func callParticipantLeft(
- 	open internal(set) lazy var callProvider
+         _ response: CallSessionParticipantLeftEvent
- 	override public init()
+     )
- 	@MainActor
+ 	open func providerDidReset(_ provider: CXProvider)
-     open func reportIncomingCall(
+ 	open func provider(
-         _ cid: String,
+         _ provider: CXProvider,
-         localizedCallerName: String,
+         didActivate audioSession: AVAudioSession
-         callerId: String,
+     )
-         hasVideo: Bool = false,
+ 	public func provider(
-         completion: @escaping (Error?) -> Void
+         _ provider: CXProvider,
-     )
+         didDeactivate audioSession: AVAudioSession
- 	open func callAccepted(_ response: CallAcceptedEvent)
+     )
- 	open func callRejected(_ response: CallRejectedEvent)
+ 	open func provider(
- 	open func callEnded(_ cId: String)
+         _ provider: CXProvider,
- 	open func callParticipantLeft(
+         perform action: CXAnswerCallAction
-         _ response: CallSessionParticipantLeftEvent
+     )
-     )
+ 	open func provider(
- 	open func providerDidReset(_ provider: CXProvider)
+         _ provider: CXProvider,
- 	open func provider(
+         perform action: CXEndCallAction
-         _ provider: CXProvider,
+     )
-         didActivate audioSession: AVAudioSession
+ 	open func provider(
-     )
+         _ provider: CXProvider,
- 	public func provider(
+         perform action: CXSetMutedCallAction
-         _ provider: CXProvider,
+     )
-         didDeactivate audioSession: AVAudioSession
+ 	open func requestTransaction(
-     )
+         _ action: CXAction
- 	open func provider(
+     ) async throws
-         _ provider: CXProvider,
+ 	open func checkIfCallWasHandled(callState: GetCallResponse) -> Bool
-         perform action: CXAnswerCallAction
+ 	open func setUpRingingTimer(for callState: GetCallResponse)
-     )
+ 	open func didUpdate(_ streamVideo: StreamVideo?)
- 	open func provider(
+ 
-         _ provider: CXProvider,
+ extension CallKitService : InjectionKey
-         perform action: CXEndCallAction
+ 	public static var currentValue: CallKitService
-     )
+ 
- 	open func provider(
+ extension InjectedValues
-         _ provider: CXProvider,
+ 	public var callKitService: CallKitService
-         perform action: CXSetMutedCallAction
+ 
-     )
+ public enum CallSettingsStatus : String, Sendable
- 	open func requestTransaction(
+ 	case enabled
-         _ action: CXAction
+ 	case disabled
-     ) async throws
+ 
- 	open func checkIfCallWasHandled(callState: GetCallResponse) -> Bool
+ public final class CameraManager : ObservableObject, CallSettingsManager, @unchecked Sendable
- 	open func setUpRingingTimer(for callState: GetCallResponse)
+ 	@Published public internal(set) var status: CallSettingsStatus
- 	open func didUpdate(_ streamVideo: StreamVideo?)
+ 	@Published public internal(set) var direction: CameraPosition
- 
+ 	public func toggle() async throws
- extension CallKitService : InjectionKey
+ 	public func flip() async throws
- 	public static var currentValue: CallKitService
+ 	public func enable() async throws
- 
+ 	public func disable() async throws
- extension InjectedValues
+ 
- 	public var callKitService: CallKitService
+ public final class MicrophoneManager : ObservableObject, CallSettingsManager, @unchecked Sendable
- 
+ 	@Published public internal(set) var status: CallSettingsStatus
- public enum CallSettingsStatus : String, Sendable
+ 	public func toggle() async throws
- 	case enabled
+ 	public func enable() async throws
- 	case disabled
+ 	public func disable() async throws
- public final class CameraManager : ObservableObject, CallSettingsManager, @unchecked Sendable
+ public final class SpeakerManager : ObservableObject, CallSettingsManager, @unchecked Sendable
- 	@Published public internal(set) var direction: CameraPosition
+ 	@Published public internal(set) var audioOutputStatus: CallSettingsStatus
- 	public func toggle() async throws
+ 	public func toggleSpeakerPhone() async throws
- 	public func flip() async throws
+ 	public func enableSpeakerPhone() async throws
- 	public func enable() async throws
+ 	public func disableSpeakerPhone() async throws
- 	public func disable() async throws
+ 	public func enableAudioOutput() async throws
- 
+ 	public func disableAudioOutput() async throws
- public final class MicrophoneManager : ObservableObject, CallSettingsManager, @unchecked Sendable
+ 
- 	@Published public internal(set) var status: CallSettingsStatus
+ public struct PermissionRequest : @unchecked Sendable, Identifiable
- 	public func toggle() async throws
+ 	public let id: UUID
- 	public func enable() async throws
+ 	public let permission: String
- 	public func disable() async throws
+ 	public let user: User
- 
+ 	public let requestedAt: Date
- public final class SpeakerManager : ObservableObject, CallSettingsManager, @unchecked Sendable
+ 	public init(
- 	@Published public internal(set) var status: CallSettingsStatus
+         permission: String,
- 	@Published public internal(set) var audioOutputStatus: CallSettingsStatus
+         user: User,
- 	public func toggleSpeakerPhone() async throws
+         requestedAt: Date,
- 	public func enableSpeakerPhone() async throws
+         onReject: @escaping (PermissionRequest) -> Void = { _ in }
- 	public func disableSpeakerPhone() async throws
+     )
- 	public func enableAudioOutput() async throws
+ 	public func reject()
- 	public func disableAudioOutput() async throws
+ 
- 
+ @MainActor public class CallState : ObservableObject
- public struct PermissionRequest : @unchecked Sendable, Identifiable
+ 	@Published public internal(set) var sessionId: String
- 	public let id: UUID
+ 	@Published public internal(set) var participants
- 	public let permission: String
+ 	@Published public internal(set) var participantsMap
- 	public let user: User
+ 	@Published public internal(set) var localParticipant: CallParticipant?
- 	public let requestedAt: Date
+ 	@Published public internal(set) var dominantSpeaker: CallParticipant?
- 	public init(
+ 	@Published public internal(set) var remoteParticipants: [CallParticipant]
-         permission: String,
+ 	@Published public internal(set) var activeSpeakers: [CallParticipant]
-         user: User,
+ 	@Published public internal(set) var members: [Member]
-         requestedAt: Date,
+ 	@Published public internal(set) var screenSharingSession: ScreenSharingSession?
-         onReject: @escaping (PermissionRequest) -> Void = { _ in }
+ 	@Published public internal(set) var recordingState: RecordingState
-     )
+ 	@Published public internal(set) var blockedUserIds: Set<String>
- 	public func reject()
+ 	@Published public internal(set) var settings: CallSettingsResponse?
- 
+ 	@Published public internal(set) var ownCapabilities: [OwnCapability]
- @MainActor public class CallState : ObservableObject
+ 	@Published public internal(set) var capabilitiesByRole: [String: [String]]
- 	@Published public internal(set) var sessionId: String
+ 	@Published public internal(set) var backstage: Bool
- 	@Published public internal(set) var participants
+ 	@Published public internal(set) var broadcasting: Bool
- 	@Published public internal(set) var participantsMap
+ 	@Published public internal(set) var createdAt: Date
- 	@Published public internal(set) var localParticipant: CallParticipant?
+ 	@Published public internal(set) var updatedAt: Date
- 	@Published public internal(set) var dominantSpeaker: CallParticipant?
+ 	@Published public internal(set) var startsAt: Date?
- 	@Published public internal(set) var remoteParticipants: [CallParticipant]
+ 	@Published public internal(set) var startedAt: Date?
- 	@Published public internal(set) var activeSpeakers: [CallParticipant]
+ 	@Published public internal(set) var endedAt: Date?
- 	@Published public internal(set) var members: [Member]
+ 	@Published public internal(set) var endedBy: User?
- 	@Published public internal(set) var screenSharingSession: ScreenSharingSession?
+ 	@Published public internal(set) var custom: [String: RawJSON]
- 	@Published public internal(set) var recordingState: RecordingState
+ 	@Published public internal(set) var team: String?
- 	@Published public internal(set) var blockedUserIds: Set<String>
+ 	@Published public internal(set) var createdBy: User?
- 	@Published public internal(set) var settings: CallSettingsResponse?
+ 	@Published public internal(set) var ingress: Ingress?
- 	@Published public internal(set) var ownCapabilities: [OwnCapability]
+ 	@Published public internal(set) var permissionRequests: [PermissionRequest]
- 	@Published public internal(set) var capabilitiesByRole: [String: [String]]
+ 	@Published public internal(set) var transcribing: Bool
- 	@Published public internal(set) var backstage: Bool
+ 	@Published public internal(set) var captioning: Bool
- 	@Published public internal(set) var broadcasting: Bool
+ 	@Published public internal(set) var egress: EgressResponse?
- 	@Published public internal(set) var createdAt: Date
+ 	@Published public internal(set) var session: CallSessionResponse?
- 	@Published public internal(set) var updatedAt: Date
+ 	@Published public internal(set) var reconnectionStatus
- 	@Published public internal(set) var startsAt: Date?
+ 	@Published public internal(set) var anonymousParticipantCount: UInt32
- 	@Published public internal(set) var startedAt: Date?
+ 	@Published public internal(set) var participantCount: UInt32
- 	@Published public internal(set) var endedAt: Date?
+ 	@Published public internal(set) var isInitialized: Bool
- 	@Published public internal(set) var endedBy: User?
+ 	@Published public internal(set) var callSettings
- 	@Published public internal(set) var custom: [String: RawJSON]
+ 	@Published public internal(set) var isCurrentUserScreensharing: Bool
- 	@Published public internal(set) var team: String?
+ 	@Published public internal(set) var duration: TimeInterval
- 	@Published public internal(set) var createdBy: User?
+ 	@Published public internal(set) var statsReport: CallStatsReport?
- 	@Published public internal(set) var ingress: Ingress?
+ 	@Published public internal(set) var closedCaptions: [CallClosedCaption]
- 	@Published public internal(set) var permissionRequests: [PermissionRequest]
+ 	@Published public internal(set) var statsCollectionInterval: Int
- 	@Published public internal(set) var transcribing: Bool
+ 	@Published public internal(set) var incomingVideoQualitySettings: IncomingVideoQualitySettings
- 	@Published public internal(set) var captioning: Bool
+ 	@Published public internal(set) var disconnectionError: Error?
- 	@Published public internal(set) var egress: EgressResponse?
+ 
- 	@Published public internal(set) var session: CallSessionResponse?
+ public class CallsController : ObservableObject, @unchecked Sendable
- 	@Published public internal(set) var reconnectionStatus
+ 	@Published public var calls
- 	@Published public internal(set) var anonymousParticipantCount: UInt32
+ 	public func loadNextCalls() async throws
- 	@Published public internal(set) var participantCount: UInt32
+ 	public func cleanUp()
- 	@Published public internal(set) var isInitialized: Bool
+ 
- 	@Published public internal(set) var callSettings
+ public protocol InjectionKey
- 	@Published public internal(set) var isCurrentUserScreensharing: Bool
+ 	static var currentValue: Self.Value
- 	@Published public internal(set) var duration: TimeInterval
+ 
- 	@Published public internal(set) var statsReport: CallStatsReport?
+ public struct InjectedValues
- 	@Published public internal(set) var closedCaptions: [CallClosedCaption]
+ 	public static subscript<K>(key: K.Type) -> K.Value where K: InjectionKey
- 	@Published public internal(set) var statsCollectionInterval: Int
+ 
- 	@Published public internal(set) var incomingVideoQualitySettings: IncomingVideoQualitySettings
+ @propertyWrapper public struct Injected
- 	@Published public internal(set) var disconnectionError: Error?
+ 	public var wrappedValue: T
- 
+ 	public init(_ keyPath: WritableKeyPath<InjectedValues, T>)
- public extension Array
+ 
- 	func sorted(by comparators: StreamSortComparator<CallParticipant>...) -> [CallParticipant]
+ extension InjectedValues
- 
+ 	public var streamVideo: StreamVideo
- public class CallsController : ObservableObject, @unchecked Sendable
+ 
- 	@Published public var calls
+ public struct ErrorPayload : LocalizedError, Codable, CustomDebugStringConvertible, Equatable
- 	public func loadNextCalls() async throws
+ 	public let code: Int
- 	public func cleanUp()
+ 	public let message: String
- 
+ 	public let statusCode: Int
- public protocol InjectionKey
+ 	public var errorDescription: String?
- 	static var currentValue: Self.Value
+ 	public var debugDescription: String
- public struct InjectedValues
+ public class ClientError : Error, ReflectiveStringConvertible
- 	public static subscript<K>(key: K.Type) -> K.Value where K: InjectionKey
+ 	public struct Location : Equatable
- 
+ 		public let file: String
- @propertyWrapper public struct Injected
+ 		public let line: Int
- 	public var wrappedValue: T
+ 	public let location: Location?
- 	public init(_ keyPath: WritableKeyPath<InjectedValues, T>)
+ 	public let underlyingError: Error?
- 
+ 	public let apiError: APIError?
- extension InjectedValues
+ 	public var localizedDescription: String
- 	public var streamVideo: StreamVideo
+ 	public init(with error: Error? = nil, _ file: StaticString = #fileID, _ line: UInt = #line)
- 
+ 	public init(_ message: String, _ file: StaticString = #fileID, _ line: UInt = #line)
- public struct ErrorPayload : LocalizedError, Codable, CustomDebugStringConvertible, Equatable
+ 
- 	public let code: Int
+ extension ClientError : Equatable
- 	public let message: String
+ 	public static func == (lhs: ClientError, rhs: ClientError) -> Bool
- 	public let statusCode: Int
+ 
- 	public var errorDescription: String?
+ extension SystemEnvironment
- 	public var debugDescription: String
+ 	public static let version: String
- 
+ 	public static let webRTCVersion: String
- public class ClientError : Error, ReflectiveStringConvertible
+ 
- 	public struct Location : Equatable
+ public enum AudioCodec : String, CustomStringConvertible, Sendable
- 		public let file: String
+ 	case opus
- 		public let line: Int
+ 	case red
- 	public let location: Location?
+ 	case unknown
- 	public let underlyingError: Error?
+ 	public var description: String
- 	public let apiError: APIError?
+ 
- 	public var localizedDescription: String
+ public struct CallParticipant : Identifiable, Sendable, Hashable
- 	public init(with error: Error? = nil, _ file: StaticString = #fileID, _ line: UInt = #line)
+ 	public var user: User
- 	public init(_ message: String, _ file: StaticString = #fileID, _ line: UInt = #line)
+ 	public var id: String
- 
+ 	public let roles: [String]
- extension ClientError : Equatable
+ 	public var trackLookupPrefix: String?
- 	public static func == (lhs: ClientError, rhs: ClientError) -> Bool
+ 	public var hasVideo: Bool
- 
+ 	public var hasAudio: Bool
- extension SystemEnvironment
+ 	public var isScreensharing: Bool
- 	public static let version: String
+ 	public var track: RTCVideoTrack?
- 	public static let webRTCVersion: String
+ 	public var trackSize: CGSize
- 
+ 	public var screenshareTrack: RTCVideoTrack?
- public enum AudioCodec : String, CustomStringConvertible, Sendable
+ 	public var showTrack: Bool
- 	case opus
+ 	public var isSpeaking: Bool
- 	case red
+ 	public var isDominantSpeaker: Bool
- 	case unknown
+ 	public var sessionId: String
- 	public var description: String
+ 	public var connectionQuality: ConnectionQuality
- 
+ 	public var joinedAt: Date
- public struct CallParticipant : Identifiable, Sendable, Hashable
+ 	public var audioLevel: Float
- 	public var user: User
+ 	public var audioLevels: [Float]
- 	public var id: String
+ 	public var pin: PinInfo?
- 	public let roles: [String]
+ 	public var userId: String
- 	public var trackLookupPrefix: String?
+ 	public var name: String
- 	public var hasVideo: Bool
+ 	public var profileImageURL: URL?
- 	public var hasAudio: Bool
+ 	public init(
- 	public var isScreensharing: Bool
+         id: String,
- 	public var track: RTCVideoTrack?
+         userId: String,
- 	public var trackSize: CGSize
+         roles: [String],
- 	public var screenshareTrack: RTCVideoTrack?
+         name: String,
- 	public var showTrack: Bool
+         profileImageURL: URL?,
- 	public var isSpeaking: Bool
+         trackLookupPrefix: String?,
- 	public var isDominantSpeaker: Bool
+         hasVideo: Bool,
- 	public var sessionId: String
+         hasAudio: Bool,
- 	public var connectionQuality: ConnectionQuality
+         isScreenSharing: Bool,
- 	public var joinedAt: Date
+         showTrack: Bool,
- 	public var audioLevel: Float
+         track: RTCVideoTrack? = nil,
- 	public var audioLevels: [Float]
+         trackSize: CGSize = CGSize(width: 1024, height: 720),
- 	public var pin: PinInfo?
+         screenshareTrack: RTCVideoTrack? = nil,
- 	public var userId: String
+         isSpeaking: Bool = false,
- 	public var name: String
+         isDominantSpeaker: Bool,
- 	public var profileImageURL: URL?
+         sessionId: String,
- 	public init(
+         connectionQuality: ConnectionQuality,
-         id: String,
+         joinedAt: Date,
-         userId: String,
+         audioLevel: Float,
-         roles: [String],
+         audioLevels: [Float],
-         name: String,
+         pin: PinInfo?
-         profileImageURL: URL?,
+     )
-         trackLookupPrefix: String?,
+ 	public static func == (lhs: CallParticipant, rhs: CallParticipant) -> Bool
-         hasVideo: Bool,
+ 	public var isPinned: Bool
-         hasAudio: Bool,
+ 	public var isPinnedRemotely: Bool
-         isScreenSharing: Bool,
+ 	public var shouldDisplayTrack: Bool
-         showTrack: Bool,
+ 	public func withUpdated(trackSize: CGSize) -> CallParticipant
-         track: RTCVideoTrack? = nil,
+ 	public func withUpdated(track: RTCVideoTrack?) -> CallParticipant
-         trackSize: CGSize = CGSize(width: 1024, height: 720),
+ 	public func withUpdated(screensharingTrack: RTCVideoTrack?) -> CallParticipant
-         screenshareTrack: RTCVideoTrack? = nil,
+ 	public func withUpdated(audio: Bool) -> CallParticipant
-         isSpeaking: Bool = false,
+ 	public func withUpdated(video: Bool) -> CallParticipant
-         isDominantSpeaker: Bool,
+ 	public func withUpdated(screensharing: Bool) -> CallParticipant
-         sessionId: String,
+ 	public func withUpdated(showTrack: Bool) -> CallParticipant
-         connectionQuality: ConnectionQuality,
+ 	public func withUpdated(trackLookupPrefix: String) -> CallParticipant
-         joinedAt: Date,
+ 	public func withUpdated(
-         audioLevel: Float,
+         isSpeaking: Bool,
-         audioLevels: [Float],
+         audioLevel: Float
-         pin: PinInfo?
+     ) -> CallParticipant
-     )
+ 	public func withUpdated(dominantSpeaker: Bool) -> CallParticipant
- 	public static func == (lhs: CallParticipant, rhs: CallParticipant) -> Bool
+ 	public func withUpdated(connectionQuality: ConnectionQuality) -> CallParticipant
- 	public var isPinned: Bool
+ 	public func withUpdated(pin: PinInfo?) -> CallParticipant
- 	public var isPinnedRemotely: Bool
+ 
- 	public var shouldDisplayTrack: Bool
+ public struct PinInfo : Sendable, Hashable
- 	public func withUpdated(trackSize: CGSize) -> CallParticipant
+ 	public let isLocal: Bool
- 	public func withUpdated(track: RTCVideoTrack?) -> CallParticipant
+ 	public let pinnedAt: Date
- 	public func withUpdated(screensharingTrack: RTCVideoTrack?) -> CallParticipant
+ 
- 	public func withUpdated(audio: Bool) -> CallParticipant
+ extension CGSize : Hashable
- 	public func withUpdated(video: Bool) -> CallParticipant
+ 	public func hash(into hasher: inout Hasher)
- 	public func withUpdated(screensharing: Bool) -> CallParticipant
+ 
- 	public func withUpdated(showTrack: Bool) -> CallParticipant
+ public final class CallSettings : ObservableObject, Sendable, Equatable, ReflectiveStringConvertible
- 	public func withUpdated(trackLookupPrefix: String) -> CallParticipant
+ 	public let audioOn: Bool
- 	public func withUpdated(
+ 	public let videoOn: Bool
-         isSpeaking: Bool,
+ 	public let speakerOn: Bool
-         audioLevel: Float
+ 	public let audioOutputOn: Bool
-     ) -> CallParticipant
+ 	public let cameraPosition: CameraPosition
- 	public func withUpdated(dominantSpeaker: Bool) -> CallParticipant
+ 	public init(
- 	public func withUpdated(connectionQuality: ConnectionQuality) -> CallParticipant
+         audioOn: Bool = true,
- 	public func withUpdated(pin: PinInfo?) -> CallParticipant
+         videoOn: Bool = true,
- 
+         speakerOn: Bool = true,
- public struct PinInfo : Sendable, Hashable
+         audioOutputOn: Bool = true,
- 	public let isLocal: Bool
+         cameraPosition: CameraPosition = .front
- 	public let pinnedAt: Date
+     )
- 
+ 	public static func == (lhs: CallSettings, rhs: CallSettings) -> Bool
- extension CGSize : Hashable
+ 	public var shouldPublish: Bool
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public enum CameraPosition : Sendable, Equatable
- public final class CallSettings : ObservableObject, Sendable, Equatable, ReflectiveStringConvertible
+ 	case front
- 	public let audioOn: Bool
+ 	case back
- 	public let videoOn: Bool
+ 	public func next() -> CameraPosition
- 	public let speakerOn: Bool
+ 
- 	public let audioOutputOn: Bool
+ extension CallSettingsResponse
- 	public let cameraPosition: CameraPosition
+ 	public var toCallSettings: CallSettings
- 	public init(
+ 
-         audioOn: Bool = true,
+ public extension CallSettings
-         videoOn: Bool = true,
+ 	func withUpdatedCameraPosition(_ cameraPosition: CameraPosition) -> CallSettings
-         speakerOn: Bool = true,
+ 	func withUpdatedAudioState(_ audioOn: Bool) -> CallSettings
-         audioOutputOn: Bool = true,
+ 	func withUpdatedVideoState(_ videoOn: Bool) -> CallSettings
-         cameraPosition: CameraPosition = .front
+ 	func withUpdatedSpeakerState(_ speakerOn: Bool) -> CallSettings
-     )
+ 	func withUpdatedAudioOutputState(_ audioOutputOn: Bool) -> CallSettings
- 	public static func == (lhs: CallSettings, rhs: CallSettings) -> Bool
+ 
- 	public var shouldPublish: Bool
+ public struct CallStatsReport : Sendable
- 
+ 	public let datacenter: String
- public enum CameraPosition : Sendable, Equatable
+ 	public let publisherStats: AggregatedStatsReport
- 	case front
+ 	public let publisherRawStats: RTCStatisticsReport?
- 	case back
+ 	public let publisherBaseStats: [BaseStats]
- 	public func next() -> CameraPosition
+ 	public let subscriberStats: AggregatedStatsReport
- 
+ 	public let subscriberRawStats: RTCStatisticsReport?
- extension CallSettingsResponse
+ 	public let participantsStats: ParticipantsStats
- 	public var toCallSettings: CallSettings
+ 	public let timestamp: Double
- public extension CallSettings
+ public struct ParticipantsStats : Sendable, Equatable
- 	func withUpdatedCameraPosition(_ cameraPosition: CameraPosition) -> CallSettings
+ 	public let report: [String: [BaseStats]]
- 	func withUpdatedAudioState(_ audioOn: Bool) -> CallSettings
+ 	public static func + (
- 	func withUpdatedVideoState(_ videoOn: Bool) -> CallSettings
+         lhs: ParticipantsStats,
- 	func withUpdatedSpeakerState(_ speakerOn: Bool) -> CallSettings
+         rhs: ParticipantsStats
- 	func withUpdatedAudioOutputState(_ audioOutputOn: Bool) -> CallSettings
+     ) -> ParticipantsStats
- public struct CallStatsReport : Sendable
+ public struct BaseStats : Sendable, Equatable
- 	public let datacenter: String
+ 	public let bytesSent: Int
- 	public let publisherStats: AggregatedStatsReport
+ 	public let bytesReceived: Int
- 	public let publisherRawStats: RTCStatisticsReport?
+ 	public let codec: String
- 	public let publisherBaseStats: [BaseStats]
+ 	public let currentRoundTripTime: Double
- 	public let subscriberStats: AggregatedStatsReport
+ 	public let frameWidth: Int
- 	public let subscriberRawStats: RTCStatisticsReport?
+ 	public let frameHeight: Int
- 	public let participantsStats: ParticipantsStats
+ 	public let framesPerSecond: Int
- 	public let timestamp: Double
+ 	public let jitter: Double
- 
+ 	public let kind: String
- public struct ParticipantsStats : Sendable, Equatable
+ 	public let qualityLimitationReason: String
- 	public let report: [String: [BaseStats]]
+ 	public let rid: String
- 	public static func + (
+ 	public let ssrc: Int
-         lhs: ParticipantsStats,
+ 	public let isPublisher: Bool
-         rhs: ParticipantsStats
+ 
-     ) -> ParticipantsStats
+ public struct AggregatedStatsReport : Sendable, Equatable
- 
+ 	public internal(set) var totalBytesSent: Int
- public struct BaseStats : Sendable, Equatable
+ 	public internal(set) var totalBytesReceived: Int
- 	public let bytesSent: Int
+ 	public internal(set) var averageJitterInMs: Double
- 	public let bytesReceived: Int
+ 	public internal(set) var averageRoundTripTimeInMs: Double
- 	public let codec: String
+ 	public internal(set) var qualityLimitationReasons: String
- 	public let currentRoundTripTime: Double
+ 	public internal(set) var highestFrameWidth: Int
- 	public let frameWidth: Int
+ 	public internal(set) var highestFrameHeight: Int
- 	public let frameHeight: Int
+ 	public internal(set) var highestFramesPerSecond: Int
- 	public let framesPerSecond: Int
+ 	public internal(set) var timestamp: Double
- 	public let jitter: Double
+ 
- 	public let kind: String
+ extension String
- 	public let qualityLimitationReason: String
+ 	public static let `default`: Self
- 	public let rid: String
+ 	public static let development: Self
- 	public let ssrc: Int
+ 	public static let audioRoom: Self
- 	public let isPublisher: Bool
+ 	public static let livestream: Self
- public struct AggregatedStatsReport : Sendable, Equatable
+ public struct CallsQuery
- 	public internal(set) var totalBytesSent: Int
+ 	public let pageSize: Int
- 	public internal(set) var totalBytesReceived: Int
+ 	public let sortParams: [CallSortParam]
- 	public internal(set) var averageJitterInMs: Double
+ 	public let filters: [String: RawJSON]?
- 	public internal(set) var averageRoundTripTimeInMs: Double
+ 	public let watch: Bool
- 	public internal(set) var qualityLimitationReasons: String
+ 	public init(
- 	public internal(set) var highestFrameWidth: Int
+         pageSize: Int = 25,
- 	public internal(set) var highestFrameHeight: Int
+         sortParams: [CallSortParam],
- 	public internal(set) var highestFramesPerSecond: Int
+         filters: [String: RawJSON]? = nil,
- 	public internal(set) var timestamp: Double
+         watch: Bool
- 
+     )
- extension String
+ 
- 	public static let `default`: Self
+ public struct CallSortParam
- 	public static let development: Self
+ 	public let direction: CallSortDirection
- 	public static let audioRoom: Self
+ 	public let field: CallSortField
- 	public static let livestream: Self
+ 	public init(direction: CallSortDirection, field: CallSortField)
- public struct CallsQuery
+ public enum CallSortDirection : Int
- 	public let pageSize: Int
+ 	case ascending = 1
- 	public let sortParams: [CallSortParam]
+ 	case descending = -1
- 	public let filters: [String: RawJSON]?
+ 
- 	public let watch: Bool
+ public struct CallSortField : RawRepresentable, Codable, Hashable, ExpressibleByStringLiteral
- 	public init(
+ 	public let rawValue: String
-         pageSize: Int = 25,
+ 	public init(rawValue: String)
-         sortParams: [CallSortParam],
+ 	public init(stringLiteral value: String)
-         filters: [String: RawJSON]? = nil,
+ 
-         watch: Bool
+ public extension CallSortField
-     )
+ 	static let startsAt: Self
- 
+ 	static let createdAt: Self
- public struct CallSortParam
+ 	static let updatedAt: Self
- 	public let direction: CallSortDirection
+ 	static let endedAt: Self
- 	public let field: CallSortField
+ 	static let type: Self
- 	public init(direction: CallSortDirection, field: CallSortField)
+ 	static let id: Self
- 
+ 	static let cid: Self
- public enum CallSortDirection : Int
+ 
- 	case ascending = 1
+ public extension SortParamRequest
- 	case descending = -1
+ 	static func ascending(_ field: String) -> SortParamRequest
- 
+ 	static func descending(_ field: String) -> SortParamRequest
- public struct CallSortField : RawRepresentable, Codable, Hashable, ExpressibleByStringLiteral
+ 
- 	public let rawValue: String
+ public struct ConnectOptions : Sendable
- 	public init(rawValue: String)
+ 	public init(iceServers: [ICEServer])
- 	public init(stringLiteral value: String)
+ 
- 
+ public enum ConnectionQuality : Hashable, Sendable
- public extension CallSortField
+ 	case unknown
- 	static let startsAt: Self
+ 	case poor
- 	static let createdAt: Self
+ 	case good
- 	static let updatedAt: Self
+ 	case excellent
- 	static let endedAt: Self
+ 
- 	static let type: Self
+ public enum ConnectionState : Equatable, Sendable
- 	static let id: Self
+ 	case disconnected(reason: DisconnectionReason? = nil)
- 	static let cid: Self
+ 	case connecting
- 
+ 	case reconnecting
- public extension SortParamRequest
+ 	case connected
- 	static func ascending(_ field: String) -> SortParamRequest
+ 
- 	static func descending(_ field: String) -> SortParamRequest
+ public enum DisconnectionReason : Equatable, Sendable
- 
+ 	public static func == (lhs: DisconnectionReason, rhs: DisconnectionReason) -> Bool
- public struct ConnectOptions : Sendable
+ 	case user
- 	public init(iceServers: [ICEServer])
+ 	case networkError(_ error: Error)
- public enum ConnectionQuality : Hashable, Sendable
+ public enum ReconnectionStatus : Sendable
- 	case unknown
+ 	case connected
- 	case poor
+ 	case reconnecting
- 	case good
+ 	case migrating
- 	case excellent
+ 	case disconnected
- public enum ConnectionState : Equatable, Sendable
+ public struct FetchingLocationError : Error
- 	case disconnected(reason: DisconnectionReason? = nil)
+ 
- 	case connecting
+ 
- 	case reconnecting
+ public enum RecordingState
- 	case connected
+ 	case noRecording
- 
+ 	case requested
- public enum DisconnectionReason : Equatable, Sendable
+ 	case recording
- 	public static func == (lhs: DisconnectionReason, rhs: DisconnectionReason) -> Bool
+ 
- 	case user
+ public struct CreateCallOptions : Sendable
- 	case networkError(_ error: Error)
+ 	public var memberIds: [String]?
- 
+ 	public var members: [MemberRequest]?
- public enum ReconnectionStatus : Sendable
+ 	public var custom: [String: RawJSON]?
- 	case connected
+ 	public var settings: CallSettingsRequest?
- 	case reconnecting
+ 	public var startsAt: Date?
- 	case migrating
+ 	public var team: String?
- 	case disconnected
+ 	public init(
- 
+         memberIds: [String]? = nil,
- public struct FetchingLocationError : Error
+         members: [MemberRequest]? = nil,
- 
+         custom: [String: RawJSON]? = nil,
- 
+         settings: CallSettingsRequest? = nil,
- public enum RecordingState
+         startsAt: Date? = nil,
- 	case noRecording
+         team: String? = nil
- 	case requested
+     )
- 	case recording
+ 
- 
+ public struct Ingress
- public struct CreateCallOptions : Sendable
+ 	public let rtmp: RTMP
- 	public var memberIds: [String]?
+ 
- 	public var members: [MemberRequest]?
+ public struct RTMP
- 	public var custom: [String: RawJSON]?
+ 	public let address: String
- 	public var settings: CallSettingsRequest?
+ 	public let streamKey: String
- 	public var startsAt: Date?
+ 
- 	public var team: String?
+ public struct PushNotificationsProvider : RawRepresentable, Hashable, ExpressibleByStringLiteral, Sendable
- 	public init(
+ 	public static let firebase: Self
-         memberIds: [String]? = nil,
+ 	public static let apn: Self
-         members: [MemberRequest]? = nil,
+ 	public let rawValue: String
-         custom: [String: RawJSON]? = nil,
+ 	public init(rawValue: String)
-         settings: CallSettingsRequest? = nil,
+ 	public init(stringLiteral value: String)
-         startsAt: Date? = nil,
+ 
-         team: String? = nil
+ public enum IncomingVideoQualitySettings : CustomStringConvertible, Equatable, Sendable
-     )
+ 	public enum Group : CustomStringConvertible, Equatable, Sendable
- 
+ 		case all
- public struct Ingress
+ 		case custom(sessionIds: Set<String>)
- 	public let rtmp: RTMP
+ 		public var description: String
- 
+ 	case none
- public struct RTMP
+ 	case manual(group: Group, targetSize: CGSize)
- 	public let address: String
+ 	case disabled(group: Group)
- 	public let streamKey: String
+ 	public var description: String
- public struct PushNotificationsProvider : RawRepresentable, Hashable, ExpressibleByStringLiteral, Sendable
+ public struct Member : Identifiable, Equatable, Sendable, Codable
- 	public static let firebase: Self
+ 	public var id: String
- 	public static let apn: Self
+ 	public let user: User
- 	public let rawValue: String
+ 	public let role: String
- 	public init(rawValue: String)
+ 	public let customData: [String: RawJSON]
- 	public init(stringLiteral value: String)
+ 	public let updatedAt: Date?
- 
+ 	public init(user: User, role: String? = nil, customData: [String: RawJSON] = [:], updatedAt: Date? = nil)
- public enum IncomingVideoQualitySettings : CustomStringConvertible, Equatable, Sendable
+ 	public init(userId: String, role: String? = nil, customData: [String: RawJSON] = [:], updatedAt: Date? = nil)
- 	public enum Group : CustomStringConvertible, Equatable, Sendable
+ 
- 		case all
+ public extension MemberResponse
- 		case custom(sessionIds: Set<String>)
+ 	var toMember: Member
- 		public var description: String
+ 
- 	case none
+ public extension Member
- 	case manual(group: Group, targetSize: CGSize)
+ 	var toMemberRequest: MemberRequest
- 	case disabled(group: Group)
+ 
- 	public var description: String
+ public extension MemberRequest
- 
+ 	var toMember: Member
- public struct Member : Identifiable, Equatable, Sendable, Codable
+ 
- 	public var id: String
+ public struct Permission : Sendable, RawRepresentable, Codable, Hashable, ExpressibleByStringLiteral
- 	public let user: User
+ 	public let rawValue: String
- 	public let role: String
+ 	public init(rawValue: String)
- 	public let customData: [String: RawJSON]
+ 	public init(stringLiteral value: String)
- 	public let updatedAt: Date?
+ 
- 	public init(user: User, role: String? = nil, customData: [String: RawJSON] = [:], updatedAt: Date? = nil)
+ public extension Permission
- 	public init(userId: String, role: String? = nil, customData: [String: RawJSON] = [:], updatedAt: Date? = nil)
+ 	static let sendAudio: Self
- 
+ 	static let sendVideo: Self
- public extension MemberResponse
+ 	static let screenshare: Self
- 	var toMember: Member
+ 
- 
+ public struct PushNotificationsConfig : Sendable, Equatable
- public extension Member
+ 	public let pushProviderInfo: PushProviderInfo
- 	var toMemberRequest: MemberRequest
+ 	public let voipPushProviderInfo: PushProviderInfo
- 
+ 	public init(pushProviderInfo: PushProviderInfo, voipPushProviderInfo: PushProviderInfo)
- public extension MemberRequest
+ 
- 	var toMember: Member
+ public extension PushNotificationsConfig
- 
+ 	static let `default`
- public struct Permission : Sendable, RawRepresentable, Codable, Hashable, ExpressibleByStringLiteral
+ 	static func make(pushProviderName: String, voipProviderName: String) -> PushNotificationsConfig
- 	public let rawValue: String
+ 
- 	public init(rawValue: String)
+ public struct PushProviderInfo : Sendable, Equatable
- 	public init(stringLiteral value: String)
+ 	public let name: String
- 
+ 	public let pushProvider: PushNotificationsProvider
- public extension Permission
+ 	public init(name: String, pushProvider: PushNotificationsProvider)
- 	static let sendAudio: Self
+ 
- 	static let sendVideo: Self
+ public struct ScreenSharingSession
- 	static let screenshare: Self
+ 	public let track: RTCVideoTrack?
- 
+ 	public let participant: CallParticipant
- public struct PushNotificationsConfig : Sendable, Equatable
+ 
- 	public let pushProviderInfo: PushProviderInfo
+ public enum ScreensharingType : Sendable
- 	public let voipPushProviderInfo: PushProviderInfo
+ 	case inApp
- 	public init(pushProviderInfo: PushProviderInfo, voipPushProviderInfo: PushProviderInfo)
+ 	case broadcast
- public extension PushNotificationsConfig
+ public struct UserToken : Codable, Equatable, ExpressibleByStringLiteral, Sendable
- 	static let `default`
+ 	public let rawValue: String
- 	static func make(pushProviderName: String, voipProviderName: String) -> PushNotificationsConfig
+ 	public init(stringLiteral value: StringLiteralType)
- 
+ 	public init(rawValue: String)
- public struct PushProviderInfo : Sendable, Equatable
+ 	public init(from decoder: Decoder) throws
- 	public let name: String
+ 
- 	public let pushProvider: PushNotificationsProvider
+ public extension UserToken
- 	public init(name: String, pushProvider: PushNotificationsProvider)
+ 	static let empty
- public struct ScreenSharingSession
+ public struct User : Identifiable, Hashable, Sendable, Codable
- 	public let track: RTCVideoTrack?
+ 	public let id: String
- 	public let participant: CallParticipant
+ 	public let imageURL: URL?
- 
+ 	public let role: String
- public enum ScreensharingType : Sendable
+ 	public let type: UserAuthType
- 	case inApp
+ 	public let customData: [String: RawJSON]
- 	case broadcast
+ 	public let originalName: String?
- 
+ 	public var name: String
- public struct UserToken : Codable, Equatable, ExpressibleByStringLiteral, Sendable
+ 	public init(
- 	public let rawValue: String
+         id: String,
- 	public init(stringLiteral value: StringLiteralType)
+         name: String? = nil,
- 	public init(rawValue: String)
+         imageURL: URL? = nil,
- 	public init(from decoder: Decoder) throws
+         role: String = "user",
- 
+         customData: [String: RawJSON] = [:]
- public extension UserToken
+     )
- 	static let empty
+ 
- 
+ public extension User
- public struct User : Identifiable, Hashable, Sendable, Codable
+ 	static func guest(_ userId: String) -> User
- 	public let id: String
+ 	static var anonymous: User
- 	public let imageURL: URL?
+ 
- 	public let role: String
+ public extension UserResponse
- 	public let type: UserAuthType
+ 	static func make(from id: String) -> UserResponse
- 	public let customData: [String: RawJSON]
+ 
- 	public let originalName: String?
+ public enum UserAuthType : Sendable, Codable, Hashable
- 	public var name: String
+ 	case regular
- 	public init(
+ 	case anonymous
-         id: String,
+ 	case guest
-         name: String? = nil,
+ 
-         imageURL: URL? = nil,
+ public enum VideoCodec : String, Sendable, Hashable, CustomStringConvertible
-         role: String = "user",
+ 	case unknown
-         customData: [String: RawJSON] = [:]
+ 	case h264
-     )
+ 	case vp8
- 
+ 	case vp9
- public extension User
+ 	case av1
- 	static func guest(_ userId: String) -> User
+ 	public var description: String
- 	static var anonymous: User
+ 
- 
+ extension OwnCapability : Identifiable
- public extension UserResponse
+ 	public var id: String
- 	static func make(from id: String) -> UserResponse
+ 
- 
+ public enum APIHelper
- public enum UserAuthType : Sendable, Codable, Hashable
+ 	public static func rejectNil(_ source: [String: Any?]) -> [String: Any]?
- 	case regular
+ 	public static func rejectNilHeaders(_ source: [String: Any?]) -> [String: String]
- 	case anonymous
+ 	public static func convertBoolToString(_ source: [String: Any]?) -> [String: Any]?
- 	case guest
+ 	public static func convertAnyToString(_ value: Any?) -> String?
- 
+ 	public static func mapValueToPathItem(_ source: Any) -> Any
- public enum VideoCodec : String, Sendable, Hashable, CustomStringConvertible
+ 	public static func mapValuesToQueryItems(_ source: [String: (wrappedValue: Any?, isExplode: Bool)]) -> [URLQueryItem]?
- 	case unknown
+ 	public static func mapValuesToQueryItems(_ source: [String: Any?]) -> [URLQueryItem]?
- 	case h264
+ 
- 	case vp8
+ open class DefaultAPI : DefaultAPIEndpoints, @unchecked Sendable
- 	case vp9
+ 	open func queryCallMembers(queryMembersRequest: QueryMembersRequest) async throws -> QueryMembersResponse
- 	case av1
+ 	open func queryCallStats(queryCallStatsRequest: QueryCallStatsRequest) async throws -> QueryCallStatsResponse
- 	public var description: String
+ 	open func getCall(
- 
+         type: String,
- extension OwnCapability : Identifiable
+         id: String,
- 	public var id: String
+         membersLimit: Int?,
- 
+         ring: Bool?,
- public enum APIHelper
+         notify: Bool?,
- 	public static func rejectNil(_ source: [String: Any?]) -> [String: Any]?
+         video: Bool?
- 	public static func rejectNilHeaders(_ source: [String: Any?]) -> [String: String]
+     ) async throws -> GetCallResponse
- 	public static func convertBoolToString(_ source: [String: Any]?) -> [String: Any]?
+ 	open func updateCall(type: String, id: String, updateCallRequest: UpdateCallRequest) async throws -> UpdateCallResponse
- 	public static func convertAnyToString(_ value: Any?) -> String?
+ 	open func getOrCreateCall(
- 	public static func mapValueToPathItem(_ source: Any) -> Any
+         type: String,
- 	public static func mapValuesToQueryItems(_ source: [String: (wrappedValue: Any?, isExplode: Bool)]) -> [URLQueryItem]?
+         id: String,
- 	public static func mapValuesToQueryItems(_ source: [String: Any?]) -> [URLQueryItem]?
+         getOrCreateCallRequest: GetOrCreateCallRequest
- 
+     ) async throws -> GetOrCreateCallResponse
- open class DefaultAPI : DefaultAPIEndpoints, @unchecked Sendable
+ 	open func acceptCall(type: String, id: String) async throws -> AcceptCallResponse
- 	open func queryCallMembers(queryMembersRequest: QueryMembersRequest) async throws -> QueryMembersResponse
+ 	open func blockUser(type: String, id: String, blockUserRequest: BlockUserRequest) async throws -> BlockUserResponse
- 	open func queryCallStats(queryCallStatsRequest: QueryCallStatsRequest) async throws -> QueryCallStatsResponse
+ 	open func deleteCall(type: String, id: String, deleteCallRequest: DeleteCallRequest) async throws -> DeleteCallResponse
- 	open func getCall(
+ 	open func sendCallEvent(type: String, id: String, sendEventRequest: SendEventRequest) async throws -> SendEventResponse
-         type: String,
+ 	open func collectUserFeedback(
-         id: String,
+         type: String,
-         membersLimit: Int?,
+         id: String,
-         ring: Bool?,
+         session: String,
-         notify: Bool?,
+         collectUserFeedbackRequest: CollectUserFeedbackRequest
-         video: Bool?
+     ) async throws -> CollectUserFeedbackResponse
-     ) async throws -> GetCallResponse
+ 	open func goLive(type: String, id: String, goLiveRequest: GoLiveRequest) async throws -> GoLiveResponse
- 	open func updateCall(type: String, id: String, updateCallRequest: UpdateCallRequest) async throws -> UpdateCallResponse
+ 	open func joinCall(type: String, id: String, joinCallRequest: JoinCallRequest) async throws -> JoinCallResponse
- 	open func getOrCreateCall(
+ 	open func endCall(type: String, id: String) async throws -> EndCallResponse
-         type: String,
+ 	open func updateCallMembers(
-         id: String,
+         type: String,
-         getOrCreateCallRequest: GetOrCreateCallRequest
+         id: String,
-     ) async throws -> GetOrCreateCallResponse
+         updateCallMembersRequest: UpdateCallMembersRequest
- 	open func acceptCall(type: String, id: String) async throws -> AcceptCallResponse
+     ) async throws -> UpdateCallMembersResponse
- 	open func blockUser(type: String, id: String, blockUserRequest: BlockUserRequest) async throws -> BlockUserResponse
+ 	open func muteUsers(type: String, id: String, muteUsersRequest: MuteUsersRequest) async throws -> MuteUsersResponse
- 	open func deleteCall(type: String, id: String, deleteCallRequest: DeleteCallRequest) async throws -> DeleteCallResponse
+ 	open func videoPin(type: String, id: String, pinRequest: PinRequest) async throws -> PinResponse
- 	open func sendCallEvent(type: String, id: String, sendEventRequest: SendEventRequest) async throws -> SendEventResponse
+ 	open func sendVideoReaction(
- 	open func collectUserFeedback(
+         type: String,
-         type: String,
+         id: String,
-         id: String,
+         sendReactionRequest: SendReactionRequest
-         session: String,
+     ) async throws -> SendReactionResponse
-         collectUserFeedbackRequest: CollectUserFeedbackRequest
+ 	open func listRecordings(type: String, id: String) async throws -> ListRecordingsResponse
-     ) async throws -> CollectUserFeedbackResponse
+ 	open func rejectCall(type: String, id: String, rejectCallRequest: RejectCallRequest) async throws -> RejectCallResponse
- 	open func goLive(type: String, id: String, goLiveRequest: GoLiveRequest) async throws -> GoLiveResponse
+ 	open func requestPermission(
- 	open func joinCall(type: String, id: String, joinCallRequest: JoinCallRequest) async throws -> JoinCallResponse
+         type: String,
- 	open func endCall(type: String, id: String) async throws -> EndCallResponse
+         id: String,
- 	open func updateCallMembers(
+         requestPermissionRequest: RequestPermissionRequest
-         type: String,
+     ) async throws -> RequestPermissionResponse
-         id: String,
+ 	open func startRTMPBroadcasts(
-         updateCallMembersRequest: UpdateCallMembersRequest
+         type: String,
-     ) async throws -> UpdateCallMembersResponse
+         id: String,
- 	open func muteUsers(type: String, id: String, muteUsersRequest: MuteUsersRequest) async throws -> MuteUsersResponse
+         startRTMPBroadcastsRequest: StartRTMPBroadcastsRequest
- 	open func videoPin(type: String, id: String, pinRequest: PinRequest) async throws -> PinResponse
+     ) async throws -> StartRTMPBroadcastsResponse
- 	open func sendVideoReaction(
+ 	open func stopAllRTMPBroadcasts(type: String, id: String) async throws -> StopAllRTMPBroadcastsResponse
-         type: String,
+ 	open func stopRTMPBroadcast(type: String, id: String, name: String) async throws -> StopRTMPBroadcastsResponse
-         id: String,
+ 	open func startHLSBroadcasting(type: String, id: String) async throws -> StartHLSBroadcastingResponse
-         sendReactionRequest: SendReactionRequest
+ 	open func startClosedCaptions(
-     ) async throws -> SendReactionResponse
+         type: String,
- 	open func listRecordings(type: String, id: String) async throws -> ListRecordingsResponse
+         id: String,
- 	open func rejectCall(type: String, id: String, rejectCallRequest: RejectCallRequest) async throws -> RejectCallResponse
+         startClosedCaptionsRequest: StartClosedCaptionsRequest
- 	open func requestPermission(
+     ) async throws -> StartClosedCaptionsResponse
-         type: String,
+ 	open func startRecording(
-         id: String,
+         type: String,
-         requestPermissionRequest: RequestPermissionRequest
+         id: String,
-     ) async throws -> RequestPermissionResponse
+         startRecordingRequest: StartRecordingRequest
- 	open func startRTMPBroadcasts(
+     ) async throws -> StartRecordingResponse
-         type: String,
+ 	open func startTranscription(
-         id: String,
+         type: String,
-         startRTMPBroadcastsRequest: StartRTMPBroadcastsRequest
+         id: String,
-     ) async throws -> StartRTMPBroadcastsResponse
+         startTranscriptionRequest: StartTranscriptionRequest
- 	open func stopAllRTMPBroadcasts(type: String, id: String) async throws -> StopAllRTMPBroadcastsResponse
+     ) async throws -> StartTranscriptionResponse
- 	open func stopRTMPBroadcast(type: String, id: String, name: String) async throws -> StopRTMPBroadcastsResponse
+ 	open func getCallStats(type: String, id: String, session: String) async throws -> GetCallStatsResponse
- 	open func startHLSBroadcasting(type: String, id: String) async throws -> StartHLSBroadcastingResponse
+ 	open func stopHLSBroadcasting(type: String, id: String) async throws -> StopHLSBroadcastingResponse
- 	open func startClosedCaptions(
+ 	open func stopClosedCaptions(
-         startClosedCaptionsRequest: StartClosedCaptionsRequest
+         stopClosedCaptionsRequest: StopClosedCaptionsRequest
-     ) async throws -> StartClosedCaptionsResponse
+     ) async throws -> StopClosedCaptionsResponse
- 	open func startRecording(
+ 	open func stopLive(type: String, id: String, stopLiveRequest: StopLiveRequest) async throws -> StopLiveResponse
-         type: String,
+ 	open func stopRecording(type: String, id: String) async throws -> StopRecordingResponse
-         id: String,
+ 	open func stopTranscription(
-         startRecordingRequest: StartRecordingRequest
+         type: String,
-     ) async throws -> StartRecordingResponse
+         id: String,
- 	open func startTranscription(
+         stopTranscriptionRequest: StopTranscriptionRequest
-         type: String,
+     ) async throws -> StopTranscriptionResponse
-         id: String,
+ 	open func listTranscriptions(type: String, id: String) async throws -> ListTranscriptionsResponse
-         startTranscriptionRequest: StartTranscriptionRequest
+ 	open func unblockUser(type: String, id: String, unblockUserRequest: UnblockUserRequest) async throws -> UnblockUserResponse
-     ) async throws -> StartTranscriptionResponse
+ 	open func videoUnpin(type: String, id: String, unpinRequest: UnpinRequest) async throws -> UnpinResponse
- 	open func getCallStats(type: String, id: String, session: String) async throws -> GetCallStatsResponse
+ 	open func updateUserPermissions(
- 	open func stopHLSBroadcasting(type: String, id: String) async throws -> StopHLSBroadcastingResponse
+         type: String,
- 	open func stopClosedCaptions(
+         id: String,
-         type: String,
+         updateUserPermissionsRequest: UpdateUserPermissionsRequest
-         id: String,
+     ) async throws -> UpdateUserPermissionsResponse
-         stopClosedCaptionsRequest: StopClosedCaptionsRequest
+ 	open func deleteRecording(type: String, id: String, session: String, filename: String) async throws -> DeleteRecordingResponse
-     ) async throws -> StopClosedCaptionsResponse
+ 	open func deleteTranscription(
- 	open func stopLive(type: String, id: String, stopLiveRequest: StopLiveRequest) async throws -> StopLiveResponse
+         type: String,
- 	open func stopRecording(type: String, id: String) async throws -> StopRecordingResponse
+         id: String,
- 	open func stopTranscription(
+         session: String,
-         type: String,
+         filename: String
-         id: String,
+     ) async throws -> DeleteTranscriptionResponse
-         stopTranscriptionRequest: StopTranscriptionRequest
+ 	open func queryCalls(queryCallsRequest: QueryCallsRequest) async throws -> QueryCallsResponse
-     ) async throws -> StopTranscriptionResponse
+ 	open func deleteDevice(id: String) async throws -> ModelResponse
- 	open func listTranscriptions(type: String, id: String) async throws -> ListTranscriptionsResponse
+ 	open func listDevices() async throws -> ListDevicesResponse
- 	open func unblockUser(type: String, id: String, unblockUserRequest: UnblockUserRequest) async throws -> UnblockUserResponse
+ 	open func createDevice(createDeviceRequest: CreateDeviceRequest) async throws -> ModelResponse
- 	open func videoUnpin(type: String, id: String, unpinRequest: UnpinRequest) async throws -> UnpinResponse
+ 	open func getEdges() async throws -> GetEdgesResponse
- 	open func updateUserPermissions(
+ 	open func createGuest(createGuestRequest: CreateGuestRequest) async throws -> CreateGuestResponse
-         type: String,
+ 	open func videoConnect() async throws
-         id: String,
+ 
-         updateUserPermissionsRequest: UpdateUserPermissionsRequest
+ open class CodableHelper
-     ) async throws -> UpdateUserPermissionsResponse
+ 	public static var dateFormatter: DateFormatter
- 	open func deleteRecording(type: String, id: String, session: String, filename: String) async throws -> DeleteRecordingResponse
+ 	public static var jsonDecoder: JSONDecoder
- 	open func deleteTranscription(
+ 	public static var jsonEncoder: JSONEncoder
-         type: String,
+ 	open class func decode<T>(_ type: T.Type, from data: Data) -> Swift.Result<T, Error> where T: Decodable
-         id: String,
+ 	open class func encode<T>(_ value: T) -> Swift.Result<Data, Error> where T: Encodable
-         session: String,
+ 
-         filename: String
+ extension String : CodingKey
-     ) async throws -> DeleteTranscriptionResponse
+ 	public var stringValue: String
- 	open func queryCalls(queryCallsRequest: QueryCallsRequest) async throws -> QueryCallsResponse
+ 	public init?(stringValue: String)
- 	open func deleteDevice(id: String) async throws -> ModelResponse
+ 	public var intValue: Int?
- 	open func listDevices() async throws -> ListDevicesResponse
+ 	public init?(intValue: Int)
- 	open func createDevice(createDeviceRequest: CreateDeviceRequest) async throws -> ModelResponse
+ 
- 	open func getEdges() async throws -> GetEdgesResponse
+ public struct JSONDataEncoding
- 	open func createGuest(createGuestRequest: CreateGuestRequest) async throws -> CreateGuestResponse
+ 	public func encode(_ urlRequest: URLRequest, with parameters: [String: Any]?) -> URLRequest
- 	open func videoConnect() async throws
+ 	public static func encodingParameters(jsonData: Data?) -> [String: Any]?
- open class CodableHelper
+ public enum NullEncodable : Hashable
- 	public static var dateFormatter: DateFormatter
+ 	case encodeNothing
- 	public static var jsonDecoder: JSONDecoder
+ 	case encodeNull
- 	public static var jsonEncoder: JSONEncoder
+ 	case encodeValue(Wrapped)
- 	open class func decode<T>(_ type: T.Type, from data: Data) -> Swift.Result<T, Error> where T: Decodable
+ 
- 	open class func encode<T>(_ value: T) -> Swift.Result<Data, Error> where T: Encodable
+ extension NullEncodable : Codable
- 
+ 	public init(from decoder: Decoder) throws
- extension String : CodingKey
+ 	public func encode(to encoder: Encoder) throws
- 	public var stringValue: String
+ 
- 	public init?(stringValue: String)
+ open class Response
- 	public var intValue: Int?
+ 	public let statusCode: Int
- 	public init?(intValue: Int)
+ 	public let header: [String: String]
- 
+ 	public let body: T
- public struct JSONDataEncoding
+ 	public let bodyData: Data?
- 	public func encode(_ urlRequest: URLRequest, with parameters: [String: Any]?) -> URLRequest
+ 	public init(statusCode: Int, header: [String: String], body: T, bodyData: Data?)
- 	public static func encodingParameters(jsonData: Data?) -> [String: Any]?
+ 	public convenience init(response: HTTPURLResponse, body: T, bodyData: Data?)
- public enum NullEncodable : Hashable
+ public final class APIError : @unchecked Sendable, Codable, JSONEncodable, Hashable, ReflectiveStringConvertible
- 	case encodeNothing
+ 	public var code: Int
- 	case encodeNull
+ 	public var details: [Int]
- 	case encodeValue(Wrapped)
+ 	public var duration: String
- 
+ 	public var exceptionFields: [String: String]?
- extension NullEncodable : Codable
+ 	public var message: String
- 	public init(from decoder: Decoder) throws
+ 	public var moreInfo: String
- 	public func encode(to encoder: Encoder) throws
+ 	public var statusCode: Int
- 
+ 	public var unrecoverable: Bool?
- open class Response
+ 	public init(
- 	public let statusCode: Int
+         code: Int,
- 	public let header: [String: String]
+         details: [Int],
- 	public let body: T
+         duration: String,
- 	public let bodyData: Data?
+         exceptionFields: [String: String]? = nil,
- 	public init(statusCode: Int, header: [String: String], body: T, bodyData: Data?)
+         message: String,
- 	public convenience init(response: HTTPURLResponse, body: T, bodyData: Data?)
+         moreInfo: String,
- 
+         statusCode: Int,
- public final class APIError : @unchecked Sendable, Codable, JSONEncodable, Hashable, ReflectiveStringConvertible
+         unrecoverable: Bool? = nil
- 	public var code: Int
+     )
- 	public var details: [Int]
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var duration: String
+ 		case code
- 	public var exceptionFields: [String: String]?
+ 		case details
- 	public var message: String
+ 		case duration
- 	public var moreInfo: String
+ 		case exceptionFields = "exception_fields"
- 	public var statusCode: Int
+ 		case message
- 	public var unrecoverable: Bool?
+ 		case moreInfo = "more_info"
- 	public init(
+ 		case statusCode = "StatusCode"
-         code: Int,
+ 		case unrecoverable
-         details: [Int],
+ 	public static func == (lhs: APIError, rhs: APIError) -> Bool
-         duration: String,
+ 	public func hash(into hasher: inout Hasher)
-         exceptionFields: [String: String]? = nil,
+ 
-         message: String,
+ public final class AcceptCallResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
-         moreInfo: String,
+ 	public var duration: String
-         statusCode: Int,
+ 	public init(duration: String)
-         unrecoverable: Bool? = nil
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
-     )
+ 		case duration
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public static func == (lhs: AcceptCallResponse, rhs: AcceptCallResponse) -> Bool
- 		case code
+ 	public func hash(into hasher: inout Hasher)
- 		case details
+ 
- 		case duration
+ public final class AggregatedStats : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case exceptionFields = "exception_fields"
+ 	public var countrywiseAggregateStats: [String: CountrywiseAggregateStats?]?
- 		case message
+ 	public var publisherAggregateStats: PublisherAggregateStats?
- 		case moreInfo = "more_info"
+ 	public var turn: TURNAggregatedStats?
- 		case statusCode = "StatusCode"
+ 	public init(
- 		case unrecoverable
+         countrywiseAggregateStats: [String: CountrywiseAggregateStats?]? = nil,
- 	public static func == (lhs: APIError, rhs: APIError) -> Bool
+         publisherAggregateStats: PublisherAggregateStats? = nil,
- 	public func hash(into hasher: inout Hasher)
+         turn: TURNAggregatedStats? = nil
- 
+     )
- public final class AcceptCallResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var duration: String
+ 		case countrywiseAggregateStats = "countrywise_aggregate_stats"
- 	public init(duration: String)
+ 		case publisherAggregateStats = "publisher_aggregate_stats"
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case turn
- 		case duration
+ 	public static func == (lhs: AggregatedStats, rhs: AggregatedStats) -> Bool
- 	public static func == (lhs: AcceptCallResponse, rhs: AcceptCallResponse) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class AudioSettings : @unchecked Sendable, Codable, JSONEncodable, Hashable
- public final class AggregatedStats : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public enum DefaultDevice : String, Sendable, Codable, CaseIterable
- 	public var countrywiseAggregateStats: [String: CountrywiseAggregateStats?]?
+ 		case earpiece
- 	public var publisherAggregateStats: PublisherAggregateStats?
+ 		case speaker
- 	public var turn: TURNAggregatedStats?
+ 		case unknown = "_unknown"
- 	public init(
+ 		public init(from decoder: Decoder) throws
-         countrywiseAggregateStats: [String: CountrywiseAggregateStats?]? = nil,
+ 	public var accessRequestEnabled: Bool
-         publisherAggregateStats: PublisherAggregateStats? = nil,
+ 	public var defaultDevice: DefaultDevice
-         turn: TURNAggregatedStats? = nil
+ 	public var micDefaultOn: Bool
-     )
+ 	public var noiseCancellation: NoiseCancellationSettingsRequest?
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var opusDtxEnabled: Bool
- 		case countrywiseAggregateStats = "countrywise_aggregate_stats"
+ 	public var redundantCodingEnabled: Bool
- 		case publisherAggregateStats = "publisher_aggregate_stats"
+ 	public var speakerDefaultOn: Bool
- 		case turn
+ 	public init(
- 	public static func == (lhs: AggregatedStats, rhs: AggregatedStats) -> Bool
+         accessRequestEnabled: Bool,
- 	public func hash(into hasher: inout Hasher)
+         defaultDevice: DefaultDevice,
- 
+         micDefaultOn: Bool,
- public final class AudioSettings : @unchecked Sendable, Codable, JSONEncodable, Hashable
+         noiseCancellation: NoiseCancellationSettingsRequest? = nil,
- 	public enum DefaultDevice : String, Sendable, Codable, CaseIterable
+         opusDtxEnabled: Bool,
- 		case earpiece
+         redundantCodingEnabled: Bool,
- 		case speaker
+         speakerDefaultOn: Bool
- 		case unknown = "_unknown"
+     )
- 		public init(from decoder: Decoder) throws
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var accessRequestEnabled: Bool
+ 		case accessRequestEnabled = "access_request_enabled"
- 	public var defaultDevice: DefaultDevice
+ 		case defaultDevice = "default_device"
- 	public var micDefaultOn: Bool
+ 		case micDefaultOn = "mic_default_on"
- 	public var noiseCancellation: NoiseCancellationSettingsRequest?
+ 		case noiseCancellation = "noise_cancellation"
- 	public var opusDtxEnabled: Bool
+ 		case opusDtxEnabled = "opus_dtx_enabled"
- 	public var redundantCodingEnabled: Bool
+ 		case redundantCodingEnabled = "redundant_coding_enabled"
- 	public var speakerDefaultOn: Bool
+ 		case speakerDefaultOn = "speaker_default_on"
- 	public init(
+ 	public static func == (lhs: AudioSettings, rhs: AudioSettings) -> Bool
-         accessRequestEnabled: Bool,
+ 	public func hash(into hasher: inout Hasher)
-         defaultDevice: DefaultDevice,
+ 
-         micDefaultOn: Bool,
+ public final class AudioSettingsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
-         noiseCancellation: NoiseCancellationSettingsRequest? = nil,
+ 	public enum DefaultDevice : String, Sendable, Codable, CaseIterable
-         opusDtxEnabled: Bool,
+ 		case earpiece
-         redundantCodingEnabled: Bool,
+ 		case speaker
-         speakerDefaultOn: Bool
+ 		case unknown = "_unknown"
-     )
+ 		public init(from decoder: Decoder) throws
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var accessRequestEnabled: Bool?
- 		case accessRequestEnabled = "access_request_enabled"
+ 	public var defaultDevice: DefaultDevice
- 		case defaultDevice = "default_device"
+ 	public var micDefaultOn: Bool?
- 		case micDefaultOn = "mic_default_on"
+ 	public var noiseCancellation: NoiseCancellationSettingsRequest?
- 		case noiseCancellation = "noise_cancellation"
+ 	public var opusDtxEnabled: Bool?
- 		case opusDtxEnabled = "opus_dtx_enabled"
+ 	public var redundantCodingEnabled: Bool?
- 		case redundantCodingEnabled = "redundant_coding_enabled"
+ 	public var speakerDefaultOn: Bool?
- 		case speakerDefaultOn = "speaker_default_on"
+ 	public init(
- 	public static func == (lhs: AudioSettings, rhs: AudioSettings) -> Bool
+         accessRequestEnabled: Bool? = nil,
- 	public func hash(into hasher: inout Hasher)
+         defaultDevice: DefaultDevice,
- 
+         micDefaultOn: Bool? = nil,
- public final class AudioSettingsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+         noiseCancellation: NoiseCancellationSettingsRequest? = nil,
- 	public enum DefaultDevice : String, Sendable, Codable, CaseIterable
+         opusDtxEnabled: Bool? = nil,
- 		case earpiece
+         redundantCodingEnabled: Bool? = nil,
- 		case speaker
+         speakerDefaultOn: Bool? = nil
- 		case unknown = "_unknown"
+     )
- 		public init(from decoder: Decoder) throws
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var accessRequestEnabled: Bool?
+ 		case accessRequestEnabled = "access_request_enabled"
- 	public var defaultDevice: DefaultDevice
+ 		case defaultDevice = "default_device"
- 	public var micDefaultOn: Bool?
+ 		case micDefaultOn = "mic_default_on"
- 	public var noiseCancellation: NoiseCancellationSettingsRequest?
+ 		case noiseCancellation = "noise_cancellation"
- 	public var opusDtxEnabled: Bool?
+ 		case opusDtxEnabled = "opus_dtx_enabled"
- 	public var redundantCodingEnabled: Bool?
+ 		case redundantCodingEnabled = "redundant_coding_enabled"
- 	public var speakerDefaultOn: Bool?
+ 		case speakerDefaultOn = "speaker_default_on"
- 	public init(
+ 	public static func == (lhs: AudioSettingsRequest, rhs: AudioSettingsRequest) -> Bool
-         accessRequestEnabled: Bool? = nil,
+ 	public func hash(into hasher: inout Hasher)
-         defaultDevice: DefaultDevice,
+ 
-         micDefaultOn: Bool? = nil,
+ public final class BackstageSettings : @unchecked Sendable, Codable, JSONEncodable, Hashable
-         noiseCancellation: NoiseCancellationSettingsRequest? = nil,
+ 	public var enabled: Bool
-         opusDtxEnabled: Bool? = nil,
+ 	public var joinAheadTimeSeconds: Int?
-         redundantCodingEnabled: Bool? = nil,
+ 	public init(enabled: Bool, joinAheadTimeSeconds: Int? = nil)
-         speakerDefaultOn: Bool? = nil
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
-     )
+ 		case enabled
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case joinAheadTimeSeconds = "join_ahead_time_seconds"
- 		case accessRequestEnabled = "access_request_enabled"
+ 	public static func == (lhs: BackstageSettings, rhs: BackstageSettings) -> Bool
- 		case defaultDevice = "default_device"
+ 	public func hash(into hasher: inout Hasher)
- 		case micDefaultOn = "mic_default_on"
+ 
- 		case noiseCancellation = "noise_cancellation"
+ public final class BackstageSettingsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case opusDtxEnabled = "opus_dtx_enabled"
+ 	public var enabled: Bool?
- 		case redundantCodingEnabled = "redundant_coding_enabled"
+ 	public var joinAheadTimeSeconds: Int?
- 		case speakerDefaultOn = "speaker_default_on"
+ 	public init(enabled: Bool? = nil, joinAheadTimeSeconds: Int? = nil)
- 	public static func == (lhs: AudioSettingsRequest, rhs: AudioSettingsRequest) -> Bool
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public func hash(into hasher: inout Hasher)
+ 		case enabled
- 
+ 		case joinAheadTimeSeconds = "join_ahead_time_seconds"
- public final class BackstageSettings : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public static func == (lhs: BackstageSettingsRequest, rhs: BackstageSettingsRequest) -> Bool
- 	public var enabled: Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public var joinAheadTimeSeconds: Int?
+ 
- 	public init(enabled: Bool, joinAheadTimeSeconds: Int? = nil)
+ public final class BlockUserRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var userId: String
- 		case enabled
+ 	public init(userId: String)
- 		case joinAheadTimeSeconds = "join_ahead_time_seconds"
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public static func == (lhs: BackstageSettings, rhs: BackstageSettings) -> Bool
+ 		case userId = "user_id"
- 	public func hash(into hasher: inout Hasher)
+ 	public static func == (lhs: BlockUserRequest, rhs: BlockUserRequest) -> Bool
- 
+ 	public func hash(into hasher: inout Hasher)
- public final class BackstageSettingsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 
- 	public var enabled: Bool?
+ public final class BlockUserResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public var joinAheadTimeSeconds: Int?
+ 	public var duration: String
- 	public init(enabled: Bool? = nil, joinAheadTimeSeconds: Int? = nil)
+ 	public init(duration: String)
- 		case enabled
+ 		case duration
- 		case joinAheadTimeSeconds = "join_ahead_time_seconds"
+ 	public static func == (lhs: BlockUserResponse, rhs: BlockUserResponse) -> Bool
- 	public static func == (lhs: BackstageSettingsRequest, rhs: BackstageSettingsRequest) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class BlockedUserEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- public final class BlockUserRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var blockedByUser: UserResponse?
- 	public var userId: String
+ 	public var callCid: String
- 	public init(userId: String)
+ 	public var createdAt: Date
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var type: String
- 		case userId = "user_id"
+ 	public var user: UserResponse
- 	public static func == (lhs: BlockUserRequest, rhs: BlockUserRequest) -> Bool
+ 	public init(blockedByUser: UserResponse? = nil, callCid: String, createdAt: Date, user: UserResponse)
- 	public func hash(into hasher: inout Hasher)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 
+ 		case blockedByUser = "blocked_by_user"
- public final class BlockUserResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case callCid = "call_cid"
- 	public var duration: String
+ 		case createdAt = "created_at"
- 	public init(duration: String)
+ 		case type
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case user
- 		case duration
+ 	public static func == (lhs: BlockedUserEvent, rhs: BlockedUserEvent) -> Bool
- 	public static func == (lhs: BlockUserResponse, rhs: BlockUserResponse) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class BroadcastSettingsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- public final class BlockedUserEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public var enabled: Bool?
- 	public var blockedByUser: UserResponse?
+ 	public var hls: HLSSettingsRequest?
- 	public var callCid: String
+ 	public var rtmp: RTMPSettingsRequest?
- 	public var createdAt: Date
+ 	public init(enabled: Bool? = nil, hls: HLSSettingsRequest? = nil, rtmp: RTMPSettingsRequest? = nil)
- 	public var type: String
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var user: UserResponse
+ 		case enabled
- 	public init(blockedByUser: UserResponse? = nil, callCid: String, createdAt: Date, user: UserResponse)
+ 		case hls
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case rtmp
- 		case blockedByUser = "blocked_by_user"
+ 	public static func == (lhs: BroadcastSettingsRequest, rhs: BroadcastSettingsRequest) -> Bool
- 		case callCid = "call_cid"
+ 	public func hash(into hasher: inout Hasher)
- 		case createdAt = "created_at"
+ 
- 		case type
+ public final class BroadcastSettingsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case user
+ 	public var enabled: Bool
- 	public static func == (lhs: BlockedUserEvent, rhs: BlockedUserEvent) -> Bool
+ 	public var hls: HLSSettingsResponse
- 	public func hash(into hasher: inout Hasher)
+ 	public var rtmp: RTMPSettingsResponse
- 
+ 	public init(enabled: Bool, hls: HLSSettingsResponse, rtmp: RTMPSettingsResponse)
- public final class BroadcastSettingsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var enabled: Bool?
+ 		case enabled
- 	public var hls: HLSSettingsRequest?
+ 		case hls
- 	public var rtmp: RTMPSettingsRequest?
+ 		case rtmp
- 	public init(enabled: Bool? = nil, hls: HLSSettingsRequest? = nil, rtmp: RTMPSettingsRequest? = nil)
+ 	public static func == (lhs: BroadcastSettingsResponse, rhs: BroadcastSettingsResponse) -> Bool
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public func hash(into hasher: inout Hasher)
- 		case enabled
+ 
- 		case hls
+ public final class CallAcceptedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- 		case rtmp
+ 	public var call: CallResponse
- 	public static func == (lhs: BroadcastSettingsRequest, rhs: BroadcastSettingsRequest) -> Bool
+ 	public var callCid: String
- 	public func hash(into hasher: inout Hasher)
+ 	public var createdAt: Date
- 
+ 	public var type: String
- public final class BroadcastSettingsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var user: UserResponse
- 	public var enabled: Bool
+ 	public init(call: CallResponse, callCid: String, createdAt: Date, user: UserResponse)
- 	public var hls: HLSSettingsResponse
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var rtmp: RTMPSettingsResponse
+ 		case call
- 	public init(enabled: Bool, hls: HLSSettingsResponse, rtmp: RTMPSettingsResponse)
+ 		case callCid = "call_cid"
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case createdAt = "created_at"
- 		case enabled
+ 		case type
- 		case hls
+ 		case user
- 		case rtmp
+ 	public static func == (lhs: CallAcceptedEvent, rhs: CallAcceptedEvent) -> Bool
- 	public static func == (lhs: BroadcastSettingsResponse, rhs: BroadcastSettingsResponse) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class CallClosedCaption : @unchecked Sendable, Codable, JSONEncodable, Hashable
- public final class CallAcceptedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public var endTime: Date
- 	public var call: CallResponse
+ 	public var speakerId: String
- 	public var callCid: String
+ 	public var startTime: Date
- 	public var createdAt: Date
+ 	public var text: String
- 	public var type: String
+ 	public var user: UserResponse
- 	public var user: UserResponse
+ 	public init(endTime: Date, speakerId: String, startTime: Date, text: String, user: UserResponse)
- 	public init(call: CallResponse, callCid: String, createdAt: Date, user: UserResponse)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case endTime = "end_time"
- 		case call
+ 		case speakerId = "speaker_id"
- 		case callCid = "call_cid"
+ 		case startTime = "start_time"
- 		case createdAt = "created_at"
+ 		case text
- 		case type
+ 		case user
- 		case user
+ 	public static func == (lhs: CallClosedCaption, rhs: CallClosedCaption) -> Bool
- 	public static func == (lhs: CallAcceptedEvent, rhs: CallAcceptedEvent) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class CallClosedCaptionsFailedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- public final class CallClosedCaption : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var callCid: String
- 	public var endTime: Date
+ 	public var createdAt: Date
- 	public var speakerId: String
+ 	public var type: String
- 	public var startTime: Date
+ 	public init(callCid: String, createdAt: Date)
- 	public var text: String
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var user: UserResponse
+ 		case callCid = "call_cid"
- 	public init(endTime: Date, speakerId: String, startTime: Date, text: String, user: UserResponse)
+ 		case createdAt = "created_at"
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case type
- 		case endTime = "end_time"
+ 	public static func == (lhs: CallClosedCaptionsFailedEvent, rhs: CallClosedCaptionsFailedEvent) -> Bool
- 		case speakerId = "speaker_id"
+ 	public func hash(into hasher: inout Hasher)
- 		case startTime = "start_time"
+ 
- 		case text
+ public final class CallClosedCaptionsStartedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- 		case user
+ 	public var callCid: String
- 	public static func == (lhs: CallClosedCaption, rhs: CallClosedCaption) -> Bool
+ 	public var createdAt: Date
- 	public func hash(into hasher: inout Hasher)
+ 	public var type: String
- 
+ 	public init(callCid: String, createdAt: Date)
- public final class CallClosedCaptionsFailedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var callCid: String
+ 		case callCid = "call_cid"
- 	public var createdAt: Date
+ 		case createdAt = "created_at"
- 	public var type: String
+ 		case type
- 	public init(callCid: String, createdAt: Date)
+ 	public static func == (lhs: CallClosedCaptionsStartedEvent, rhs: CallClosedCaptionsStartedEvent) -> Bool
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public func hash(into hasher: inout Hasher)
- 		case callCid = "call_cid"
+ 
- 		case createdAt = "created_at"
+ public final class CallClosedCaptionsStoppedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- 		case type
+ 	public var callCid: String
- 	public static func == (lhs: CallClosedCaptionsFailedEvent, rhs: CallClosedCaptionsFailedEvent) -> Bool
+ 	public var createdAt: Date
- 	public func hash(into hasher: inout Hasher)
+ 	public var type: String
- 
+ 	public init(callCid: String, createdAt: Date)
- public final class CallClosedCaptionsStartedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var callCid: String
+ 		case callCid = "call_cid"
- 	public var createdAt: Date
+ 		case createdAt = "created_at"
- 	public var type: String
+ 		case type
- 	public init(callCid: String, createdAt: Date)
+ 	public static func == (lhs: CallClosedCaptionsStoppedEvent, rhs: CallClosedCaptionsStoppedEvent) -> Bool
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public func hash(into hasher: inout Hasher)
- 		case callCid = "call_cid"
+ 
- 		case createdAt = "created_at"
+ public final class CallCreatedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- 		case type
+ 	public var call: CallResponse
- 	public static func == (lhs: CallClosedCaptionsStartedEvent, rhs: CallClosedCaptionsStartedEvent) -> Bool
+ 	public var callCid: String
- 	public func hash(into hasher: inout Hasher)
+ 	public var createdAt: Date
- 
+ 	public var members: [MemberResponse]
- public final class CallClosedCaptionsStoppedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public var type: String
- 	public var callCid: String
+ 	public init(call: CallResponse, callCid: String, createdAt: Date, members: [MemberResponse])
- 	public var createdAt: Date
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var type: String
+ 		case call
- 	public init(callCid: String, createdAt: Date)
+ 		case callCid = "call_cid"
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case createdAt = "created_at"
- 		case callCid = "call_cid"
+ 		case members
- 		case createdAt = "created_at"
+ 		case type
- 		case type
+ 	public static func == (lhs: CallCreatedEvent, rhs: CallCreatedEvent) -> Bool
- 	public static func == (lhs: CallClosedCaptionsStoppedEvent, rhs: CallClosedCaptionsStoppedEvent) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class CallDeletedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- public final class CallCreatedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public var call: CallResponse
- 	public var call: CallResponse
+ 	public var callCid: String
- 	public var callCid: String
+ 	public var createdAt: Date
- 	public var createdAt: Date
+ 	public var type: String
- 	public var members: [MemberResponse]
+ 	public init(call: CallResponse, callCid: String, createdAt: Date)
- 	public var type: String
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public init(call: CallResponse, callCid: String, createdAt: Date, members: [MemberResponse])
+ 		case call
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case callCid = "call_cid"
- 		case call
+ 		case createdAt = "created_at"
- 		case callCid = "call_cid"
+ 		case type
- 		case createdAt = "created_at"
+ 	public static func == (lhs: CallDeletedEvent, rhs: CallDeletedEvent) -> Bool
- 		case members
+ 	public func hash(into hasher: inout Hasher)
- 		case type
+ 
- 	public static func == (lhs: CallCreatedEvent, rhs: CallCreatedEvent) -> Bool
+ public final class CallEndedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- 	public func hash(into hasher: inout Hasher)
+ 	public var call: CallResponse
- 
+ 	public var callCid: String
- public final class CallDeletedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public var createdAt: Date
- 	public var call: CallResponse
+ 	public var type: String
- 	public var callCid: String
+ 	public var user: UserResponse?
- 	public var createdAt: Date
+ 	public init(call: CallResponse, callCid: String, createdAt: Date, user: UserResponse? = nil)
- 	public var type: String
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public init(call: CallResponse, callCid: String, createdAt: Date)
+ 		case call
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case callCid = "call_cid"
- 		case call
+ 		case createdAt = "created_at"
- 		case callCid = "call_cid"
+ 		case type
- 		case createdAt = "created_at"
+ 		case user
- 		case type
+ 	public static func == (lhs: CallEndedEvent, rhs: CallEndedEvent) -> Bool
- 	public static func == (lhs: CallDeletedEvent, rhs: CallDeletedEvent) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class CallEvent : @unchecked Sendable, Codable, JSONEncodable, Hashable
- public final class CallEndedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public var _internal: Bool
- 	public var call: CallResponse
+ 	public var category: String?
- 	public var callCid: String
+ 	public var component: String?
- 	public var createdAt: Date
+ 	public var description: String
- 	public var type: String
+ 	public var endTimestamp: Int
- 	public var user: UserResponse?
+ 	public var issueTags: [String]?
- 	public init(call: CallResponse, callCid: String, createdAt: Date, user: UserResponse? = nil)
+ 	public var kind: String
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var severity: Int
- 		case call
+ 	public var timestamp: Int
- 		case callCid = "call_cid"
+ 	public var type: String
- 		case createdAt = "created_at"
+ 	public init(
- 		case type
+         _internal: Bool,
- 		case user
+         category: String? = nil,
- 	public static func == (lhs: CallEndedEvent, rhs: CallEndedEvent) -> Bool
+         component: String? = nil,
- 	public func hash(into hasher: inout Hasher)
+         description: String,
- 
+         endTimestamp: Int,
- public final class CallEvent : @unchecked Sendable, Codable, JSONEncodable, Hashable
+         issueTags: [String]? = nil,
- 	public var _internal: Bool
+         kind: String,
- 	public var category: String?
+         severity: Int,
- 	public var component: String?
+         timestamp: Int,
- 	public var description: String
+         type: String
- 	public var endTimestamp: Int
+     )
- 	public var issueTags: [String]?
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var kind: String
+ 		case _internal = "internal"
- 	public var severity: Int
+ 		case category
- 	public var timestamp: Int
+ 		case component
- 	public var type: String
+ 		case description
- 	public init(
+ 		case endTimestamp = "end_timestamp"
-         _internal: Bool,
+ 		case issueTags = "issue_tags"
-         category: String? = nil,
+ 		case kind
-         component: String? = nil,
+ 		case severity
-         description: String,
+ 		case timestamp
-         endTimestamp: Int,
+ 		case type
-         issueTags: [String]? = nil,
+ 	public static func == (lhs: CallEvent, rhs: CallEvent) -> Bool
-         kind: String,
+ 	public func hash(into hasher: inout Hasher)
-         severity: Int,
+ 
-         timestamp: Int,
+ public final class CallHLSBroadcastingFailedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
-         type: String
+ 	public var callCid: String
-     )
+ 	public var createdAt: Date
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var type: String
- 		case _internal = "internal"
+ 	public init(callCid: String, createdAt: Date)
- 		case category
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 		case component
+ 		case callCid = "call_cid"
- 		case description
+ 		case createdAt = "created_at"
- 		case endTimestamp = "end_timestamp"
+ 		case type
- 		case issueTags = "issue_tags"
+ 	public static func == (lhs: CallHLSBroadcastingFailedEvent, rhs: CallHLSBroadcastingFailedEvent) -> Bool
- 		case kind
+ 	public func hash(into hasher: inout Hasher)
- 		case severity
+ 
- 		case timestamp
+ public final class CallHLSBroadcastingStartedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- 		case type
+ 	public var callCid: String
- 	public static func == (lhs: CallEvent, rhs: CallEvent) -> Bool
+ 	public var createdAt: Date
- 	public func hash(into hasher: inout Hasher)
+ 	public var hlsPlaylistUrl: String
- 
+ 	public var type: String
- public final class CallHLSBroadcastingFailedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public init(callCid: String, createdAt: Date, hlsPlaylistUrl: String)
- 	public var callCid: String
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var createdAt: Date
+ 		case callCid = "call_cid"
- 	public var type: String
+ 		case createdAt = "created_at"
- 	public init(callCid: String, createdAt: Date)
+ 		case hlsPlaylistUrl = "hls_playlist_url"
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case type
- 		case callCid = "call_cid"
+ 	public static func == (lhs: CallHLSBroadcastingStartedEvent, rhs: CallHLSBroadcastingStartedEvent) -> Bool
- 		case createdAt = "created_at"
+ 	public func hash(into hasher: inout Hasher)
- 		case type
+ 
- 	public static func == (lhs: CallHLSBroadcastingFailedEvent, rhs: CallHLSBroadcastingFailedEvent) -> Bool
+ public final class CallHLSBroadcastingStoppedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- 	public func hash(into hasher: inout Hasher)
+ 	public var callCid: String
- 
+ 	public var createdAt: Date
- public final class CallHLSBroadcastingStartedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public var type: String
- 	public var callCid: String
+ 	public init(callCid: String, createdAt: Date)
- 	public var createdAt: Date
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var hlsPlaylistUrl: String
+ 		case callCid = "call_cid"
- 	public var type: String
+ 		case createdAt = "created_at"
- 	public init(callCid: String, createdAt: Date, hlsPlaylistUrl: String)
+ 		case type
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public static func == (lhs: CallHLSBroadcastingStoppedEvent, rhs: CallHLSBroadcastingStoppedEvent) -> Bool
- 		case callCid = "call_cid"
+ 	public func hash(into hasher: inout Hasher)
- 		case createdAt = "created_at"
+ 
- 		case hlsPlaylistUrl = "hls_playlist_url"
+ public final class CallIngressResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case type
+ 	public var rtmp: RTMPIngress
- 	public static func == (lhs: CallHLSBroadcastingStartedEvent, rhs: CallHLSBroadcastingStartedEvent) -> Bool
+ 	public init(rtmp: RTMPIngress)
- 	public func hash(into hasher: inout Hasher)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 
+ 		case rtmp
- public final class CallHLSBroadcastingStoppedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public static func == (lhs: CallIngressResponse, rhs: CallIngressResponse) -> Bool
- 	public var callCid: String
+ 	public func hash(into hasher: inout Hasher)
- 	public var createdAt: Date
+ 
- 	public var type: String
+ public final class CallLiveStartedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- 	public init(callCid: String, createdAt: Date)
+ 	public var call: CallResponse
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var callCid: String
- 		case callCid = "call_cid"
+ 	public var createdAt: Date
- 		case createdAt = "created_at"
+ 	public var type: String
- 		case type
+ 	public init(call: CallResponse, callCid: String, createdAt: Date)
- 	public static func == (lhs: CallHLSBroadcastingStoppedEvent, rhs: CallHLSBroadcastingStoppedEvent) -> Bool
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public func hash(into hasher: inout Hasher)
+ 		case call
- 
+ 		case callCid = "call_cid"
- public final class CallIngressResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case createdAt = "created_at"
- 	public var rtmp: RTMPIngress
+ 		case type
- 	public init(rtmp: RTMPIngress)
+ 	public static func == (lhs: CallLiveStartedEvent, rhs: CallLiveStartedEvent) -> Bool
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public func hash(into hasher: inout Hasher)
- 		case rtmp
+ 
- 	public static func == (lhs: CallIngressResponse, rhs: CallIngressResponse) -> Bool
+ public final class CallMemberAddedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- 	public func hash(into hasher: inout Hasher)
+ 	public var call: CallResponse
- 
+ 	public var callCid: String
- public final class CallLiveStartedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public var createdAt: Date
- 	public var call: CallResponse
+ 	public var members: [MemberResponse]
- 	public var callCid: String
+ 	public var type: String
- 	public var createdAt: Date
+ 	public init(call: CallResponse, callCid: String, createdAt: Date, members: [MemberResponse])
- 	public var type: String
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public init(call: CallResponse, callCid: String, createdAt: Date)
+ 		case call
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case callCid = "call_cid"
- 		case call
+ 		case createdAt = "created_at"
- 		case callCid = "call_cid"
+ 		case members
- 		case createdAt = "created_at"
+ 		case type
- 		case type
+ 	public static func == (lhs: CallMemberAddedEvent, rhs: CallMemberAddedEvent) -> Bool
- 	public static func == (lhs: CallLiveStartedEvent, rhs: CallLiveStartedEvent) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class CallMemberRemovedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- public final class CallMemberAddedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public var call: CallResponse
- 	public var call: CallResponse
+ 	public var callCid: String
- 	public var callCid: String
+ 	public var createdAt: Date
- 	public var createdAt: Date
+ 	public var members: [String]
- 	public var members: [MemberResponse]
+ 	public var type: String
- 	public var type: String
+ 	public init(call: CallResponse, callCid: String, createdAt: Date, members: [String])
- 	public init(call: CallResponse, callCid: String, createdAt: Date, members: [MemberResponse])
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case call
- 		case call
+ 		case callCid = "call_cid"
- 		case callCid = "call_cid"
+ 		case createdAt = "created_at"
- 		case createdAt = "created_at"
+ 		case members
- 		case members
+ 		case type
- 		case type
+ 	public static func == (lhs: CallMemberRemovedEvent, rhs: CallMemberRemovedEvent) -> Bool
- 	public static func == (lhs: CallMemberAddedEvent, rhs: CallMemberAddedEvent) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class CallMemberUpdatedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- public final class CallMemberRemovedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public var call: CallResponse
- 	public var call: CallResponse
+ 	public var callCid: String
- 	public var callCid: String
+ 	public var createdAt: Date
- 	public var createdAt: Date
+ 	public var members: [MemberResponse]
- 	public var members: [String]
+ 	public var type: String
- 	public var type: String
+ 	public init(call: CallResponse, callCid: String, createdAt: Date, members: [MemberResponse])
- 	public init(call: CallResponse, callCid: String, createdAt: Date, members: [String])
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case call
- 		case call
+ 		case callCid = "call_cid"
- 		case callCid = "call_cid"
+ 		case createdAt = "created_at"
- 		case createdAt = "created_at"
+ 		case members
- 		case members
+ 		case type
- 		case type
+ 	public static func == (lhs: CallMemberUpdatedEvent, rhs: CallMemberUpdatedEvent) -> Bool
- 	public static func == (lhs: CallMemberRemovedEvent, rhs: CallMemberRemovedEvent) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class CallMemberUpdatedPermissionEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- public final class CallMemberUpdatedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public var call: CallResponse
- 	public var call: CallResponse
+ 	public var callCid: String
- 	public var callCid: String
+ 	public var capabilitiesByRole: [String: [String]]
...
- 	public init(call: CallResponse, callCid: String, createdAt: Date, members: [MemberResponse])
+ 	public init(
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+         call: CallResponse,
- 		case call
+         callCid: String,
- 		case callCid = "call_cid"
+         capabilitiesByRole: [String: [String]],
- 		case createdAt = "created_at"
+         createdAt: Date,
- 		case members
+         members: [MemberResponse]
- 		case type
+     )
- 	public static func == (lhs: CallMemberUpdatedEvent, rhs: CallMemberUpdatedEvent) -> Bool
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public func hash(into hasher: inout Hasher)
+ 		case call
- 
+ 		case callCid = "call_cid"
- public final class CallMemberUpdatedPermissionEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 		case capabilitiesByRole = "capabilities_by_role"
- 	public var call: CallResponse
+ 		case createdAt = "created_at"
- 	public var callCid: String
+ 		case members
- 	public var capabilitiesByRole: [String: [String]]
+ 		case type
- 	public var createdAt: Date
+ 	public static func == (lhs: CallMemberUpdatedPermissionEvent, rhs: CallMemberUpdatedPermissionEvent) -> Bool
- 	public var members: [MemberResponse]
+ 	public func hash(into hasher: inout Hasher)
- 	public var type: String
+ 
- 	public init(
+ public final class CallMissedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
-         call: CallResponse,
+ 	public var call: CallResponse
-         callCid: String,
+ 	public var callCid: String
-         capabilitiesByRole: [String: [String]],
+ 	public var createdAt: Date
-         createdAt: Date,
+ 	public var members: [MemberResponse]
-         members: [MemberResponse]
+ 	public var notifyUser: Bool
-     )
+ 	public var sessionId: String
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var type: String
- 		case call
+ 	public var user: UserResponse
- 		case callCid = "call_cid"
+ 	public init(
- 		case capabilitiesByRole = "capabilities_by_role"
+         call: CallResponse,
- 		case createdAt = "created_at"
+         callCid: String,
- 		case members
+         createdAt: Date,
- 		case type
+         members: [MemberResponse],
- 	public static func == (lhs: CallMemberUpdatedPermissionEvent, rhs: CallMemberUpdatedPermissionEvent) -> Bool
+         notifyUser: Bool,
- 	public func hash(into hasher: inout Hasher)
+         sessionId: String,
- 
+         user: UserResponse
- public final class CallMissedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+     )
- 	public var call: CallResponse
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var callCid: String
+ 		case call
- 	public var createdAt: Date
+ 		case callCid = "call_cid"
- 	public var members: [MemberResponse]
+ 		case createdAt = "created_at"
- 	public var notifyUser: Bool
+ 		case members
- 	public var sessionId: String
+ 		case notifyUser = "notify_user"
- 	public var type: String
+ 		case sessionId = "session_id"
- 	public var user: UserResponse
+ 		case type
- 	public init(
+ 		case user
-         call: CallResponse,
+ 	public static func == (lhs: CallMissedEvent, rhs: CallMissedEvent) -> Bool
-         callCid: String,
+ 	public func hash(into hasher: inout Hasher)
-         createdAt: Date,
+ 
-         members: [MemberResponse],
+ public final class CallNotificationEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
-         notifyUser: Bool,
+ 	public var call: CallResponse
-         sessionId: String,
+ 	public var callCid: String
-         user: UserResponse
+ 	public var createdAt: Date
-     )
+ 	public var members: [MemberResponse]
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var sessionId: String
- 		case call
+ 	public var type: String
- 		case callCid = "call_cid"
+ 	public var user: UserResponse
- 		case createdAt = "created_at"
+ 	public init(
- 		case members
+         call: CallResponse,
- 		case notifyUser = "notify_user"
+         callCid: String,
- 		case sessionId = "session_id"
+         createdAt: Date,
- 		case type
+         members: [MemberResponse],
- 		case user
+         sessionId: String,
- 	public static func == (lhs: CallMissedEvent, rhs: CallMissedEvent) -> Bool
+         user: UserResponse
- 	public func hash(into hasher: inout Hasher)
+     )
- 
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- public final class CallNotificationEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 		case call
- 	public var call: CallResponse
+ 		case callCid = "call_cid"
- 	public var callCid: String
+ 		case createdAt = "created_at"
- 	public var createdAt: Date
+ 		case members
- 	public var members: [MemberResponse]
+ 		case sessionId = "session_id"
- 	public var sessionId: String
+ 		case type
- 	public var type: String
+ 		case user
- 	public var user: UserResponse
+ 	public static func == (lhs: CallNotificationEvent, rhs: CallNotificationEvent) -> Bool
- 	public init(
+ 	public func hash(into hasher: inout Hasher)
-         call: CallResponse,
+ 
-         callCid: String,
+ public final class CallParticipantResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
-         createdAt: Date,
+ 	public var joinedAt: Date
-         members: [MemberResponse],
+ 	public var role: String
-         sessionId: String,
+ 	public var user: UserResponse
-         user: UserResponse
+ 	public var userSessionId: String
-     )
+ 	public init(joinedAt: Date, role: String, user: UserResponse, userSessionId: String)
- 		case call
+ 		case joinedAt = "joined_at"
- 		case callCid = "call_cid"
+ 		case role
- 		case createdAt = "created_at"
+ 		case user
- 		case members
+ 		case userSessionId = "user_session_id"
- 		case sessionId = "session_id"
+ 	public static func == (lhs: CallParticipantResponse, rhs: CallParticipantResponse) -> Bool
- 		case type
+ 	public func hash(into hasher: inout Hasher)
- 		case user
+ 
- 	public static func == (lhs: CallNotificationEvent, rhs: CallNotificationEvent) -> Bool
+ public final class CallReactionEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- 	public func hash(into hasher: inout Hasher)
+ 	public var callCid: String
- 
+ 	public var createdAt: Date
- public final class CallParticipantResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var reaction: ReactionResponse
- 	public var joinedAt: Date
+ 	public var type: String
- 	public var role: String
+ 	public init(callCid: String, createdAt: Date, reaction: ReactionResponse)
- 	public var user: UserResponse
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var userSessionId: String
+ 		case callCid = "call_cid"
- 	public init(joinedAt: Date, role: String, user: UserResponse, userSessionId: String)
+ 		case createdAt = "created_at"
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case reaction
- 		case joinedAt = "joined_at"
+ 		case type
- 		case role
+ 	public static func == (lhs: CallReactionEvent, rhs: CallReactionEvent) -> Bool
- 		case user
+ 	public func hash(into hasher: inout Hasher)
- 		case userSessionId = "user_session_id"
+ 
- 	public static func == (lhs: CallParticipantResponse, rhs: CallParticipantResponse) -> Bool
+ public final class CallRecording : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public func hash(into hasher: inout Hasher)
+ 	public var endTime: Date
- 
+ 	public var filename: String
- public final class CallReactionEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public var startTime: Date
- 	public var callCid: String
+ 	public var url: String
- 	public var createdAt: Date
+ 	public init(endTime: Date, filename: String, startTime: Date, url: String)
- 	public var reaction: ReactionResponse
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var type: String
+ 		case endTime = "end_time"
- 	public init(callCid: String, createdAt: Date, reaction: ReactionResponse)
+ 		case filename
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case startTime = "start_time"
- 		case callCid = "call_cid"
+ 		case url
- 		case createdAt = "created_at"
+ 	public static func == (lhs: CallRecording, rhs: CallRecording) -> Bool
- 		case reaction
+ 	public func hash(into hasher: inout Hasher)
- 		case type
+ 
- 	public static func == (lhs: CallReactionEvent, rhs: CallReactionEvent) -> Bool
+ public final class CallRecordingFailedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- 	public func hash(into hasher: inout Hasher)
+ 	public var callCid: String
- 
+ 	public var createdAt: Date
- public final class CallRecording : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var type: String
- 	public var endTime: Date
+ 	public init(callCid: String, createdAt: Date)
- 	public var filename: String
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var startTime: Date
+ 		case callCid = "call_cid"
- 	public var url: String
+ 		case createdAt = "created_at"
- 	public init(endTime: Date, filename: String, startTime: Date, url: String)
+ 		case type
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public static func == (lhs: CallRecordingFailedEvent, rhs: CallRecordingFailedEvent) -> Bool
- 		case endTime = "end_time"
+ 	public func hash(into hasher: inout Hasher)
- 		case filename
+ 
- 		case startTime = "start_time"
+ public final class CallRecordingReadyEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- 		case url
+ 	public var callCid: String
- 	public static func == (lhs: CallRecording, rhs: CallRecording) -> Bool
+ 	public var callRecording: CallRecording
- 	public func hash(into hasher: inout Hasher)
+ 	public var createdAt: Date
- 
+ 	public var type: String
- public final class CallRecordingFailedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public init(callCid: String, callRecording: CallRecording, createdAt: Date)
- 	public var callCid: String
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var createdAt: Date
+ 		case callCid = "call_cid"
- 	public var type: String
+ 		case callRecording = "call_recording"
- 	public init(callCid: String, createdAt: Date)
+ 		case createdAt = "created_at"
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case type
- 		case callCid = "call_cid"
+ 	public static func == (lhs: CallRecordingReadyEvent, rhs: CallRecordingReadyEvent) -> Bool
- 		case createdAt = "created_at"
+ 	public func hash(into hasher: inout Hasher)
- 		case type
+ 
- 	public static func == (lhs: CallRecordingFailedEvent, rhs: CallRecordingFailedEvent) -> Bool
+ public final class CallRecordingStartedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- 	public func hash(into hasher: inout Hasher)
+ 	public var callCid: String
- 
+ 	public var createdAt: Date
- public final class CallRecordingReadyEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public var type: String
- 	public var callCid: String
+ 	public init(callCid: String, createdAt: Date)
- 	public var callRecording: CallRecording
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var createdAt: Date
+ 		case callCid = "call_cid"
- 	public var type: String
+ 		case createdAt = "created_at"
- 	public init(callCid: String, callRecording: CallRecording, createdAt: Date)
+ 		case type
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public static func == (lhs: CallRecordingStartedEvent, rhs: CallRecordingStartedEvent) -> Bool
- 		case callCid = "call_cid"
+ 	public func hash(into hasher: inout Hasher)
- 		case callRecording = "call_recording"
+ 
- 		case createdAt = "created_at"
+ public final class CallRecordingStoppedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- 		case type
+ 	public var callCid: String
- 	public static func == (lhs: CallRecordingReadyEvent, rhs: CallRecordingReadyEvent) -> Bool
+ 	public var createdAt: Date
- 	public func hash(into hasher: inout Hasher)
+ 	public var type: String
- 
+ 	public init(callCid: String, createdAt: Date)
- public final class CallRecordingStartedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var callCid: String
+ 		case callCid = "call_cid"
- 	public var createdAt: Date
+ 		case createdAt = "created_at"
- 	public var type: String
+ 		case type
- 	public init(callCid: String, createdAt: Date)
+ 	public static func == (lhs: CallRecordingStoppedEvent, rhs: CallRecordingStoppedEvent) -> Bool
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public func hash(into hasher: inout Hasher)
- 		case callCid = "call_cid"
+ 
- 		case createdAt = "created_at"
+ public final class CallRejectedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- 		case type
+ 	public var call: CallResponse
- 	public static func == (lhs: CallRecordingStartedEvent, rhs: CallRecordingStartedEvent) -> Bool
+ 	public var callCid: String
- 	public func hash(into hasher: inout Hasher)
+ 	public var createdAt: Date
- 
+ 	public var reason: String?
- public final class CallRecordingStoppedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public var type: String
- 	public var callCid: String
+ 	public var user: UserResponse
- 	public var createdAt: Date
+ 	public init(call: CallResponse, callCid: String, createdAt: Date, reason: String? = nil, user: UserResponse)
- 	public var type: String
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public init(callCid: String, createdAt: Date)
+ 		case call
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case callCid = "call_cid"
- 		case callCid = "call_cid"
+ 		case createdAt = "created_at"
- 		case createdAt = "created_at"
+ 		case reason
- 	public static func == (lhs: CallRecordingStoppedEvent, rhs: CallRecordingStoppedEvent) -> Bool
+ 		case user
- 	public func hash(into hasher: inout Hasher)
+ 	public static func == (lhs: CallRejectedEvent, rhs: CallRejectedEvent) -> Bool
- 
+ 	public func hash(into hasher: inout Hasher)
- public final class CallRejectedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 
- 	public var call: CallResponse
+ public final class CallRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public var callCid: String
+ 	public var custom: [String: RawJSON]?
- 	public var createdAt: Date
+ 	public var members: [MemberRequest]?
- 	public var reason: String?
+ 	public var settingsOverride: CallSettingsRequest?
- 	public var type: String
+ 	public var startsAt: Date?
- 	public var user: UserResponse
+ 	public var team: String?
- 	public init(call: CallResponse, callCid: String, createdAt: Date, reason: String? = nil, user: UserResponse)
+ 	public var video: Bool?
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public init(
- 		case call
+         custom: [String: RawJSON]? = nil,
- 		case callCid = "call_cid"
+         members: [MemberRequest]? = nil,
- 		case createdAt = "created_at"
+         settingsOverride: CallSettingsRequest? = nil,
- 		case reason
+         startsAt: Date? = nil,
- 		case type
+         team: String? = nil,
- 		case user
+         video: Bool? = nil
- 	public static func == (lhs: CallRejectedEvent, rhs: CallRejectedEvent) -> Bool
+     )
- 	public func hash(into hasher: inout Hasher)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 
+ 		case custom
- public final class CallRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case members
- 	public var custom: [String: RawJSON]?
+ 		case settingsOverride = "settings_override"
- 	public var members: [MemberRequest]?
+ 		case startsAt = "starts_at"
- 	public var settingsOverride: CallSettingsRequest?
+ 		case team
- 	public var startsAt: Date?
+ 		case video
- 	public var team: String?
+ 	public static func == (lhs: CallRequest, rhs: CallRequest) -> Bool
- 	public var video: Bool?
+ 	public func hash(into hasher: inout Hasher)
- 	public init(
+ 
-         custom: [String: RawJSON]? = nil,
+ public final class CallResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
-         members: [MemberRequest]? = nil,
+ 	public var backstage: Bool
-         settingsOverride: CallSettingsRequest? = nil,
+ 	public var blockedUserIds: [String]
-         startsAt: Date? = nil,
+ 	public var captioning: Bool
-         team: String? = nil,
+ 	public var cid: String
-         video: Bool? = nil
+ 	public var createdAt: Date
-     )
+ 	public var createdBy: UserResponse
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var currentSessionId: String
- 		case custom
+ 	public var custom: [String: RawJSON]
- 		case members
+ 	public var egress: EgressResponse
- 		case settingsOverride = "settings_override"
+ 	public var endedAt: Date?
- 		case startsAt = "starts_at"
+ 	public var id: String
- 		case team
+ 	public var ingress: CallIngressResponse
- 		case video
+ 	public var joinAheadTimeSeconds: Int?
- 	public static func == (lhs: CallRequest, rhs: CallRequest) -> Bool
+ 	public var recording: Bool
- 	public func hash(into hasher: inout Hasher)
+ 	public var session: CallSessionResponse?
- 
+ 	public var settings: CallSettingsResponse
- public final class CallResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var startsAt: Date?
- 	public var backstage: Bool
+ 	public var team: String?
- 	public var blockedUserIds: [String]
+ 	public var thumbnails: ThumbnailResponse?
- 	public var captioning: Bool
+ 	public var transcribing: Bool
- 	public var cid: String
+ 	public var type: String
- 	public var createdAt: Date
+ 	public var updatedAt: Date
- 	public var createdBy: UserResponse
+ 	public init(
- 	public var currentSessionId: String
+         backstage: Bool,
- 	public var custom: [String: RawJSON]
+         blockedUserIds: [String],
- 	public var egress: EgressResponse
+         captioning: Bool,
- 	public var endedAt: Date?
+         cid: String,
- 	public var id: String
+         createdAt: Date,
- 	public var ingress: CallIngressResponse
+         createdBy: UserResponse,
- 	public var joinAheadTimeSeconds: Int?
+         currentSessionId: String,
- 	public var recording: Bool
+         custom: [String: RawJSON],
- 	public var session: CallSessionResponse?
+         egress: EgressResponse,
- 	public var settings: CallSettingsResponse
+         endedAt: Date? = nil,
- 	public var startsAt: Date?
+         id: String,
- 	public var team: String?
+         ingress: CallIngressResponse,
- 	public var thumbnails: ThumbnailResponse?
+         joinAheadTimeSeconds: Int? = nil,
- 	public var transcribing: Bool
+         recording: Bool,
- 	public var type: String
+         session: CallSessionResponse? = nil,
- 	public var updatedAt: Date
+         settings: CallSettingsResponse,
- 	public init(
+         startsAt: Date? = nil,
-         backstage: Bool,
+         team: String? = nil,
-         blockedUserIds: [String],
+         thumbnails: ThumbnailResponse? = nil,
-         captioning: Bool,
+         transcribing: Bool,
-         cid: String,
+         type: String,
-         createdAt: Date,
+         updatedAt: Date
-         createdBy: UserResponse,
+     )
-         currentSessionId: String,
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
-         custom: [String: RawJSON],
+ 		case backstage
-         egress: EgressResponse,
+ 		case blockedUserIds = "blocked_user_ids"
-         endedAt: Date? = nil,
+ 		case captioning
-         id: String,
+ 		case cid
-         ingress: CallIngressResponse,
+ 		case createdAt = "created_at"
-         joinAheadTimeSeconds: Int? = nil,
+ 		case createdBy = "created_by"
-         recording: Bool,
+ 		case currentSessionId = "current_session_id"
-         session: CallSessionResponse? = nil,
+ 		case custom
-         settings: CallSettingsResponse,
+ 		case egress
-         startsAt: Date? = nil,
+ 		case endedAt = "ended_at"
-         team: String? = nil,
+ 		case id
-         thumbnails: ThumbnailResponse? = nil,
+ 		case ingress
-         transcribing: Bool,
+ 		case joinAheadTimeSeconds = "join_ahead_time_seconds"
-         type: String,
+ 		case recording
-         updatedAt: Date
+ 		case session
-     )
+ 		case settings
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case startsAt = "starts_at"
- 		case backstage
+ 		case team
- 		case blockedUserIds = "blocked_user_ids"
+ 		case thumbnails
- 		case captioning
+ 		case transcribing
- 		case cid
+ 		case type
- 		case createdAt = "created_at"
+ 		case updatedAt = "updated_at"
- 		case createdBy = "created_by"
+ 	public static func == (lhs: CallResponse, rhs: CallResponse) -> Bool
- 		case currentSessionId = "current_session_id"
+ 	public func hash(into hasher: inout Hasher)
- 		case custom
+ 
- 		case egress
+ public final class CallRingEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- 		case endedAt = "ended_at"
+ 	public var call: CallResponse
- 		case id
+ 	public var callCid: String
- 		case ingress
+ 	public var createdAt: Date
- 		case joinAheadTimeSeconds = "join_ahead_time_seconds"
+ 	public var members: [MemberResponse]
- 		case recording
+ 	public var sessionId: String
- 		case session
+ 	public var type: String
- 		case settings
+ 	public var user: UserResponse
- 		case startsAt = "starts_at"
+ 	public var video: Bool
- 		case team
+ 	public init(
- 		case thumbnails
+         call: CallResponse,
- 		case transcribing
+         callCid: String,
- 		case type
+         createdAt: Date,
- 		case updatedAt = "updated_at"
+         members: [MemberResponse],
- 	public static func == (lhs: CallResponse, rhs: CallResponse) -> Bool
+         sessionId: String,
- 	public func hash(into hasher: inout Hasher)
+         user: UserResponse,
- 
+         video: Bool
- public final class CallRingEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+     )
- 	public var call: CallResponse
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var callCid: String
+ 		case call
- 	public var createdAt: Date
+ 		case callCid = "call_cid"
- 	public var members: [MemberResponse]
+ 		case createdAt = "created_at"
- 	public var sessionId: String
+ 		case members
- 	public var type: String
+ 		case sessionId = "session_id"
- 	public var user: UserResponse
+ 		case type
- 	public var video: Bool
+ 		case user
- 	public init(
+ 		case video
-         call: CallResponse,
+ 	public static func == (lhs: CallRingEvent, rhs: CallRingEvent) -> Bool
-         callCid: String,
+ 	public func hash(into hasher: inout Hasher)
-         createdAt: Date,
+ 
-         members: [MemberResponse],
+ public final class CallRtmpBroadcastFailedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
-         sessionId: String,
+ 	public var callCid: String
-         user: UserResponse,
+ 	public var createdAt: Date
-         video: Bool
+ 	public var name: String
-     )
+ 	public var type: String
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public init(callCid: String, createdAt: Date, name: String)
- 		case call
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 		case members
+ 		case name
- 		case sessionId = "session_id"
+ 		case type
- 		case type
+ 	public static func == (lhs: CallRtmpBroadcastFailedEvent, rhs: CallRtmpBroadcastFailedEvent) -> Bool
- 		case user
+ 	public func hash(into hasher: inout Hasher)
- 		case video
+ 
- 	public static func == (lhs: CallRingEvent, rhs: CallRingEvent) -> Bool
+ public final class CallRtmpBroadcastStartedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- 	public func hash(into hasher: inout Hasher)
+ 	public var callCid: String
- 
+ 	public var createdAt: Date
- public final class CallRtmpBroadcastFailedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public var name: String
- 	public var callCid: String
+ 	public var type: String
- 	public var createdAt: Date
+ 	public init(callCid: String, createdAt: Date, name: String)
- 	public var name: String
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var type: String
+ 		case callCid = "call_cid"
- 	public init(callCid: String, createdAt: Date, name: String)
+ 		case createdAt = "created_at"
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case name
- 		case callCid = "call_cid"
+ 		case type
- 		case createdAt = "created_at"
+ 	public static func == (lhs: CallRtmpBroadcastStartedEvent, rhs: CallRtmpBroadcastStartedEvent) -> Bool
- 		case name
+ 	public func hash(into hasher: inout Hasher)
- 		case type
+ 
- 	public static func == (lhs: CallRtmpBroadcastFailedEvent, rhs: CallRtmpBroadcastFailedEvent) -> Bool
+ public final class CallRtmpBroadcastStoppedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- 	public func hash(into hasher: inout Hasher)
+ 	public var callCid: String
- 
+ 	public var createdAt: Date
- public final class CallRtmpBroadcastStartedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public var name: String
- 	public var callCid: String
+ 	public var type: String
- 	public var createdAt: Date
+ 	public init(callCid: String, createdAt: Date, name: String)
- 	public var name: String
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var type: String
+ 		case callCid = "call_cid"
- 	public init(callCid: String, createdAt: Date, name: String)
+ 		case createdAt = "created_at"
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case name
- 		case callCid = "call_cid"
+ 		case type
- 		case createdAt = "created_at"
+ 	public static func == (lhs: CallRtmpBroadcastStoppedEvent, rhs: CallRtmpBroadcastStoppedEvent) -> Bool
- 		case name
+ 	public func hash(into hasher: inout Hasher)
- 		case type
+ 
- 	public static func == (lhs: CallRtmpBroadcastStartedEvent, rhs: CallRtmpBroadcastStartedEvent) -> Bool
+ public final class CallSessionEndedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- 	public func hash(into hasher: inout Hasher)
+ 	public var call: CallResponse
- 
+ 	public var callCid: String
- public final class CallRtmpBroadcastStoppedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public var createdAt: Date
- 	public var callCid: String
+ 	public var sessionId: String
- 	public var createdAt: Date
+ 	public var type: String
- 	public var name: String
+ 	public init(call: CallResponse, callCid: String, createdAt: Date, sessionId: String)
- 	public var type: String
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public init(callCid: String, createdAt: Date, name: String)
+ 		case call
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case callCid = "call_cid"
- 		case callCid = "call_cid"
+ 		case createdAt = "created_at"
- 		case createdAt = "created_at"
+ 		case sessionId = "session_id"
- 		case name
+ 		case type
- 		case type
+ 	public static func == (lhs: CallSessionEndedEvent, rhs: CallSessionEndedEvent) -> Bool
- 	public static func == (lhs: CallRtmpBroadcastStoppedEvent, rhs: CallRtmpBroadcastStoppedEvent) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class CallSessionParticipantCountsUpdatedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- public final class CallSessionEndedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public var anonymousParticipantCount: Int
- 	public var call: CallResponse
+ 	public var callCid: String
- 	public var callCid: String
+ 	public var createdAt: Date
- 	public var createdAt: Date
+ 	public var participantsCountByRole: [String: Int]
- 	public init(call: CallResponse, callCid: String, createdAt: Date, sessionId: String)
+ 	public init(
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+         anonymousParticipantCount: Int,
- 		case call
+         callCid: String,
- 		case callCid = "call_cid"
+         createdAt: Date,
- 		case createdAt = "created_at"
+         participantsCountByRole: [String: Int],
- 		case sessionId = "session_id"
+         sessionId: String
- 		case type
+     )
- 	public static func == (lhs: CallSessionEndedEvent, rhs: CallSessionEndedEvent) -> Bool
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public func hash(into hasher: inout Hasher)
+ 		case anonymousParticipantCount = "anonymous_participant_count"
- 
+ 		case callCid = "call_cid"
- public final class CallSessionParticipantCountsUpdatedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 		case createdAt = "created_at"
- 	public var anonymousParticipantCount: Int
+ 		case participantsCountByRole = "participants_count_by_role"
- 	public var callCid: String
+ 		case sessionId = "session_id"
- 	public var createdAt: Date
+ 		case type
- 	public var participantsCountByRole: [String: Int]
+ 	public static func == (lhs: CallSessionParticipantCountsUpdatedEvent, rhs: CallSessionParticipantCountsUpdatedEvent) -> Bool
- 	public var sessionId: String
+ 	public func hash(into hasher: inout Hasher)
- 	public var type: String
+ 
- 	public init(
+ public final class CallSessionParticipantJoinedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
-         anonymousParticipantCount: Int,
+ 	public var callCid: String
-         callCid: String,
+ 	public var createdAt: Date
-         createdAt: Date,
+ 	public var participant: CallParticipantResponse
-         participantsCountByRole: [String: Int],
+ 	public var sessionId: String
-         sessionId: String
+ 	public var type: String
-     )
+ 	public init(callCid: String, createdAt: Date, participant: CallParticipantResponse, sessionId: String)
- 		case anonymousParticipantCount = "anonymous_participant_count"
+ 		case callCid = "call_cid"
- 		case callCid = "call_cid"
+ 		case createdAt = "created_at"
- 		case createdAt = "created_at"
+ 		case participant
- 		case participantsCountByRole = "participants_count_by_role"
+ 		case sessionId = "session_id"
- 		case sessionId = "session_id"
+ 		case type
- 		case type
+ 	public static func == (lhs: CallSessionParticipantJoinedEvent, rhs: CallSessionParticipantJoinedEvent) -> Bool
- 	public static func == (lhs: CallSessionParticipantCountsUpdatedEvent, rhs: CallSessionParticipantCountsUpdatedEvent) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class CallSessionParticipantLeftEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- public final class CallSessionParticipantJoinedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public var callCid: String
- 	public var callCid: String
+ 	public var createdAt: Date
- 	public var createdAt: Date
+ 	public var durationSeconds: Int
...
- 	public init(callCid: String, createdAt: Date, participant: CallParticipantResponse, sessionId: String)
+ 	public init(callCid: String, createdAt: Date, durationSeconds: Int, participant: CallParticipantResponse, sessionId: String)
...
- 		case participant
+ 		case durationSeconds = "duration_seconds"
- 		case sessionId = "session_id"
+ 		case participant
- 		case type
+ 		case sessionId = "session_id"
- 	public static func == (lhs: CallSessionParticipantJoinedEvent, rhs: CallSessionParticipantJoinedEvent) -> Bool
+ 		case type
- 	public func hash(into hasher: inout Hasher)
+ 	public static func == (lhs: CallSessionParticipantLeftEvent, rhs: CallSessionParticipantLeftEvent) -> Bool
- 
+ 	public func hash(into hasher: inout Hasher)
- public final class CallSessionParticipantLeftEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 
- 	public var callCid: String
+ public final class CallSessionResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public var createdAt: Date
+ 	public var acceptedBy: [String: Date]
- 	public var durationSeconds: Int
+ 	public var anonymousParticipantCount: Int
- 	public var participant: CallParticipantResponse
+ 	public var endedAt: Date?
- 	public var sessionId: String
+ 	public var id: String
- 	public var type: String
+ 	public var liveEndedAt: Date?
- 	public init(callCid: String, createdAt: Date, durationSeconds: Int, participant: CallParticipantResponse, sessionId: String)
+ 	public var liveStartedAt: Date?
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var missedBy: [String: Date]
- 		case callCid = "call_cid"
+ 	public var participants: [CallParticipantResponse]
- 		case createdAt = "created_at"
+ 	public var participantsCountByRole: [String: Int]
- 		case durationSeconds = "duration_seconds"
+ 	public var rejectedBy: [String: Date]
- 		case participant
+ 	public var startedAt: Date?
- 		case sessionId = "session_id"
+ 	public var timerEndsAt: Date?
- 		case type
+ 	public init(
- 	public static func == (lhs: CallSessionParticipantLeftEvent, rhs: CallSessionParticipantLeftEvent) -> Bool
+         acceptedBy: [String: Date],
- 	public func hash(into hasher: inout Hasher)
+         anonymousParticipantCount: Int,
- 
+         endedAt: Date? = nil,
- public final class CallSessionResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+         id: String,
- 	public var acceptedBy: [String: Date]
+         liveEndedAt: Date? = nil,
- 	public var anonymousParticipantCount: Int
+         liveStartedAt: Date? = nil,
- 	public var endedAt: Date?
+         missedBy: [String: Date],
- 	public var id: String
+         participants: [CallParticipantResponse],
- 	public var liveEndedAt: Date?
+         participantsCountByRole: [String: Int],
- 	public var liveStartedAt: Date?
+         rejectedBy: [String: Date],
- 	public var missedBy: [String: Date]
+         startedAt: Date? = nil,
- 	public var participants: [CallParticipantResponse]
+         timerEndsAt: Date? = nil
- 	public var participantsCountByRole: [String: Int]
+     )
- 	public var rejectedBy: [String: Date]
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var startedAt: Date?
+ 		case acceptedBy = "accepted_by"
- 	public var timerEndsAt: Date?
+ 		case anonymousParticipantCount = "anonymous_participant_count"
- 	public init(
+ 		case endedAt = "ended_at"
-         acceptedBy: [String: Date],
+ 		case id
-         anonymousParticipantCount: Int,
+ 		case liveEndedAt = "live_ended_at"
-         endedAt: Date? = nil,
+ 		case liveStartedAt = "live_started_at"
-         id: String,
+ 		case missedBy = "missed_by"
-         liveEndedAt: Date? = nil,
+ 		case participants
-         liveStartedAt: Date? = nil,
+ 		case participantsCountByRole = "participants_count_by_role"
-         missedBy: [String: Date],
+ 		case rejectedBy = "rejected_by"
-         participants: [CallParticipantResponse],
+ 		case startedAt = "started_at"
-         participantsCountByRole: [String: Int],
+ 		case timerEndsAt = "timer_ends_at"
-         rejectedBy: [String: Date],
+ 	public static func == (lhs: CallSessionResponse, rhs: CallSessionResponse) -> Bool
-         startedAt: Date? = nil,
+ 	public func hash(into hasher: inout Hasher)
-         timerEndsAt: Date? = nil
+ 
-     )
+ public final class CallSessionStartedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var call: CallResponse
- 		case acceptedBy = "accepted_by"
+ 	public var callCid: String
- 		case anonymousParticipantCount = "anonymous_participant_count"
+ 	public var createdAt: Date
- 		case endedAt = "ended_at"
+ 	public var sessionId: String
- 		case id
+ 	public var type: String
- 		case liveEndedAt = "live_ended_at"
+ 	public init(call: CallResponse, callCid: String, createdAt: Date, sessionId: String)
- 		case liveStartedAt = "live_started_at"
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 		case missedBy = "missed_by"
+ 		case call
- 		case participants
+ 		case callCid = "call_cid"
- 		case participantsCountByRole = "participants_count_by_role"
+ 		case createdAt = "created_at"
- 		case rejectedBy = "rejected_by"
+ 		case sessionId = "session_id"
- 		case startedAt = "started_at"
+ 		case type
- 		case timerEndsAt = "timer_ends_at"
+ 	public static func == (lhs: CallSessionStartedEvent, rhs: CallSessionStartedEvent) -> Bool
- 	public static func == (lhs: CallSessionResponse, rhs: CallSessionResponse) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class CallSettingsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- public final class CallSessionStartedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public var audio: AudioSettingsRequest?
- 	public var call: CallResponse
+ 	public var backstage: BackstageSettingsRequest?
- 	public var callCid: String
+ 	public var broadcasting: BroadcastSettingsRequest?
- 	public var createdAt: Date
+ 	public var geofencing: GeofenceSettingsRequest?
- 	public var sessionId: String
+ 	public var limits: LimitsSettingsRequest?
- 	public var type: String
+ 	public var recording: RecordSettingsRequest?
- 	public init(call: CallResponse, callCid: String, createdAt: Date, sessionId: String)
+ 	public var ring: RingSettingsRequest?
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var screensharing: ScreensharingSettingsRequest?
- 		case call
+ 	public var session: SessionSettingsRequest?
- 		case callCid = "call_cid"
+ 	public var thumbnails: ThumbnailsSettingsRequest?
- 		case createdAt = "created_at"
+ 	public var transcription: TranscriptionSettingsRequest?
- 		case sessionId = "session_id"
+ 	public var video: VideoSettingsRequest?
- 		case type
+ 	public init(
- 	public static func == (lhs: CallSessionStartedEvent, rhs: CallSessionStartedEvent) -> Bool
+         audio: AudioSettingsRequest? = nil,
- 	public func hash(into hasher: inout Hasher)
+         backstage: BackstageSettingsRequest? = nil,
- 
+         broadcasting: BroadcastSettingsRequest? = nil,
- public final class CallSettingsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+         geofencing: GeofenceSettingsRequest? = nil,
- 	public var audio: AudioSettingsRequest?
+         limits: LimitsSettingsRequest? = nil,
- 	public var backstage: BackstageSettingsRequest?
+         recording: RecordSettingsRequest? = nil,
- 	public var broadcasting: BroadcastSettingsRequest?
+         ring: RingSettingsRequest? = nil,
- 	public var geofencing: GeofenceSettingsRequest?
+         screensharing: ScreensharingSettingsRequest? = nil,
- 	public var limits: LimitsSettingsRequest?
+         session: SessionSettingsRequest? = nil,
- 	public var recording: RecordSettingsRequest?
+         thumbnails: ThumbnailsSettingsRequest? = nil,
- 	public var ring: RingSettingsRequest?
+         transcription: TranscriptionSettingsRequest? = nil,
- 	public var screensharing: ScreensharingSettingsRequest?
+         video: VideoSettingsRequest? = nil
- 	public var session: SessionSettingsRequest?
+     )
- 	public var thumbnails: ThumbnailsSettingsRequest?
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var transcription: TranscriptionSettingsRequest?
+ 		case audio
- 	public var video: VideoSettingsRequest?
+ 		case backstage
- 	public init(
+ 		case broadcasting
-         audio: AudioSettingsRequest? = nil,
+ 		case geofencing
-         backstage: BackstageSettingsRequest? = nil,
+ 		case limits
-         broadcasting: BroadcastSettingsRequest? = nil,
+ 		case recording
-         geofencing: GeofenceSettingsRequest? = nil,
+ 		case ring
-         limits: LimitsSettingsRequest? = nil,
+ 		case screensharing
-         recording: RecordSettingsRequest? = nil,
+ 		case session
-         ring: RingSettingsRequest? = nil,
+ 		case thumbnails
-         screensharing: ScreensharingSettingsRequest? = nil,
+ 		case transcription
-         session: SessionSettingsRequest? = nil,
+ 		case video
-         thumbnails: ThumbnailsSettingsRequest? = nil,
+ 	public static func == (lhs: CallSettingsRequest, rhs: CallSettingsRequest) -> Bool
-         transcription: TranscriptionSettingsRequest? = nil,
+ 	public func hash(into hasher: inout Hasher)
-         video: VideoSettingsRequest? = nil
+ 
-     )
+ public final class CallSettingsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var audio: AudioSettings
- 		case audio
+ 	public var backstage: BackstageSettings
- 		case backstage
+ 	public var broadcasting: BroadcastSettingsResponse
- 		case broadcasting
+ 	public var geofencing: GeofenceSettings
- 		case geofencing
+ 	public var limits: LimitsSettingsResponse
- 		case limits
+ 	public var recording: RecordSettingsResponse
- 		case recording
+ 	public var ring: RingSettings
- 		case ring
+ 	public var screensharing: ScreensharingSettings
- 		case screensharing
+ 	public var session: SessionSettingsResponse
- 		case session
+ 	public var thumbnails: ThumbnailsSettings
- 		case thumbnails
+ 	public var transcription: TranscriptionSettings
- 		case transcription
+ 	public var video: VideoSettings
- 		case video
+ 	public init(
- 	public static func == (lhs: CallSettingsRequest, rhs: CallSettingsRequest) -> Bool
+         audio: AudioSettings,
- 	public func hash(into hasher: inout Hasher)
+         backstage: BackstageSettings,
- 
+         broadcasting: BroadcastSettingsResponse,
- public final class CallSettingsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+         geofencing: GeofenceSettings,
- 	public var audio: AudioSettings
+         limits: LimitsSettingsResponse,
- 	public var backstage: BackstageSettings
+         recording: RecordSettingsResponse,
- 	public var broadcasting: BroadcastSettingsResponse
+         ring: RingSettings,
- 	public var geofencing: GeofenceSettings
+         screensharing: ScreensharingSettings,
- 	public var limits: LimitsSettingsResponse
+         session: SessionSettingsResponse,
- 	public var recording: RecordSettingsResponse
+         thumbnails: ThumbnailsSettings,
- 	public var ring: RingSettings
+         transcription: TranscriptionSettings,
- 	public var screensharing: ScreensharingSettings
+         video: VideoSettings
- 	public var session: SessionSettingsResponse
+     )
- 	public var thumbnails: ThumbnailsSettings
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var transcription: TranscriptionSettings
+ 		case audio
- 	public var video: VideoSettings
+ 		case backstage
- 	public init(
+ 		case broadcasting
-         audio: AudioSettings,
+ 		case geofencing
-         backstage: BackstageSettings,
+ 		case limits
-         broadcasting: BroadcastSettingsResponse,
+ 		case recording
-         geofencing: GeofenceSettings,
+ 		case ring
-         limits: LimitsSettingsResponse,
+ 		case screensharing
-         recording: RecordSettingsResponse,
+ 		case session
-         ring: RingSettings,
+ 		case thumbnails
-         screensharing: ScreensharingSettings,
+ 		case transcription
-         session: SessionSettingsResponse,
+ 		case video
-         thumbnails: ThumbnailsSettings,
+ 	public static func == (lhs: CallSettingsResponse, rhs: CallSettingsResponse) -> Bool
-         transcription: TranscriptionSettings,
+ 	public func hash(into hasher: inout Hasher)
-         video: VideoSettings
+ 
-     )
+ public final class CallStateResponseFields : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var call: CallResponse
- 		case audio
+ 	public var members: [MemberResponse]
- 		case backstage
+ 	public var membership: MemberResponse?
- 		case broadcasting
+ 	public var ownCapabilities: [OwnCapability]
- 		case geofencing
+ 	public init(
- 		case limits
+         call: CallResponse,
- 		case recording
+         members: [MemberResponse],
- 		case ring
+         membership: MemberResponse? = nil,
- 		case screensharing
+         ownCapabilities: [OwnCapability]
- 		case session
+     )
- 		case thumbnails
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 		case transcription
+ 		case call
- 		case video
+ 		case members
- 	public static func == (lhs: CallSettingsResponse, rhs: CallSettingsResponse) -> Bool
+ 		case membership
- 	public func hash(into hasher: inout Hasher)
+ 		case ownCapabilities = "own_capabilities"
- 
+ 	public static func == (lhs: CallStateResponseFields, rhs: CallStateResponseFields) -> Bool
- public final class CallStateResponseFields : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public func hash(into hasher: inout Hasher)
- 	public var call: CallResponse
+ 
- 	public var members: [MemberResponse]
+ public final class CallStatsReportSummaryResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public var membership: MemberResponse?
+ 	public var callCid: String
- 	public var ownCapabilities: [OwnCapability]
+ 	public var callDurationSeconds: Int
- 	public init(
+ 	public var callSessionId: String
-         call: CallResponse,
+ 	public var callStatus: String
-         members: [MemberResponse],
+ 	public var createdAt: Date?
-         membership: MemberResponse? = nil,
+ 	public var firstStatsTime: Date
-         ownCapabilities: [OwnCapability]
+ 	public var minUserRating: Int?
-     )
+ 	public var qualityScore: Int?
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public init(
- 		case call
+         callCid: String,
- 		case members
+         callDurationSeconds: Int,
- 		case membership
+         callSessionId: String,
- 		case ownCapabilities = "own_capabilities"
+         callStatus: String,
- 	public static func == (lhs: CallStateResponseFields, rhs: CallStateResponseFields) -> Bool
+         createdAt: Date? = nil,
- 	public func hash(into hasher: inout Hasher)
+         firstStatsTime: Date,
- 
+         minUserRating: Int? = nil,
- public final class CallStatsReportSummaryResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+         qualityScore: Int? = nil
- 	public var callCid: String
+     )
- 	public var callDurationSeconds: Int
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var callSessionId: String
+ 		case callCid = "call_cid"
- 	public var callStatus: String
+ 		case callDurationSeconds = "call_duration_seconds"
- 	public var createdAt: Date?
+ 		case callSessionId = "call_session_id"
- 	public var firstStatsTime: Date
+ 		case callStatus = "call_status"
- 	public var minUserRating: Int?
+ 		case createdAt = "created_at"
- 	public var qualityScore: Int?
+ 		case firstStatsTime = "first_stats_time"
- 	public init(
+ 		case minUserRating = "min_user_rating"
-         callCid: String,
+ 		case qualityScore = "quality_score"
-         callDurationSeconds: Int,
+ 	public static func == (lhs: CallStatsReportSummaryResponse, rhs: CallStatsReportSummaryResponse) -> Bool
-         callSessionId: String,
+ 	public func hash(into hasher: inout Hasher)
-         callStatus: String,
+ 
-         createdAt: Date? = nil,
+ public final class CallTimeline : @unchecked Sendable, Codable, JSONEncodable, Hashable
-         firstStatsTime: Date,
+ 	public var events: [CallEvent]
-         minUserRating: Int? = nil,
+ 	public init(events: [CallEvent])
-         qualityScore: Int? = nil
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
-     )
+ 		case events
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public static func == (lhs: CallTimeline, rhs: CallTimeline) -> Bool
- 		case callCid = "call_cid"
+ 	public func hash(into hasher: inout Hasher)
- 		case callDurationSeconds = "call_duration_seconds"
+ 
- 		case callSessionId = "call_session_id"
+ public final class CallTranscription : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case callStatus = "call_status"
+ 	public var endTime: Date
- 		case createdAt = "created_at"
+ 	public var filename: String
- 		case firstStatsTime = "first_stats_time"
+ 	public var startTime: Date
- 		case minUserRating = "min_user_rating"
+ 	public var url: String
- 		case qualityScore = "quality_score"
+ 	public init(endTime: Date, filename: String, startTime: Date, url: String)
- 	public static func == (lhs: CallStatsReportSummaryResponse, rhs: CallStatsReportSummaryResponse) -> Bool
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public func hash(into hasher: inout Hasher)
+ 		case endTime = "end_time"
- 
+ 		case filename
- public final class CallTimeline : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case startTime = "start_time"
- 	public var events: [CallEvent]
+ 		case url
- 	public init(events: [CallEvent])
+ 	public static func == (lhs: CallTranscription, rhs: CallTranscription) -> Bool
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public func hash(into hasher: inout Hasher)
- 		case events
+ 
- 	public static func == (lhs: CallTimeline, rhs: CallTimeline) -> Bool
+ public final class CallTranscriptionFailedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- 	public func hash(into hasher: inout Hasher)
+ 	public var callCid: String
- 
+ 	public var createdAt: Date
- public final class CallTranscription : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var type: String
- 	public var endTime: Date
+ 	public init(callCid: String, createdAt: Date)
- 	public var filename: String
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var startTime: Date
+ 		case callCid = "call_cid"
- 	public var url: String
+ 		case createdAt = "created_at"
- 	public init(endTime: Date, filename: String, startTime: Date, url: String)
+ 		case type
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public static func == (lhs: CallTranscriptionFailedEvent, rhs: CallTranscriptionFailedEvent) -> Bool
- 		case endTime = "end_time"
+ 	public func hash(into hasher: inout Hasher)
- 		case filename
+ 
- 		case startTime = "start_time"
+ public final class CallTranscriptionReadyEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- 		case url
+ 	public var callCid: String
- 	public static func == (lhs: CallTranscription, rhs: CallTranscription) -> Bool
+ 	public var callTranscription: CallTranscription
- 	public func hash(into hasher: inout Hasher)
+ 	public var createdAt: Date
- 
+ 	public var type: String
- public final class CallTranscriptionFailedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public init(callCid: String, callTranscription: CallTranscription, createdAt: Date)
- 	public var callCid: String
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var createdAt: Date
+ 		case callCid = "call_cid"
- 	public var type: String
+ 		case callTranscription = "call_transcription"
- 	public init(callCid: String, createdAt: Date)
+ 		case createdAt = "created_at"
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case type
- 		case callCid = "call_cid"
+ 	public static func == (lhs: CallTranscriptionReadyEvent, rhs: CallTranscriptionReadyEvent) -> Bool
- 		case createdAt = "created_at"
+ 	public func hash(into hasher: inout Hasher)
- 		case type
+ 
- 	public static func == (lhs: CallTranscriptionFailedEvent, rhs: CallTranscriptionFailedEvent) -> Bool
+ public final class CallTranscriptionStartedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- 	public func hash(into hasher: inout Hasher)
+ 	public var callCid: String
- 
+ 	public var createdAt: Date
- public final class CallTranscriptionReadyEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public var type: String
- 	public var callCid: String
+ 	public init(callCid: String, createdAt: Date)
- 	public var callTranscription: CallTranscription
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var createdAt: Date
+ 		case callCid = "call_cid"
- 	public var type: String
+ 		case createdAt = "created_at"
- 	public init(callCid: String, callTranscription: CallTranscription, createdAt: Date)
+ 		case type
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public static func == (lhs: CallTranscriptionStartedEvent, rhs: CallTranscriptionStartedEvent) -> Bool
- 		case callCid = "call_cid"
+ 	public func hash(into hasher: inout Hasher)
- 		case callTranscription = "call_transcription"
+ 
- 		case createdAt = "created_at"
+ public final class CallTranscriptionStoppedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- 		case type
+ 	public var callCid: String
- 	public static func == (lhs: CallTranscriptionReadyEvent, rhs: CallTranscriptionReadyEvent) -> Bool
+ 	public var createdAt: Date
- 	public func hash(into hasher: inout Hasher)
+ 	public var type: String
- 
+ 	public init(callCid: String, createdAt: Date)
- public final class CallTranscriptionStartedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var callCid: String
+ 		case callCid = "call_cid"
- 	public var createdAt: Date
+ 		case createdAt = "created_at"
- 	public var type: String
+ 		case type
- 	public init(callCid: String, createdAt: Date)
+ 	public static func == (lhs: CallTranscriptionStoppedEvent, rhs: CallTranscriptionStoppedEvent) -> Bool
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public func hash(into hasher: inout Hasher)
- 		case callCid = "call_cid"
+ 
- 		case createdAt = "created_at"
+ public final class CallUpdatedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- 		case type
+ 	public var call: CallResponse
- 	public static func == (lhs: CallTranscriptionStartedEvent, rhs: CallTranscriptionStartedEvent) -> Bool
+ 	public var callCid: String
- 	public func hash(into hasher: inout Hasher)
+ 	public var capabilitiesByRole: [String: [String]]
- 
+ 	public var createdAt: Date
- public final class CallTranscriptionStoppedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public var type: String
- 	public var callCid: String
+ 	public init(call: CallResponse, callCid: String, capabilitiesByRole: [String: [String]], createdAt: Date)
- 	public var createdAt: Date
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var type: String
+ 		case call
- 	public init(callCid: String, createdAt: Date)
+ 		case callCid = "call_cid"
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case capabilitiesByRole = "capabilities_by_role"
- 		case callCid = "call_cid"
+ 		case createdAt = "created_at"
- 		case createdAt = "created_at"
+ 		case type
- 		case type
+ 	public static func == (lhs: CallUpdatedEvent, rhs: CallUpdatedEvent) -> Bool
- 	public static func == (lhs: CallTranscriptionStoppedEvent, rhs: CallTranscriptionStoppedEvent) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class CallUserMutedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- public final class CallUpdatedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public var callCid: String
- 	public var call: CallResponse
+ 	public var createdAt: Date
- 	public var callCid: String
+ 	public var fromUserId: String
- 	public var capabilitiesByRole: [String: [String]]
+ 	public var mutedUserIds: [String]
- 	public var createdAt: Date
+ 	public var type: String
- 	public var type: String
+ 	public init(callCid: String, createdAt: Date, fromUserId: String, mutedUserIds: [String])
- 	public init(call: CallResponse, callCid: String, capabilitiesByRole: [String: [String]], createdAt: Date)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case callCid = "call_cid"
- 		case call
+ 		case createdAt = "created_at"
- 		case callCid = "call_cid"
+ 		case fromUserId = "from_user_id"
- 		case capabilitiesByRole = "capabilities_by_role"
+ 		case mutedUserIds = "muted_user_ids"
- 		case createdAt = "created_at"
+ 		case type
- 		case type
+ 	public static func == (lhs: CallUserMutedEvent, rhs: CallUserMutedEvent) -> Bool
- 	public static func == (lhs: CallUpdatedEvent, rhs: CallUpdatedEvent) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class ClosedCaptionEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- public final class CallUserMutedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public var callCid: String
- 	public var callCid: String
+ 	public var closedCaption: CallClosedCaption
- 	public var fromUserId: String
+ 	public var type: String
- 	public var mutedUserIds: [String]
+ 	public init(callCid: String, closedCaption: CallClosedCaption, createdAt: Date)
- 	public var type: String
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public init(callCid: String, createdAt: Date, fromUserId: String, mutedUserIds: [String])
+ 		case callCid = "call_cid"
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case closedCaption = "closed_caption"
- 		case callCid = "call_cid"
+ 		case createdAt = "created_at"
- 		case createdAt = "created_at"
+ 		case type
- 		case fromUserId = "from_user_id"
+ 	public static func == (lhs: ClosedCaptionEvent, rhs: ClosedCaptionEvent) -> Bool
- 		case mutedUserIds = "muted_user_ids"
+ 	public func hash(into hasher: inout Hasher)
- 		case type
+ 
- 	public static func == (lhs: CallUserMutedEvent, rhs: CallUserMutedEvent) -> Bool
+ public final class CollectUserFeedbackRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public func hash(into hasher: inout Hasher)
+ 	public var custom: [String: RawJSON]?
- 
+ 	public var rating: Int
- public final class ClosedCaptionEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public var reason: String?
- 	public var callCid: String
+ 	public var sdk: String
- 	public var closedCaption: CallClosedCaption
+ 	public var sdkVersion: String
- 	public var createdAt: Date
+ 	public var userSessionId: String
- 	public var type: String
+ 	public init(
- 	public init(callCid: String, closedCaption: CallClosedCaption, createdAt: Date)
+         custom: [String: RawJSON]? = nil,
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+         rating: Int,
- 		case callCid = "call_cid"
+         reason: String? = nil,
- 		case closedCaption = "closed_caption"
+         sdk: String,
- 		case createdAt = "created_at"
+         sdkVersion: String,
- 		case type
+         userSessionId: String
- 	public static func == (lhs: ClosedCaptionEvent, rhs: ClosedCaptionEvent) -> Bool
+     )
- 	public func hash(into hasher: inout Hasher)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 
+ 		case custom
- public final class CollectUserFeedbackRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case rating
- 	public var custom: [String: RawJSON]?
+ 		case reason
- 	public var rating: Int
+ 		case sdk
- 	public var reason: String?
+ 		case sdkVersion = "sdk_version"
- 	public var sdk: String
+ 		case userSessionId = "user_session_id"
- 	public var sdkVersion: String
+ 	public static func == (lhs: CollectUserFeedbackRequest, rhs: CollectUserFeedbackRequest) -> Bool
- 	public var userSessionId: String
+ 	public func hash(into hasher: inout Hasher)
- 	public init(
+ 
-         custom: [String: RawJSON]? = nil,
+ public final class CollectUserFeedbackResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
-         rating: Int,
+ 	public var duration: String
-         reason: String? = nil,
+ 	public init(duration: String)
-         sdk: String,
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
-         sdkVersion: String,
+ 		case duration
-         userSessionId: String
+ 	public static func == (lhs: CollectUserFeedbackResponse, rhs: CollectUserFeedbackResponse) -> Bool
-     )
+ 	public func hash(into hasher: inout Hasher)
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 
- 		case custom
+ public final class ConnectUserDetailsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case rating
+ 	public var custom: [String: RawJSON]?
- 		case reason
+ 	public var id: String
- 		case sdk
+ 	public var image: String?
- 		case sdkVersion = "sdk_version"
+ 	public var invisible: Bool?
- 		case userSessionId = "user_session_id"
+ 	public var language: String?
- 	public static func == (lhs: CollectUserFeedbackRequest, rhs: CollectUserFeedbackRequest) -> Bool
+ 	public var name: String?
- 	public func hash(into hasher: inout Hasher)
+ 	public init(
- 
+         custom: [String: RawJSON]? = nil,
- public final class CollectUserFeedbackResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+         id: String,
- 	public var duration: String
+         image: String? = nil,
- 	public init(duration: String)
+         invisible: Bool? = nil,
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+         language: String? = nil,
- 		case duration
+         name: String? = nil
- 	public static func == (lhs: CollectUserFeedbackResponse, rhs: CollectUserFeedbackResponse) -> Bool
+     )
- 	public func hash(into hasher: inout Hasher)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 
+ 		case custom
- public final class ConnectUserDetailsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case id
- 	public var custom: [String: RawJSON]?
+ 		case image
- 	public var id: String
+ 		case invisible
- 	public var image: String?
+ 		case language
- 	public var invisible: Bool?
+ 		case name
- 	public var language: String?
+ 	public static func == (lhs: ConnectUserDetailsRequest, rhs: ConnectUserDetailsRequest) -> Bool
- 	public var name: String?
+ 	public func hash(into hasher: inout Hasher)
- 	public init(
+ 
-         custom: [String: RawJSON]? = nil,
+ public final class ConnectedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable
-         id: String,
+ 	public var connectionId: String
-         image: String? = nil,
+ 	public var createdAt: Date
-         invisible: Bool? = nil,
+ 	public var me: OwnUserResponse
-         language: String? = nil,
+ 	public var type: String
-         name: String? = nil
+ 	public init(connectionId: String, createdAt: Date, me: OwnUserResponse)
-     )
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case connectionId = "connection_id"
- 		case custom
+ 		case createdAt = "created_at"
- 		case id
+ 		case me
- 		case image
+ 		case type
- 		case invisible
+ 	public static func == (lhs: ConnectedEvent, rhs: ConnectedEvent) -> Bool
- 		case language
+ 	public func hash(into hasher: inout Hasher)
- 		case name
+ 
- 	public static func == (lhs: ConnectUserDetailsRequest, rhs: ConnectUserDetailsRequest) -> Bool
+ public final class ConnectionErrorEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable
- 	public func hash(into hasher: inout Hasher)
+ 	public var connectionId: String
- 
+ 	public var createdAt: Date
- public final class ConnectedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable
+ 	public var error: APIError
- 	public var connectionId: String
+ 	public var type: String
- 	public var createdAt: Date
+ 	public init(connectionId: String, createdAt: Date, error: APIError)
- 	public var me: OwnUserResponse
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var type: String
+ 		case connectionId = "connection_id"
- 	public init(connectionId: String, createdAt: Date, me: OwnUserResponse)
+ 		case createdAt = "created_at"
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case error
- 		case connectionId = "connection_id"
+ 		case type
- 		case createdAt = "created_at"
+ 	public static func == (lhs: ConnectionErrorEvent, rhs: ConnectionErrorEvent) -> Bool
- 		case me
+ 	public func hash(into hasher: inout Hasher)
- 		case type
+ 
- 	public static func == (lhs: ConnectedEvent, rhs: ConnectedEvent) -> Bool
+ public final class Coordinates : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public func hash(into hasher: inout Hasher)
+ 	public var latitude: Float
- 
+ 	public var longitude: Float
- public final class ConnectionErrorEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable
+ 	public init(latitude: Float, longitude: Float)
- 	public var connectionId: String
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var createdAt: Date
+ 		case latitude
- 	public var error: APIError
+ 		case longitude
- 	public var type: String
+ 	public static func == (lhs: Coordinates, rhs: Coordinates) -> Bool
- 	public init(connectionId: String, createdAt: Date, error: APIError)
+ 	public func hash(into hasher: inout Hasher)
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 
- 		case connectionId = "connection_id"
+ public final class Count : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case createdAt = "created_at"
+ 	public var approximate: Bool
- 		case error
+ 	public var value: Int
- 		case type
+ 	public init(approximate: Bool, value: Int)
- 	public static func == (lhs: ConnectionErrorEvent, rhs: ConnectionErrorEvent) -> Bool
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public func hash(into hasher: inout Hasher)
+ 		case approximate
- 
+ 		case value
- public final class Coordinates : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public static func == (lhs: Count, rhs: Count) -> Bool
- 	public var latitude: Float
+ 	public func hash(into hasher: inout Hasher)
- 	public var longitude: Float
+ 
- 	public init(latitude: Float, longitude: Float)
+ public final class CountrywiseAggregateStats : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var participantCount: Count?
- 		case latitude
+ 	public var publisherJitter: Stats?
- 		case longitude
+ 	public var publisherLatency: Stats?
- 	public static func == (lhs: Coordinates, rhs: Coordinates) -> Bool
+ 	public var subscriberJitter: Stats?
- 	public func hash(into hasher: inout Hasher)
+ 	public var subscriberLatency: Stats?
- 
+ 	public init(
- public final class Count : @unchecked Sendable, Codable, JSONEncodable, Hashable
+         participantCount: Count? = nil,
- 	public var approximate: Bool
+         publisherJitter: Stats? = nil,
- 	public var value: Int
+         publisherLatency: Stats? = nil,
- 	public init(approximate: Bool, value: Int)
+         subscriberJitter: Stats? = nil,
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+         subscriberLatency: Stats? = nil
- 		case approximate
+     )
- 		case value
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public static func == (lhs: Count, rhs: Count) -> Bool
+ 		case participantCount = "participant_count"
- 	public func hash(into hasher: inout Hasher)
+ 		case publisherJitter = "publisher_jitter"
- 
+ 		case publisherLatency = "publisher_latency"
- public final class CountrywiseAggregateStats : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case subscriberJitter = "subscriber_jitter"
- 	public var participantCount: Count?
+ 		case subscriberLatency = "subscriber_latency"
- 	public var publisherJitter: Stats?
+ 	public static func == (lhs: CountrywiseAggregateStats, rhs: CountrywiseAggregateStats) -> Bool
- 	public var publisherLatency: Stats?
+ 	public func hash(into hasher: inout Hasher)
- 	public var subscriberJitter: Stats?
+ 
- 	public var subscriberLatency: Stats?
+ public final class CreateDeviceRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public init(
+ 	public enum PushProvider : String, Sendable, Codable, CaseIterable
-         participantCount: Count? = nil,
+ 		case apn
-         publisherJitter: Stats? = nil,
+ 		case firebase
-         publisherLatency: Stats? = nil,
+ 		case huawei
-         subscriberJitter: Stats? = nil,
+ 		case xiaomi
-         subscriberLatency: Stats? = nil
+ 		case unknown = "_unknown"
-     )
+ 		public init(from decoder: Decoder) throws
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var id: String
- 		case participantCount = "participant_count"
+ 	public var pushProvider: PushProvider
- 		case publisherJitter = "publisher_jitter"
+ 	public var pushProviderName: String?
- 		case publisherLatency = "publisher_latency"
+ 	public var voipToken: Bool?
- 		case subscriberJitter = "subscriber_jitter"
+ 	public init(id: String, pushProvider: PushProvider, pushProviderName: String? = nil, voipToken: Bool? = nil)
- 		case subscriberLatency = "subscriber_latency"
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public static func == (lhs: CountrywiseAggregateStats, rhs: CountrywiseAggregateStats) -> Bool
+ 		case id
- 	public func hash(into hasher: inout Hasher)
+ 		case pushProvider = "push_provider"
- 
+ 		case pushProviderName = "push_provider_name"
- public final class CreateDeviceRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case voipToken = "voip_token"
- 	public enum PushProvider : String, Sendable, Codable, CaseIterable
+ 	public static func == (lhs: CreateDeviceRequest, rhs: CreateDeviceRequest) -> Bool
- 		case apn
+ 	public func hash(into hasher: inout Hasher)
- 		case firebase
+ 
- 		case huawei
+ public final class CreateGuestRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case xiaomi
+ 	public var user: UserRequest
- 		case unknown = "_unknown"
+ 	public init(user: UserRequest)
- 		public init(from decoder: Decoder) throws
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var id: String
+ 		case user
- 	public var pushProvider: PushProvider
+ 	public static func == (lhs: CreateGuestRequest, rhs: CreateGuestRequest) -> Bool
- 	public var pushProviderName: String?
+ 	public func hash(into hasher: inout Hasher)
- 	public var voipToken: Bool?
+ 
- 	public init(id: String, pushProvider: PushProvider, pushProviderName: String? = nil, voipToken: Bool? = nil)
+ public final class CreateGuestResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var accessToken: String
- 		case id
+ 	public var duration: String
- 		case pushProvider = "push_provider"
+ 	public var user: UserResponse
- 		case pushProviderName = "push_provider_name"
+ 	public init(accessToken: String, duration: String, user: UserResponse)
- 		case voipToken = "voip_token"
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public static func == (lhs: CreateDeviceRequest, rhs: CreateDeviceRequest) -> Bool
+ 		case accessToken = "access_token"
- 	public func hash(into hasher: inout Hasher)
+ 		case duration
- 
+ 		case user
- public final class CreateGuestRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public static func == (lhs: CreateGuestResponse, rhs: CreateGuestResponse) -> Bool
- 	public var user: UserRequest
+ 	public func hash(into hasher: inout Hasher)
- 	public init(user: UserRequest)
+ 
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ public final class Credentials : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case user
+ 	public var iceServers: [ICEServer]
- 	public static func == (lhs: CreateGuestRequest, rhs: CreateGuestRequest) -> Bool
+ 	public var server: SFUResponse
- 	public func hash(into hasher: inout Hasher)
+ 	public var token: String
- 
+ 	public init(iceServers: [ICEServer], server: SFUResponse, token: String)
- public final class CreateGuestResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var accessToken: String
+ 		case iceServers = "ice_servers"
- 	public var duration: String
+ 		case server
- 	public var user: UserResponse
+ 		case token
- 	public init(accessToken: String, duration: String, user: UserResponse)
+ 	public static func == (lhs: Credentials, rhs: Credentials) -> Bool
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public func hash(into hasher: inout Hasher)
- 		case accessToken = "access_token"
+ 
- 		case duration
+ public final class CustomVideoEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- 		case user
+ 	public var callCid: String
- 	public static func == (lhs: CreateGuestResponse, rhs: CreateGuestResponse) -> Bool
+ 	public var createdAt: Date
- 	public func hash(into hasher: inout Hasher)
+ 	public var custom: [String: RawJSON]
- 
+ 	public var type: String
- public final class Credentials : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var user: UserResponse
- 	public var iceServers: [ICEServer]
+ 	public init(callCid: String, createdAt: Date, custom: [String: RawJSON], user: UserResponse)
- 	public var server: SFUResponse
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var token: String
+ 		case callCid = "call_cid"
- 	public init(iceServers: [ICEServer], server: SFUResponse, token: String)
+ 		case createdAt = "created_at"
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case custom
- 		case iceServers = "ice_servers"
+ 		case type
- 		case server
+ 		case user
- 		case token
+ 	public static func == (lhs: CustomVideoEvent, rhs: CustomVideoEvent) -> Bool
- 	public static func == (lhs: Credentials, rhs: Credentials) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class DeleteCallRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- public final class CustomVideoEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public var hard: Bool?
- 	public var callCid: String
+ 	public init(hard: Bool? = nil)
- 	public var createdAt: Date
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var custom: [String: RawJSON]
+ 		case hard
- 	public var type: String
+ 	public static func == (lhs: DeleteCallRequest, rhs: DeleteCallRequest) -> Bool
- 	public var user: UserResponse
+ 	public func hash(into hasher: inout Hasher)
- 	public init(callCid: String, createdAt: Date, custom: [String: RawJSON], user: UserResponse)
+ 
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ public final class DeleteCallResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case callCid = "call_cid"
+ 	public var call: CallResponse
- 		case createdAt = "created_at"
+ 	public var duration: String
- 		case custom
+ 	public var taskId: String?
- 		case type
+ 	public init(call: CallResponse, duration: String, taskId: String? = nil)
- 		case user
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public static func == (lhs: CustomVideoEvent, rhs: CustomVideoEvent) -> Bool
+ 		case call
- 	public func hash(into hasher: inout Hasher)
+ 		case duration
- 
+ 		case taskId = "task_id"
- public final class DeleteCallRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public static func == (lhs: DeleteCallResponse, rhs: DeleteCallResponse) -> Bool
- 	public var hard: Bool?
+ 	public func hash(into hasher: inout Hasher)
- 	public init(hard: Bool? = nil)
+ 
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ public final class DeleteRecordingResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case hard
+ 	public var duration: String
- 	public static func == (lhs: DeleteCallRequest, rhs: DeleteCallRequest) -> Bool
+ 	public init(duration: String)
- 	public func hash(into hasher: inout Hasher)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 
+ 		case duration
- public final class DeleteCallResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public static func == (lhs: DeleteRecordingResponse, rhs: DeleteRecordingResponse) -> Bool
- 	public var call: CallResponse
+ 	public func hash(into hasher: inout Hasher)
- 	public var duration: String
+ 
- 	public var taskId: String?
+ public final class DeleteTranscriptionResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public init(call: CallResponse, duration: String, taskId: String? = nil)
+ 	public var duration: String
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public init(duration: String)
- 		case call
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 		case taskId = "task_id"
+ 	public static func == (lhs: DeleteTranscriptionResponse, rhs: DeleteTranscriptionResponse) -> Bool
- 	public static func == (lhs: DeleteCallResponse, rhs: DeleteCallResponse) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class Device : @unchecked Sendable, Codable, JSONEncodable, Hashable
- public final class DeleteRecordingResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var createdAt: Date
- 	public var duration: String
+ 	public var disabled: Bool?
- 	public init(duration: String)
+ 	public var disabledReason: String?
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var id: String
- 		case duration
+ 	public var pushProvider: String
- 	public static func == (lhs: DeleteRecordingResponse, rhs: DeleteRecordingResponse) -> Bool
+ 	public var pushProviderName: String?
- 	public func hash(into hasher: inout Hasher)
+ 	public var userId: String
- 
+ 	public var voip: Bool?
- public final class DeleteTranscriptionResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public init(
- 	public var duration: String
+         createdAt: Date,
- 	public init(duration: String)
+         disabled: Bool? = nil,
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+         disabledReason: String? = nil,
- 		case duration
+         id: String,
- 	public static func == (lhs: DeleteTranscriptionResponse, rhs: DeleteTranscriptionResponse) -> Bool
+         pushProvider: String,
- 	public func hash(into hasher: inout Hasher)
+         pushProviderName: String? = nil,
- 
+         userId: String,
- public final class Device : @unchecked Sendable, Codable, JSONEncodable, Hashable
+         voip: Bool? = nil
- 	public var createdAt: Date
+     )
- 	public var disabled: Bool?
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var disabledReason: String?
+ 		case createdAt = "created_at"
- 	public var id: String
+ 		case disabled
- 	public var pushProvider: String
+ 		case disabledReason = "disabled_reason"
- 	public var pushProviderName: String?
+ 		case id
- 	public var userId: String
+ 		case pushProvider = "push_provider"
- 	public var voip: Bool?
+ 		case pushProviderName = "push_provider_name"
- 	public init(
+ 		case userId = "user_id"
-         createdAt: Date,
+ 		case voip
-         disabled: Bool? = nil,
+ 	public static func == (lhs: Device, rhs: Device) -> Bool
-         disabledReason: String? = nil,
+ 	public func hash(into hasher: inout Hasher)
-         id: String,
+ 
-         pushProvider: String,
+ public final class EdgeResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
-         pushProviderName: String? = nil,
+ 	public var continentCode: String
-         userId: String,
+ 	public var countryIsoCode: String
-         voip: Bool? = nil
+ 	public var green: Int
-     )
+ 	public var id: String
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var latencyTestUrl: String
- 		case createdAt = "created_at"
+ 	public var latitude: Float
- 		case disabled
+ 	public var longitude: Float
- 		case disabledReason = "disabled_reason"
+ 	public var red: Int
- 		case id
+ 	public var subdivisionIsoCode: String
- 		case pushProvider = "push_provider"
+ 	public var yellow: Int
- 		case pushProviderName = "push_provider_name"
+ 	public init(
- 		case userId = "user_id"
+         continentCode: String,
- 		case voip
+         countryIsoCode: String,
- 	public static func == (lhs: Device, rhs: Device) -> Bool
+         green: Int,
- 	public func hash(into hasher: inout Hasher)
+         id: String,
- 
+         latencyTestUrl: String,
- public final class EdgeResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+         latitude: Float,
- 	public var continentCode: String
+         longitude: Float,
- 	public var countryIsoCode: String
+         red: Int,
- 	public var green: Int
+         subdivisionIsoCode: String,
- 	public var id: String
+         yellow: Int
- 	public var latencyTestUrl: String
+     )
- 	public var latitude: Float
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var longitude: Float
+ 		case continentCode = "continent_code"
- 	public var red: Int
+ 		case countryIsoCode = "country_iso_code"
- 	public var subdivisionIsoCode: String
+ 		case green
- 	public var yellow: Int
+ 		case id
- 	public init(
+ 		case latencyTestUrl = "latency_test_url"
-         continentCode: String,
+ 		case latitude
-         countryIsoCode: String,
+ 		case longitude
-         green: Int,
+ 		case red
-         id: String,
+ 		case subdivisionIsoCode = "subdivision_iso_code"
-         latencyTestUrl: String,
+ 		case yellow
-         latitude: Float,
+ 	public static func == (lhs: EdgeResponse, rhs: EdgeResponse) -> Bool
-         longitude: Float,
+ 	public func hash(into hasher: inout Hasher)
-         red: Int,
+ 
-         subdivisionIsoCode: String,
+ public final class EgressHLSResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
-         yellow: Int
+ 	public var playlistUrl: String
-     )
+ 	public init(playlistUrl: String)
- 		case continentCode = "continent_code"
+ 		case playlistUrl = "playlist_url"
- 		case countryIsoCode = "country_iso_code"
+ 	public static func == (lhs: EgressHLSResponse, rhs: EgressHLSResponse) -> Bool
- 		case green
+ 	public func hash(into hasher: inout Hasher)
- 		case id
+ 
- 		case latencyTestUrl = "latency_test_url"
+ public final class EgressRTMPResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case latitude
+ 	public var name: String
- 		case longitude
+ 	public var startedAt: Date
- 		case red
+ 	public var streamKey: String?
- 		case subdivisionIsoCode = "subdivision_iso_code"
+ 	public var streamUrl: String?
- 		case yellow
+ 	public init(name: String, startedAt: Date, streamKey: String? = nil, streamUrl: String? = nil)
- 	public static func == (lhs: EdgeResponse, rhs: EdgeResponse) -> Bool
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public func hash(into hasher: inout Hasher)
+ 		case name
- 
+ 		case startedAt = "started_at"
- public final class EgressHLSResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case streamKey = "stream_key"
- 	public var playlistUrl: String
+ 		case streamUrl = "stream_url"
- 	public init(playlistUrl: String)
+ 	public static func == (lhs: EgressRTMPResponse, rhs: EgressRTMPResponse) -> Bool
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public func hash(into hasher: inout Hasher)
- 		case playlistUrl = "playlist_url"
+ 
- 	public static func == (lhs: EgressHLSResponse, rhs: EgressHLSResponse) -> Bool
+ public final class EgressResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public func hash(into hasher: inout Hasher)
+ 	public var broadcasting: Bool
- 
+ 	public var hls: EgressHLSResponse?
- public final class EgressRTMPResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var rtmps: [EgressRTMPResponse]
- 	public var name: String
+ 	public init(broadcasting: Bool, hls: EgressHLSResponse? = nil, rtmps: [EgressRTMPResponse])
- 	public var startedAt: Date
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var streamKey: String?
+ 		case broadcasting
- 	public var streamUrl: String?
+ 		case hls
- 	public init(name: String, startedAt: Date, streamKey: String? = nil, streamUrl: String? = nil)
+ 		case rtmps
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public static func == (lhs: EgressResponse, rhs: EgressResponse) -> Bool
- 		case name
+ 	public func hash(into hasher: inout Hasher)
- 		case startedAt = "started_at"
+ 
- 		case streamKey = "stream_key"
+ public final class EndCallResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case streamUrl = "stream_url"
+ 	public var duration: String
- 	public static func == (lhs: EgressRTMPResponse, rhs: EgressRTMPResponse) -> Bool
+ 	public init(duration: String)
- 	public func hash(into hasher: inout Hasher)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 
+ 		case duration
- public final class EgressResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public static func == (lhs: EndCallResponse, rhs: EndCallResponse) -> Bool
- 	public var broadcasting: Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public var hls: EgressHLSResponse?
+ 
- 	public var rtmps: [EgressRTMPResponse]
+ public final class GeofenceSettings : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public init(broadcasting: Bool, hls: EgressHLSResponse? = nil, rtmps: [EgressRTMPResponse])
+ 	public var names: [String]
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public init(names: [String])
- 		case broadcasting
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 		case hls
+ 		case names
- 		case rtmps
+ 	public static func == (lhs: GeofenceSettings, rhs: GeofenceSettings) -> Bool
- 	public static func == (lhs: EgressResponse, rhs: EgressResponse) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class GeofenceSettingsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- public final class EndCallResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var names: [String]?
- 	public var duration: String
+ 	public init(names: [String]? = nil)
- 	public init(duration: String)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case names
- 		case duration
+ 	public static func == (lhs: GeofenceSettingsRequest, rhs: GeofenceSettingsRequest) -> Bool
- 	public static func == (lhs: EndCallResponse, rhs: EndCallResponse) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class GeolocationResult : @unchecked Sendable, Codable, JSONEncodable, Hashable
- public final class GeofenceSettings : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var accuracyRadius: Int
- 	public var names: [String]
+ 	public var city: String
- 	public init(names: [String])
+ 	public var continent: String
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var continentCode: String
- 		case names
+ 	public var country: String
- 	public static func == (lhs: GeofenceSettings, rhs: GeofenceSettings) -> Bool
+ 	public var countryIsoCode: String
- 	public func hash(into hasher: inout Hasher)
+ 	public var latitude: Float
- 
+ 	public var longitude: Float
- public final class GeofenceSettingsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var subdivision: String
- 	public var names: [String]?
+ 	public var subdivisionIsoCode: String
- 	public init(names: [String]? = nil)
+ 	public init(
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+         accuracyRadius: Int,
- 		case names
+         city: String,
- 	public static func == (lhs: GeofenceSettingsRequest, rhs: GeofenceSettingsRequest) -> Bool
+         continent: String,
- 	public func hash(into hasher: inout Hasher)
+         continentCode: String,
- 
+         country: String,
- public final class GeolocationResult : @unchecked Sendable, Codable, JSONEncodable, Hashable
+         countryIsoCode: String,
- 	public var accuracyRadius: Int
+         latitude: Float,
- 	public var city: String
+         longitude: Float,
- 	public var continent: String
+         subdivision: String,
- 	public var continentCode: String
+         subdivisionIsoCode: String
- 	public var country: String
+     )
- 	public var countryIsoCode: String
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var latitude: Float
+ 		case accuracyRadius = "accuracy_radius"
- 	public var longitude: Float
+ 		case city
- 	public var subdivision: String
+ 		case continent
- 	public var subdivisionIsoCode: String
+ 		case continentCode = "continent_code"
- 	public init(
+ 		case country
-         accuracyRadius: Int,
+ 		case countryIsoCode = "country_iso_code"
-         city: String,
+ 		case latitude
-         continent: String,
+ 		case longitude
-         continentCode: String,
+ 		case subdivision
-         country: String,
+ 		case subdivisionIsoCode = "subdivision_iso_code"
-         countryIsoCode: String,
+ 	public static func == (lhs: GeolocationResult, rhs: GeolocationResult) -> Bool
-         latitude: Float,
+ 	public func hash(into hasher: inout Hasher)
-         longitude: Float,
+ 
-         subdivision: String,
+ public final class GetCallResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
-         subdivisionIsoCode: String
+ 	public var call: CallResponse
-     )
+ 	public var duration: String
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var members: [MemberResponse]
- 		case accuracyRadius = "accuracy_radius"
+ 	public var membership: MemberResponse?
- 		case city
+ 	public var ownCapabilities: [OwnCapability]
- 		case continent
+ 	public init(
- 		case continentCode = "continent_code"
+         call: CallResponse,
- 		case country
+         duration: String,
- 		case countryIsoCode = "country_iso_code"
+         members: [MemberResponse],
- 		case latitude
+         membership: MemberResponse? = nil,
- 		case longitude
+         ownCapabilities: [OwnCapability]
- 		case subdivision
+     )
- 		case subdivisionIsoCode = "subdivision_iso_code"
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public static func == (lhs: GeolocationResult, rhs: GeolocationResult) -> Bool
+ 		case call
- 	public func hash(into hasher: inout Hasher)
+ 		case duration
- 
+ 		case members
- public final class GetCallResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case membership
- 	public var call: CallResponse
+ 		case ownCapabilities = "own_capabilities"
- 	public var duration: String
+ 	public static func == (lhs: GetCallResponse, rhs: GetCallResponse) -> Bool
- 	public var members: [MemberResponse]
+ 	public func hash(into hasher: inout Hasher)
- 	public var membership: MemberResponse?
+ 
- 	public var ownCapabilities: [OwnCapability]
+ public final class GetCallStatsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public init(
+ 	public var aggregated: AggregatedStats?
-         call: CallResponse,
+ 	public var averageConnectionTime: Float?
-         duration: String,
+ 	public var callDurationSeconds: Int
-         members: [MemberResponse],
+ 	public var callStatus: String
-         membership: MemberResponse? = nil,
+ 	public var callTimeline: CallTimeline?
-         ownCapabilities: [OwnCapability]
+ 	public var duration: String
-     )
+ 	public var jitter: Stats?
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var latency: Stats?
- 		case call
+ 	public var maxFreezesDurationSeconds: Int
- 		case duration
+ 	public var maxParticipants: Int
- 		case members
+ 	public var maxTotalQualityLimitationDurationSeconds: Int
- 		case membership
+ 	public var participantReport: [UserStats]
- 		case ownCapabilities = "own_capabilities"
+ 	public var publishingParticipants: Int
- 	public static func == (lhs: GetCallResponse, rhs: GetCallResponse) -> Bool
+ 	public var qualityScore: Int
- 	public func hash(into hasher: inout Hasher)
+ 	public var sfuCount: Int
- 
+ 	public var sfus: [SFULocationResponse]
- public final class GetCallStatsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public init(
- 	public var aggregated: AggregatedStats?
+         aggregated: AggregatedStats? = nil,
- 	public var averageConnectionTime: Float?
+         averageConnectionTime: Float? = nil,
- 	public var callDurationSeconds: Int
+         callDurationSeconds: Int,
- 	public var callStatus: String
+         callStatus: String,
- 	public var callTimeline: CallTimeline?
+         callTimeline: CallTimeline? = nil,
- 	public var duration: String
+         duration: String,
- 	public var jitter: Stats?
+         jitter: Stats? = nil,
- 	public var latency: Stats?
+         latency: Stats? = nil,
- 	public var maxFreezesDurationSeconds: Int
+         maxFreezesDurationSeconds: Int,
- 	public var maxParticipants: Int
+         maxParticipants: Int,
- 	public var maxTotalQualityLimitationDurationSeconds: Int
+         maxTotalQualityLimitationDurationSeconds: Int,
- 	public var participantReport: [UserStats]
+         participantReport: [UserStats],
- 	public var publishingParticipants: Int
+         publishingParticipants: Int,
- 	public var qualityScore: Int
+         qualityScore: Int,
- 	public var sfuCount: Int
+         sfuCount: Int,
- 	public var sfus: [SFULocationResponse]
+         sfus: [SFULocationResponse]
- 	public init(
+     )
-         aggregated: AggregatedStats? = nil,
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
-         averageConnectionTime: Float? = nil,
+ 		case aggregated
-         callDurationSeconds: Int,
+ 		case averageConnectionTime = "average_connection_time"
-         callStatus: String,
+ 		case callDurationSeconds = "call_duration_seconds"
-         callTimeline: CallTimeline? = nil,
+ 		case callStatus = "call_status"
-         duration: String,
+ 		case callTimeline = "call_timeline"
-         jitter: Stats? = nil,
+ 		case duration
-         latency: Stats? = nil,
+ 		case jitter
-         maxFreezesDurationSeconds: Int,
+ 		case latency
-         maxParticipants: Int,
+ 		case maxFreezesDurationSeconds = "max_freezes_duration_seconds"
-         maxTotalQualityLimitationDurationSeconds: Int,
+ 		case maxParticipants = "max_participants"
-         participantReport: [UserStats],
+ 		case maxTotalQualityLimitationDurationSeconds = "max_total_quality_limitation_duration_seconds"
-         publishingParticipants: Int,
+ 		case participantReport = "participant_report"
-         qualityScore: Int,
+ 		case publishingParticipants = "publishing_participants"
-         sfuCount: Int,
+ 		case qualityScore = "quality_score"
-         sfus: [SFULocationResponse]
+ 		case sfuCount = "sfu_count"
-     )
+ 		case sfus
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public static func == (lhs: GetCallStatsResponse, rhs: GetCallStatsResponse) -> Bool
- 		case aggregated
+ 	public func hash(into hasher: inout Hasher)
- 		case averageConnectionTime = "average_connection_time"
+ 
- 		case callDurationSeconds = "call_duration_seconds"
+ public final class GetEdgesResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case callStatus = "call_status"
+ 	public var duration: String
- 		case callTimeline = "call_timeline"
+ 	public var edges: [EdgeResponse]
- 		case duration
+ 	public init(duration: String, edges: [EdgeResponse])
- 		case jitter
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 		case latency
+ 		case duration
- 		case maxFreezesDurationSeconds = "max_freezes_duration_seconds"
+ 		case edges
- 		case maxParticipants = "max_participants"
+ 	public static func == (lhs: GetEdgesResponse, rhs: GetEdgesResponse) -> Bool
- 		case maxTotalQualityLimitationDurationSeconds = "max_total_quality_limitation_duration_seconds"
+ 	public func hash(into hasher: inout Hasher)
- 		case participantReport = "participant_report"
+ 
- 		case publishingParticipants = "publishing_participants"
+ public final class GetOrCreateCallRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case qualityScore = "quality_score"
+ 	public var data: CallRequest?
- 		case sfuCount = "sfu_count"
+ 	public var membersLimit: Int?
- 		case sfus
+ 	public var notify: Bool?
- 	public static func == (lhs: GetCallStatsResponse, rhs: GetCallStatsResponse) -> Bool
+ 	public var ring: Bool?
- 	public func hash(into hasher: inout Hasher)
+ 	public var video: Bool?
- 
+ 	public init(data: CallRequest? = nil, membersLimit: Int? = nil, notify: Bool? = nil, ring: Bool? = nil, video: Bool? = nil)
- public final class GetEdgesResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var duration: String
+ 		case data
- 	public var edges: [EdgeResponse]
+ 		case membersLimit = "members_limit"
- 	public init(duration: String, edges: [EdgeResponse])
+ 		case notify
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case ring
- 		case duration
+ 		case video
- 		case edges
+ 	public static func == (lhs: GetOrCreateCallRequest, rhs: GetOrCreateCallRequest) -> Bool
- 	public static func == (lhs: GetEdgesResponse, rhs: GetEdgesResponse) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class GetOrCreateCallResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- public final class GetOrCreateCallRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var call: CallResponse
- 	public var data: CallRequest?
+ 	public var created: Bool
- 	public var membersLimit: Int?
+ 	public var duration: String
- 	public var notify: Bool?
+ 	public var members: [MemberResponse]
- 	public var ring: Bool?
+ 	public var membership: MemberResponse?
- 	public var video: Bool?
+ 	public var ownCapabilities: [OwnCapability]
- 	public init(data: CallRequest? = nil, membersLimit: Int? = nil, notify: Bool? = nil, ring: Bool? = nil, video: Bool? = nil)
+ 	public init(
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+         call: CallResponse,
- 		case data
+         created: Bool,
- 		case membersLimit = "members_limit"
+         duration: String,
- 		case notify
+         members: [MemberResponse],
- 		case ring
+         membership: MemberResponse? = nil,
- 		case video
+         ownCapabilities: [OwnCapability]
- 	public static func == (lhs: GetOrCreateCallRequest, rhs: GetOrCreateCallRequest) -> Bool
+     )
- 	public func hash(into hasher: inout Hasher)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 
+ 		case call
- public final class GetOrCreateCallResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case created
- 	public var call: CallResponse
+ 		case duration
- 	public var created: Bool
+ 		case members
- 	public var duration: String
+ 		case membership
- 	public var members: [MemberResponse]
+ 		case ownCapabilities = "own_capabilities"
- 	public var membership: MemberResponse?
+ 	public static func == (lhs: GetOrCreateCallResponse, rhs: GetOrCreateCallResponse) -> Bool
- 	public var ownCapabilities: [OwnCapability]
+ 	public func hash(into hasher: inout Hasher)
- 	public init(
+ 
-         call: CallResponse,
+ public final class GoLiveRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
-         created: Bool,
+ 	public var recordingStorageName: String?
-         duration: String,
+ 	public var startClosedCaption: Bool?
-         members: [MemberResponse],
+ 	public var startHls: Bool?
-         membership: MemberResponse? = nil,
+ 	public var startRecording: Bool?
-         ownCapabilities: [OwnCapability]
+ 	public var startRtmpBroadcasts: Bool?
-     )
+ 	public var startTranscription: Bool?
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var transcriptionStorageName: String?
- 		case call
+ 	public init(
- 		case created
+         recordingStorageName: String? = nil,
- 		case duration
+         startClosedCaption: Bool? = nil,
- 		case members
+         startHls: Bool? = nil,
- 		case membership
+         startRecording: Bool? = nil,
- 		case ownCapabilities = "own_capabilities"
+         startRtmpBroadcasts: Bool? = nil,
- 	public static func == (lhs: GetOrCreateCallResponse, rhs: GetOrCreateCallResponse) -> Bool
+         startTranscription: Bool? = nil,
- 	public func hash(into hasher: inout Hasher)
+         transcriptionStorageName: String? = nil
- 
+     )
- public final class GoLiveRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var recordingStorageName: String?
+ 		case recordingStorageName = "recording_storage_name"
- 	public var startClosedCaption: Bool?
+ 		case startClosedCaption = "start_closed_caption"
- 	public var startHls: Bool?
+ 		case startHls = "start_hls"
- 	public var startRecording: Bool?
+ 		case startRecording = "start_recording"
- 	public var startRtmpBroadcasts: Bool?
+ 		case startRtmpBroadcasts = "start_rtmp_broadcasts"
- 	public var startTranscription: Bool?
+ 		case startTranscription = "start_transcription"
- 	public var transcriptionStorageName: String?
+ 		case transcriptionStorageName = "transcription_storage_name"
- 	public init(
+ 	public static func == (lhs: GoLiveRequest, rhs: GoLiveRequest) -> Bool
-         recordingStorageName: String? = nil,
+ 	public func hash(into hasher: inout Hasher)
-         startClosedCaption: Bool? = nil,
+ 
-         startHls: Bool? = nil,
+ public final class GoLiveResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
-         startRecording: Bool? = nil,
+ 	public var call: CallResponse
-         startRtmpBroadcasts: Bool? = nil,
+ 	public var duration: String
-         startTranscription: Bool? = nil,
+ 	public init(call: CallResponse, duration: String)
-         transcriptionStorageName: String? = nil
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
-     )
+ 		case call
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case duration
- 		case recordingStorageName = "recording_storage_name"
+ 	public static func == (lhs: GoLiveResponse, rhs: GoLiveResponse) -> Bool
- 		case startClosedCaption = "start_closed_caption"
+ 	public func hash(into hasher: inout Hasher)
- 		case startHls = "start_hls"
+ 
- 		case startRecording = "start_recording"
+ public final class HLSSettingsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case startRtmpBroadcasts = "start_rtmp_broadcasts"
+ 	public var autoOn: Bool?
- 		case startTranscription = "start_transcription"
+ 	public var enabled: Bool?
- 		case transcriptionStorageName = "transcription_storage_name"
+ 	public var qualityTracks: [String]
- 	public static func == (lhs: GoLiveRequest, rhs: GoLiveRequest) -> Bool
+ 	public init(autoOn: Bool? = nil, enabled: Bool? = nil, qualityTracks: [String])
- 	public func hash(into hasher: inout Hasher)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 
+ 		case autoOn = "auto_on"
- public final class GoLiveResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case enabled
- 	public var call: CallResponse
+ 		case qualityTracks = "quality_tracks"
- 	public var duration: String
+ 	public static func == (lhs: HLSSettingsRequest, rhs: HLSSettingsRequest) -> Bool
- 	public init(call: CallResponse, duration: String)
+ 	public func hash(into hasher: inout Hasher)
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 
- 		case call
+ public final class HLSSettingsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case duration
+ 	public var autoOn: Bool
- 	public static func == (lhs: GoLiveResponse, rhs: GoLiveResponse) -> Bool
+ 	public var enabled: Bool
- 	public func hash(into hasher: inout Hasher)
+ 	public var qualityTracks: [String]
- 
+ 	public init(autoOn: Bool, enabled: Bool, qualityTracks: [String])
- public final class HLSSettingsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var autoOn: Bool?
+ 		case autoOn = "auto_on"
- 	public var enabled: Bool?
+ 		case enabled
- 	public var qualityTracks: [String]
+ 		case qualityTracks = "quality_tracks"
- 	public init(autoOn: Bool? = nil, enabled: Bool? = nil, qualityTracks: [String])
+ 	public static func == (lhs: HLSSettingsResponse, rhs: HLSSettingsResponse) -> Bool
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public func hash(into hasher: inout Hasher)
- 		case autoOn = "auto_on"
+ 
- 		case enabled
+ public final class HealthCheckEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable
- 		case qualityTracks = "quality_tracks"
+ 	public var cid: String?
- 	public static func == (lhs: HLSSettingsRequest, rhs: HLSSettingsRequest) -> Bool
+ 	public var connectionId: String
- 	public func hash(into hasher: inout Hasher)
+ 	public var createdAt: Date
- 
+ 	public var receivedAt: Date?
- public final class HLSSettingsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var type: String
- 	public var autoOn: Bool
+ 	public init(cid: String? = nil, connectionId: String, createdAt: Date, receivedAt: Date? = nil)
- 	public var enabled: Bool
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var qualityTracks: [String]
+ 		case cid
- 	public init(autoOn: Bool, enabled: Bool, qualityTracks: [String])
+ 		case connectionId = "connection_id"
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case createdAt = "created_at"
- 		case autoOn = "auto_on"
+ 		case receivedAt = "received_at"
- 		case enabled
+ 		case type
- 		case qualityTracks = "quality_tracks"
+ 	public static func == (lhs: HealthCheckEvent, rhs: HealthCheckEvent) -> Bool
- 	public static func == (lhs: HLSSettingsResponse, rhs: HLSSettingsResponse) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class ICEServer : @unchecked Sendable, Codable, JSONEncodable, Hashable
- public final class HealthCheckEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable
+ 	public var password: String
- 	public var cid: String?
+ 	public var urls: [String]
- 	public var connectionId: String
+ 	public var username: String
- 	public var createdAt: Date
+ 	public init(password: String, urls: [String], username: String)
- 	public var receivedAt: Date?
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var type: String
+ 		case password
- 	public init(cid: String? = nil, connectionId: String, createdAt: Date, receivedAt: Date? = nil)
+ 		case urls
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case username
- 		case cid
+ 	public static func == (lhs: ICEServer, rhs: ICEServer) -> Bool
- 		case connectionId = "connection_id"
+ 	public func hash(into hasher: inout Hasher)
- 		case createdAt = "created_at"
+ 
- 		case receivedAt = "received_at"
+ public final class JoinCallRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case type
+ 	public var create: Bool?
- 	public static func == (lhs: HealthCheckEvent, rhs: HealthCheckEvent) -> Bool
+ 	public var data: CallRequest?
- 	public func hash(into hasher: inout Hasher)
+ 	public var location: String
- 
+ 	public var membersLimit: Int?
- public final class ICEServer : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var migratingFrom: String?
- 	public var password: String
+ 	public var notify: Bool?
- 	public var urls: [String]
+ 	public var ring: Bool?
- 	public var username: String
+ 	public var video: Bool?
- 	public init(password: String, urls: [String], username: String)
+ 	public init(
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+         create: Bool? = nil,
- 		case password
+         data: CallRequest? = nil,
- 		case urls
+         location: String,
- 		case username
+         membersLimit: Int? = nil,
- 	public static func == (lhs: ICEServer, rhs: ICEServer) -> Bool
+         migratingFrom: String? = nil,
- 	public func hash(into hasher: inout Hasher)
+         notify: Bool? = nil,
- 
+         ring: Bool? = nil,
- public final class JoinCallRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+         video: Bool? = nil
- 	public var create: Bool?
+     )
- 	public var data: CallRequest?
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var location: String
+ 		case create
- 	public var membersLimit: Int?
+ 		case data
- 	public var migratingFrom: String?
+ 		case location
- 	public var notify: Bool?
+ 		case membersLimit = "members_limit"
- 	public var ring: Bool?
+ 		case migratingFrom = "migrating_from"
- 	public var video: Bool?
+ 		case notify
- 	public init(
+ 		case ring
-         create: Bool? = nil,
+ 		case video
-         data: CallRequest? = nil,
+ 	public static func == (lhs: JoinCallRequest, rhs: JoinCallRequest) -> Bool
-         location: String,
+ 	public func hash(into hasher: inout Hasher)
-         membersLimit: Int? = nil,
+ 
-         migratingFrom: String? = nil,
+ public final class JoinCallResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
-         notify: Bool? = nil,
+ 	public var call: CallResponse
-         ring: Bool? = nil,
+ 	public var created: Bool
-         video: Bool? = nil
+ 	public var credentials: Credentials
-     )
+ 	public var duration: String
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var members: [MemberResponse]
- 		case create
+ 	public var membership: MemberResponse?
- 		case data
+ 	public var ownCapabilities: [OwnCapability]
- 		case location
+ 	public var statsOptions: StatsOptions
- 		case membersLimit = "members_limit"
+ 	public init(
- 		case migratingFrom = "migrating_from"
+         call: CallResponse,
- 		case notify
+         created: Bool,
- 		case ring
+         credentials: Credentials,
- 		case video
+         duration: String,
- 	public static func == (lhs: JoinCallRequest, rhs: JoinCallRequest) -> Bool
+         members: [MemberResponse],
- 	public func hash(into hasher: inout Hasher)
+         membership: MemberResponse? = nil,
- 
+         ownCapabilities: [OwnCapability],
- public final class JoinCallResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+         statsOptions: StatsOptions
- 	public var call: CallResponse
+     )
- 	public var created: Bool
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var credentials: Credentials
+ 		case call
- 	public var duration: String
+ 		case created
- 	public var members: [MemberResponse]
+ 		case credentials
- 	public var membership: MemberResponse?
+ 		case duration
- 	public var ownCapabilities: [OwnCapability]
+ 		case members
- 	public var statsOptions: StatsOptions
+ 		case membership
- 	public init(
+ 		case ownCapabilities = "own_capabilities"
-         call: CallResponse,
+ 		case statsOptions = "stats_options"
-         created: Bool,
+ 	public static func == (lhs: JoinCallResponse, rhs: JoinCallResponse) -> Bool
-         credentials: Credentials,
+ 	public func hash(into hasher: inout Hasher)
-         duration: String,
+ 
-         members: [MemberResponse],
+ public final class LayoutSettings : @unchecked Sendable, Codable, JSONEncodable, Hashable
-         membership: MemberResponse? = nil,
+ 	public enum Name : String, Sendable, Codable, CaseIterable
-         ownCapabilities: [OwnCapability],
+ 		case custom
-         statsOptions: StatsOptions
+ 		case grid
-     )
+ 		case mobile
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case singleParticipant = "single-participant"
- 		case call
+ 		case spotlight
- 		case created
+ 		case unknown = "_unknown"
- 		case credentials
+ 		public init(from decoder: Decoder) throws
- 		case duration
+ 	public var detectOrientation: Bool?
- 		case members
+ 	public var externalAppUrl: String?
- 		case membership
+ 	public var externalCssUrl: String?
- 		case ownCapabilities = "own_capabilities"
+ 	public var name: Name
- 		case statsOptions = "stats_options"
+ 	public var options: [String: RawJSON]?
- 	public static func == (lhs: JoinCallResponse, rhs: JoinCallResponse) -> Bool
+ 	public init(
- 	public func hash(into hasher: inout Hasher)
+         detectOrientation: Bool? = nil,
- 
+         externalAppUrl: String? = nil,
- public final class LayoutSettings : @unchecked Sendable, Codable, JSONEncodable, Hashable
+         externalCssUrl: String? = nil,
- 	public enum Name : String, Sendable, Codable, CaseIterable
+         name: Name,
- 		case custom
+         options: [String: RawJSON]? = nil
- 		case grid
+     )
- 		case mobile
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 		case singleParticipant = "single-participant"
+ 		case detectOrientation = "detect_orientation"
- 		case spotlight
+ 		case externalAppUrl = "external_app_url"
- 		case unknown = "_unknown"
+ 		case externalCssUrl = "external_css_url"
- 		public init(from decoder: Decoder) throws
+ 		case name
- 	public var detectOrientation: Bool?
+ 		case options
- 	public var externalAppUrl: String?
+ 	public static func == (lhs: LayoutSettings, rhs: LayoutSettings) -> Bool
- 	public var externalCssUrl: String?
+ 	public func hash(into hasher: inout Hasher)
- 	public var name: Name
+ 
- 	public var options: [String: RawJSON]?
+ public final class LimitsSettingsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public init(
+ 	public var maxDurationSeconds: Int?
-         detectOrientation: Bool? = nil,
+ 	public var maxParticipants: Int?
-         externalAppUrl: String? = nil,
+ 	public init(maxDurationSeconds: Int? = nil, maxParticipants: Int? = nil)
-         externalCssUrl: String? = nil,
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
-         name: Name,
+ 		case maxDurationSeconds = "max_duration_seconds"
-         options: [String: RawJSON]? = nil
+ 		case maxParticipants = "max_participants"
-     )
+ 	public static func == (lhs: LimitsSettingsRequest, rhs: LimitsSettingsRequest) -> Bool
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public func hash(into hasher: inout Hasher)
- 		case detectOrientation = "detect_orientation"
+ 
- 		case externalAppUrl = "external_app_url"
+ public final class LimitsSettingsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case externalCssUrl = "external_css_url"
+ 	public var maxDurationSeconds: Int?
- 		case name
+ 	public var maxParticipants: Int?
- 		case options
+ 	public init(maxDurationSeconds: Int? = nil, maxParticipants: Int? = nil)
- 	public static func == (lhs: LayoutSettings, rhs: LayoutSettings) -> Bool
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public func hash(into hasher: inout Hasher)
+ 		case maxDurationSeconds = "max_duration_seconds"
- 
+ 		case maxParticipants = "max_participants"
- public final class LimitsSettingsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public static func == (lhs: LimitsSettingsResponse, rhs: LimitsSettingsResponse) -> Bool
- 	public var maxDurationSeconds: Int?
+ 	public func hash(into hasher: inout Hasher)
- 	public var maxParticipants: Int?
+ 
- 	public init(maxDurationSeconds: Int? = nil, maxParticipants: Int? = nil)
+ public final class ListDevicesResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var devices: [Device]
- 		case maxDurationSeconds = "max_duration_seconds"
+ 	public var duration: String
- 		case maxParticipants = "max_participants"
+ 	public init(devices: [Device], duration: String)
- 	public static func == (lhs: LimitsSettingsRequest, rhs: LimitsSettingsRequest) -> Bool
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public func hash(into hasher: inout Hasher)
+ 		case devices
- 
+ 		case duration
- public final class LimitsSettingsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public static func == (lhs: ListDevicesResponse, rhs: ListDevicesResponse) -> Bool
- 	public var maxDurationSeconds: Int?
+ 	public func hash(into hasher: inout Hasher)
- 	public var maxParticipants: Int?
+ 
- 	public init(maxDurationSeconds: Int? = nil, maxParticipants: Int? = nil)
+ public final class ListRecordingsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var duration: String
- 		case maxDurationSeconds = "max_duration_seconds"
+ 	public var recordings: [CallRecording]
- 		case maxParticipants = "max_participants"
+ 	public init(duration: String, recordings: [CallRecording])
- 	public static func == (lhs: LimitsSettingsResponse, rhs: LimitsSettingsResponse) -> Bool
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public func hash(into hasher: inout Hasher)
+ 		case duration
- 
+ 		case recordings
- public final class ListDevicesResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public static func == (lhs: ListRecordingsResponse, rhs: ListRecordingsResponse) -> Bool
- 	public var devices: [Device]
+ 	public func hash(into hasher: inout Hasher)
- 	public var duration: String
+ 
- 	public init(devices: [Device], duration: String)
+ public final class ListTranscriptionsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var duration: String
- 		case devices
+ 	public var transcriptions: [CallTranscription]
- 		case duration
+ 	public init(duration: String, transcriptions: [CallTranscription])
- 	public static func == (lhs: ListDevicesResponse, rhs: ListDevicesResponse) -> Bool
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public func hash(into hasher: inout Hasher)
+ 		case duration
- 
+ 		case transcriptions
- public final class ListRecordingsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public static func == (lhs: ListTranscriptionsResponse, rhs: ListTranscriptionsResponse) -> Bool
- 	public var duration: String
+ 	public func hash(into hasher: inout Hasher)
- 	public var recordings: [CallRecording]
+ 
- 	public init(duration: String, recordings: [CallRecording])
+ public final class Location : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var continentCode: String
- 		case duration
+ 	public var countryIsoCode: String
- 		case recordings
+ 	public var subdivisionIsoCode: String
- 	public static func == (lhs: ListRecordingsResponse, rhs: ListRecordingsResponse) -> Bool
+ 	public init(continentCode: String, countryIsoCode: String, subdivisionIsoCode: String)
- 	public func hash(into hasher: inout Hasher)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 
+ 		case continentCode = "continent_code"
- public final class ListTranscriptionsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case countryIsoCode = "country_iso_code"
- 	public var duration: String
+ 		case subdivisionIsoCode = "subdivision_iso_code"
- 	public var transcriptions: [CallTranscription]
+ 	public static func == (lhs: Location, rhs: Location) -> Bool
- 	public init(duration: String, transcriptions: [CallTranscription])
+ 	public func hash(into hasher: inout Hasher)
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 
- 		case duration
+ public final class MediaPubSubHint : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case transcriptions
+ 	public var audioPublished: Bool
- 	public static func == (lhs: ListTranscriptionsResponse, rhs: ListTranscriptionsResponse) -> Bool
+ 	public var audioSubscribed: Bool
- 	public func hash(into hasher: inout Hasher)
+ 	public var videoPublished: Bool
- 
+ 	public var videoSubscribed: Bool
- public final class Location : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public init(audioPublished: Bool, audioSubscribed: Bool, videoPublished: Bool, videoSubscribed: Bool)
- 	public var continentCode: String
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var countryIsoCode: String
+ 		case audioPublished = "audio_published"
- 	public var subdivisionIsoCode: String
+ 		case audioSubscribed = "audio_subscribed"
- 	public init(continentCode: String, countryIsoCode: String, subdivisionIsoCode: String)
+ 		case videoPublished = "video_published"
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case videoSubscribed = "video_subscribed"
- 		case continentCode = "continent_code"
+ 	public static func == (lhs: MediaPubSubHint, rhs: MediaPubSubHint) -> Bool
- 		case countryIsoCode = "country_iso_code"
+ 	public func hash(into hasher: inout Hasher)
- 		case subdivisionIsoCode = "subdivision_iso_code"
+ 
- 	public static func == (lhs: Location, rhs: Location) -> Bool
+ public final class MemberRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public func hash(into hasher: inout Hasher)
+ 	public var custom: [String: RawJSON]?
- 
+ 	public var role: String?
- public final class MediaPubSubHint : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var userId: String
- 	public var audioPublished: Bool
+ 	public init(custom: [String: RawJSON]? = nil, role: String? = nil, userId: String)
- 	public var audioSubscribed: Bool
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var videoPublished: Bool
+ 		case custom
- 	public var videoSubscribed: Bool
+ 		case role
- 	public init(audioPublished: Bool, audioSubscribed: Bool, videoPublished: Bool, videoSubscribed: Bool)
+ 		case userId = "user_id"
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public static func == (lhs: MemberRequest, rhs: MemberRequest) -> Bool
- 		case audioPublished = "audio_published"
+ 	public func hash(into hasher: inout Hasher)
- 		case audioSubscribed = "audio_subscribed"
+ 
- 		case videoPublished = "video_published"
+ public final class MemberResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case videoSubscribed = "video_subscribed"
+ 	public var createdAt: Date
- 	public static func == (lhs: MediaPubSubHint, rhs: MediaPubSubHint) -> Bool
+ 	public var custom: [String: RawJSON]
- 	public func hash(into hasher: inout Hasher)
+ 	public var deletedAt: Date?
- 
+ 	public var role: String?
- public final class MemberRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var updatedAt: Date
- 	public var custom: [String: RawJSON]?
+ 	public var user: UserResponse
- 	public var role: String?
+ 	public var userId: String
- 	public var userId: String
+ 	public init(
- 	public init(custom: [String: RawJSON]? = nil, role: String? = nil, userId: String)
+         createdAt: Date,
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+         custom: [String: RawJSON],
- 		case custom
+         deletedAt: Date? = nil,
- 		case role
+         role: String? = nil,
- 		case userId = "user_id"
+         updatedAt: Date,
- 	public static func == (lhs: MemberRequest, rhs: MemberRequest) -> Bool
+         user: UserResponse,
- 	public func hash(into hasher: inout Hasher)
+         userId: String
- 
+     )
- public final class MemberResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var createdAt: Date
+ 		case createdAt = "created_at"
- 	public var custom: [String: RawJSON]
+ 		case custom
- 	public var deletedAt: Date?
+ 		case deletedAt = "deleted_at"
- 	public var role: String?
+ 		case role
- 	public var updatedAt: Date
+ 		case updatedAt = "updated_at"
- 	public var user: UserResponse
+ 		case user
- 	public var userId: String
+ 		case userId = "user_id"
- 	public init(
+ 	public static func == (lhs: MemberResponse, rhs: MemberResponse) -> Bool
-         createdAt: Date,
+ 	public func hash(into hasher: inout Hasher)
-         custom: [String: RawJSON],
+ 
-         deletedAt: Date? = nil,
+ public final class ModelResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
-         role: String? = nil,
+ 	public var duration: String
-         updatedAt: Date,
+ 	public init(duration: String)
-         user: UserResponse,
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
-         userId: String
+ 		case duration
-     )
+ 	public static func == (lhs: ModelResponse, rhs: ModelResponse) -> Bool
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public func hash(into hasher: inout Hasher)
- 		case createdAt = "created_at"
+ 
- 		case custom
+ public final class MuteUsersRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case deletedAt = "deleted_at"
+ 	public var audio: Bool?
- 		case role
+ 	public var muteAllUsers: Bool?
- 		case updatedAt = "updated_at"
+ 	public var screenshare: Bool?
- 		case user
+ 	public var screenshareAudio: Bool?
- 		case userId = "user_id"
+ 	public var userIds: [String]?
- 	public static func == (lhs: MemberResponse, rhs: MemberResponse) -> Bool
+ 	public var video: Bool?
- 	public func hash(into hasher: inout Hasher)
+ 	public init(
- 
+         audio: Bool? = nil,
- public final class ModelResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+         muteAllUsers: Bool? = nil,
- 	public var duration: String
+         screenshare: Bool? = nil,
- 	public init(duration: String)
+         screenshareAudio: Bool? = nil,
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+         userIds: [String]? = nil,
- 		case duration
+         video: Bool? = nil
- 	public static func == (lhs: ModelResponse, rhs: ModelResponse) -> Bool
+     )
- 	public func hash(into hasher: inout Hasher)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 
+ 		case audio
- public final class MuteUsersRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case muteAllUsers = "mute_all_users"
- 	public var audio: Bool?
+ 		case screenshare
- 	public var muteAllUsers: Bool?
+ 		case screenshareAudio = "screenshare_audio"
- 	public var screenshare: Bool?
+ 		case userIds = "user_ids"
- 	public var screenshareAudio: Bool?
+ 		case video
- 	public var userIds: [String]?
+ 	public static func == (lhs: MuteUsersRequest, rhs: MuteUsersRequest) -> Bool
- 	public var video: Bool?
+ 	public func hash(into hasher: inout Hasher)
- 	public init(
+ 
-         audio: Bool? = nil,
+ public final class MuteUsersResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
-         muteAllUsers: Bool? = nil,
+ 	public var duration: String
-         screenshare: Bool? = nil,
+ 	public init(duration: String)
-         screenshareAudio: Bool? = nil,
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
-         userIds: [String]? = nil,
+ 		case duration
-         video: Bool? = nil
+ 	public static func == (lhs: MuteUsersResponse, rhs: MuteUsersResponse) -> Bool
-     )
+ 	public func hash(into hasher: inout Hasher)
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 
- 		case audio
+ public final class NoiseCancellationSettingsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case muteAllUsers = "mute_all_users"
+ 	public enum Mode : String, Sendable, Codable, CaseIterable
- 		case screenshare
+ 		case autoOn = "auto-on"
- 		case screenshareAudio = "screenshare_audio"
+ 		case available
- 		case userIds = "user_ids"
+ 		case disabled
- 		case video
+ 		case unknown = "_unknown"
- 	public static func == (lhs: MuteUsersRequest, rhs: MuteUsersRequest) -> Bool
+ 		public init(from decoder: Decoder) throws
- 	public func hash(into hasher: inout Hasher)
+ 	public var mode: Mode
- 
+ 	public init(mode: Mode)
- public final class MuteUsersResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var duration: String
+ 		case mode
- 	public init(duration: String)
+ 	public static func == (lhs: NoiseCancellationSettingsRequest, rhs: NoiseCancellationSettingsRequest) -> Bool
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public func hash(into hasher: inout Hasher)
- 		case duration
+ 
- 	public static func == (lhs: MuteUsersResponse, rhs: MuteUsersResponse) -> Bool
+ public enum OwnCapability : String, Sendable, Codable, CaseIterable
- 	public func hash(into hasher: inout Hasher)
+ 	case blockUsers = "block-users"
- 
+ 	case changeMaxDuration = "change-max-duration"
- public final class NoiseCancellationSettingsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	case createCall = "create-call"
- 	public enum Mode : String, Sendable, Codable, CaseIterable
+ 	case createReaction = "create-reaction"
- 		case autoOn = "auto-on"
+ 	case enableNoiseCancellation = "enable-noise-cancellation"
- 		case available
+ 	case endCall = "end-call"
- 		case disabled
+ 	case joinBackstage = "join-backstage"
- 		case unknown = "_unknown"
+ 	case joinCall = "join-call"
- 		public init(from decoder: Decoder) throws
+ 	case joinEndedCall = "join-ended-call"
- 	public var mode: Mode
+ 	case muteUsers = "mute-users"
- 	public init(mode: Mode)
+ 	case pinForEveryone = "pin-for-everyone"
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	case readCall = "read-call"
- 		case mode
+ 	case removeCallMember = "remove-call-member"
- 	public static func == (lhs: NoiseCancellationSettingsRequest, rhs: NoiseCancellationSettingsRequest) -> Bool
+ 	case screenshare
- 	public func hash(into hasher: inout Hasher)
+ 	case sendAudio = "send-audio"
- 
+ 	case sendVideo = "send-video"
- public enum OwnCapability : String, Sendable, Codable, CaseIterable
+ 	case startBroadcastCall = "start-broadcast-call"
- 	case blockUsers = "block-users"
+ 	case startClosedCaptionsCall = "start-closed-captions-call"
- 	case changeMaxDuration = "change-max-duration"
+ 	case startRecordCall = "start-record-call"
- 	case createCall = "create-call"
+ 	case startTranscriptionCall = "start-transcription-call"
- 	case createReaction = "create-reaction"
+ 	case stopBroadcastCall = "stop-broadcast-call"
- 	case enableNoiseCancellation = "enable-noise-cancellation"
+ 	case stopClosedCaptionsCall = "stop-closed-captions-call"
- 	case endCall = "end-call"
+ 	case stopRecordCall = "stop-record-call"
- 	case joinBackstage = "join-backstage"
+ 	case stopTranscriptionCall = "stop-transcription-call"
- 	case joinCall = "join-call"
+ 	case updateCall = "update-call"
- 	case joinEndedCall = "join-ended-call"
+ 	case updateCallMember = "update-call-member"
- 	case muteUsers = "mute-users"
+ 	case updateCallPermissions = "update-call-permissions"
- 	case pinForEveryone = "pin-for-everyone"
+ 	case updateCallSettings = "update-call-settings"
- 	case readCall = "read-call"
+ 	case unknown = "_unknown"
- 	case removeCallMember = "remove-call-member"
+ 	public init(from decoder: Decoder) throws
- 	case screenshare
+ 
- 	case sendAudio = "send-audio"
+ public final class OwnUserResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	case sendVideo = "send-video"
+ 	public var blockedUserIds: [String]?
- 	case startBroadcastCall = "start-broadcast-call"
+ 	public var createdAt: Date
- 	case startClosedCaptionsCall = "start-closed-captions-call"
+ 	public var custom: [String: RawJSON]
- 	case startRecordCall = "start-record-call"
+ 	public var deactivatedAt: Date?
- 	case startTranscriptionCall = "start-transcription-call"
+ 	public var deletedAt: Date?
- 	case stopBroadcastCall = "stop-broadcast-call"
+ 	public var devices: [Device]
- 	case stopClosedCaptionsCall = "stop-closed-captions-call"
+ 	public var id: String
- 	case stopRecordCall = "stop-record-call"
+ 	public var image: String?
- 	case stopTranscriptionCall = "stop-transcription-call"
+ 	public var language: String
- 	case updateCall = "update-call"
+ 	public var lastActive: Date?
- 	case updateCallMember = "update-call-member"
+ 	public var name: String?
- 	case updateCallPermissions = "update-call-permissions"
+ 	public var pushNotifications: PushNotificationSettingsResponse?
- 	case updateCallSettings = "update-call-settings"
+ 	public var revokeTokensIssuedBefore: Date?
- 	case unknown = "_unknown"
+ 	public var role: String
- 	public init(from decoder: Decoder) throws
+ 	public var teams: [String]
- 
+ 	public var updatedAt: Date
- public final class OwnUserResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public init(
- 	public var blockedUserIds: [String]?
+         blockedUserIds: [String]? = nil,
- 	public var createdAt: Date
+         createdAt: Date,
- 	public var custom: [String: RawJSON]
+         custom: [String: RawJSON],
- 	public var deactivatedAt: Date?
+         deactivatedAt: Date? = nil,
- 	public var deletedAt: Date?
+         deletedAt: Date? = nil,
- 	public var devices: [Device]
+         devices: [Device],
- 	public var id: String
+         id: String,
- 	public var image: String?
+         image: String? = nil,
- 	public var language: String
+         language: String,
- 	public var lastActive: Date?
+         lastActive: Date? = nil,
- 	public var name: String?
+         name: String? = nil,
- 	public var pushNotifications: PushNotificationSettingsResponse?
+         pushNotifications: PushNotificationSettingsResponse? = nil,
- 	public var revokeTokensIssuedBefore: Date?
+         revokeTokensIssuedBefore: Date? = nil,
- 	public var role: String
+         role: String,
- 	public var teams: [String]
+         teams: [String],
- 	public var updatedAt: Date
+         updatedAt: Date
- 	public init(
+     )
-         blockedUserIds: [String]? = nil,
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
-         createdAt: Date,
+ 		case blockedUserIds = "blocked_user_ids"
-         custom: [String: RawJSON],
+ 		case createdAt = "created_at"
-         deactivatedAt: Date? = nil,
+ 		case custom
-         deletedAt: Date? = nil,
+ 		case deactivatedAt = "deactivated_at"
-         devices: [Device],
+ 		case deletedAt = "deleted_at"
-         id: String,
+ 		case devices
-         image: String? = nil,
+ 		case id
-         language: String,
+ 		case image
-         lastActive: Date? = nil,
+ 		case language
-         name: String? = nil,
+ 		case lastActive = "last_active"
-         pushNotifications: PushNotificationSettingsResponse? = nil,
+ 		case name
-         revokeTokensIssuedBefore: Date? = nil,
+ 		case pushNotifications = "push_notifications"
-         role: String,
+ 		case revokeTokensIssuedBefore = "revoke_tokens_issued_before"
-         teams: [String],
+ 		case role
-         updatedAt: Date
+ 		case teams
-     )
+ 		case updatedAt = "updated_at"
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public static func == (lhs: OwnUserResponse, rhs: OwnUserResponse) -> Bool
- 		case blockedUserIds = "blocked_user_ids"
+ 	public func hash(into hasher: inout Hasher)
- 		case createdAt = "created_at"
+ 
- 		case custom
+ public final class PermissionRequestEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- 		case deactivatedAt = "deactivated_at"
+ 	public var callCid: String
- 		case deletedAt = "deleted_at"
+ 	public var createdAt: Date
- 		case devices
+ 	public var permissions: [String]
- 		case id
+ 	public var type: String
- 		case image
+ 	public var user: UserResponse
- 		case language
+ 	public init(callCid: String, createdAt: Date, permissions: [String], user: UserResponse)
- 		case lastActive = "last_active"
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 		case name
+ 		case callCid = "call_cid"
- 		case pushNotifications = "push_notifications"
+ 		case createdAt = "created_at"
- 		case revokeTokensIssuedBefore = "revoke_tokens_issued_before"
+ 		case permissions
- 		case role
+ 		case type
- 		case teams
+ 		case user
- 		case updatedAt = "updated_at"
+ 	public static func == (lhs: PermissionRequestEvent, rhs: PermissionRequestEvent) -> Bool
- 	public static func == (lhs: OwnUserResponse, rhs: OwnUserResponse) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class PinRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- public final class PermissionRequestEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public var sessionId: String
- 	public var callCid: String
+ 	public var userId: String
- 	public var createdAt: Date
+ 	public init(sessionId: String, userId: String)
- 	public var permissions: [String]
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var type: String
+ 		case sessionId = "session_id"
- 	public var user: UserResponse
+ 		case userId = "user_id"
- 	public init(callCid: String, createdAt: Date, permissions: [String], user: UserResponse)
+ 	public static func == (lhs: PinRequest, rhs: PinRequest) -> Bool
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public func hash(into hasher: inout Hasher)
- 		case callCid = "call_cid"
+ 
- 		case createdAt = "created_at"
+ public final class PinResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case permissions
+ 	public var duration: String
- 		case type
+ 	public init(duration: String)
- 		case user
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public static func == (lhs: PermissionRequestEvent, rhs: PermissionRequestEvent) -> Bool
+ 		case duration
- 	public func hash(into hasher: inout Hasher)
+ 	public static func == (lhs: PinResponse, rhs: PinResponse) -> Bool
- 
+ 	public func hash(into hasher: inout Hasher)
- public final class PinRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 
- 	public var sessionId: String
+ public final class PublishedTrackInfo : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public var userId: String
+ 	public var codecMimeType: String?
- 	public init(sessionId: String, userId: String)
+ 	public var durationSeconds: Int?
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var trackType: String?
- 		case sessionId = "session_id"
+ 	public init(codecMimeType: String? = nil, durationSeconds: Int? = nil, trackType: String? = nil)
- 		case userId = "user_id"
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public static func == (lhs: PinRequest, rhs: PinRequest) -> Bool
+ 		case codecMimeType = "codec_mime_type"
- 	public func hash(into hasher: inout Hasher)
+ 		case durationSeconds = "duration_seconds"
- 
+ 		case trackType = "track_type"
- public final class PinResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public static func == (lhs: PublishedTrackInfo, rhs: PublishedTrackInfo) -> Bool
- 	public var duration: String
+ 	public func hash(into hasher: inout Hasher)
- 	public init(duration: String)
+ 
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ public final class PublisherAggregateStats : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case duration
+ 	public var byTrackType: [String: Count]?
- 	public static func == (lhs: PinResponse, rhs: PinResponse) -> Bool
+ 	public var total: Count?
- 	public func hash(into hasher: inout Hasher)
+ 	public init(byTrackType: [String: Count]? = nil, total: Count? = nil)
- 
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- public final class PublishedTrackInfo : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case byTrackType = "by_track_type"
- 	public var codecMimeType: String?
+ 		case total
- 	public var durationSeconds: Int?
+ 	public static func == (lhs: PublisherAggregateStats, rhs: PublisherAggregateStats) -> Bool
- 	public var trackType: String?
+ 	public func hash(into hasher: inout Hasher)
- 	public init(codecMimeType: String? = nil, durationSeconds: Int? = nil, trackType: String? = nil)
+ 
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ public final class PushNotificationSettingsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case codecMimeType = "codec_mime_type"
+ 	public var disabled: Bool?
- 		case durationSeconds = "duration_seconds"
+ 	public var disabledUntil: Date?
- 		case trackType = "track_type"
+ 	public init(disabled: Bool? = nil, disabledUntil: Date? = nil)
- 	public static func == (lhs: PublishedTrackInfo, rhs: PublishedTrackInfo) -> Bool
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public func hash(into hasher: inout Hasher)
+ 		case disabled
- 
+ 		case disabledUntil = "disabled_until"
- public final class PublisherAggregateStats : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public static func == (lhs: PushNotificationSettingsResponse, rhs: PushNotificationSettingsResponse) -> Bool
- 	public var byTrackType: [String: Count]?
+ 	public func hash(into hasher: inout Hasher)
- 	public var total: Count?
+ 
- 	public init(byTrackType: [String: Count]? = nil, total: Count? = nil)
+ public final class QueryCallStatsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var filterConditions: [String: RawJSON]?
- 		case byTrackType = "by_track_type"
+ 	public var limit: Int?
- 		case total
+ 	public var next: String?
- 	public static func == (lhs: PublisherAggregateStats, rhs: PublisherAggregateStats) -> Bool
+ 	public var prev: String?
- 	public func hash(into hasher: inout Hasher)
+ 	public var sort: [SortParamRequest]?
- 
+ 	public init(
- public final class PushNotificationSettingsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+         filterConditions: [String: RawJSON]? = nil,
- 	public var disabled: Bool?
+         limit: Int? = nil,
- 	public var disabledUntil: Date?
+         next: String? = nil,
- 	public init(disabled: Bool? = nil, disabledUntil: Date? = nil)
+         prev: String? = nil,
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+         sort: [SortParamRequest]? = nil
- 		case disabled
+     )
- 		case disabledUntil = "disabled_until"
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public static func == (lhs: PushNotificationSettingsResponse, rhs: PushNotificationSettingsResponse) -> Bool
+ 		case filterConditions = "filter_conditions"
- 	public func hash(into hasher: inout Hasher)
+ 		case limit
- 
+ 		case next
- public final class QueryCallStatsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case prev
- 	public var filterConditions: [String: RawJSON]?
+ 		case sort
- 	public var limit: Int?
+ 	public static func == (lhs: QueryCallStatsRequest, rhs: QueryCallStatsRequest) -> Bool
- 	public var next: String?
+ 	public func hash(into hasher: inout Hasher)
- 	public var prev: String?
+ 
- 	public var sort: [SortParamRequest]?
+ public final class QueryCallStatsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public init(
+ 	public var duration: String
-         filterConditions: [String: RawJSON]? = nil,
+ 	public var next: String?
-         limit: Int? = nil,
+ 	public var prev: String?
-         next: String? = nil,
+ 	public var reports: [CallStatsReportSummaryResponse]
-         prev: String? = nil,
+ 	public init(duration: String, next: String? = nil, prev: String? = nil, reports: [CallStatsReportSummaryResponse])
-         sort: [SortParamRequest]? = nil
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
-     )
+ 		case duration
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case next
- 		case filterConditions = "filter_conditions"
+ 		case prev
- 		case limit
+ 		case reports
- 		case next
+ 	public static func == (lhs: QueryCallStatsResponse, rhs: QueryCallStatsResponse) -> Bool
- 		case prev
+ 	public func hash(into hasher: inout Hasher)
- 		case sort
+ 
- 	public static func == (lhs: QueryCallStatsRequest, rhs: QueryCallStatsRequest) -> Bool
+ public final class QueryCallsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public func hash(into hasher: inout Hasher)
+ 	public var filterConditions: [String: RawJSON]?
- 
+ 	public var limit: Int?
- public final class QueryCallStatsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var next: String?
- 	public var duration: String
+ 	public var prev: String?
- 	public var next: String?
+ 	public var sort: [SortParamRequest]?
- 	public var prev: String?
+ 	public var watch: Bool?
- 	public var reports: [CallStatsReportSummaryResponse]
+ 	public init(
- 	public init(duration: String, next: String? = nil, prev: String? = nil, reports: [CallStatsReportSummaryResponse])
+         filterConditions: [String: RawJSON]? = nil,
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+         limit: Int? = nil,
- 		case duration
+         next: String? = nil,
- 		case next
+         prev: String? = nil,
- 		case prev
+         sort: [SortParamRequest]? = nil,
- 		case reports
+         watch: Bool? = nil
- 	public static func == (lhs: QueryCallStatsResponse, rhs: QueryCallStatsResponse) -> Bool
+     )
- 	public func hash(into hasher: inout Hasher)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 
+ 		case filterConditions = "filter_conditions"
- public final class QueryCallsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case limit
- 	public var filterConditions: [String: RawJSON]?
+ 		case next
- 	public var limit: Int?
+ 		case prev
- 	public var next: String?
+ 		case sort
- 	public var prev: String?
+ 		case watch
- 	public var sort: [SortParamRequest]?
+ 	public static func == (lhs: QueryCallsRequest, rhs: QueryCallsRequest) -> Bool
- 	public var watch: Bool?
+ 	public func hash(into hasher: inout Hasher)
- 	public init(
+ 
-         filterConditions: [String: RawJSON]? = nil,
+ public final class QueryCallsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
-         limit: Int? = nil,
+ 	public var calls: [CallStateResponseFields]
-         next: String? = nil,
+ 	public var duration: String
-         prev: String? = nil,
+ 	public var next: String?
-         sort: [SortParamRequest]? = nil,
+ 	public var prev: String?
-         watch: Bool? = nil
+ 	public init(calls: [CallStateResponseFields], duration: String, next: String? = nil, prev: String? = nil)
-     )
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case calls
- 		case filterConditions = "filter_conditions"
+ 		case duration
- 		case limit
+ 		case next
- 		case next
+ 		case prev
- 		case prev
+ 	public static func == (lhs: QueryCallsResponse, rhs: QueryCallsResponse) -> Bool
- 		case sort
+ 	public func hash(into hasher: inout Hasher)
- 		case watch
+ 
- 	public static func == (lhs: QueryCallsRequest, rhs: QueryCallsRequest) -> Bool
+ public final class QueryMembersRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public func hash(into hasher: inout Hasher)
+ 	public var filterConditions: [String: RawJSON]?
- 
+ 	public var id: String
- public final class QueryCallsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var limit: Int?
- 	public var calls: [CallStateResponseFields]
+ 	public var next: String?
- 	public var duration: String
+ 	public var prev: String?
- 	public var next: String?
+ 	public var sort: [SortParamRequest]?
- 	public var prev: String?
+ 	public var type: String
- 	public init(calls: [CallStateResponseFields], duration: String, next: String? = nil, prev: String? = nil)
+ 	public init(
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+         filterConditions: [String: RawJSON]? = nil,
- 		case calls
+         id: String,
- 		case duration
+         limit: Int? = nil,
- 		case next
+         next: String? = nil,
- 		case prev
+         prev: String? = nil,
- 	public static func == (lhs: QueryCallsResponse, rhs: QueryCallsResponse) -> Bool
+         sort: [SortParamRequest]? = nil,
- 	public func hash(into hasher: inout Hasher)
+         type: String
- 
+     )
- public final class QueryMembersRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var filterConditions: [String: RawJSON]?
+ 		case filterConditions = "filter_conditions"
- 	public var id: String
+ 		case id
- 	public var limit: Int?
+ 		case limit
- 	public var next: String?
+ 		case next
- 	public var prev: String?
+ 		case prev
- 	public var sort: [SortParamRequest]?
+ 		case sort
- 	public var type: String
+ 		case type
- 	public init(
+ 	public static func == (lhs: QueryMembersRequest, rhs: QueryMembersRequest) -> Bool
-         filterConditions: [String: RawJSON]? = nil,
+ 	public func hash(into hasher: inout Hasher)
-         id: String,
+ 
-         limit: Int? = nil,
+ public final class QueryMembersResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
-         next: String? = nil,
+ 	public var duration: String
-         prev: String? = nil,
+ 	public var members: [MemberResponse]
-         sort: [SortParamRequest]? = nil,
+ 	public var next: String?
-         type: String
+ 	public var prev: String?
-     )
+ 	public init(duration: String, members: [MemberResponse], next: String? = nil, prev: String? = nil)
- 		case filterConditions = "filter_conditions"
+ 		case duration
- 		case id
+ 		case members
- 		case limit
+ 		case next
- 		case next
+ 		case prev
- 		case prev
+ 	public static func == (lhs: QueryMembersResponse, rhs: QueryMembersResponse) -> Bool
- 		case sort
+ 	public func hash(into hasher: inout Hasher)
- 		case type
+ 
- 	public static func == (lhs: QueryMembersRequest, rhs: QueryMembersRequest) -> Bool
+ public final class RTMPBroadcastRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public func hash(into hasher: inout Hasher)
+ 	public enum Quality : String, Sendable, Codable, CaseIterable
- 
+ 		case _1080p = "1080p"
- public final class QueryMembersResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case _1440p = "1440p"
- 	public var duration: String
+ 		case _360p = "360p"
- 	public var members: [MemberResponse]
+ 		case _480p = "480p"
- 	public var next: String?
+ 		case _720p = "720p"
- 	public var prev: String?
+ 		case portrait1080x1920 = "portrait-1080x1920"
- 	public init(duration: String, members: [MemberResponse], next: String? = nil, prev: String? = nil)
+ 		case portrait1440x2560 = "portrait-1440x2560"
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case portrait360x640 = "portrait-360x640"
- 		case duration
+ 		case portrait480x854 = "portrait-480x854"
- 		case members
+ 		case portrait720x1280 = "portrait-720x1280"
- 		case next
+ 		case unknown = "_unknown"
- 		case prev
+ 		public init(from decoder: Decoder) throws
- 	public static func == (lhs: QueryMembersResponse, rhs: QueryMembersResponse) -> Bool
+ 	public var layout: LayoutSettings?
- 	public func hash(into hasher: inout Hasher)
+ 	public var name: String
- 
+ 	public var quality: Quality?
- public final class RTMPBroadcastRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var streamKey: String?
- 	public enum Quality : String, Sendable, Codable, CaseIterable
+ 	public var streamUrl: String
- 		case _1080p = "1080p"
+ 	public init(layout: LayoutSettings? = nil, name: String, quality: Quality? = nil, streamKey: String? = nil, streamUrl: String)
- 		case _1440p = "1440p"
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 		case _360p = "360p"
+ 		case layout
- 		case _480p = "480p"
+ 		case name
- 		case _720p = "720p"
+ 		case quality
- 		case portrait1080x1920 = "portrait-1080x1920"
+ 		case streamKey = "stream_key"
- 		case portrait1440x2560 = "portrait-1440x2560"
+ 		case streamUrl = "stream_url"
- 		case portrait360x640 = "portrait-360x640"
+ 	public static func == (lhs: RTMPBroadcastRequest, rhs: RTMPBroadcastRequest) -> Bool
- 		case portrait480x854 = "portrait-480x854"
+ 	public func hash(into hasher: inout Hasher)
- 		case portrait720x1280 = "portrait-720x1280"
+ 
- 		case unknown = "_unknown"
+ public final class RTMPIngress : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		public init(from decoder: Decoder) throws
+ 	public var address: String
- 	public var layout: LayoutSettings?
+ 	public init(address: String)
- 	public var name: String
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var quality: Quality?
+ 		case address
- 	public var streamKey: String?
+ 	public static func == (lhs: RTMPIngress, rhs: RTMPIngress) -> Bool
- 	public var streamUrl: String
+ 	public func hash(into hasher: inout Hasher)
- 	public init(layout: LayoutSettings? = nil, name: String, quality: Quality? = nil, streamKey: String? = nil, streamUrl: String)
+ 
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ public final class RTMPSettingsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case layout
+ 	public enum Quality : String, Sendable, Codable, CaseIterable
- 		case name
+ 		case _1080p = "1080p"
- 		case quality
+ 		case _1440p = "1440p"
- 		case streamKey = "stream_key"
+ 		case _360p = "360p"
- 		case streamUrl = "stream_url"
+ 		case _480p = "480p"
- 	public static func == (lhs: RTMPBroadcastRequest, rhs: RTMPBroadcastRequest) -> Bool
+ 		case _720p = "720p"
- 	public func hash(into hasher: inout Hasher)
+ 		case portrait1080x1920 = "portrait-1080x1920"
- 
+ 		case portrait1440x2560 = "portrait-1440x2560"
- public final class RTMPIngress : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case portrait360x640 = "portrait-360x640"
- 	public var address: String
+ 		case portrait480x854 = "portrait-480x854"
- 	public init(address: String)
+ 		case portrait720x1280 = "portrait-720x1280"
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case unknown = "_unknown"
- 		case address
+ 		public init(from decoder: Decoder) throws
- 	public static func == (lhs: RTMPIngress, rhs: RTMPIngress) -> Bool
+ 	public var enabled: Bool?
- 	public func hash(into hasher: inout Hasher)
+ 	public var quality: Quality?
- 
+ 	public init(enabled: Bool? = nil, quality: Quality? = nil)
- public final class RTMPSettingsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public enum Quality : String, Sendable, Codable, CaseIterable
+ 		case enabled
- 		case _1080p = "1080p"
+ 		case quality
- 		case _1440p = "1440p"
+ 	public static func == (lhs: RTMPSettingsRequest, rhs: RTMPSettingsRequest) -> Bool
- 		case _360p = "360p"
+ 	public func hash(into hasher: inout Hasher)
- 		case _480p = "480p"
+ 
- 		case _720p = "720p"
+ public final class RTMPSettingsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case portrait1080x1920 = "portrait-1080x1920"
+ 	public var enabled: Bool
- 		case portrait1440x2560 = "portrait-1440x2560"
+ 	public var quality: String
- 		case portrait360x640 = "portrait-360x640"
+ 	public init(enabled: Bool, quality: String)
- 		case portrait480x854 = "portrait-480x854"
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 		case portrait720x1280 = "portrait-720x1280"
+ 		case enabled
- 		case unknown = "_unknown"
+ 		case quality
- 		public init(from decoder: Decoder) throws
+ 	public static func == (lhs: RTMPSettingsResponse, rhs: RTMPSettingsResponse) -> Bool
- 	public var enabled: Bool?
+ 	public func hash(into hasher: inout Hasher)
- 	public var quality: Quality?
+ 
- 	public init(enabled: Bool? = nil, quality: Quality? = nil)
+ public final class ReactionResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var custom: [String: RawJSON]?
- 		case enabled
+ 	public var emojiCode: String?
- 		case quality
+ 	public var type: String
- 	public static func == (lhs: RTMPSettingsRequest, rhs: RTMPSettingsRequest) -> Bool
+ 	public var user: UserResponse
- 	public func hash(into hasher: inout Hasher)
+ 	public init(custom: [String: RawJSON]? = nil, emojiCode: String? = nil, type: String, user: UserResponse)
- 
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- public final class RTMPSettingsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case custom
- 	public var enabled: Bool
+ 		case emojiCode = "emoji_code"
- 	public var quality: String
+ 		case type
- 	public init(enabled: Bool, quality: String)
+ 		case user
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public static func == (lhs: ReactionResponse, rhs: ReactionResponse) -> Bool
- 		case enabled
+ 	public func hash(into hasher: inout Hasher)
- 		case quality
+ 
- 	public static func == (lhs: RTMPSettingsResponse, rhs: RTMPSettingsResponse) -> Bool
+ public final class RecordSettingsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public func hash(into hasher: inout Hasher)
+ 	public enum Mode : String, Sendable, Codable, CaseIterable
- 
+ 		case autoOn = "auto-on"
- public final class ReactionResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case available
- 	public var custom: [String: RawJSON]?
+ 		case disabled
- 	public var emojiCode: String?
+ 		case unknown = "_unknown"
- 	public var type: String
+ 		public init(from decoder: Decoder) throws
- 	public var user: UserResponse
+ 	public enum Quality : String, Sendable, Codable, CaseIterable
- 	public init(custom: [String: RawJSON]? = nil, emojiCode: String? = nil, type: String, user: UserResponse)
+ 		case _1080p = "1080p"
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case _1440p = "1440p"
- 		case custom
+ 		case _360p = "360p"
- 		case emojiCode = "emoji_code"
+ 		case _480p = "480p"
- 		case type
+ 		case _720p = "720p"
- 		case user
+ 		case portrait1080x1920 = "portrait-1080x1920"
- 	public static func == (lhs: ReactionResponse, rhs: ReactionResponse) -> Bool
+ 		case portrait1440x2560 = "portrait-1440x2560"
- 	public func hash(into hasher: inout Hasher)
+ 		case portrait360x640 = "portrait-360x640"
- 
+ 		case portrait480x854 = "portrait-480x854"
- public final class RecordSettingsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case portrait720x1280 = "portrait-720x1280"
- 	public enum Mode : String, Sendable, Codable, CaseIterable
+ 		case unknown = "_unknown"
- 		case autoOn = "auto-on"
+ 		public init(from decoder: Decoder) throws
- 		case available
+ 	public var audioOnly: Bool?
- 		case disabled
+ 	public var mode: Mode
- 		case unknown = "_unknown"
+ 	public var quality: Quality?
- 		public init(from decoder: Decoder) throws
+ 	public init(audioOnly: Bool? = nil, mode: Mode, quality: Quality? = nil)
- 	public enum Quality : String, Sendable, Codable, CaseIterable
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 		case _1080p = "1080p"
+ 		case audioOnly = "audio_only"
- 		case _1440p = "1440p"
+ 		case mode
- 		case _360p = "360p"
+ 		case quality
- 		case _480p = "480p"
+ 	public static func == (lhs: RecordSettingsRequest, rhs: RecordSettingsRequest) -> Bool
- 		case _720p = "720p"
+ 	public func hash(into hasher: inout Hasher)
- 		case portrait1080x1920 = "portrait-1080x1920"
+ 
- 		case portrait1440x2560 = "portrait-1440x2560"
+ public final class RecordSettingsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case portrait360x640 = "portrait-360x640"
+ 	public var audioOnly: Bool
- 		case portrait480x854 = "portrait-480x854"
+ 	public var mode: String
- 		case portrait720x1280 = "portrait-720x1280"
+ 	public var quality: String
- 		case unknown = "_unknown"
+ 	public init(audioOnly: Bool, mode: String, quality: String)
- 		public init(from decoder: Decoder) throws
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var audioOnly: Bool?
+ 		case audioOnly = "audio_only"
- 	public var mode: Mode
+ 		case mode
- 	public var quality: Quality?
+ 		case quality
- 	public init(audioOnly: Bool? = nil, mode: Mode, quality: Quality? = nil)
+ 	public static func == (lhs: RecordSettingsResponse, rhs: RecordSettingsResponse) -> Bool
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public func hash(into hasher: inout Hasher)
- 		case audioOnly = "audio_only"
+ 
- 		case mode
+ public final class RejectCallRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case quality
+ 	public var reason: String?
- 	public static func == (lhs: RecordSettingsRequest, rhs: RecordSettingsRequest) -> Bool
+ 	public init(reason: String? = nil)
- 	public func hash(into hasher: inout Hasher)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 
+ 		case reason
- public final class RecordSettingsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public static func == (lhs: RejectCallRequest, rhs: RejectCallRequest) -> Bool
- 	public var audioOnly: Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public var mode: String
+ 
- 	public var quality: String
+ public final class RejectCallResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public init(audioOnly: Bool, mode: String, quality: String)
+ 	public var duration: String
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public init(duration: String)
- 		case audioOnly = "audio_only"
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 		case mode
+ 		case duration
- 		case quality
+ 	public static func == (lhs: RejectCallResponse, rhs: RejectCallResponse) -> Bool
- 	public static func == (lhs: RecordSettingsResponse, rhs: RecordSettingsResponse) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class RequestPermissionRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- public final class RejectCallRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var permissions: [String]
- 	public var reason: String?
+ 	public init(permissions: [String])
- 	public init(reason: String? = nil)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case permissions
- 		case reason
+ 	public static func == (lhs: RequestPermissionRequest, rhs: RequestPermissionRequest) -> Bool
- 	public static func == (lhs: RejectCallRequest, rhs: RejectCallRequest) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class RequestPermissionResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- public final class RejectCallResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var duration: String
- 	public var duration: String
+ 	public init(duration: String)
- 	public init(duration: String)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case duration
- 		case duration
+ 	public static func == (lhs: RequestPermissionResponse, rhs: RequestPermissionResponse) -> Bool
- 	public static func == (lhs: RejectCallResponse, rhs: RejectCallResponse) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class RingSettings : @unchecked Sendable, Codable, JSONEncodable, Hashable
- public final class RequestPermissionRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var autoCancelTimeoutMs: Int
- 	public var permissions: [String]
+ 	public var incomingCallTimeoutMs: Int
- 	public init(permissions: [String])
+ 	public var missedCallTimeoutMs: Int
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public init(autoCancelTimeoutMs: Int, incomingCallTimeoutMs: Int, missedCallTimeoutMs: Int)
- 		case permissions
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public static func == (lhs: RequestPermissionRequest, rhs: RequestPermissionRequest) -> Bool
+ 		case autoCancelTimeoutMs = "auto_cancel_timeout_ms"
- 	public func hash(into hasher: inout Hasher)
+ 		case incomingCallTimeoutMs = "incoming_call_timeout_ms"
- 
+ 		case missedCallTimeoutMs = "missed_call_timeout_ms"
- public final class RequestPermissionResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public static func == (lhs: RingSettings, rhs: RingSettings) -> Bool
- 	public var duration: String
+ 	public func hash(into hasher: inout Hasher)
- 	public init(duration: String)
+ 
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ public final class RingSettingsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case duration
+ 	public var autoCancelTimeoutMs: Int
- 	public static func == (lhs: RequestPermissionResponse, rhs: RequestPermissionResponse) -> Bool
+ 	public var incomingCallTimeoutMs: Int
- 	public func hash(into hasher: inout Hasher)
+ 	public var missedCallTimeoutMs: Int?
- 
+ 	public init(autoCancelTimeoutMs: Int, incomingCallTimeoutMs: Int, missedCallTimeoutMs: Int? = nil)
- public final class RingSettings : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var autoCancelTimeoutMs: Int
+ 		case autoCancelTimeoutMs = "auto_cancel_timeout_ms"
- 	public var incomingCallTimeoutMs: Int
+ 		case incomingCallTimeoutMs = "incoming_call_timeout_ms"
- 	public var missedCallTimeoutMs: Int
+ 		case missedCallTimeoutMs = "missed_call_timeout_ms"
- 	public init(autoCancelTimeoutMs: Int, incomingCallTimeoutMs: Int, missedCallTimeoutMs: Int)
+ 	public static func == (lhs: RingSettingsRequest, rhs: RingSettingsRequest) -> Bool
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public func hash(into hasher: inout Hasher)
- 		case autoCancelTimeoutMs = "auto_cancel_timeout_ms"
+ 
- 		case incomingCallTimeoutMs = "incoming_call_timeout_ms"
+ public final class SFULocationResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case missedCallTimeoutMs = "missed_call_timeout_ms"
+ 	public var coordinates: Coordinates
- 	public static func == (lhs: RingSettings, rhs: RingSettings) -> Bool
+ 	public var datacenter: String
- 	public func hash(into hasher: inout Hasher)
+ 	public var id: String
- 
+ 	public var location: Location
- public final class RingSettingsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public init(coordinates: Coordinates, datacenter: String, id: String, location: Location)
- 	public var autoCancelTimeoutMs: Int
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var incomingCallTimeoutMs: Int
+ 		case coordinates
- 	public var missedCallTimeoutMs: Int?
+ 		case datacenter
- 	public init(autoCancelTimeoutMs: Int, incomingCallTimeoutMs: Int, missedCallTimeoutMs: Int? = nil)
+ 		case id
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case location
- 		case autoCancelTimeoutMs = "auto_cancel_timeout_ms"
+ 	public static func == (lhs: SFULocationResponse, rhs: SFULocationResponse) -> Bool
- 		case incomingCallTimeoutMs = "incoming_call_timeout_ms"
+ 	public func hash(into hasher: inout Hasher)
- 		case missedCallTimeoutMs = "missed_call_timeout_ms"
+ 
- 	public static func == (lhs: RingSettingsRequest, rhs: RingSettingsRequest) -> Bool
+ public final class SFUResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public func hash(into hasher: inout Hasher)
+ 	public var edgeName: String
- 
+ 	public var url: String
- public final class SFULocationResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var wsEndpoint: String
- 	public var coordinates: Coordinates
+ 	public init(edgeName: String, url: String, wsEndpoint: String)
- 	public var datacenter: String
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var id: String
+ 		case edgeName = "edge_name"
- 	public var location: Location
+ 		case url
- 	public init(coordinates: Coordinates, datacenter: String, id: String, location: Location)
+ 		case wsEndpoint = "ws_endpoint"
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public static func == (lhs: SFUResponse, rhs: SFUResponse) -> Bool
- 		case coordinates
+ 	public func hash(into hasher: inout Hasher)
- 		case datacenter
+ 
- 		case id
+ public final class ScreensharingSettings : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case location
+ 	public var accessRequestEnabled: Bool
- 	public static func == (lhs: SFULocationResponse, rhs: SFULocationResponse) -> Bool
+ 	public var enabled: Bool
- 	public func hash(into hasher: inout Hasher)
+ 	public var targetResolution: TargetResolution?
- 
+ 	public init(accessRequestEnabled: Bool, enabled: Bool, targetResolution: TargetResolution? = nil)
- public final class SFUResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var edgeName: String
+ 		case accessRequestEnabled = "access_request_enabled"
- 	public var url: String
+ 		case enabled
- 	public var wsEndpoint: String
+ 		case targetResolution = "target_resolution"
- 	public init(edgeName: String, url: String, wsEndpoint: String)
+ 	public static func == (lhs: ScreensharingSettings, rhs: ScreensharingSettings) -> Bool
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public func hash(into hasher: inout Hasher)
- 		case edgeName = "edge_name"
+ 
- 		case url
+ public final class ScreensharingSettingsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case wsEndpoint = "ws_endpoint"
+ 	public var accessRequestEnabled: Bool?
- 	public static func == (lhs: SFUResponse, rhs: SFUResponse) -> Bool
+ 	public var enabled: Bool?
- 	public func hash(into hasher: inout Hasher)
+ 	public var targetResolution: TargetResolution?
- 
+ 	public init(accessRequestEnabled: Bool? = nil, enabled: Bool? = nil, targetResolution: TargetResolution? = nil)
- public final class ScreensharingSettings : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var accessRequestEnabled: Bool
+ 		case accessRequestEnabled = "access_request_enabled"
- 	public var enabled: Bool
+ 		case enabled
- 	public var targetResolution: TargetResolution?
+ 		case targetResolution = "target_resolution"
- 	public init(accessRequestEnabled: Bool, enabled: Bool, targetResolution: TargetResolution? = nil)
+ 	public static func == (lhs: ScreensharingSettingsRequest, rhs: ScreensharingSettingsRequest) -> Bool
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public func hash(into hasher: inout Hasher)
- 		case accessRequestEnabled = "access_request_enabled"
+ 
- 		case enabled
+ public final class SendEventRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case targetResolution = "target_resolution"
+ 	public var custom: [String: RawJSON]?
- 	public static func == (lhs: ScreensharingSettings, rhs: ScreensharingSettings) -> Bool
+ 	public init(custom: [String: RawJSON]? = nil)
- 	public func hash(into hasher: inout Hasher)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 
+ 		case custom
- public final class ScreensharingSettingsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public static func == (lhs: SendEventRequest, rhs: SendEventRequest) -> Bool
- 	public var accessRequestEnabled: Bool?
+ 	public func hash(into hasher: inout Hasher)
- 	public var enabled: Bool?
+ 
- 	public var targetResolution: TargetResolution?
+ public final class SendEventResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public init(accessRequestEnabled: Bool? = nil, enabled: Bool? = nil, targetResolution: TargetResolution? = nil)
+ 	public var duration: String
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public init(duration: String)
- 		case accessRequestEnabled = "access_request_enabled"
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 		case enabled
+ 		case duration
- 		case targetResolution = "target_resolution"
+ 	public static func == (lhs: SendEventResponse, rhs: SendEventResponse) -> Bool
- 	public static func == (lhs: ScreensharingSettingsRequest, rhs: ScreensharingSettingsRequest) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class SendReactionRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- public final class SendEventRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var custom: [String: RawJSON]?
- 	public var custom: [String: RawJSON]?
+ 	public var emojiCode: String?
- 	public init(custom: [String: RawJSON]? = nil)
+ 	public var type: String
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public init(custom: [String: RawJSON]? = nil, emojiCode: String? = nil, type: String)
- 		case custom
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public static func == (lhs: SendEventRequest, rhs: SendEventRequest) -> Bool
+ 		case custom
- 	public func hash(into hasher: inout Hasher)
+ 		case emojiCode = "emoji_code"
- 
+ 		case type
- public final class SendEventResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public static func == (lhs: SendReactionRequest, rhs: SendReactionRequest) -> Bool
- 	public var duration: String
+ 	public func hash(into hasher: inout Hasher)
- 	public init(duration: String)
+ 
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ public final class SendReactionResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case duration
+ 	public var duration: String
- 	public static func == (lhs: SendEventResponse, rhs: SendEventResponse) -> Bool
+ 	public var reaction: ReactionResponse
- 	public func hash(into hasher: inout Hasher)
+ 	public init(duration: String, reaction: ReactionResponse)
- 
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- public final class SendReactionRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case duration
- 	public var custom: [String: RawJSON]?
+ 		case reaction
- 	public var emojiCode: String?
+ 	public static func == (lhs: SendReactionResponse, rhs: SendReactionResponse) -> Bool
- 	public var type: String
+ 	public func hash(into hasher: inout Hasher)
- 	public init(custom: [String: RawJSON]? = nil, emojiCode: String? = nil, type: String)
+ 
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ public final class SessionSettingsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case custom
+ 	public var inactivityTimeoutSeconds: Int
- 		case emojiCode = "emoji_code"
+ 	public init(inactivityTimeoutSeconds: Int)
- 		case type
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public static func == (lhs: SendReactionRequest, rhs: SendReactionRequest) -> Bool
+ 		case inactivityTimeoutSeconds = "inactivity_timeout_seconds"
- 	public func hash(into hasher: inout Hasher)
+ 	public static func == (lhs: SessionSettingsRequest, rhs: SessionSettingsRequest) -> Bool
- 
+ 	public func hash(into hasher: inout Hasher)
- public final class SendReactionResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 
- 	public var duration: String
+ public final class SessionSettingsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public var reaction: ReactionResponse
+ 	public var inactivityTimeoutSeconds: Int
- 	public init(duration: String, reaction: ReactionResponse)
+ 	public init(inactivityTimeoutSeconds: Int)
- 		case duration
+ 		case inactivityTimeoutSeconds = "inactivity_timeout_seconds"
- 		case reaction
+ 	public static func == (lhs: SessionSettingsResponse, rhs: SessionSettingsResponse) -> Bool
- 	public static func == (lhs: SendReactionResponse, rhs: SendReactionResponse) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class SortParamRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- public final class SessionSettingsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var direction: Int?
- 	public var inactivityTimeoutSeconds: Int
+ 	public var field: String?
- 	public init(inactivityTimeoutSeconds: Int)
+ 	public init(direction: Int? = nil, field: String? = nil)
- 		case inactivityTimeoutSeconds = "inactivity_timeout_seconds"
+ 		case direction
- 	public static func == (lhs: SessionSettingsRequest, rhs: SessionSettingsRequest) -> Bool
+ 		case field
- 	public func hash(into hasher: inout Hasher)
+ 	public static func == (lhs: SortParamRequest, rhs: SortParamRequest) -> Bool
- 
+ 	public func hash(into hasher: inout Hasher)
- public final class SessionSettingsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 
- 	public var inactivityTimeoutSeconds: Int
+ public final class StartClosedCaptionsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public init(inactivityTimeoutSeconds: Int)
+ 	public var enableTranscription: Bool?
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var externalStorage: String?
- 		case inactivityTimeoutSeconds = "inactivity_timeout_seconds"
+ 	public var language: String?
- 	public static func == (lhs: SessionSettingsResponse, rhs: SessionSettingsResponse) -> Bool
+ 	public init(enableTranscription: Bool? = nil, externalStorage: String? = nil, language: String? = nil)
- 	public func hash(into hasher: inout Hasher)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 
+ 		case enableTranscription = "enable_transcription"
- public final class SortParamRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case externalStorage = "external_storage"
- 	public var direction: Int?
+ 		case language
- 	public var field: String?
+ 	public static func == (lhs: StartClosedCaptionsRequest, rhs: StartClosedCaptionsRequest) -> Bool
- 	public init(direction: Int? = nil, field: String? = nil)
+ 	public func hash(into hasher: inout Hasher)
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 
- 		case direction
+ public final class StartClosedCaptionsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case field
+ 	public var duration: String
- 	public static func == (lhs: SortParamRequest, rhs: SortParamRequest) -> Bool
+ 	public init(duration: String)
- 	public func hash(into hasher: inout Hasher)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 
+ 		case duration
- public final class StartClosedCaptionsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public static func == (lhs: StartClosedCaptionsResponse, rhs: StartClosedCaptionsResponse) -> Bool
- 	public var enableTranscription: Bool?
+ 	public func hash(into hasher: inout Hasher)
- 	public var externalStorage: String?
+ 
- 	public var language: String?
+ public final class StartHLSBroadcastingResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public init(enableTranscription: Bool? = nil, externalStorage: String? = nil, language: String? = nil)
+ 	public var duration: String
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var playlistUrl: String
- 		case enableTranscription = "enable_transcription"
+ 	public init(duration: String, playlistUrl: String)
- 		case externalStorage = "external_storage"
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 		case language
+ 		case duration
- 	public static func == (lhs: StartClosedCaptionsRequest, rhs: StartClosedCaptionsRequest) -> Bool
+ 		case playlistUrl = "playlist_url"
- 	public func hash(into hasher: inout Hasher)
+ 	public static func == (lhs: StartHLSBroadcastingResponse, rhs: StartHLSBroadcastingResponse) -> Bool
- 
+ 	public func hash(into hasher: inout Hasher)
- public final class StartClosedCaptionsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 
- 	public var duration: String
+ public final class StartRTMPBroadcastsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public init(duration: String)
+ 	public var broadcasts: [RTMPBroadcastRequest]
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public init(broadcasts: [RTMPBroadcastRequest])
- 		case duration
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public static func == (lhs: StartClosedCaptionsResponse, rhs: StartClosedCaptionsResponse) -> Bool
+ 		case broadcasts
- 	public func hash(into hasher: inout Hasher)
+ 	public static func == (lhs: StartRTMPBroadcastsRequest, rhs: StartRTMPBroadcastsRequest) -> Bool
- 
+ 	public func hash(into hasher: inout Hasher)
- public final class StartHLSBroadcastingResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 
- 	public var duration: String
+ public final class StartRTMPBroadcastsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public var playlistUrl: String
+ 	public var duration: String
- 	public init(duration: String, playlistUrl: String)
+ 	public init(duration: String)
- 		case playlistUrl = "playlist_url"
+ 	public static func == (lhs: StartRTMPBroadcastsResponse, rhs: StartRTMPBroadcastsResponse) -> Bool
- 	public static func == (lhs: StartHLSBroadcastingResponse, rhs: StartHLSBroadcastingResponse) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class StartRecordingRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- public final class StartRTMPBroadcastsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var recordingExternalStorage: String?
- 	public var broadcasts: [RTMPBroadcastRequest]
+ 	public init(recordingExternalStorage: String? = nil)
- 	public init(broadcasts: [RTMPBroadcastRequest])
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case recordingExternalStorage = "recording_external_storage"
- 		case broadcasts
+ 	public static func == (lhs: StartRecordingRequest, rhs: StartRecordingRequest) -> Bool
- 	public static func == (lhs: StartRTMPBroadcastsRequest, rhs: StartRTMPBroadcastsRequest) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class StartRecordingResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- public final class StartRTMPBroadcastsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var duration: String
- 	public var duration: String
+ 	public init(duration: String)
- 	public init(duration: String)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case duration
- 		case duration
+ 	public static func == (lhs: StartRecordingResponse, rhs: StartRecordingResponse) -> Bool
- 	public static func == (lhs: StartRTMPBroadcastsResponse, rhs: StartRTMPBroadcastsResponse) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class StartTranscriptionRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- public final class StartRecordingRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var enableClosedCaptions: Bool?
- 	public var recordingExternalStorage: String?
+ 	public var language: String?
- 	public init(recordingExternalStorage: String? = nil)
+ 	public var transcriptionExternalStorage: String?
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public init(enableClosedCaptions: Bool? = nil, language: String? = nil, transcriptionExternalStorage: String? = nil)
- 		case recordingExternalStorage = "recording_external_storage"
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public static func == (lhs: StartRecordingRequest, rhs: StartRecordingRequest) -> Bool
+ 		case enableClosedCaptions = "enable_closed_captions"
- 	public func hash(into hasher: inout Hasher)
+ 		case language
- 
+ 		case transcriptionExternalStorage = "transcription_external_storage"
- public final class StartRecordingResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public static func == (lhs: StartTranscriptionRequest, rhs: StartTranscriptionRequest) -> Bool
- 	public var duration: String
+ 	public func hash(into hasher: inout Hasher)
- 	public init(duration: String)
+ 
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ public final class StartTranscriptionResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case duration
+ 	public var duration: String
- 	public static func == (lhs: StartRecordingResponse, rhs: StartRecordingResponse) -> Bool
+ 	public init(duration: String)
- 	public func hash(into hasher: inout Hasher)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 
+ 		case duration
- public final class StartTranscriptionRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public static func == (lhs: StartTranscriptionResponse, rhs: StartTranscriptionResponse) -> Bool
- 	public var enableClosedCaptions: Bool?
+ 	public func hash(into hasher: inout Hasher)
- 	public var language: String?
+ 
- 	public var transcriptionExternalStorage: String?
+ public final class Stats : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public init(enableClosedCaptions: Bool? = nil, language: String? = nil, transcriptionExternalStorage: String? = nil)
+ 	public var averageSeconds: Float
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var maxSeconds: Float
- 		case enableClosedCaptions = "enable_closed_captions"
+ 	public init(averageSeconds: Float, maxSeconds: Float)
- 		case language
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 		case transcriptionExternalStorage = "transcription_external_storage"
+ 		case averageSeconds = "average_seconds"
- 	public static func == (lhs: StartTranscriptionRequest, rhs: StartTranscriptionRequest) -> Bool
+ 		case maxSeconds = "max_seconds"
- 	public func hash(into hasher: inout Hasher)
+ 	public static func == (lhs: Stats, rhs: Stats) -> Bool
- 
+ 	public func hash(into hasher: inout Hasher)
- public final class StartTranscriptionResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 
- 	public var duration: String
+ public final class StatsOptions : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public init(duration: String)
+ 	public var reportingIntervalMs: Int
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public init(reportingIntervalMs: Int)
- 		case duration
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public static func == (lhs: StartTranscriptionResponse, rhs: StartTranscriptionResponse) -> Bool
+ 		case reportingIntervalMs = "reporting_interval_ms"
- 	public func hash(into hasher: inout Hasher)
+ 	public static func == (lhs: StatsOptions, rhs: StatsOptions) -> Bool
- 
+ 	public func hash(into hasher: inout Hasher)
- public final class Stats : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 
- 	public var averageSeconds: Float
+ public final class StopAllRTMPBroadcastsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public var maxSeconds: Float
+ 	public var duration: String
- 	public init(averageSeconds: Float, maxSeconds: Float)
+ 	public init(duration: String)
- 		case averageSeconds = "average_seconds"
+ 		case duration
- 		case maxSeconds = "max_seconds"
+ 	public static func == (lhs: StopAllRTMPBroadcastsResponse, rhs: StopAllRTMPBroadcastsResponse) -> Bool
- 	public static func == (lhs: Stats, rhs: Stats) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class StopClosedCaptionsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- public final class StatsOptions : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var stopTranscription: Bool?
- 	public var reportingIntervalMs: Int
+ 	public init(stopTranscription: Bool? = nil)
- 	public init(reportingIntervalMs: Int)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case stopTranscription = "stop_transcription"
- 		case reportingIntervalMs = "reporting_interval_ms"
+ 	public static func == (lhs: StopClosedCaptionsRequest, rhs: StopClosedCaptionsRequest) -> Bool
- 	public static func == (lhs: StatsOptions, rhs: StatsOptions) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class StopClosedCaptionsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- public final class StopAllRTMPBroadcastsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var duration: String
- 	public var duration: String
+ 	public init(duration: String)
- 	public init(duration: String)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case duration
- 		case duration
+ 	public static func == (lhs: StopClosedCaptionsResponse, rhs: StopClosedCaptionsResponse) -> Bool
- 	public static func == (lhs: StopAllRTMPBroadcastsResponse, rhs: StopAllRTMPBroadcastsResponse) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class StopHLSBroadcastingResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- public final class StopClosedCaptionsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var duration: String
- 	public var stopTranscription: Bool?
+ 	public init(duration: String)
- 	public init(stopTranscription: Bool? = nil)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case duration
- 		case stopTranscription = "stop_transcription"
+ 	public static func == (lhs: StopHLSBroadcastingResponse, rhs: StopHLSBroadcastingResponse) -> Bool
- 	public static func == (lhs: StopClosedCaptionsRequest, rhs: StopClosedCaptionsRequest) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class StopLiveRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- public final class StopClosedCaptionsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var continueClosedCaption: Bool?
- 	public var duration: String
+ 	public var continueHls: Bool?
- 	public init(duration: String)
+ 	public var continueRecording: Bool?
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var continueRtmpBroadcasts: Bool?
- 		case duration
+ 	public var continueTranscription: Bool?
- 	public static func == (lhs: StopClosedCaptionsResponse, rhs: StopClosedCaptionsResponse) -> Bool
+ 	public init(
- 	public func hash(into hasher: inout Hasher)
+         continueClosedCaption: Bool? = nil,
- 
+         continueHls: Bool? = nil,
- public final class StopHLSBroadcastingResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+         continueRecording: Bool? = nil,
- 	public var duration: String
+         continueRtmpBroadcasts: Bool? = nil,
- 	public init(duration: String)
+         continueTranscription: Bool? = nil
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+     )
- 		case duration
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public static func == (lhs: StopHLSBroadcastingResponse, rhs: StopHLSBroadcastingResponse) -> Bool
+ 		case continueClosedCaption = "continue_closed_caption"
- 	public func hash(into hasher: inout Hasher)
+ 		case continueHls = "continue_hls"
- 
+ 		case continueRecording = "continue_recording"
- public final class StopLiveRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case continueRtmpBroadcasts = "continue_rtmp_broadcasts"
- 	public var continueClosedCaption: Bool?
+ 		case continueTranscription = "continue_transcription"
- 	public var continueHls: Bool?
+ 	public static func == (lhs: StopLiveRequest, rhs: StopLiveRequest) -> Bool
- 	public var continueRecording: Bool?
+ 	public func hash(into hasher: inout Hasher)
- 	public var continueRtmpBroadcasts: Bool?
+ 
- 	public var continueTranscription: Bool?
+ public final class StopLiveResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public init(
+ 	public var call: CallResponse
-         continueClosedCaption: Bool? = nil,
+ 	public var duration: String
-         continueHls: Bool? = nil,
+ 	public init(call: CallResponse, duration: String)
-         continueRecording: Bool? = nil,
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
-         continueRtmpBroadcasts: Bool? = nil,
+ 		case call
-         continueTranscription: Bool? = nil
+ 		case duration
-     )
+ 	public static func == (lhs: StopLiveResponse, rhs: StopLiveResponse) -> Bool
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public func hash(into hasher: inout Hasher)
- 		case continueClosedCaption = "continue_closed_caption"
+ 
- 		case continueHls = "continue_hls"
+ public final class StopRTMPBroadcastsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case continueRecording = "continue_recording"
+ 	public var duration: String
- 		case continueRtmpBroadcasts = "continue_rtmp_broadcasts"
+ 	public init(duration: String)
- 		case continueTranscription = "continue_transcription"
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public static func == (lhs: StopLiveRequest, rhs: StopLiveRequest) -> Bool
+ 		case duration
- 	public func hash(into hasher: inout Hasher)
+ 	public static func == (lhs: StopRTMPBroadcastsResponse, rhs: StopRTMPBroadcastsResponse) -> Bool
- 
+ 	public func hash(into hasher: inout Hasher)
- public final class StopLiveResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 
- 	public var call: CallResponse
+ public final class StopRecordingResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public init(call: CallResponse, duration: String)
+ 	public init(duration: String)
- 		case call
+ 		case duration
- 		case duration
+ 	public static func == (lhs: StopRecordingResponse, rhs: StopRecordingResponse) -> Bool
- 	public static func == (lhs: StopLiveResponse, rhs: StopLiveResponse) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class StopTranscriptionRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- public final class StopRTMPBroadcastsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var stopClosedCaptions: Bool?
- 	public var duration: String
+ 	public init(stopClosedCaptions: Bool? = nil)
- 	public init(duration: String)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case stopClosedCaptions = "stop_closed_captions"
- 		case duration
+ 	public static func == (lhs: StopTranscriptionRequest, rhs: StopTranscriptionRequest) -> Bool
- 	public static func == (lhs: StopRTMPBroadcastsResponse, rhs: StopRTMPBroadcastsResponse) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class StopTranscriptionResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- public final class StopRecordingResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var duration: String
- 	public var duration: String
+ 	public init(duration: String)
- 	public init(duration: String)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case duration
- 		case duration
+ 	public static func == (lhs: StopTranscriptionResponse, rhs: StopTranscriptionResponse) -> Bool
- 	public static func == (lhs: StopRecordingResponse, rhs: StopRecordingResponse) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class Subsession : @unchecked Sendable, Codable, JSONEncodable, Hashable
- public final class StopTranscriptionRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var endedAt: Int
- 	public var stopClosedCaptions: Bool?
+ 	public var joinedAt: Int
- 	public init(stopClosedCaptions: Bool? = nil)
+ 	public var pubSubHint: MediaPubSubHint?
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var sfuId: String
- 		case stopClosedCaptions = "stop_closed_captions"
+ 	public init(endedAt: Int, joinedAt: Int, pubSubHint: MediaPubSubHint? = nil, sfuId: String)
- 	public static func == (lhs: StopTranscriptionRequest, rhs: StopTranscriptionRequest) -> Bool
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public func hash(into hasher: inout Hasher)
+ 		case endedAt = "ended_at"
- 
+ 		case joinedAt = "joined_at"
- public final class StopTranscriptionResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case pubSubHint = "pub_sub_hint"
- 	public var duration: String
+ 		case sfuId = "sfu_id"
- 	public init(duration: String)
+ 	public static func == (lhs: Subsession, rhs: Subsession) -> Bool
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public func hash(into hasher: inout Hasher)
- 		case duration
+ 
- 	public static func == (lhs: StopTranscriptionResponse, rhs: StopTranscriptionResponse) -> Bool
+ public final class TURNAggregatedStats : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public func hash(into hasher: inout Hasher)
+ 	public var tcp: Count?
- 
+ 	public var total: Count?
- public final class Subsession : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public init(tcp: Count? = nil, total: Count? = nil)
- 	public var endedAt: Int
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var joinedAt: Int
+ 		case tcp
- 	public var pubSubHint: MediaPubSubHint?
+ 		case total
- 	public var sfuId: String
+ 	public static func == (lhs: TURNAggregatedStats, rhs: TURNAggregatedStats) -> Bool
- 	public init(endedAt: Int, joinedAt: Int, pubSubHint: MediaPubSubHint? = nil, sfuId: String)
+ 	public func hash(into hasher: inout Hasher)
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 
- 		case endedAt = "ended_at"
+ public final class TargetResolution : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case joinedAt = "joined_at"
+ 	public var bitrate: Int?
- 		case pubSubHint = "pub_sub_hint"
+ 	public var height: Int
- 		case sfuId = "sfu_id"
+ 	public var width: Int
- 	public static func == (lhs: Subsession, rhs: Subsession) -> Bool
+ 	public init(bitrate: Int? = nil, height: Int, width: Int)
- 	public func hash(into hasher: inout Hasher)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 
+ 		case bitrate
- public final class TURNAggregatedStats : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case height
- 	public var tcp: Count?
+ 		case width
- 	public var total: Count?
+ 	public static func == (lhs: TargetResolution, rhs: TargetResolution) -> Bool
- 	public init(tcp: Count? = nil, total: Count? = nil)
+ 	public func hash(into hasher: inout Hasher)
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 
- 		case tcp
+ public final class ThumbnailResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case total
+ 	public var imageUrl: String
- 	public static func == (lhs: TURNAggregatedStats, rhs: TURNAggregatedStats) -> Bool
+ 	public init(imageUrl: String)
- 	public func hash(into hasher: inout Hasher)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 
+ 		case imageUrl = "image_url"
- public final class TargetResolution : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public static func == (lhs: ThumbnailResponse, rhs: ThumbnailResponse) -> Bool
- 	public var bitrate: Int?
+ 	public func hash(into hasher: inout Hasher)
- 	public var height: Int
+ 
- 	public var width: Int
+ public final class ThumbnailsSettings : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public init(bitrate: Int? = nil, height: Int, width: Int)
+ 	public var enabled: Bool
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public init(enabled: Bool)
- 		case bitrate
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 		case height
+ 		case enabled
- 		case width
+ 	public static func == (lhs: ThumbnailsSettings, rhs: ThumbnailsSettings) -> Bool
- 	public static func == (lhs: TargetResolution, rhs: TargetResolution) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class ThumbnailsSettingsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- public final class ThumbnailResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var enabled: Bool?
- 	public var imageUrl: String
+ 	public init(enabled: Bool? = nil)
- 	public init(imageUrl: String)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case enabled
- 		case imageUrl = "image_url"
+ 	public static func == (lhs: ThumbnailsSettingsRequest, rhs: ThumbnailsSettingsRequest) -> Bool
- 	public static func == (lhs: ThumbnailResponse, rhs: ThumbnailResponse) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class TranscriptionSettings : @unchecked Sendable, Codable, JSONEncodable, Hashable
- public final class ThumbnailsSettings : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public enum ClosedCaptionMode : String, Sendable, Codable, CaseIterable
- 	public var enabled: Bool
+ 		case autoOn = "auto-on"
- 	public init(enabled: Bool)
+ 		case available
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case disabled
- 		case enabled
+ 		case unknown = "_unknown"
- 	public static func == (lhs: ThumbnailsSettings, rhs: ThumbnailsSettings) -> Bool
+ 		public init(from decoder: Decoder) throws
- 	public func hash(into hasher: inout Hasher)
+ 	public enum Language : String, Sendable, Codable, CaseIterable
- 
+ 		case ar
- public final class ThumbnailsSettingsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case auto
- 	public var enabled: Bool?
+ 		case ca
- 	public init(enabled: Bool? = nil)
+ 		case cs
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case da
- 		case enabled
+ 		case de
- 	public static func == (lhs: ThumbnailsSettingsRequest, rhs: ThumbnailsSettingsRequest) -> Bool
+ 		case el
- 	public func hash(into hasher: inout Hasher)
+ 		case en
- 
+ 		case es
- public final class TranscriptionSettings : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case fi
- 	public enum ClosedCaptionMode : String, Sendable, Codable, CaseIterable
+ 		case fr
- 		case autoOn = "auto-on"
+ 		case he
- 		case available
+ 		case hi
- 		case disabled
+ 		case hr
- 		case unknown = "_unknown"
+ 		case hu
- 		public init(from decoder: Decoder) throws
+ 		case id
- 	public enum Language : String, Sendable, Codable, CaseIterable
+ 		case it
- 		case ar
+ 		case ja
- 		case auto
+ 		case ko
- 		case ca
+ 		case ms
- 		case cs
+ 		case nl
- 		case da
+ 		case no
- 		case de
+ 		case pl
- 		case el
+ 		case pt
- 		case en
+ 		case ro
- 		case es
+ 		case ru
- 		case fi
+ 		case sv
- 		case fr
+ 		case ta
- 		case he
+ 		case th
- 		case hi
+ 		case tl
- 		case hr
+ 		case tr
- 		case hu
+ 		case uk
- 		case id
+ 		case zh
- 		case it
+ 		case unknown = "_unknown"
- 		case ja
+ 		public init(from decoder: Decoder) throws
- 		case ko
+ 	public enum Mode : String, Sendable, Codable, CaseIterable
- 		case ms
+ 		case autoOn = "auto-on"
- 		case nl
+ 		case available
- 		case no
+ 		case disabled
- 		case pl
+ 		case unknown = "_unknown"
- 		case pt
+ 		public init(from decoder: Decoder) throws
- 		case ro
+ 	public var closedCaptionMode: ClosedCaptionMode
- 		case ru
+ 	public var language: Language
- 		case sv
+ 	public var mode: Mode
- 		case ta
+ 	public init(closedCaptionMode: ClosedCaptionMode, language: Language, mode: Mode)
- 		case th
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 		case tl
+ 		case closedCaptionMode = "closed_caption_mode"
- 		case tr
+ 		case language
- 		case uk
+ 		case mode
- 		case zh
+ 	public static func == (lhs: TranscriptionSettings, rhs: TranscriptionSettings) -> Bool
- 		case unknown = "_unknown"
+ 	public func hash(into hasher: inout Hasher)
- 		public init(from decoder: Decoder) throws
+ 
- 	public enum Mode : String, Sendable, Codable, CaseIterable
+ public final class TranscriptionSettingsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case autoOn = "auto-on"
+ 	public enum ClosedCaptionMode : String, Sendable, Codable, CaseIterable
- 		case available
+ 		case autoOn = "auto-on"
- 		case disabled
+ 		case available
- 		case unknown = "_unknown"
+ 		case disabled
- 		public init(from decoder: Decoder) throws
+ 		case unknown = "_unknown"
- 	public var closedCaptionMode: ClosedCaptionMode
+ 		public init(from decoder: Decoder) throws
- 	public var language: Language
+ 	public enum Language : String, Sendable, Codable, CaseIterable
- 	public var mode: Mode
+ 		case ar
- 	public init(closedCaptionMode: ClosedCaptionMode, language: Language, mode: Mode)
+ 		case auto
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case ca
- 		case closedCaptionMode = "closed_caption_mode"
+ 		case cs
- 		case language
+ 		case da
- 		case mode
+ 		case de
- 	public static func == (lhs: TranscriptionSettings, rhs: TranscriptionSettings) -> Bool
+ 		case el
- 	public func hash(into hasher: inout Hasher)
+ 		case en
- 
+ 		case es
- public final class TranscriptionSettingsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case fi
- 	public enum ClosedCaptionMode : String, Sendable, Codable, CaseIterable
+ 		case fr
- 		case autoOn = "auto-on"
+ 		case he
- 		case available
+ 		case hi
- 		case disabled
+ 		case hr
- 		case unknown = "_unknown"
+ 		case hu
- 		public init(from decoder: Decoder) throws
+ 		case id
- 	public enum Language : String, Sendable, Codable, CaseIterable
+ 		case it
- 		case ar
+ 		case ja
- 		case auto
+ 		case ko
- 		case ca
+ 		case ms
- 		case cs
+ 		case nl
- 		case da
+ 		case no
- 		case de
+ 		case pl
- 		case el
+ 		case pt
- 		case en
+ 		case ro
- 		case es
+ 		case ru
- 		case fi
+ 		case sv
- 		case fr
+ 		case ta
- 		case he
+ 		case th
- 		case hi
+ 		case tl
- 		case hr
+ 		case tr
- 		case hu
+ 		case uk
- 		case id
+ 		case zh
- 		case it
+ 		case unknown = "_unknown"
- 		case ja
+ 		public init(from decoder: Decoder) throws
- 		case ko
+ 	public enum Mode : String, Sendable, Codable, CaseIterable
- 		case ms
+ 		case autoOn = "auto-on"
- 		case nl
+ 		case available
- 		case no
+ 		case disabled
- 		case pl
+ 		case unknown = "_unknown"
- 		case pt
+ 		public init(from decoder: Decoder) throws
- 		case ro
+ 	public var closedCaptionMode: ClosedCaptionMode?
- 		case ru
+ 	public var language: Language?
- 		case sv
+ 	public var mode: Mode
- 		case ta
+ 	public init(closedCaptionMode: ClosedCaptionMode? = nil, language: Language? = nil, mode: Mode)
- 		case th
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 		case tl
+ 		case closedCaptionMode = "closed_caption_mode"
- 		case tr
+ 		case language
- 		case uk
+ 		case mode
- 		case zh
+ 	public static func == (lhs: TranscriptionSettingsRequest, rhs: TranscriptionSettingsRequest) -> Bool
- 		case unknown = "_unknown"
+ 	public func hash(into hasher: inout Hasher)
- 		public init(from decoder: Decoder) throws
+ 
- 	public enum Mode : String, Sendable, Codable, CaseIterable
+ public final class UnblockUserRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case autoOn = "auto-on"
+ 	public var userId: String
- 		case available
+ 	public init(userId: String)
- 		case disabled
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 		case unknown = "_unknown"
+ 		case userId = "user_id"
- 		public init(from decoder: Decoder) throws
+ 	public static func == (lhs: UnblockUserRequest, rhs: UnblockUserRequest) -> Bool
- 	public var closedCaptionMode: ClosedCaptionMode?
+ 	public func hash(into hasher: inout Hasher)
- 	public var language: Language?
+ 
- 	public var mode: Mode
+ public final class UnblockUserResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public init(closedCaptionMode: ClosedCaptionMode? = nil, language: Language? = nil, mode: Mode)
+ 	public var duration: String
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public init(duration: String)
- 		case closedCaptionMode = "closed_caption_mode"
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 		case language
+ 		case duration
- 		case mode
+ 	public static func == (lhs: UnblockUserResponse, rhs: UnblockUserResponse) -> Bool
- 	public static func == (lhs: TranscriptionSettingsRequest, rhs: TranscriptionSettingsRequest) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class UnblockedUserEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- public final class UnblockUserRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var callCid: String
- 	public var userId: String
+ 	public var createdAt: Date
- 	public init(userId: String)
+ 	public var type: String
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var user: UserResponse
- 		case userId = "user_id"
+ 	public init(callCid: String, createdAt: Date, user: UserResponse)
- 	public static func == (lhs: UnblockUserRequest, rhs: UnblockUserRequest) -> Bool
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public func hash(into hasher: inout Hasher)
+ 		case callCid = "call_cid"
- 
+ 		case createdAt = "created_at"
- public final class UnblockUserResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case type
- 	public var duration: String
+ 		case user
- 	public init(duration: String)
+ 	public static func == (lhs: UnblockedUserEvent, rhs: UnblockedUserEvent) -> Bool
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public func hash(into hasher: inout Hasher)
- 		case duration
+ 
- 	public static func == (lhs: UnblockUserResponse, rhs: UnblockUserResponse) -> Bool
+ public final class UnpinRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public func hash(into hasher: inout Hasher)
+ 	public var sessionId: String
- 
+ 	public var userId: String
- public final class UnblockedUserEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public init(sessionId: String, userId: String)
- 	public var callCid: String
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var createdAt: Date
+ 		case sessionId = "session_id"
- 	public var type: String
+ 		case userId = "user_id"
- 	public var user: UserResponse
+ 	public static func == (lhs: UnpinRequest, rhs: UnpinRequest) -> Bool
- 	public init(callCid: String, createdAt: Date, user: UserResponse)
+ 	public func hash(into hasher: inout Hasher)
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 
- 		case callCid = "call_cid"
+ public final class UnpinResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case createdAt = "created_at"
+ 	public var duration: String
- 		case type
+ 	public init(duration: String)
- 		case user
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public static func == (lhs: UnblockedUserEvent, rhs: UnblockedUserEvent) -> Bool
+ 		case duration
- 	public func hash(into hasher: inout Hasher)
+ 	public static func == (lhs: UnpinResponse, rhs: UnpinResponse) -> Bool
- 
+ 	public func hash(into hasher: inout Hasher)
- public final class UnpinRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 
- 	public var sessionId: String
+ public final class UpdateCallMembersRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public var userId: String
+ 	public var removeMembers: [String]?
- 	public init(sessionId: String, userId: String)
+ 	public var updateMembers: [MemberRequest]?
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public init(removeMembers: [String]? = nil, updateMembers: [MemberRequest]? = nil)
- 		case sessionId = "session_id"
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 		case userId = "user_id"
+ 		case removeMembers = "remove_members"
- 	public static func == (lhs: UnpinRequest, rhs: UnpinRequest) -> Bool
+ 		case updateMembers = "update_members"
- 	public func hash(into hasher: inout Hasher)
+ 	public static func == (lhs: UpdateCallMembersRequest, rhs: UpdateCallMembersRequest) -> Bool
- 
+ 	public func hash(into hasher: inout Hasher)
- public final class UnpinResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 
- 	public var duration: String
+ public final class UpdateCallMembersResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public init(duration: String)
+ 	public var duration: String
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var members: [MemberResponse]
- 		case duration
+ 	public init(duration: String, members: [MemberResponse])
- 	public static func == (lhs: UnpinResponse, rhs: UnpinResponse) -> Bool
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public func hash(into hasher: inout Hasher)
+ 		case duration
- 
+ 		case members
- public final class UpdateCallMembersRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public static func == (lhs: UpdateCallMembersResponse, rhs: UpdateCallMembersResponse) -> Bool
- 	public var removeMembers: [String]?
+ 	public func hash(into hasher: inout Hasher)
- 	public var updateMembers: [MemberRequest]?
+ 
- 	public init(removeMembers: [String]? = nil, updateMembers: [MemberRequest]? = nil)
+ public final class UpdateCallRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var custom: [String: RawJSON]?
- 		case removeMembers = "remove_members"
+ 	public var settingsOverride: CallSettingsRequest?
- 		case updateMembers = "update_members"
+ 	public var startsAt: Date?
- 	public static func == (lhs: UpdateCallMembersRequest, rhs: UpdateCallMembersRequest) -> Bool
+ 	public init(custom: [String: RawJSON]? = nil, settingsOverride: CallSettingsRequest? = nil, startsAt: Date? = nil)
- 	public func hash(into hasher: inout Hasher)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 
+ 		case custom
- public final class UpdateCallMembersResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case settingsOverride = "settings_override"
- 	public var duration: String
+ 		case startsAt = "starts_at"
- 	public var members: [MemberResponse]
+ 	public static func == (lhs: UpdateCallRequest, rhs: UpdateCallRequest) -> Bool
- 	public init(duration: String, members: [MemberResponse])
+ 	public func hash(into hasher: inout Hasher)
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 
- 		case duration
+ public final class UpdateCallResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case members
+ 	public var call: CallResponse
- 	public static func == (lhs: UpdateCallMembersResponse, rhs: UpdateCallMembersResponse) -> Bool
+ 	public var duration: String
- 	public func hash(into hasher: inout Hasher)
+ 	public var members: [MemberResponse]
- 
+ 	public var membership: MemberResponse?
- public final class UpdateCallRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var ownCapabilities: [OwnCapability]
- 	public var custom: [String: RawJSON]?
+ 	public init(
- 	public var settingsOverride: CallSettingsRequest?
+         call: CallResponse,
- 	public var startsAt: Date?
+         duration: String,
- 	public init(custom: [String: RawJSON]? = nil, settingsOverride: CallSettingsRequest? = nil, startsAt: Date? = nil)
+         members: [MemberResponse],
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+         membership: MemberResponse? = nil,
- 		case custom
+         ownCapabilities: [OwnCapability]
- 		case settingsOverride = "settings_override"
+     )
- 		case startsAt = "starts_at"
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public static func == (lhs: UpdateCallRequest, rhs: UpdateCallRequest) -> Bool
+ 		case call
- 	public func hash(into hasher: inout Hasher)
+ 		case duration
- 
+ 		case members
- public final class UpdateCallResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case membership
- 	public var call: CallResponse
+ 		case ownCapabilities = "own_capabilities"
- 	public var duration: String
+ 	public static func == (lhs: UpdateCallResponse, rhs: UpdateCallResponse) -> Bool
- 	public var members: [MemberResponse]
+ 	public func hash(into hasher: inout Hasher)
- 	public var membership: MemberResponse?
+ 
- 	public var ownCapabilities: [OwnCapability]
+ public final class UpdateUserPermissionsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public init(
+ 	public var grantPermissions: [String]?
-         call: CallResponse,
+ 	public var revokePermissions: [String]?
-         duration: String,
+ 	public var userId: String
-         members: [MemberResponse],
+ 	public init(grantPermissions: [String]? = nil, revokePermissions: [String]? = nil, userId: String)
-         membership: MemberResponse? = nil,
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
-         ownCapabilities: [OwnCapability]
+ 		case grantPermissions = "grant_permissions"
-     )
+ 		case revokePermissions = "revoke_permissions"
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case userId = "user_id"
- 		case call
+ 	public static func == (lhs: UpdateUserPermissionsRequest, rhs: UpdateUserPermissionsRequest) -> Bool
- 		case duration
+ 	public func hash(into hasher: inout Hasher)
- 		case members
+ 
- 		case membership
+ public final class UpdateUserPermissionsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case ownCapabilities = "own_capabilities"
+ 	public var duration: String
- 	public static func == (lhs: UpdateCallResponse, rhs: UpdateCallResponse) -> Bool
+ 	public init(duration: String)
- 	public func hash(into hasher: inout Hasher)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 
+ 		case duration
- public final class UpdateUserPermissionsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public static func == (lhs: UpdateUserPermissionsResponse, rhs: UpdateUserPermissionsResponse) -> Bool
- 	public var grantPermissions: [String]?
+ 	public func hash(into hasher: inout Hasher)
- 	public var revokePermissions: [String]?
+ 
- 	public var userId: String
+ public final class UpdatedCallPermissionsEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
- 	public init(grantPermissions: [String]? = nil, revokePermissions: [String]? = nil, userId: String)
+ 	public var callCid: String
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var createdAt: Date
- 		case grantPermissions = "grant_permissions"
+ 	public var ownCapabilities: [OwnCapability]
- 		case revokePermissions = "revoke_permissions"
+ 	public var type: String
- 		case userId = "user_id"
+ 	public var user: UserResponse
- 	public static func == (lhs: UpdateUserPermissionsRequest, rhs: UpdateUserPermissionsRequest) -> Bool
+ 	public init(callCid: String, createdAt: Date, ownCapabilities: [OwnCapability], user: UserResponse)
- 	public func hash(into hasher: inout Hasher)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 
+ 		case callCid = "call_cid"
- public final class UpdateUserPermissionsResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case createdAt = "created_at"
- 	public var duration: String
+ 		case ownCapabilities = "own_capabilities"
- 	public init(duration: String)
+ 		case type
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case user
- 		case duration
+ 	public static func == (lhs: UpdatedCallPermissionsEvent, rhs: UpdatedCallPermissionsEvent) -> Bool
- 	public static func == (lhs: UpdateUserPermissionsResponse, rhs: UpdateUserPermissionsResponse) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class UserEventPayload : @unchecked Sendable, Codable, JSONEncodable, Hashable
- public final class UpdatedCallPermissionsEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable, WSCallEvent
+ 	public var blockedUserIds: [String]
- 	public var callCid: String
+ 	public var createdAt: Date
- 	public var createdAt: Date
+ 	public var custom: [String: RawJSON]
- 	public var ownCapabilities: [OwnCapability]
+ 	public var deactivatedAt: Date?
- 	public var type: String
+ 	public var deletedAt: Date?
- 	public var user: UserResponse
+ 	public var id: String
- 	public init(callCid: String, createdAt: Date, ownCapabilities: [OwnCapability], user: UserResponse)
+ 	public var image: String?
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var invisible: Bool?
- 		case callCid = "call_cid"
+ 	public var language: String
- 		case createdAt = "created_at"
+ 	public var lastActive: Date?
- 		case ownCapabilities = "own_capabilities"
+ 	public var name: String?
- 		case type
+ 	public var revokeTokensIssuedBefore: Date?
- 		case user
+ 	public var role: String
- 	public static func == (lhs: UpdatedCallPermissionsEvent, rhs: UpdatedCallPermissionsEvent) -> Bool
+ 	public var teams: [String]
- 	public func hash(into hasher: inout Hasher)
+ 	public var updatedAt: Date
- 
+ 	public init(
- public final class UserEventPayload : @unchecked Sendable, Codable, JSONEncodable, Hashable
+         blockedUserIds: [String],
- 	public var blockedUserIds: [String]
+         createdAt: Date,
- 	public var createdAt: Date
+         custom: [String: RawJSON],
- 	public var custom: [String: RawJSON]
+         deactivatedAt: Date? = nil,
- 	public var deactivatedAt: Date?
+         deletedAt: Date? = nil,
- 	public var deletedAt: Date?
+         id: String,
- 	public var id: String
+         image: String? = nil,
- 	public var image: String?
+         invisible: Bool? = nil,
- 	public var invisible: Bool?
+         language: String,
- 	public var language: String
+         lastActive: Date? = nil,
- 	public var lastActive: Date?
+         name: String? = nil,
- 	public var name: String?
+         revokeTokensIssuedBefore: Date? = nil,
- 	public var revokeTokensIssuedBefore: Date?
+         role: String,
- 	public var role: String
+         teams: [String],
- 	public var teams: [String]
+         updatedAt: Date
- 	public var updatedAt: Date
+     )
- 	public init(
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
-         blockedUserIds: [String],
+ 		case blockedUserIds = "blocked_user_ids"
-         createdAt: Date,
+ 		case createdAt = "created_at"
-         custom: [String: RawJSON],
+ 		case custom
-         deactivatedAt: Date? = nil,
+ 		case deactivatedAt = "deactivated_at"
-         deletedAt: Date? = nil,
+ 		case deletedAt = "deleted_at"
-         id: String,
+ 		case id
-         image: String? = nil,
+ 		case image
-         invisible: Bool? = nil,
+ 		case invisible
-         language: String,
+ 		case language
-         lastActive: Date? = nil,
+ 		case lastActive = "last_active"
-         name: String? = nil,
+ 		case name
-         revokeTokensIssuedBefore: Date? = nil,
+ 		case revokeTokensIssuedBefore = "revoke_tokens_issued_before"
-         role: String,
+ 		case role
-         teams: [String],
+ 		case teams
-         updatedAt: Date
+ 		case updatedAt = "updated_at"
-     )
+ 	public static func == (lhs: UserEventPayload, rhs: UserEventPayload) -> Bool
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public func hash(into hasher: inout Hasher)
- 		case blockedUserIds = "blocked_user_ids"
+ 
- 		case createdAt = "created_at"
+ public final class UserInfoResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case custom
+ 	public var custom: [String: RawJSON]
- 		case deactivatedAt = "deactivated_at"
+ 	public var id: String
- 		case deletedAt = "deleted_at"
+ 	public var image: String
- 		case id
+ 	public var name: String
- 		case image
+ 	public var roles: [String]
- 		case invisible
+ 	public init(custom: [String: RawJSON], id: String, image: String, name: String, roles: [String])
- 		case language
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 		case lastActive = "last_active"
+ 		case custom
- 		case name
+ 		case id
- 		case revokeTokensIssuedBefore = "revoke_tokens_issued_before"
+ 		case image
- 		case role
+ 		case name
- 		case teams
+ 		case roles
- 		case updatedAt = "updated_at"
+ 	public static func == (lhs: UserInfoResponse, rhs: UserInfoResponse) -> Bool
- 	public static func == (lhs: UserEventPayload, rhs: UserEventPayload) -> Bool
+ 	public func hash(into hasher: inout Hasher)
- 	public func hash(into hasher: inout Hasher)
+ 
- 
+ public final class UserRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- public final class UserInfoResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var custom: [String: RawJSON]?
- 	public var custom: [String: RawJSON]
+ 	public var id: String
- 	public var id: String
+ 	public var image: String?
- 	public var image: String
+ 	public var invisible: Bool?
- 	public var name: String
+ 	public var language: String?
- 	public var roles: [String]
+ 	public var name: String?
- 	public init(custom: [String: RawJSON], id: String, image: String, name: String, roles: [String])
+ 	public init(
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+         custom: [String: RawJSON]? = nil,
- 		case custom
+         id: String,
- 		case id
+         image: String? = nil,
- 		case image
+         invisible: Bool? = nil,
- 		case name
+         language: String? = nil,
- 		case roles
+         name: String? = nil
- 	public static func == (lhs: UserInfoResponse, rhs: UserInfoResponse) -> Bool
+     )
- 	public func hash(into hasher: inout Hasher)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 
+ 		case custom
- public final class UserRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		case id
- 	public var custom: [String: RawJSON]?
+ 		case image
- 	public var id: String
+ 		case invisible
- 	public var image: String?
+ 		case language
- 	public var invisible: Bool?
+ 		case name
- 	public var language: String?
+ 	public static func == (lhs: UserRequest, rhs: UserRequest) -> Bool
- 	public var name: String?
+ 	public func hash(into hasher: inout Hasher)
- 	public init(
+ 
-         custom: [String: RawJSON]? = nil,
+ public final class UserResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
-         id: String,
+ 	public var blockedUserIds: [String]
-         image: String? = nil,
+ 	public var createdAt: Date
-         invisible: Bool? = nil,
+ 	public var custom: [String: RawJSON]
-         language: String? = nil,
+ 	public var deactivatedAt: Date?
-         name: String? = nil
+ 	public var deletedAt: Date?
-     )
+ 	public var id: String
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var image: String?
- 		case custom
+ 	public var language: String
- 		case id
+ 	public var lastActive: Date?
- 		case image
+ 	public var name: String?
- 		case invisible
+ 	public var revokeTokensIssuedBefore: Date?
- 		case language
+ 	public var role: String
- 		case name
+ 	public var teams: [String]
- 	public static func == (lhs: UserRequest, rhs: UserRequest) -> Bool
+ 	public var updatedAt: Date
- 	public func hash(into hasher: inout Hasher)
+ 	public init(
- 
+         blockedUserIds: [String],
- public final class UserResponse : @unchecked Sendable, Codable, JSONEncodable, Hashable
+         createdAt: Date,
- 	public var blockedUserIds: [String]
+         custom: [String: RawJSON],
- 	public var createdAt: Date
+         deactivatedAt: Date? = nil,
- 	public var custom: [String: RawJSON]
+         deletedAt: Date? = nil,
- 	public var deactivatedAt: Date?
+         id: String,
- 	public var deletedAt: Date?
+         image: String? = nil,
- 	public var id: String
+         language: String,
- 	public var image: String?
+         lastActive: Date? = nil,
- 	public var language: String
+         name: String? = nil,
- 	public var lastActive: Date?
+         revokeTokensIssuedBefore: Date? = nil,
- 	public var name: String?
+         role: String,
- 	public var revokeTokensIssuedBefore: Date?
+         teams: [String],
- 	public var role: String
+         updatedAt: Date
- 	public var teams: [String]
+     )
- 	public var updatedAt: Date
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public init(
+ 		case blockedUserIds = "blocked_user_ids"
-         blockedUserIds: [String],
+ 		case createdAt = "created_at"
-         createdAt: Date,
+ 		case custom
-         custom: [String: RawJSON],
+ 		case deactivatedAt = "deactivated_at"
-         deactivatedAt: Date? = nil,
+ 		case deletedAt = "deleted_at"
-         deletedAt: Date? = nil,
+ 		case id
-         id: String,
+ 		case image
-         image: String? = nil,
+ 		case language
-         language: String,
+ 		case lastActive = "last_active"
-         lastActive: Date? = nil,
+ 		case name
-         name: String? = nil,
+ 		case revokeTokensIssuedBefore = "revoke_tokens_issued_before"
-         revokeTokensIssuedBefore: Date? = nil,
+ 		case role
-         role: String,
+ 		case teams
-         teams: [String],
+ 		case updatedAt = "updated_at"
-         updatedAt: Date
+ 	public static func == (lhs: UserResponse, rhs: UserResponse) -> Bool
-     )
+ 	public func hash(into hasher: inout Hasher)
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 
- 		case blockedUserIds = "blocked_user_ids"
+ public final class UserSessionStats : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case createdAt = "created_at"
+ 	public var averageConnectionTime: Float?
- 		case custom
+ 	public var browser: String?
- 		case deactivatedAt = "deactivated_at"
+ 	public var browserVersion: String?
- 		case deletedAt = "deleted_at"
+ 	public var currentIp: String?
- 		case id
+ 	public var currentSfu: String?
- 		case image
+ 	public var deviceModel: String?
- 		case language
+ 	public var deviceVersion: String?
- 		case lastActive = "last_active"
+ 	public var distanceToSfuKilometers: Float?
- 		case name
+ 	public var freezeDurationSeconds: Int
- 		case revokeTokensIssuedBefore = "revoke_tokens_issued_before"
+ 	public var geolocation: GeolocationResult?
- 		case role
+ 	public var group: String
- 		case teams
+ 	public var jitter: Stats?
- 		case updatedAt = "updated_at"
+ 	public var latency: Stats?
- 	public static func == (lhs: UserResponse, rhs: UserResponse) -> Bool
+ 	public var maxFirPerSecond: Float?
- 	public func hash(into hasher: inout Hasher)
+ 	public var maxFreezeFraction: Float
- 
+ 	public var maxFreezesDurationSeconds: Int
- public final class UserSessionStats : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var maxFreezesPerSecond: Float?
- 	public var averageConnectionTime: Float?
+ 	public var maxNackPerSecond: Float?
- 	public var browser: String?
+ 	public var maxPliPerSecond: Float?
- 	public var browserVersion: String?
+ 	public var maxPublishingVideoQuality: VideoQuality?
- 	public var currentIp: String?
+ 	public var maxReceivingVideoQuality: VideoQuality?
- 	public var currentSfu: String?
+ 	public var minEventTs: Int
- 	public var deviceModel: String?
+ 	public var os: String?
- 	public var deviceVersion: String?
+ 	public var osVersion: String?
- 	public var distanceToSfuKilometers: Float?
+ 	public var packetLossFraction: Float
- 	public var freezeDurationSeconds: Int
+ 	public var pubSubHints: MediaPubSubHint?
- 	public var geolocation: GeolocationResult?
+ 	public var publishedTracks: [PublishedTrackInfo]?
- 	public var group: String
+ 	public var publisherJitter: Stats?
- 	public var jitter: Stats?
+ 	public var publisherLatency: Stats?
- 	public var latency: Stats?
+ 	public var publisherNoiseCancellationSeconds: Float?
- 	public var maxFirPerSecond: Float?
+ 	public var publisherPacketLossFraction: Float
- 	public var maxFreezeFraction: Float
+ 	public var publisherQualityLimitationFraction: Float?
- 	public var maxFreezesDurationSeconds: Int
+ 	public var publisherVideoQualityLimitationDurationSeconds: [String: Float]?
- 	public var maxFreezesPerSecond: Float?
+ 	public var publishingAudioCodec: String?
- 	public var maxNackPerSecond: Float?
+ 	public var publishingDurationSeconds: Int
- 	public var maxPliPerSecond: Float?
+ 	public var publishingVideoCodec: String?
- 	public var maxPublishingVideoQuality: VideoQuality?
+ 	public var qualityScore: Float
- 	public var maxReceivingVideoQuality: VideoQuality?
+ 	public var receivingAudioCodec: String?
- 	public var minEventTs: Int
+ 	public var receivingDurationSeconds: Int
- 	public var os: String?
+ 	public var receivingVideoCodec: String?
- 	public var osVersion: String?
+ 	public var sdk: String?
- 	public var packetLossFraction: Float
+ 	public var sdkVersion: String?
- 	public var pubSubHints: MediaPubSubHint?
+ 	public var sessionId: String
- 	public var publishedTracks: [PublishedTrackInfo]?
+ 	public var subscriberJitter: Stats?
- 	public var publisherJitter: Stats?
+ 	public var subscriberLatency: Stats?
- 	public var publisherLatency: Stats?
+ 	public var subscriberVideoQualityThrottledDurationSeconds: Float?
- 	public var publisherNoiseCancellationSeconds: Float?
+ 	public var subsessions: [Subsession]?
- 	public var publisherPacketLossFraction: Float
+ 	public var timeline: CallTimeline?
- 	public var publisherQualityLimitationFraction: Float?
+ 	public var totalPixelsIn: Int
- 	public var publisherVideoQualityLimitationDurationSeconds: [String: Float]?
+ 	public var totalPixelsOut: Int
- 	public var publishingAudioCodec: String?
+ 	public var truncated: Bool?
- 	public var publishingDurationSeconds: Int
+ 	public var webrtcVersion: String?
- 	public var publishingVideoCodec: String?
+ 	public init(
- 	public var qualityScore: Float
+         averageConnectionTime: Float? = nil,
- 	public var receivingAudioCodec: String?
+         browser: String? = nil,
- 	public var receivingDurationSeconds: Int
+         browserVersion: String? = nil,
- 	public var receivingVideoCodec: String?
+         currentIp: String? = nil,
- 	public var sdk: String?
+         currentSfu: String? = nil,
- 	public var sdkVersion: String?
+         deviceModel: String? = nil,
- 	public var sessionId: String
+         deviceVersion: String? = nil,
- 	public var subscriberJitter: Stats?
+         distanceToSfuKilometers: Float? = nil,
- 	public var subscriberLatency: Stats?
+         freezeDurationSeconds: Int,
- 	public var subscriberVideoQualityThrottledDurationSeconds: Float?
+         geolocation: GeolocationResult? = nil,
- 	public var subsessions: [Subsession]?
+         group: String,
- 	public var timeline: CallTimeline?
+         jitter: Stats? = nil,
- 	public var totalPixelsIn: Int
+         latency: Stats? = nil,
- 	public var totalPixelsOut: Int
+         maxFirPerSecond: Float? = nil,
- 	public var truncated: Bool?
+         maxFreezeFraction: Float,
- 	public var webrtcVersion: String?
+         maxFreezesDurationSeconds: Int,
- 	public init(
+         maxFreezesPerSecond: Float? = nil,
-         averageConnectionTime: Float? = nil,
+         maxNackPerSecond: Float? = nil,
-         browser: String? = nil,
+         maxPliPerSecond: Float? = nil,
-         browserVersion: String? = nil,
+         maxPublishingVideoQuality: VideoQuality? = nil,
-         currentIp: String? = nil,
+         maxReceivingVideoQuality: VideoQuality? = nil,
-         currentSfu: String? = nil,
+         minEventTs: Int,
-         deviceModel: String? = nil,
+         os: String? = nil,
-         deviceVersion: String? = nil,
+         osVersion: String? = nil,
-         distanceToSfuKilometers: Float? = nil,
+         packetLossFraction: Float,
-         freezeDurationSeconds: Int,
+         pubSubHints: MediaPubSubHint? = nil,
-         geolocation: GeolocationResult? = nil,
+         publishedTracks: [PublishedTrackInfo]? = nil,
-         group: String,
+         publisherJitter: Stats? = nil,
-         jitter: Stats? = nil,
+         publisherLatency: Stats? = nil,
-         latency: Stats? = nil,
+         publisherNoiseCancellationSeconds: Float? = nil,
-         maxFirPerSecond: Float? = nil,
+         publisherPacketLossFraction: Float,
-         maxFreezeFraction: Float,
+         publisherQualityLimitationFraction: Float? = nil,
-         maxFreezesDurationSeconds: Int,
+         publisherVideoQualityLimitationDurationSeconds: [String: Float]? = nil,
-         maxFreezesPerSecond: Float? = nil,
+         publishingAudioCodec: String? = nil,
-         maxNackPerSecond: Float? = nil,
+         publishingDurationSeconds: Int,
-         maxPliPerSecond: Float? = nil,
+         publishingVideoCodec: String? = nil,
-         maxPublishingVideoQuality: VideoQuality? = nil,
+         qualityScore: Float,
-         maxReceivingVideoQuality: VideoQuality? = nil,
+         receivingAudioCodec: String? = nil,
-         minEventTs: Int,
+         receivingDurationSeconds: Int,
-         os: String? = nil,
+         receivingVideoCodec: String? = nil,
-         osVersion: String? = nil,
+         sdk: String? = nil,
-         packetLossFraction: Float,
+         sdkVersion: String? = nil,
-         pubSubHints: MediaPubSubHint? = nil,
+         sessionId: String,
-         publishedTracks: [PublishedTrackInfo]? = nil,
+         subscriberJitter: Stats? = nil,
-         publisherJitter: Stats? = nil,
+         subscriberLatency: Stats? = nil,
-         publisherLatency: Stats? = nil,
+         subscriberVideoQualityThrottledDurationSeconds: Float? = nil,
-         publisherNoiseCancellationSeconds: Float? = nil,
+         subsessions: [Subsession]? = nil,
-         publisherPacketLossFraction: Float,
+         timeline: CallTimeline? = nil,
-         publisherQualityLimitationFraction: Float? = nil,
+         totalPixelsIn: Int,
-         publisherVideoQualityLimitationDurationSeconds: [String: Float]? = nil,
+         totalPixelsOut: Int,
-         publishingAudioCodec: String? = nil,
+         truncated: Bool? = nil,
-         publishingDurationSeconds: Int,
+         webrtcVersion: String? = nil
-         publishingVideoCodec: String? = nil,
+     )
-         qualityScore: Float,
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
-         receivingAudioCodec: String? = nil,
+ 		case averageConnectionTime = "average_connection_time"
-         receivingDurationSeconds: Int,
+ 		case browser
-         receivingVideoCodec: String? = nil,
+ 		case browserVersion = "browser_version"
-         sdk: String? = nil,
+ 		case currentIp = "current_ip"
-         sdkVersion: String? = nil,
+ 		case currentSfu = "current_sfu"
-         sessionId: String,
+ 		case deviceModel = "device_model"
-         subscriberJitter: Stats? = nil,
+ 		case deviceVersion = "device_version"
-         subscriberLatency: Stats? = nil,
+ 		case distanceToSfuKilometers = "distance_to_sfu_kilometers"
-         subscriberVideoQualityThrottledDurationSeconds: Float? = nil,
+ 		case freezeDurationSeconds = "freeze_duration_seconds"
-         subsessions: [Subsession]? = nil,
+ 		case geolocation
-         timeline: CallTimeline? = nil,
+ 		case group
-         totalPixelsIn: Int,
+ 		case jitter
-         totalPixelsOut: Int,
+ 		case latency
-         truncated: Bool? = nil,
+ 		case maxFirPerSecond = "max_fir_per_second"
-         webrtcVersion: String? = nil
+ 		case maxFreezeFraction = "max_freeze_fraction"
-     )
+ 		case maxFreezesDurationSeconds = "max_freezes_duration_seconds"
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case maxFreezesPerSecond = "max_freezes_per_second"
- 		case averageConnectionTime = "average_connection_time"
+ 		case maxNackPerSecond = "max_nack_per_second"
- 		case browser
+ 		case maxPliPerSecond = "max_pli_per_second"
- 		case browserVersion = "browser_version"
+ 		case maxPublishingVideoQuality = "max_publishing_video_quality"
- 		case currentIp = "current_ip"
+ 		case maxReceivingVideoQuality = "max_receiving_video_quality"
- 		case currentSfu = "current_sfu"
+ 		case minEventTs = "min_event_ts"
- 		case deviceModel = "device_model"
+ 		case os
- 		case deviceVersion = "device_version"
+ 		case osVersion = "os_version"
- 		case distanceToSfuKilometers = "distance_to_sfu_kilometers"
+ 		case packetLossFraction = "packet_loss_fraction"
- 		case freezeDurationSeconds = "freeze_duration_seconds"
+ 		case pubSubHints = "pub_sub_hints"
- 		case geolocation
+ 		case publishedTracks = "published_tracks"
- 		case group
+ 		case publisherJitter = "publisher_jitter"
- 		case jitter
+ 		case publisherLatency = "publisher_latency"
- 		case latency
+ 		case publisherNoiseCancellationSeconds = "publisher_noise_cancellation_seconds"
- 		case maxFirPerSecond = "max_fir_per_second"
+ 		case publisherPacketLossFraction = "publisher_packet_loss_fraction"
- 		case maxFreezeFraction = "max_freeze_fraction"
+ 		case publisherQualityLimitationFraction = "publisher_quality_limitation_fraction"
- 		case maxFreezesDurationSeconds = "max_freezes_duration_seconds"
+ 		case publisherVideoQualityLimitationDurationSeconds = "publisher_video_quality_limitation_duration_seconds"
- 		case maxFreezesPerSecond = "max_freezes_per_second"
+ 		case publishingAudioCodec = "publishing_audio_codec"
- 		case maxNackPerSecond = "max_nack_per_second"
+ 		case publishingDurationSeconds = "publishing_duration_seconds"
- 		case maxPliPerSecond = "max_pli_per_second"
+ 		case publishingVideoCodec = "publishing_video_codec"
- 		case maxPublishingVideoQuality = "max_publishing_video_quality"
+ 		case qualityScore = "quality_score"
- 		case maxReceivingVideoQuality = "max_receiving_video_quality"
+ 		case receivingAudioCodec = "receiving_audio_codec"
- 		case minEventTs = "min_event_ts"
+ 		case receivingDurationSeconds = "receiving_duration_seconds"
- 		case os
+ 		case receivingVideoCodec = "receiving_video_codec"
- 		case osVersion = "os_version"
+ 		case sdk
- 		case packetLossFraction = "packet_loss_fraction"
+ 		case sdkVersion = "sdk_version"
- 		case pubSubHints = "pub_sub_hints"
+ 		case sessionId = "session_id"
- 		case publishedTracks = "published_tracks"
+ 		case subscriberJitter = "subscriber_jitter"
- 		case publisherJitter = "publisher_jitter"
+ 		case subscriberLatency = "subscriber_latency"
- 		case publisherLatency = "publisher_latency"
+ 		case subscriberVideoQualityThrottledDurationSeconds = "subscriber_video_quality_throttled_duration_seconds"
- 		case publisherNoiseCancellationSeconds = "publisher_noise_cancellation_seconds"
+ 		case subsessions
- 		case publisherPacketLossFraction = "publisher_packet_loss_fraction"
+ 		case timeline
- 		case publisherQualityLimitationFraction = "publisher_quality_limitation_fraction"
+ 		case totalPixelsIn = "total_pixels_in"
- 		case publisherVideoQualityLimitationDurationSeconds = "publisher_video_quality_limitation_duration_seconds"
+ 		case totalPixelsOut = "total_pixels_out"
- 		case publishingAudioCodec = "publishing_audio_codec"
+ 		case truncated
- 		case publishingDurationSeconds = "publishing_duration_seconds"
+ 		case webrtcVersion = "webrtc_version"
- 		case publishingVideoCodec = "publishing_video_codec"
+ 	public static func == (lhs: UserSessionStats, rhs: UserSessionStats) -> Bool
- 		case qualityScore = "quality_score"
+ 	public func hash(into hasher: inout Hasher)
- 		case receivingAudioCodec = "receiving_audio_codec"
+ 
- 		case receivingDurationSeconds = "receiving_duration_seconds"
+ public final class UserStats : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 		case receivingVideoCodec = "receiving_video_codec"
+ 	public var info: UserInfoResponse
- 		case sdk
+ 	public var minEventTs: Int
- 		case sdkVersion = "sdk_version"
+ 	public var rating: Int?
- 		case sessionId = "session_id"
+ 	public var sessionStats: [UserSessionStats]
- 		case subscriberJitter = "subscriber_jitter"
+ 	public init(info: UserInfoResponse, minEventTs: Int, rating: Int? = nil, sessionStats: [UserSessionStats])
- 		case subscriberLatency = "subscriber_latency"
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 		case subscriberVideoQualityThrottledDurationSeconds = "subscriber_video_quality_throttled_duration_seconds"
+ 		case info
- 		case subsessions
+ 		case minEventTs = "min_event_ts"
- 		case timeline
+ 		case rating
- 		case totalPixelsIn = "total_pixels_in"
+ 		case sessionStats = "session_stats"
- 		case totalPixelsOut = "total_pixels_out"
+ 	public static func == (lhs: UserStats, rhs: UserStats) -> Bool
- 		case truncated
+ 	public func hash(into hasher: inout Hasher)
- 		case webrtcVersion = "webrtc_version"
+ 
- 	public static func == (lhs: UserSessionStats, rhs: UserSessionStats) -> Bool
+ public final class UserUpdatedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable
- 	public func hash(into hasher: inout Hasher)
+ 	public var createdAt: Date
- 
+ 	public var receivedAt: Date?
- public final class UserStats : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var type: String
- 	public var info: UserInfoResponse
+ 	public var user: UserEventPayload
- 	public var minEventTs: Int
+ 	public init(createdAt: Date, receivedAt: Date? = nil, user: UserEventPayload)
- 	public var rating: Int?
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public var sessionStats: [UserSessionStats]
+ 		case createdAt = "created_at"
- 	public init(info: UserInfoResponse, minEventTs: Int, rating: Int? = nil, sessionStats: [UserSessionStats])
+ 		case receivedAt = "received_at"
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case type
- 		case info
+ 		case user
- 		case minEventTs = "min_event_ts"
+ 	public static func == (lhs: UserUpdatedEvent, rhs: UserUpdatedEvent) -> Bool
- 		case rating
+ 	public func hash(into hasher: inout Hasher)
- 		case sessionStats = "session_stats"
+ 
- 	public static func == (lhs: UserStats, rhs: UserStats) -> Bool
+ public enum VideoEvent : Codable, Hashable
- 	public func hash(into hasher: inout Hasher)
+ 	case typeCallAcceptedEvent(CallAcceptedEvent)
- 
+ 	case typeBlockedUserEvent(BlockedUserEvent)
- public final class UserUpdatedEvent : @unchecked Sendable, Event, Codable, JSONEncodable, Hashable
+ 	case typeClosedCaptionEvent(ClosedCaptionEvent)
- 	public var createdAt: Date
+ 	case typeCallClosedCaptionsFailedEvent(CallClosedCaptionsFailedEvent)
- 	public var receivedAt: Date?
+ 	case typeCallClosedCaptionsStartedEvent(CallClosedCaptionsStartedEvent)
- 	public var type: String
+ 	case typeCallClosedCaptionsStoppedEvent(CallClosedCaptionsStoppedEvent)
- 	public var user: UserEventPayload
+ 	case typeCallCreatedEvent(CallCreatedEvent)
- 	public init(createdAt: Date, receivedAt: Date? = nil, user: UserEventPayload)
+ 	case typeCallDeletedEvent(CallDeletedEvent)
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	case typeCallEndedEvent(CallEndedEvent)
- 		case createdAt = "created_at"
+ 	case typeCallHLSBroadcastingFailedEvent(CallHLSBroadcastingFailedEvent)
- 		case receivedAt = "received_at"
+ 	case typeCallHLSBroadcastingStartedEvent(CallHLSBroadcastingStartedEvent)
- 		case type
+ 	case typeCallHLSBroadcastingStoppedEvent(CallHLSBroadcastingStoppedEvent)
- 		case user
+ 	case typeCallLiveStartedEvent(CallLiveStartedEvent)
- 	public static func == (lhs: UserUpdatedEvent, rhs: UserUpdatedEvent) -> Bool
+ 	case typeCallMemberAddedEvent(CallMemberAddedEvent)
- 	public func hash(into hasher: inout Hasher)
+ 	case typeCallMemberRemovedEvent(CallMemberRemovedEvent)
- 
+ 	case typeCallMemberUpdatedEvent(CallMemberUpdatedEvent)
- public enum VideoEvent : Codable, Hashable
+ 	case typeCallMemberUpdatedPermissionEvent(CallMemberUpdatedPermissionEvent)
- 	case typeCallAcceptedEvent(CallAcceptedEvent)
+ 	case typeCallMissedEvent(CallMissedEvent)
- 	case typeBlockedUserEvent(BlockedUserEvent)
+ 	case typeCallNotificationEvent(CallNotificationEvent)
- 	case typeClosedCaptionEvent(ClosedCaptionEvent)
+ 	case typePermissionRequestEvent(PermissionRequestEvent)
- 	case typeCallClosedCaptionsFailedEvent(CallClosedCaptionsFailedEvent)
+ 	case typeUpdatedCallPermissionsEvent(UpdatedCallPermissionsEvent)
- 	case typeCallClosedCaptionsStartedEvent(CallClosedCaptionsStartedEvent)
+ 	case typeCallReactionEvent(CallReactionEvent)
- 	case typeCallClosedCaptionsStoppedEvent(CallClosedCaptionsStoppedEvent)
+ 	case typeCallRecordingFailedEvent(CallRecordingFailedEvent)
- 	case typeCallCreatedEvent(CallCreatedEvent)
+ 	case typeCallRecordingReadyEvent(CallRecordingReadyEvent)
- 	case typeCallDeletedEvent(CallDeletedEvent)
+ 	case typeCallRecordingStartedEvent(CallRecordingStartedEvent)
- 	case typeCallEndedEvent(CallEndedEvent)
+ 	case typeCallRecordingStoppedEvent(CallRecordingStoppedEvent)
- 	case typeCallHLSBroadcastingFailedEvent(CallHLSBroadcastingFailedEvent)
+ 	case typeCallRejectedEvent(CallRejectedEvent)
- 	case typeCallHLSBroadcastingStartedEvent(CallHLSBroadcastingStartedEvent)
+ 	case typeCallRingEvent(CallRingEvent)
- 	case typeCallHLSBroadcastingStoppedEvent(CallHLSBroadcastingStoppedEvent)
+ 	case typeCallRtmpBroadcastFailedEvent(CallRtmpBroadcastFailedEvent)
- 	case typeCallLiveStartedEvent(CallLiveStartedEvent)
+ 	case typeCallRtmpBroadcastStartedEvent(CallRtmpBroadcastStartedEvent)
- 	case typeCallMemberAddedEvent(CallMemberAddedEvent)
+ 	case typeCallRtmpBroadcastStoppedEvent(CallRtmpBroadcastStoppedEvent)
- 	case typeCallMemberRemovedEvent(CallMemberRemovedEvent)
+ 	case typeCallSessionEndedEvent(CallSessionEndedEvent)
- 	case typeCallMemberUpdatedEvent(CallMemberUpdatedEvent)
+ 	case typeCallSessionParticipantCountsUpdatedEvent(CallSessionParticipantCountsUpdatedEvent)
- 	case typeCallMemberUpdatedPermissionEvent(CallMemberUpdatedPermissionEvent)
+ 	case typeCallSessionParticipantJoinedEvent(CallSessionParticipantJoinedEvent)
- 	case typeCallMissedEvent(CallMissedEvent)
+ 	case typeCallSessionParticipantLeftEvent(CallSessionParticipantLeftEvent)
- 	case typeCallNotificationEvent(CallNotificationEvent)
+ 	case typeCallSessionStartedEvent(CallSessionStartedEvent)
- 	case typePermissionRequestEvent(PermissionRequestEvent)
+ 	case typeCallTranscriptionFailedEvent(CallTranscriptionFailedEvent)
- 	case typeUpdatedCallPermissionsEvent(UpdatedCallPermissionsEvent)
+ 	case typeCallTranscriptionReadyEvent(CallTranscriptionReadyEvent)
- 	case typeCallReactionEvent(CallReactionEvent)
+ 	case typeCallTranscriptionStartedEvent(CallTranscriptionStartedEvent)
- 	case typeCallRecordingFailedEvent(CallRecordingFailedEvent)
+ 	case typeCallTranscriptionStoppedEvent(CallTranscriptionStoppedEvent)
- 	case typeCallRecordingReadyEvent(CallRecordingReadyEvent)
+ 	case typeUnblockedUserEvent(UnblockedUserEvent)
- 	case typeCallRecordingStartedEvent(CallRecordingStartedEvent)
+ 	case typeCallUpdatedEvent(CallUpdatedEvent)
- 	case typeCallRecordingStoppedEvent(CallRecordingStoppedEvent)
+ 	case typeCallUserMutedEvent(CallUserMutedEvent)
- 	case typeCallRejectedEvent(CallRejectedEvent)
+ 	case typeConnectionErrorEvent(ConnectionErrorEvent)
- 	case typeCallRingEvent(CallRingEvent)
+ 	case typeConnectedEvent(ConnectedEvent)
- 	case typeCallRtmpBroadcastFailedEvent(CallRtmpBroadcastFailedEvent)
+ 	case typeCustomVideoEvent(CustomVideoEvent)
- 	case typeCallRtmpBroadcastStartedEvent(CallRtmpBroadcastStartedEvent)
+ 	case typeHealthCheckEvent(HealthCheckEvent)
- 	case typeCallRtmpBroadcastStoppedEvent(CallRtmpBroadcastStoppedEvent)
+ 	case typeUserUpdatedEvent(UserUpdatedEvent)
- 	case typeCallSessionEndedEvent(CallSessionEndedEvent)
+ 	public var type: String
- 	case typeCallSessionParticipantCountsUpdatedEvent(CallSessionParticipantCountsUpdatedEvent)
+ 	public var rawValue: Event
- 	case typeCallSessionParticipantJoinedEvent(CallSessionParticipantJoinedEvent)
+ 	public func encode(to encoder: Encoder) throws
- 	case typeCallSessionParticipantLeftEvent(CallSessionParticipantLeftEvent)
+ 	public init(from decoder: Decoder) throws
- 	case typeCallSessionStartedEvent(CallSessionStartedEvent)
+ 
- 	case typeCallTranscriptionFailedEvent(CallTranscriptionFailedEvent)
+ public final class VideoQuality : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	case typeCallTranscriptionReadyEvent(CallTranscriptionReadyEvent)
+ 	public var resolution: VideoResolution?
- 	case typeCallTranscriptionStartedEvent(CallTranscriptionStartedEvent)
+ 	public var usageType: String?
- 	case typeCallTranscriptionStoppedEvent(CallTranscriptionStoppedEvent)
+ 	public init(resolution: VideoResolution? = nil, usageType: String? = nil)
- 	case typeUnblockedUserEvent(UnblockedUserEvent)
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	case typeCallUpdatedEvent(CallUpdatedEvent)
+ 		case resolution
- 	case typeCallUserMutedEvent(CallUserMutedEvent)
+ 		case usageType = "usage_type"
- 	case typeConnectionErrorEvent(ConnectionErrorEvent)
+ 	public static func == (lhs: VideoQuality, rhs: VideoQuality) -> Bool
- 	case typeConnectedEvent(ConnectedEvent)
+ 	public func hash(into hasher: inout Hasher)
- 	case typeCustomVideoEvent(CustomVideoEvent)
+ 
- 	case typeHealthCheckEvent(HealthCheckEvent)
+ public final class VideoResolution : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	case typeUserUpdatedEvent(UserUpdatedEvent)
+ 	public var height: Int
- 	public var type: String
+ 	public var width: Int
- 	public var rawValue: Event
+ 	public init(height: Int, width: Int)
- 	public func encode(to encoder: Encoder) throws
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 	public init(from decoder: Decoder) throws
+ 		case height
- 
+ 		case width
- public final class VideoQuality : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public static func == (lhs: VideoResolution, rhs: VideoResolution) -> Bool
- 	public var resolution: VideoResolution?
+ 	public func hash(into hasher: inout Hasher)
- 	public var usageType: String?
+ 
- 	public init(resolution: VideoResolution? = nil, usageType: String? = nil)
+ public final class VideoSettings : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public enum CameraFacing : String, Sendable, Codable, CaseIterable
- 		case resolution
+ 		case back
- 		case usageType = "usage_type"
+ 		case external
- 	public static func == (lhs: VideoQuality, rhs: VideoQuality) -> Bool
+ 		case front
- 	public func hash(into hasher: inout Hasher)
+ 		case unknown = "_unknown"
- 
+ 		public init(from decoder: Decoder) throws
- public final class VideoResolution : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 	public var accessRequestEnabled: Bool
- 	public var height: Int
+ 	public var cameraDefaultOn: Bool
- 	public var width: Int
+ 	public var cameraFacing: CameraFacing
- 	public init(height: Int, width: Int)
+ 	public var enabled: Bool
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var targetResolution: TargetResolution
- 		case height
+ 	public init(
- 		case width
+         accessRequestEnabled: Bool,
- 	public static func == (lhs: VideoResolution, rhs: VideoResolution) -> Bool
+         cameraDefaultOn: Bool,
- 	public func hash(into hasher: inout Hasher)
+         cameraFacing: CameraFacing,
- 
+         enabled: Bool,
- public final class VideoSettings : @unchecked Sendable, Codable, JSONEncodable, Hashable
+         targetResolution: TargetResolution
- 	public enum CameraFacing : String, Sendable, Codable, CaseIterable
+     )
- 		case back
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 		case external
+ 		case accessRequestEnabled = "access_request_enabled"
- 		case front
+ 		case cameraDefaultOn = "camera_default_on"
- 		case unknown = "_unknown"
+ 		case cameraFacing = "camera_facing"
- 		public init(from decoder: Decoder) throws
+ 		case enabled
- 	public var accessRequestEnabled: Bool
+ 		case targetResolution = "target_resolution"
- 	public var cameraDefaultOn: Bool
+ 	public static func == (lhs: VideoSettings, rhs: VideoSettings) -> Bool
- 	public var cameraFacing: CameraFacing
+ 	public func hash(into hasher: inout Hasher)
- 	public var enabled: Bool
+ 
- 	public var targetResolution: TargetResolution
+ public final class VideoSettingsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public init(
+ 	public enum CameraFacing : String, Sendable, Codable, CaseIterable
-         accessRequestEnabled: Bool,
+ 		case back
-         cameraDefaultOn: Bool,
+ 		case external
-         cameraFacing: CameraFacing,
+ 		case front
-         enabled: Bool,
+ 		case unknown = "_unknown"
-         targetResolution: TargetResolution
+ 		public init(from decoder: Decoder) throws
-     )
+ 	public var accessRequestEnabled: Bool?
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public var cameraDefaultOn: Bool?
- 		case accessRequestEnabled = "access_request_enabled"
+ 	public var cameraFacing: CameraFacing?
- 		case cameraDefaultOn = "camera_default_on"
+ 	public var enabled: Bool?
- 		case cameraFacing = "camera_facing"
+ 	public var targetResolution: TargetResolution?
- 		case enabled
+ 	public init(
- 		case targetResolution = "target_resolution"
+         accessRequestEnabled: Bool? = nil,
- 	public static func == (lhs: VideoSettings, rhs: VideoSettings) -> Bool
+         cameraDefaultOn: Bool? = nil,
- 	public func hash(into hasher: inout Hasher)
+         cameraFacing: CameraFacing? = nil,
- 
+         enabled: Bool? = nil,
- public final class VideoSettingsRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+         targetResolution: TargetResolution? = nil
- 	public enum CameraFacing : String, Sendable, Codable, CaseIterable
+     )
- 		case back
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
- 		case external
+ 		case accessRequestEnabled = "access_request_enabled"
- 		case front
+ 		case cameraDefaultOn = "camera_default_on"
- 		case unknown = "_unknown"
+ 		case cameraFacing = "camera_facing"
- 		public init(from decoder: Decoder) throws
+ 		case enabled
- 	public var accessRequestEnabled: Bool?
+ 		case targetResolution = "target_resolution"
- 	public var cameraDefaultOn: Bool?
+ 	public static func == (lhs: VideoSettingsRequest, rhs: VideoSettingsRequest) -> Bool
- 	public var cameraFacing: CameraFacing?
+ 	public func hash(into hasher: inout Hasher)
- 	public var enabled: Bool?
+ 
- 	public var targetResolution: TargetResolution?
+ public final class WSAuthMessageRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
- 	public init(
+ 	public var products: [String]?
-         accessRequestEnabled: Bool? = nil,
+ 	public var token: String
-         cameraDefaultOn: Bool? = nil,
+ 	public var userDetails: ConnectUserDetailsRequest
-         cameraFacing: CameraFacing? = nil,
+ 	public init(products: [String]? = nil, token: String, userDetails: ConnectUserDetailsRequest)
-         enabled: Bool? = nil,
+ 	public enum CodingKeys : String, CodingKey, CaseIterable
-         targetResolution: TargetResolution? = nil
+ 		case products
-     )
+ 		case token
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 		case userDetails = "user_details"
- 		case accessRequestEnabled = "access_request_enabled"
+ 	public static func == (lhs: WSAuthMessageRequest, rhs: WSAuthMessageRequest) -> Bool
- 		case cameraDefaultOn = "camera_default_on"
+ 	public func hash(into hasher: inout Hasher)
- 		case cameraFacing = "camera_facing"
+ 
- 		case enabled
+ public class OpenISO8601DateFormatter : DateFormatter
- 		case targetResolution = "target_resolution"
+ 	override public func date(from string: String) -> Date?
- 	public static func == (lhs: VideoSettingsRequest, rhs: VideoSettingsRequest) -> Bool
+ 
- 	public func hash(into hasher: inout Hasher)
+ public class StreamVideo : ObservableObject, @unchecked Sendable
- 
+ 	public class State : ObservableObject
- public final class WSAuthMessageRequest : @unchecked Sendable, Codable, JSONEncodable, Hashable
+ 		@Published public internal(set) var connection: ConnectionStatus
- 	public var products: [String]?
+ 		@Published public internal(set) var user: User
- 	public var token: String
+ 		@Published public internal(set) var activeCall: Call?
- 	public var userDetails: ConnectUserDetailsRequest
+ 		@Published public internal(set) var ringingCall: Call?
- 	public init(products: [String]? = nil, token: String, userDetails: ConnectUserDetailsRequest)
+ 	public var state: State
- 	public enum CodingKeys : String, CodingKey, CaseIterable
+ 	public let videoConfig: VideoConfig
- 		case products
+ 	public var user: User
- 		case token
+ 	public var isHardwareAccelerationAvailable: Bool
- 		case userDetails = "user_details"
+ 	public lazy var rejectionReasonProvider: RejectionReasonProviding
- 	public static func == (lhs: WSAuthMessageRequest, rhs: WSAuthMessageRequest) -> Bool
+ 	public convenience init(
- 	public func hash(into hasher: inout Hasher)
+         apiKey: String,
- 
+         user: User,
- public class OpenISO8601DateFormatter : DateFormatter
+         token: UserToken,
- 	override public func date(from string: String) -> Date?
+         videoConfig: VideoConfig = VideoConfig(),
- 
+         pushNotificationsConfig: PushNotificationsConfig = .default,
- public class StreamVideo : ObservableObject, @unchecked Sendable
+         tokenProvider: UserTokenProvider? = nil
- 	public class State : ObservableObject
+     )
- 		@Published public internal(set) var connection: ConnectionStatus
+ 	public func connect() async throws
- 		@Published public internal(set) var user: User
+ 	public func call(
- 		@Published public internal(set) var activeCall: Call?
+         callType: String,
- 		@Published public internal(set) var ringingCall: Call?
+         callId: String,
- 	public var state: State
+         callSettings: CallSettings? = nil
- 	public let videoConfig: VideoConfig
+     ) -> Call
- 	public var user: User
+ 	public func makeCallsController(callsQuery: CallsQuery) -> CallsController
- 	public var isHardwareAccelerationAvailable: Bool
+ 	@discardableResult
- 	public lazy var rejectionReasonProvider: RejectionReasonProviding
+     public func setDevice(id: String) async throws -> ModelResponse
- 	public convenience init(
+ 	@discardableResult
-         apiKey: String,
+     public func setVoipDevice(id: String) async throws -> ModelResponse
-         user: User,
+ 	@discardableResult
-         token: UserToken,
+     public func deleteDevice(id: String) async throws -> ModelResponse
-         videoConfig: VideoConfig = VideoConfig(),
+ 	public func listDevices() async throws -> [Device]
-         pushNotificationsConfig: PushNotificationsConfig = .default,
+ 	public func disconnect() async
-         tokenProvider: UserTokenProvider? = nil
+ 	public func subscribe() -> AsyncStream<VideoEvent>
-     )
+ 	public func subscribe<WSEvent: Event>(for event: WSEvent.Type) -> AsyncStream<WSEvent>
- 	public func connect() async throws
+ 	public func queryCalls(
- 	public func call(
+         next: String? = nil,
-         callType: String,
+         watch: Bool = false
-         callId: String,
+     ) async throws -> (calls: [Call], next: String?)
-         callSettings: CallSettings? = nil
+ 	public func queryCalls(
-     ) -> Call
+         filters: [String: RawJSON]?,
- 	public func makeCallsController(callsQuery: CallsQuery) -> CallsController
+         sort: [SortParamRequest] = [SortParamRequest.descending("created_at")],
- 	@discardableResult
+         limit: Int? = 25,
-     public func setDevice(id: String) async throws -> ModelResponse
+         watch: Bool = false
- 	@discardableResult
+     ) async throws -> (calls: [Call], next: String?)
-     public func setVoipDevice(id: String) async throws -> ModelResponse
+ 
- 	@discardableResult
+ open class StreamCallAudioRecorder : @unchecked Sendable
-     public func deleteDevice(id: String) async throws -> ModelResponse
+ 	open private(set) lazy var metersPublisher: AnyPublisher<Float, Never>
- 	public func listDevices() async throws -> [Device]
+ 	public init(filename: String)
- 	public func disconnect() async
+ 	open func startRecording(ignoreActiveCall: Bool = false) async
- 	public func subscribe() -> AsyncStream<VideoEvent>
+ 	open func stopRecording() async
- 	public func subscribe<WSEvent: Event>(for event: WSEvent.Type) -> AsyncStream<WSEvent>
+ 
- 	public func queryCalls(
+ extension InjectedValues
-         next: String? = nil,
+ 	public var callAudioRecorder: StreamCallAudioRecorder
-         watch: Bool = false
+ 
-     ) async throws -> (calls: [Call], next: String?)
+ public struct AudioSessionConfiguration : ReflectiveStringConvertible, Equatable
- 	public func queryCalls(
+ 	public static func == (lhs: Self, rhs: Self) -> Bool
-         filters: [String: RawJSON]?,
+ 
-         sort: [SortParamRequest] = [SortParamRequest.descending("created_at")],
+ extension AVAudioSession.Category : CustomStringConvertible
-         limit: Int? = 25,
+ 	public var description: String
-         watch: Bool = false
+ 
-     ) async throws -> (calls: [Call], next: String?)
+ extension AVAudioSession.CategoryOptions : CustomStringConvertible
- 
+ 	public var description: String
- open class StreamCallAudioRecorder : @unchecked Sendable
+ 
- 	open private(set) lazy var metersPublisher: AnyPublisher<Float, Never>
+ extension AVAudioSession.Mode : CustomStringConvertible
- 	public init(filename: String)
+ 	public var description: String
- 	open func startRecording(ignoreActiveCall: Bool = false) async
+ 
- 	open func stopRecording() async
+ extension AVAudioSession.PortOverride : CustomStringConvertible
- 
+ 	public var description: String
- extension InjectedValues
+ 
- 	public var callAudioRecorder: StreamCallAudioRecorder
+ extension AVAudioSession.RouteChangeReason : CustomStringConvertible
- 
+ 	public var description: String
- public struct AudioSessionConfiguration : ReflectiveStringConvertible, Equatable
+ 
- 	public static func == (lhs: Self, rhs: Self) -> Bool
+ extension AVAudioSessionRouteDescription
- 
+ 	override open var description: String
- extension AVAudioSession.Category : CustomStringConvertible
+ 	private static let externalPorts: Set<AVAudioSession.Port>
- 	public var description: String
+ 	var isExternal: Bool
- 
+ 	var isSpeaker: Bool
- extension AVAudioSession.CategoryOptions : CustomStringConvertible
+ 	var isReceiver: Bool
- 	public var description: String
+ 	var outputTypes: String
- extension AVAudioSession.Mode : CustomStringConvertible
+ public protocol AudioSessionPolicy : Sendable
- 	public var description: String
+ 	func configuration(
- 
+         for callSettings: CallSettings,
- extension AVAudioSession.PortOverride : CustomStringConvertible
+         ownCapabilities: Set<OwnCapability>
- 	public var description: String
+     ) -> AudioSessionConfiguration
- extension AVAudioSession.RouteChangeReason : CustomStringConvertible
+ public struct DefaultAudioSessionPolicy : AudioSessionPolicy
- 	public var description: String
+ 	public init()
- 
+ 	public func configuration(
- extension AVAudioSessionRouteDescription
+         for callSettings: CallSettings,
- 	override open var description: String
+         ownCapabilities: Set<OwnCapability>
- 	private static let externalPorts: Set<AVAudioSession.Port>
+     ) -> AudioSessionConfiguration
- 	var isExternal: Bool
+ 
- 	var isSpeaker: Bool
+ public struct OwnCapabilitiesAudioSessionPolicy : AudioSessionPolicy
- 	var isReceiver: Bool
+ 	public init()
- 	var outputTypes: String
+ 	public func configuration(
- 
+         for callSettings: CallSettings,
- public protocol AudioSessionPolicy : Sendable
+         ownCapabilities: Set<OwnCapability>
- 	func configuration(
+     ) -> AudioSessionConfiguration
-         for callSettings: CallSettings,
+ 
-         ownCapabilities: Set<OwnCapability>
+ public enum StreamDeviceOrientation : Equatable
-     ) -> AudioSessionConfiguration
+ 	case portrait(isUpsideDown: Bool)
- 
+ 	case landscape(isLeft: Bool)
- public struct DefaultAudioSessionPolicy : AudioSessionPolicy
+ 	public var isPortrait: Bool
- 	public init()
+ 	public var isLandscape: Bool
- 	public func configuration(
+ 	public var cgOrientation: CGImagePropertyOrientation
-         for callSettings: CallSettings,
+ 
-         ownCapabilities: Set<OwnCapability>
+ open class StreamDeviceOrientationAdapter : ObservableObject
-     ) -> AudioSessionConfiguration
+ 	@MainActor
- 
+     public static let defaultProvider: Provider
- public struct OwnCapabilitiesAudioSessionPolicy : AudioSessionPolicy
+ 	@Published public private(set) var orientation: StreamDeviceOrientation
- 	public init()
+ 	@MainActor
- 	public func configuration(
+     public init(
-         for callSettings: CallSettings,
+         notificationCenter: NotificationCenter = .default,
-         ownCapabilities: Set<OwnCapability>
+         _ provider: @escaping Provider = StreamDeviceOrientationAdapter.defaultProvider
-     ) -> AudioSessionConfiguration
+     )
- public enum StreamDeviceOrientation : Equatable
+ extension InjectedValues
- 	case portrait(isUpsideDown: Bool)
+ 	@MainActor
- 	case landscape(isLeft: Bool)
+     public var orientationAdapter: StreamDeviceOrientationAdapter
- 	public var isPortrait: Bool
+ 
- 	public var isLandscape: Bool
+ public final class DisposableBag : @unchecked Sendable
- 	public var cgOrientation: CGImagePropertyOrientation
+ 	public init()
- 
+ 	public func insert(
- open class StreamDeviceOrientationAdapter : ObservableObject
+         _ cancellable: AnyCancellable,
- 	@MainActor
+         with key: String = UUID().uuidString
-     public static let defaultProvider: Provider
+     )
- 	@Published public private(set) var orientation: StreamDeviceOrientation
+ 	public func remove(_ key: String)
- 	@MainActor
+ 	public func removeAll()
-     public init(
+ 	public var isEmpty: Bool
-         notificationCenter: NotificationCenter = .default,
+ 
-         _ provider: @escaping Provider = StreamDeviceOrientationAdapter.defaultProvider
+ extension AnyCancellable
-     )
+ 	public func store(
- 
+         in disposableBag: DisposableBag?,
- extension InjectedValues
+         key: String = UUID().uuidString
- 	@MainActor
+     )
-     public var orientationAdapter: StreamDeviceOrientationAdapter
+ 
- 
+ extension Task
- public final class DisposableBag : @unchecked Sendable
+ 	func eraseToAnyCancellable() -> AnyCancellable
- 	public init()
+ 	public func store(
- 	public func insert(
+         in disposableBag: DisposableBag,
-         _ cancellable: AnyCancellable,
+         key: String = UUID().uuidString
-         with key: String = UUID().uuidString
+     )
-     )
+ 
- 	public func remove(_ key: String)
+ extension Array
- 	public func removeAll()
+ 	public func log(
- 	public var isEmpty: Bool
+         _ level: LogLevel,
- 
+         subsystems: LogSubsystem = .other,
- extension AnyCancellable
+         functionName: StaticString = #function,
- 	public func store(
+         fileName: StaticString = #fileID,
-         in disposableBag: DisposableBag?,
+         lineNumber: UInt = #line,
-         key: String = UUID().uuidString
+         messageBuilder: ((Self) -> String)? = nil
-     )
+     ) -> Self
- extension Task
+ open class BaseLogDestination : LogDestination
- 	func eraseToAnyCancellable() -> AnyCancellable
+ 	open var identifier: String
- 	public func store(
+ 	open var level: LogLevel
-         in disposableBag: DisposableBag,
+ 	open var subsystems: LogSubsystem
-         key: String = UUID().uuidString
+ 	open var dateFormatter: DateFormatter
-     )
+ 	open var formatters: [LogFormatter]
- 
+ 	open var showDate: Bool
- extension Array
+ 	open var showLevel: Bool
- 	public func log(
+ 	open var showIdentifier: Bool
-         _ level: LogLevel,
+ 	open var showThreadName: Bool
-         subsystems: LogSubsystem = .other,
+ 	open var showFileName: Bool
-         functionName: StaticString = #function,
+ 	open var showLineNumber: Bool
-         fileName: StaticString = #fileID,
+ 	open var showFunctionName: Bool
-         lineNumber: UInt = #line,
+ 	public required init(
-         messageBuilder: ((Self) -> String)? = nil
+         identifier: String,
-     ) -> Self
+         level: LogLevel,
- 
+         subsystems: LogSubsystem,
- open class BaseLogDestination : LogDestination
+         showDate: Bool,
- 	open var identifier: String
+         dateFormatter: DateFormatter,
- 	open var level: LogLevel
+         formatters: [LogFormatter],
- 	open var subsystems: LogSubsystem
+         showLevel: Bool,
- 	open var dateFormatter: DateFormatter
+         showIdentifier: Bool,
- 	open var formatters: [LogFormatter]
+         showThreadName: Bool,
- 	open var showDate: Bool
+         showFileName: Bool,
- 	open var showLevel: Bool
+         showLineNumber: Bool,
- 	open var showIdentifier: Bool
+         showFunctionName: Bool
- 	open var showThreadName: Bool
+     )
- 	open var showFileName: Bool
+ 	open func isEnabled(level: LogLevel) -> Bool
- 	open var showLineNumber: Bool
+ 	open func isEnabled(level: LogLevel, subsystems: LogSubsystem) -> Bool
- 	open var showFunctionName: Bool
+ 	open func process(logDetails: LogDetails)
- 	public required init(
+ 	open func applyFormatters(logDetails: LogDetails, message: String) -> String
-         identifier: String,
+ 	open func write(message: String)
-         level: LogLevel,
+ 
-         subsystems: LogSubsystem,
+ public class ConsoleLogDestination : BaseLogDestination
-         showDate: Bool,
+ 	override open func write(message: String)
-         dateFormatter: DateFormatter,
+ 
-         formatters: [LogFormatter],
+ public enum LogLevel : Int
-         showLevel: Bool,
+ 	case debug = 0
-         showIdentifier: Bool,
+ 	case info
-         showThreadName: Bool,
+ 	case warning
-         showFileName: Bool,
+ 	case error
-         showLineNumber: Bool,
+ 
-         showFunctionName: Bool
+ public struct LogDetails
-     )
+ 	public let loggerIdentifier: String
- 	open func isEnabled(level: LogLevel) -> Bool
+ 	public let subsystem: LogSubsystem
- 	open func isEnabled(level: LogLevel, subsystems: LogSubsystem) -> Bool
+ 	public let level: LogLevel
- 	open func process(logDetails: LogDetails)
+ 	public let date: Date
- 	open func applyFormatters(logDetails: LogDetails, message: String) -> String
+ 	public let message: String
- 	open func write(message: String)
+ 	public let threadName: String
- 
+ 	public let functionName: StaticString
- public class ConsoleLogDestination : BaseLogDestination
+ 	public let fileName: StaticString
- 	override open func write(message: String)
+ 	public let lineNumber: UInt
- 
+ 	public let error: Error?
- public enum LogLevel : Int
+ 
- 	case debug = 0
+ public protocol LogDestination
- 	case info
+ 	var identifier: String
- 	case warning
+ 	var level: LogLevel
- 	case error
+ 	var subsystems: LogSubsystem
- 
+ 	var dateFormatter: DateFormatter
- public struct LogDetails
+ 	var formatters: [LogFormatter]
- 	public let loggerIdentifier: String
+ 	var showDate: Bool
- 	public let subsystem: LogSubsystem
+ 	var showLevel: Bool
- 	public let level: LogLevel
+ 	var showIdentifier: Bool
- 	public let date: Date
+ 	var showThreadName: Bool
- 	public let message: String
+ 	var showFileName: Bool
- 	public let threadName: String
+ 	var showLineNumber: Bool
- 	public let functionName: StaticString
+ 	var showFunctionName: Bool
- 	public let fileName: StaticString
+ 	init(
- 	public let lineNumber: UInt
+         identifier: String,
- 	public let error: Error?
+         level: LogLevel,
- 
+         subsystems: LogSubsystem,
- public protocol LogDestination
+         showDate: Bool,
- 	var identifier: String
+         dateFormatter: DateFormatter,
- 	var level: LogLevel
+         formatters: [LogFormatter],
- 	var subsystems: LogSubsystem
+         showLevel: Bool,
- 	var dateFormatter: DateFormatter
+         showIdentifier: Bool,
- 	var formatters: [LogFormatter]
+         showThreadName: Bool,
- 	var showDate: Bool
+         showFileName: Bool,
- 	var showLevel: Bool
+         showLineNumber: Bool,
- 	var showIdentifier: Bool
+         showFunctionName: Bool
- 	var showThreadName: Bool
+     )
- 	var showFileName: Bool
+ 	func isEnabled(level: LogLevel) -> Bool
- 	var showLineNumber: Bool
+ 	func isEnabled(level: LogLevel, subsystems: LogSubsystem) -> Bool
- 	var showFunctionName: Bool
+ 	func process(logDetails: LogDetails)
- 	init(
+ 	func applyFormatters(logDetails: LogDetails, message: String) -> String
-         identifier: String,
+ 
-         level: LogLevel,
+ public extension LogDestination
-         subsystems: LogSubsystem,
+ 	var subsystems: LogSubsystem
-         showDate: Bool,
+ 	func isEnabled(level: LogLevel, subsystems: LogSubsystem) -> Bool
-         dateFormatter: DateFormatter,
+ 
-         formatters: [LogFormatter],
+ public protocol LogFormatter
-         showLevel: Bool,
+ 	func format(logDetails: LogDetails, message: String) -> String
-         showIdentifier: Bool,
+ 
-         showThreadName: Bool,
+ public class PrefixLogFormatter : LogFormatter
-         showFileName: Bool,
+ 	public init(prefixes: [LogLevel: String])
-         showLineNumber: Bool,
+ 	public func format(logDetails: LogDetails, message: String) -> String
-         showFunctionName: Bool
+ 
-     )
+ public struct LogSubsystem : OptionSet, CustomStringConvertible
- 	func isEnabled(level: LogLevel) -> Bool
+ 	public let rawValue: Int
- 	func isEnabled(level: LogLevel, subsystems: LogSubsystem) -> Bool
+ 	public init(rawValue: Int)
- 	func process(logDetails: LogDetails)
+ 	public static let allCases: [LogSubsystem]
- 	func applyFormatters(logDetails: LogDetails, message: String) -> String
+ 	public static let all: LogSubsystem
- 
+ 	public static let other
- public extension LogDestination
+ 	public static let database
- 	var subsystems: LogSubsystem
+ 	public static let httpRequests
- 	func isEnabled(level: LogLevel, subsystems: LogSubsystem) -> Bool
+ 	public static let webSocket
- 
+ 	public static let offlineSupport
- public protocol LogFormatter
+ 	public static let webRTC
- 	func format(logDetails: LogDetails, message: String) -> String
+ 	public static let peerConnectionPublisher
- 
+ 	public static let peerConnectionSubscriber
- public class PrefixLogFormatter : LogFormatter
+ 	public static let sfu
- 	public init(prefixes: [LogLevel: String])
+ 	public static let iceAdapter
- 	public func format(logDetails: LogDetails, message: String) -> String
+ 	public static let mediaAdapter
- 
+ 	public static let thermalState
- public struct LogSubsystem : OptionSet, CustomStringConvertible
+ 	public static let audioSession
- 	public let rawValue: Int
+ 	public static let videoCapturer
- 	public init(rawValue: Int)
+ 	public static let pictureInPicture
- 	public static let allCases: [LogSubsystem]
+ 	public var description: String
- 	public static let all: LogSubsystem
+ 
- 	public static let other
+ public enum LogConfig
- 	public static let database
+ 	public static var identifier
- 	public static let httpRequests
+ 	public static var level: LogLevel
- 	public static let webSocket
+ 	public static var dateFormatter: DateFormatter
- 	public static let offlineSupport
+ 	public static var formatters
- 	public static let webRTC
+ 	public static var showDate
- 	public static let peerConnectionPublisher
+ 	public static var showLevel
- 	public static let peerConnectionSubscriber
+ 	public static var showIdentifier
- 	public static let sfu
+ 	public static var showThreadName
- 	public static let iceAdapter
+ 	public static var showFileName
- 	public static let mediaAdapter
+ 	public static var showLineNumber
- 	public static let thermalState
+ 	public static var showFunctionName
- 	public static let audioSession
+ 	public static var subsystems: LogSubsystem
- 	public static let videoCapturer
+ 	public static var destinationTypes: [LogDestination.Type]
- 	public static let pictureInPicture
+ 	public static var destinations: [LogDestination]
- 	public var description: String
+ 	public static var logger: Logger
- public enum LogConfig
+ public class Logger
- 	public static var identifier
+ 	public let identifier: String
- 	public static var level: LogLevel
+ 	public var destinations: [LogDestination]
- 	public static var dateFormatter: DateFormatter
+ 	public init(identifier: String = "", destinations: [LogDestination] = [])
- 	public static var formatters
+ 	public func callAsFunction(
- 	public static var showDate
+         _ level: LogLevel,
- 	public static var showLevel
+         functionName: StaticString = #function,
- 	public static var showIdentifier
+         fileName: StaticString = #fileID,
- 	public static var showThreadName
+         lineNumber: UInt = #line,
- 	public static var showFileName
+         message: @autoclosure () -> Any,
- 	public static var showLineNumber
+         subsystems: LogSubsystem = .other,
- 	public static var showFunctionName
+         error: Error?
- 	public static var subsystems: LogSubsystem
+     )
- 	public static var destinationTypes: [LogDestination.Type]
+ 	public func log(
- 	public static var destinations: [LogDestination]
+         _ level: LogLevel,
- 	public static var logger: Logger
+         functionName: StaticString = #function,
- 
+         fileName: StaticString = #fileID,
- public class Logger
+         lineNumber: UInt = #line,
- 	public let identifier: String
+         message: @autoclosure () -> Any,
- 	public var destinations: [LogDestination]
+         subsystems: LogSubsystem = .other,
- 	public init(identifier: String = "", destinations: [LogDestination] = [])
+         error: Error?
- 	public func callAsFunction(
+     )
-         _ level: LogLevel,
+ 	public func info(
-         functionName: StaticString = #function,
+         _ message: @autoclosure () -> Any,
-         fileName: StaticString = #fileID,
+         subsystems: LogSubsystem = .other,
-         lineNumber: UInt = #line,
+         functionName: StaticString = #function,
-         message: @autoclosure () -> Any,
+         fileName: StaticString = #fileID,
-         subsystems: LogSubsystem = .other,
+         lineNumber: UInt = #line
-         error: Error?
+     )
-     )
+ 	public func debug(
- 	public func log(
+         _ message: @autoclosure () -> Any,
-         _ level: LogLevel,
+         subsystems: LogSubsystem = .other,
-         lineNumber: UInt = #line,
+         lineNumber: UInt = #line
-         message: @autoclosure () -> Any,
+     )
-         subsystems: LogSubsystem = .other,
+ 	public func warning(
-         error: Error?
+         _ message: @autoclosure () -> Any,
-     )
+         subsystems: LogSubsystem = .other,
- 	public func info(
+         functionName: StaticString = #function,
-         _ message: @autoclosure () -> Any,
+         fileName: StaticString = #fileID,
-         subsystems: LogSubsystem = .other,
+         lineNumber: UInt = #line
-         functionName: StaticString = #function,
+     )
-         fileName: StaticString = #fileID,
+ 	public func error(
-         lineNumber: UInt = #line
+         _ message: @autoclosure () -> Any,
-     )
+         subsystems: LogSubsystem = .other,
- 	public func debug(
+         error: Error? = nil,
-         _ message: @autoclosure () -> Any,
+         functionName: StaticString = #function,
-         subsystems: LogSubsystem = .other,
+         fileName: StaticString = #fileID,
-         functionName: StaticString = #function,
+         lineNumber: UInt = #line
-         fileName: StaticString = #fileID,
+     )
-         lineNumber: UInt = #line
+ 	public func assert(
-     )
+         _ condition: @autoclosure () -> Bool,
- 	public func warning(
+         _ message: @autoclosure () -> Any,
-         _ message: @autoclosure () -> Any,
+         subsystems: LogSubsystem = .other,
-         subsystems: LogSubsystem = .other,
+         functionName: StaticString = #function,
-         functionName: StaticString = #function,
+         fileName: StaticString = #fileID,
-         fileName: StaticString = #fileID,
+         lineNumber: UInt = #line
-         lineNumber: UInt = #line
+     )
-     )
+ 	public func assertionFailure(
- 	public func error(
+         _ message: @autoclosure () -> Any,
-         _ message: @autoclosure () -> Any,
+         subsystems: LogSubsystem = .other,
-         subsystems: LogSubsystem = .other,
+         functionName: StaticString = #function,
-         error: Error? = nil,
+         fileName: StaticString = #fileID,
-         functionName: StaticString = #function,
+         lineNumber: UInt = #line
-         fileName: StaticString = #fileID,
+     )
-         lineNumber: UInt = #line
+ 
-     )
+ extension Publisher
- 	public func assert(
+ 	public func log(
-         _ condition: @autoclosure () -> Bool,
+         _ level: LogLevel,
-         _ message: @autoclosure () -> Any,
+         subsystems: LogSubsystem = .other,
-         subsystems: LogSubsystem = .other,
+         functionName: StaticString = #function,
-         functionName: StaticString = #function,
+         fileName: StaticString = #fileID,
-         fileName: StaticString = #fileID,
+         lineNumber: UInt = #line,
-         lineNumber: UInt = #line
+         messageBuilder: ((Self.Output) -> String)? = nil
-     )
+     ) -> Publishers.Log<Self>
- 	public func assertionFailure(
+ 
-         _ message: @autoclosure () -> Any,
+ public final class DefaultParticipantAutoLeavePolicy : ParticipantAutoLeavePolicy
-         subsystems: LogSubsystem = .other,
+ 	public var onPolicyTriggered: (() -> Void)?
-         functionName: StaticString = #function,
+ 	public init()
-         fileName: StaticString = #fileID,
+ 
-         lineNumber: UInt = #line
+ public final class LastParticipantAutoLeavePolicy : ParticipantAutoLeavePolicy
-     )
+ 	public var onPolicyTriggered: (() -> Void)?
- 
+ 	public init()
- extension Publisher
+ 
- 	public func log(
+ public protocol ParticipantAutoLeavePolicy
-         _ level: LogLevel,
+ 	var onPolicyTriggered: (() -> Void)?
-         subsystems: LogSubsystem = .other,
+ 
-         functionName: StaticString = #function,
+ extension Publisher
-         fileName: StaticString = #fileID,
+ 	public func assign<Root: AnyObject>(
-         lineNumber: UInt = #line,
+         to keyPath: ReferenceWritableKeyPath<Root, Output>,
-         messageBuilder: ((Self.Output) -> String)? = nil
+         onWeak object: Root
-     ) -> Publishers.Log<Self>
+     ) -> AnyCancellable
- public final class DefaultParticipantAutoLeavePolicy : ParticipantAutoLeavePolicy
+ public final class RecursiveQueue : LockQueuing, @unchecked Sendable
- 	public var onPolicyTriggered: (() -> Void)?
+ 	public init()
- 	public init()
+ 	public func sync<T>(_ block: () throws -> T) rethrows -> T
- public final class LastParticipantAutoLeavePolicy : ParticipantAutoLeavePolicy
+ public final class UnfairQueue : LockQueuing, @unchecked Sendable
- 	public var onPolicyTriggered: (() -> Void)?
+ 	public init()
- 	public init()
+ 	public func sync<T>(_ block: () throws -> T) rethrows -> T
- public protocol ParticipantAutoLeavePolicy
+ public indirect enum RawJSON : Codable, Hashable, Sendable
- 	var onPolicyTriggered: (() -> Void)?
+ 	case number(Double)
- 
+ 	case string(String)
- extension Publisher
+ 	case bool(Bool)
- 	public func assign<Root: AnyObject>(
+ 	case dictionary([String: RawJSON])
-         to keyPath: ReferenceWritableKeyPath<Root, Output>,
+ 	case array([RawJSON])
-         onWeak object: Root
+ 	case `nil`
-     ) -> AnyCancellable
+ 	public init(from decoder: Decoder) throws
- 
+ 	public func encode(to encoder: Encoder) throws
- public final class RecursiveQueue : LockQueuing, @unchecked Sendable
+ 
- 	public init()
+ public extension RawJSON
- 	public func sync<T>(_ block: () throws -> T) rethrows -> T
+ 	var numberValue: Double?
- 
+ 	var stringValue: String?
- public final class UnfairQueue : LockQueuing, @unchecked Sendable
+ 	var boolValue: Bool?
- 	public init()
+ 	var dictionaryValue: [String: RawJSON]?
- 	public func sync<T>(_ block: () throws -> T) rethrows -> T
+ 	var arrayValue: [RawJSON]?
- 
+ 	var numberArrayValue: [Double]?
- public indirect enum RawJSON : Codable, Hashable, Sendable
+ 	var stringArrayValue: [String]?
- 	case number(Double)
+ 	var boolArrayValue: [Bool]?
- 	case string(String)
+ 	var isNil: Bool
- 	case bool(Bool)
+ 
- 	case dictionary([String: RawJSON])
+ public enum ReflectiveStringConvertibleSkipRule : Hashable
- 	case array([RawJSON])
+ 	case empty
- 	case `nil`
+ 	case nilValues
- 	public init(from decoder: Decoder) throws
+ 	case custom(identifier: String, rule: (Mirror.Child) -> Bool)
- 	public func encode(to encoder: Encoder) throws
+ 	public func hash(into hasher: inout Hasher)
- 
+ 	public func shouldBeSkipped(_ child: Mirror.Child) -> Bool
- public extension RawJSON
+ 	public static func == (
- 	var numberValue: Double?
+         lhs: ReflectiveStringConvertibleSkipRule,
- 	var stringValue: String?
+         rhs: ReflectiveStringConvertibleSkipRule
- 	var boolValue: Bool?
+     ) -> Bool
- 	var dictionaryValue: [String: RawJSON]?
+ 
- 	var arrayValue: [RawJSON]?
+ public protocol ReflectiveStringConvertible : CustomStringConvertible
- 	var numberArrayValue: [Double]?
+ 	var separator: String
- 	var stringArrayValue: [String]?
+ 	var excludedProperties: Set<String>
- 	var boolArrayValue: [Bool]?
+ 	var propertyTransformers: [String: (Any) -> String]
- 	var isNil: Bool
+ 	var skipRuleSet: Set<ReflectiveStringConvertibleSkipRule>
- public enum ReflectiveStringConvertibleSkipRule : Hashable
+ public extension ReflectiveStringConvertible
- 	case empty
+ 	var skipRuleSet: Set<ReflectiveStringConvertibleSkipRule>
- 	case nilValues
+ 	var separator: String
- 	case custom(identifier: String, rule: (Mirror.Child) -> Bool)
+ 	var excludedProperties: Set<String>
- 	public func hash(into hasher: inout Hasher)
+ 	var propertyTransformers: [String: (Any) -> String]
- 	public func shouldBeSkipped(_ child: Mirror.Child) -> Bool
+ 	var description: String
- 	public static func == (
+ 
-         lhs: ReflectiveStringConvertibleSkipRule,
+ public protocol RejectionReasonProviding
-         rhs: ReflectiveStringConvertibleSkipRule
+ 	func reason(for callCid: String, ringTimeout: Bool) -> String?
-     ) -> Bool
+ 
- 
+ public final class SerialActorQueue
- public protocol ReflectiveStringConvertible : CustomStringConvertible
+ 	public init()
- 	var separator: String
+ 	public func async(
- 	var excludedProperties: Set<String>
+         file: StaticString = #file,
- 	var propertyTransformers: [String: (Any) -> String]
+         functionName: StaticString = #function,
- 	var skipRuleSet: Set<ReflectiveStringConvertibleSkipRule>
+         line: UInt = #line,
- 
+         _ block: @Sendable @escaping () async throws -> Void
- public extension ReflectiveStringConvertible
+     )
- 	var skipRuleSet: Set<ReflectiveStringConvertibleSkipRule>
+ 	public func sync(
- 	var separator: String
+         _ block: @Sendable @escaping () async throws -> Void
- 	var excludedProperties: Set<String>
+     ) async throws
- 	var propertyTransformers: [String: (Any) -> String]
+ 
- 	var description: String
+ public enum StreamSortOrder
- 
+ 	case ascending, descending
- public protocol RejectionReasonProviding
+ 
- 	func reason(for callCid: String, ringTimeout: Bool) -> String?
+ extension Sequence
- 
+ 	public func sorted(
- public final class SerialActorQueue
+         by comparator: StreamSortComparator<Element>,
- 	public init()
+         order: StreamSortOrder = .ascending
- 	public func async(
+     ) -> [Element]
-         file: StaticString = #file,
+ 	public func sorted(
-         functionName: StaticString = #function,
+         by comparators: [StreamSortComparator<Element>],
-         line: UInt = #line,
+         order: StreamSortOrder = .ascending
-         _ block: @Sendable @escaping () async throws -> Void
+     ) -> [Element]
-     )
+ 
- 	public func sync(
+ public final class StreamStateMachine
-         _ block: @Sendable @escaping () async throws -> Void
+ 	public var currentStage: StageType
-     ) async throws
+ 	public let publisher: CurrentValueSubject<StageType, Never>
- 
+ 	public init(initialStage: StageType, logSubsystem: LogSubsystem = .other)
- public enum StreamSortOrder
+ 	public func transition(to nextStage: StageType) throws
- 	case ascending, descending
+ 
- 
+ public protocol StreamStateMachineStage : CustomStringConvertible
- extension Sequence
+ 	var id: ID
- 	public func sorted(
+ 	var transition: Transition?
-         by comparator: StreamSortComparator<Element>,
+ 	func willTransitionAway()
-         order: StreamSortOrder = .ascending
+ 	func transition(from previousStage: Self) -> Self?
-     ) -> [Element]
+ 	func didTransitionAway()
- 	public func sorted(
+ 
-         by comparators: [StreamSortComparator<Element>],
+ extension StreamStateMachineStage
-         order: StreamSortOrder = .ascending
+ 	public var description: String
-     ) -> [Element]
+ 
- 
+ public final class StreamAppStateAdapter : ObservableObject, @unchecked Sendable
- public final class StreamStateMachine
+ 	public enum State : Sendable, Equatable
- 	public var currentStage: StageType
+ 		case foreground, background
- 	public let publisher: CurrentValueSubject<StageType, Never>
+ 	@Published public private(set) var state: State
- 	public init(initialStage: StageType, logSubsystem: LogSubsystem = .other)
+ 
- 	public func transition(to nextStage: StageType) throws
+ extension StreamAppStateAdapter : InjectionKey
- 
+ 	public static var currentValue: StreamAppStateAdapter
- public protocol StreamStateMachineStage : CustomStringConvertible
+ 
- 	var id: ID
+ extension InjectedValues
- 	var transition: Transition?
+ 	public var applicationStateAdapter: StreamAppStateAdapter
- 	func willTransitionAway()
+ 
- 	func transition(from previousStage: Self) -> Self?
+ public enum StreamRuntimeCheck
- 	func didTransitionAway()
+ 
- extension StreamStateMachineStage
+ public protocol ThermalStateObserving : ObservableObject
- 	public var description: String
+ 	var state: ProcessInfo.ThermalState
- 
+ 	var statePublisher: AnyPublisher<ProcessInfo.ThermalState, Never>
- public final class StreamAppStateAdapter : ObservableObject, @unchecked Sendable
+ 	var scale: CGFloat
- 	public enum State : Sendable, Equatable
+ 
- 		case foreground, background
+ extension ProcessInfo.ThermalState : Comparable
- 	@Published public private(set) var state: State
+ 	public static func < (
- 
+         lhs: ProcessInfo.ThermalState,
- extension StreamAppStateAdapter : InjectionKey
+         rhs: ProcessInfo.ThermalState
- 	public static var currentValue: StreamAppStateAdapter
+     ) -> Bool
- 	public var applicationStateAdapter: StreamAppStateAdapter
+ 	public var thermalStateObserver: any ThermalStateObserving
- public enum StreamRuntimeCheck
+ public protocol UUIDProviding
- 
+ 	func get() -> UUID
- public protocol ThermalStateObserving : ObservableObject
+ public enum UUIDProviderKey : InjectionKey
- 	var state: ProcessInfo.ThermalState
+ 	public static var currentValue: UUIDProviding
- 	var statePublisher: AnyPublisher<ProcessInfo.ThermalState, Never>
+ 
- 	var scale: CGFloat
+ extension InjectedValues
- 
+ 	public var uuidFactory: UUIDProviding
- extension ProcessInfo.ThermalState : Comparable
+ 
- 	public static func < (
+ public struct StreamUUIDFactory : UUIDProviding
-         lhs: ProcessInfo.ThermalState,
+ 	public func get() -> UUID
-         rhs: ProcessInfo.ThermalState
+ 
-     ) -> Bool
+ public enum CallNotification
- 
+ 	public static let callEnded
- extension InjectedValues
+ 	public static let participantLeft
- 	public var thermalStateObserver: any ThermalStateObserving
+ 
- 
+ public final class VideoConfig : Sendable
- public protocol UUIDProviding
+ 	public let videoFilters: [VideoFilter]
- 	func get() -> UUID
+ 	public let noiseCancellationFilter: NoiseCancellationFilter?
- 
+ 	public let audioProcessingModule: AudioProcessingModule
- public enum UUIDProviderKey : InjectionKey
+ 	public init(
- 	public static var currentValue: UUIDProviding
+         videoFilters: [VideoFilter] = [],
- 
+         noiseCancellationFilter: NoiseCancellationFilter? = nil,
- extension InjectedValues
+         audioProcessingModule: AudioProcessingModule? = nil
- 	public var uuidFactory: UUIDProviding
+     )
- public struct StreamUUIDFactory : UUIDProviding
+ public protocol AudioFilter : Sendable
- 	public func get() -> UUID
+ 	var id: String
- 
+ 	func initialize(sampleRate: Int, channels: Int)
- public enum CallNotification
+ 	func applyEffect(to audioBuffer: inout RTCAudioBuffer)
- 	public static let callEnded
+ 	func release()
- 	public static let participantLeft
+ 
- 
+ public extension AudioFilter
- public final class VideoConfig : Sendable
+ 	func initialize(sampleRate: Int, channels: Int)
- 	public let videoFilters: [VideoFilter]
+ 	func release()
- 	public let noiseCancellationFilter: NoiseCancellationFilter?
+ 
- 	public let audioProcessingModule: AudioProcessingModule
+ public final class NoiseCancellationFilter : AudioFilter, @unchecked Sendable
-         videoFilters: [VideoFilter] = [],
+         name: String,
-         noiseCancellationFilter: NoiseCancellationFilter? = nil,
+         initialize: @escaping InitializeClosure,
-         audioProcessingModule: AudioProcessingModule? = nil
+         process: @escaping ProcessClosure,
-     )
+         release: @escaping ReleaseClosure
- 
+     )
- public protocol AudioFilter : Sendable
+ 	public var id: String
- 	var id: String
+ 	public func initialize(sampleRate: Int, channels: Int)
- 	func initialize(sampleRate: Int, channels: Int)
+ 	public func applyEffect(to buffer: inout RTCAudioBuffer)
- 	func applyEffect(to audioBuffer: inout RTCAudioBuffer)
+ 	public func release()
- 	func release()
+ 
- 
+ public protocol AudioFilterCapturePostProcessingModule : RTCAudioCustomProcessingDelegate
- public extension AudioFilter
+ 	var audioFilter: AudioFilter?
- 	func initialize(sampleRate: Int, channels: Int)
+ 	func setAudioFilter(_ audioFilter: AudioFilter?)
- 	func release()
+ 
- 
+ open class StreamAudioFilterCapturePostProcessingModule : NSObject, AudioFilterCapturePostProcessingModule, @unchecked Sendable
- public final class NoiseCancellationFilter : AudioFilter, @unchecked Sendable
+ 	public private(set) var audioFilter: AudioFilter?
- 	public init(
+ 	public private(set) var sampleRate: Int
-         name: String,
+ 	public private(set) var channels: Int
-         initialize: @escaping InitializeClosure,
+ 	override public init()
-         process: @escaping ProcessClosure,
+ 	open func setAudioFilter(_ audioFilter: AudioFilter?)
-         release: @escaping ReleaseClosure
+ 	open func audioProcessingInitialize(
-     )
+         sampleRate sampleRateHz: Int,
- 	public var id: String
+         channels: Int
- 	public func initialize(sampleRate: Int, channels: Int)
+     )
- 	public func applyEffect(to buffer: inout RTCAudioBuffer)
+ 	open func audioProcessingProcess(audioBuffer: RTCAudioBuffer)
- 	public func release()
+ 	open func audioProcessingRelease()
- public protocol AudioFilterCapturePostProcessingModule : RTCAudioCustomProcessingDelegate
+ public protocol AudioProcessingModule : RTCAudioProcessingModule, Sendable
- 	var audioFilter: AudioFilter?
+ 	var activeAudioFilter: AudioFilter?
- 	func setAudioFilter(_ audioFilter: AudioFilter?)
+ 	func setAudioFilter(_ filter: AudioFilter?)
- open class StreamAudioFilterCapturePostProcessingModule : NSObject, AudioFilterCapturePostProcessingModule, @unchecked Sendable
+ open class StreamAudioFilterProcessingModule : RTCDefaultAudioProcessingModule, AudioProcessingModule, @unchecked Sendable
- 	public private(set) var audioFilter: AudioFilter?
+ 	public init(
- 	public private(set) var sampleRate: Int
+         config: RTCAudioProcessingConfig? = nil,
- 	public private(set) var channels: Int
+         capturePostProcessingDelegate: AudioFilterCapturePostProcessingModule = StreamAudioFilterCapturePostProcessingModule(),
- 	override public init()
+         renderPreProcessingDelegate: RTCAudioCustomProcessingDelegate? = nil
- 	open func setAudioFilter(_ audioFilter: AudioFilter?)
+     )
- 	open func audioProcessingInitialize(
+ 	override public func apply(_ config: RTCAudioProcessingConfig)
-         sampleRate sampleRateHz: Int,
+ 	public var activeAudioFilter: AudioFilter?
-         channels: Int
+ 	public func setAudioFilter(_ filter: AudioFilter?)
-     )
+ 
- 	open func audioProcessingProcess(audioBuffer: RTCAudioBuffer)
+ public enum BroadcastState
- 	open func audioProcessingRelease()
+ 	case notStarted
- 
+ 	case started
- public protocol AudioProcessingModule : RTCAudioProcessingModule, Sendable
+ 	case finished
- 	var activeAudioFilter: AudioFilter?
+ 
- 	func setAudioFilter(_ filter: AudioFilter?)
+ public class BroadcastObserver : ObservableObject
- 
+ 	@Published public var broadcastState: BroadcastState
- open class StreamAudioFilterProcessingModule : RTCDefaultAudioProcessingModule, AudioProcessingModule, @unchecked Sendable
+ 	public init()
- 	public init(
+ 	public func observe()
-         config: RTCAudioProcessingConfig? = nil,
+ 
-         capturePostProcessingDelegate: AudioFilterCapturePostProcessingModule = StreamAudioFilterCapturePostProcessingModule(),
+ open class BroadcastSampleHandler : RPBroadcastSampleHandler
-         renderPreProcessingDelegate: RTCAudioCustomProcessingDelegate? = nil
+ 	override public init()
-     )
+ 	override public func broadcastStarted(withSetupInfo setupInfo: [String: NSObject]?)
- 	override public func apply(_ config: RTCAudioProcessingConfig)
+ 	override public func broadcastPaused()
- 	public var activeAudioFilter: AudioFilter?
+ 	override public func broadcastResumed()
- 	public func setAudioFilter(_ filter: AudioFilter?)
+ 	override public func broadcastFinished()
- 
+ 	override public func processSampleBuffer(
- public enum BroadcastState
+         _ sampleBuffer: CMSampleBuffer,
- 	case notStarted
+         with sampleBufferType: RPSampleBufferType
- 	case started
+     )
- 	case finished
+ 
- 
+ extension InjectedValues
- public class BroadcastObserver : ObservableObject
+ 	public var simulatorStreamFile: URL?
- 	@Published public var broadcastState: BroadcastState
+ 
- 	public init()
+ @available(iOS 15.0, *) public final class BlurBackgroundVideoFilter : VideoFilter
- 	public func observe()
+ 	@available(*, unavailable)
- 
+     override public init(
- open class BroadcastSampleHandler : RPBroadcastSampleHandler
+         id: String,
- 	override public init()
+         name: String,
- 	override public func broadcastStarted(withSetupInfo setupInfo: [String: NSObject]?)
+         filter: @escaping (Input) async -> CIImage
- 	override public func broadcastPaused()
+     )
- 	override public func broadcastResumed()
+ 
- 	override public func broadcastFinished()
+ @available(iOS 15.0, *) public final class ImageBackgroundVideoFilter : VideoFilter
- 	override public func processSampleBuffer(
+ 	@available(*, unavailable)
-         _ sampleBuffer: CMSampleBuffer,
+     override public init(
-         with sampleBufferType: RPSampleBufferType
+         id: String,
-     )
+         name: String,
- 
+         filter: @escaping (Input) async -> CIImage
- extension InjectedValues
+     )
- 	public var simulatorStreamFile: URL?
+ 
- 
+ open class VideoFilter : @unchecked Sendable
- @available(iOS 15.0, *) public final class BlurBackgroundVideoFilter : VideoFilter
+ 	public struct Input
- 	@available(*, unavailable)
+ 		public var originalImage: CIImage
-     override public init(
+ 		public var originalPixelBuffer: CVPixelBuffer
-         id: String,
+ 		public var originalImageOrientation: CGImagePropertyOrientation
-         name: String,
+ 	public let id: String
-         filter: @escaping (Input) async -> CIImage
+ 	public let name: String
-     )
+ 	public var filter: (Input) async -> CIImage
- 
+ 	public init(
- @available(iOS 15.0, *) public final class ImageBackgroundVideoFilter : VideoFilter
+         id: String,
- 	@available(*, unavailable)
+         name: String,
-     override public init(
+         filter: @escaping (Input) async -> CIImage
-         id: String,
+     )
-         name: String,
+ 
-         filter: @escaping (Input) async -> CIImage
+ extension VideoFilter
-     )
+ 	@available(iOS 15.0, *)
- 
+     public static let blurredBackground: VideoFilter
- open class VideoFilter : @unchecked Sendable
+ 	@available(iOS 15.0, *)
- 	public struct Input
+     public static func imageBackground(
- 		public var originalImage: CIImage
+         _ backgroundImage: CIImage,
- 		public var originalPixelBuffer: CVPixelBuffer
+         id: String
- 		public var originalImageOrientation: CGImagePropertyOrientation
+     ) -> VideoFilter
- 	public let id: String
+ 
- 	public let name: String
+ extension AVCaptureDevice.Position : CustomStringConvertible
- 	public var filter: (Input) async -> CIImage
+ 	public var description: String
- 	public init(
+ 
-         id: String,
+ extension CMVideoDimensions
-         name: String,
+ 	public static var full
-         filter: @escaping (Input) async -> CIImage
+ 	public static var half
-     )
+ 	public static var quarter
- 
+ 	var area: Int32
- extension VideoFilter
+ 	init(_ source: CGSize)
- 	@available(iOS 15.0, *)
+ 
-     public static let blurredBackground: VideoFilter
+ extension Int
- 	@available(iOS 15.0, *)
+ 	public static let defaultFrameRate: Int
-     public static func imageBackground(
+ 	public static let defaultScreenShareFrameRate: Int
-         _ backgroundImage: CIImage,
+ 	public static let maxBitrate
-         id: String
+ 	public static let maxSpatialLayers
-     ) -> VideoFilter
+ 	public static let maxTemporalLayers
- extension AVCaptureDevice.Position : CustomStringConvertible
+ extension Publisher
- 	public var description: String
+ 	public func sinkTask(
- 
+         storeIn disposableBag: DisposableBag? = nil,
- extension CMVideoDimensions
+         identifier: String? = nil,
- 	public static var full
+         receiveCompletion: @escaping ((Subscribers.Completion<Failure>) -> Void) = { _ in },
- 	public static var half
+         receiveValue: @escaping ((Output) async throws -> Void)
- 	public static var quarter
+     ) -> AnyCancellable
- 	var area: Int32
+ 	public func sinkTask(
- 	init(_ source: CGSize)
+         queue: SerialActorQueue,
- 
+         receiveCompletion: @escaping ((Subscribers.Completion<Failure>) -> Void) = { _ in },
- extension Int
+         receiveValue: @escaping ((Output) async throws -> Void)
- 	public static let defaultFrameRate: Int
+     ) -> AnyCancellable
- 	public static let defaultScreenShareFrameRate: Int
+ 
- 	public static let maxBitrate
+ extension RTCIceCandidate
- 	public static let maxSpatialLayers
+ 	override public var description: String
- 	public static let maxTemporalLayers
+ 
- 
+ extension RTCIceConnectionState : CustomStringConvertible
- extension Publisher
+ 	public var description: String
- 	public func sinkTask(
+ 
-         storeIn disposableBag: DisposableBag? = nil,
+ extension RTCIceGatheringState : CustomStringConvertible
-         identifier: String? = nil,
+ 	public var description: String
-         receiveCompletion: @escaping ((Subscribers.Completion<Failure>) -> Void) = { _ in },
+ 
-         receiveValue: @escaping ((Output) async throws -> Void)
+ extension RTCMediaStream
-     ) -> AnyCancellable
+ 	override public var description: String
- 	public func sinkTask(
+ 
-         queue: SerialActorQueue,
+ extension RTCPeerConnectionState : CustomStringConvertible
-         receiveCompletion: @escaping ((Subscribers.Completion<Failure>) -> Void) = { _ in },
+ 	public var description: String
-         receiveValue: @escaping ((Output) async throws -> Void)
+ 
-     ) -> AnyCancellable
+ extension RTCRtpReceiver
- 
+ 	override public var description: String
- extension RTCIceCandidate
+ 
- 	override public var description: String
+ extension RTCRtpTransceiverDirection : CustomStringConvertible
- 
+ 	public var description: String
- extension RTCIceConnectionState : CustomStringConvertible
+ 
- 	public var description: String
+ extension RTCSdpType : CustomStringConvertible
- 
+ 	public var description: String
- extension RTCIceGatheringState : CustomStringConvertible
+ 
- 	public var description: String
+ extension RTCSignalingState : CustomStringConvertible
- 
+ 	public var description: String
- extension RTCMediaStream
+ 
- 	override public var description: String
+ public class VideoCapturePolicy : @unchecked Sendable
- extension RTCPeerConnectionState : CustomStringConvertible
+ 
- 	public var description: String
+ extension VideoCapturePolicy : InjectionKey
- 
+ 	public static var currentValue: VideoCapturePolicy
- extension RTCRtpReceiver
+ 
- 	override public var description: String
+ public struct APIKey : Equatable
- 
+ 	public let apiKeyString: String
- extension RTCRtpTransceiverDirection : CustomStringConvertible
+ 	public init(_ apiKeyString: String)
- 	public var description: String
+ 
- 
+ public enum ConnectionStatus : Equatable
- extension RTCSdpType : CustomStringConvertible
+ 	case initialized
- 	public var description: String
+ 	case disconnected(error: ClientError? = nil)
- 
+ 	case connecting
- extension RTCSignalingState : CustomStringConvertible
+ 	case connected
- 	public var description: String
+ 	case disconnecting
- public class VideoCapturePolicy : @unchecked Sendable
+ public protocol Event : Sendable
- extension VideoCapturePolicy : InjectionKey
+ public protocol SendableEvent : Event, ProtoModel, ReflectiveStringConvertible
- 	public static var currentValue: VideoCapturePolicy
+ 
- public struct APIKey : Equatable
+ extension UserResponse
- 	public let apiKeyString: String
+ 	public var toUser: User
- 	public init(_ apiKeyString: String)
+ 
- 
+ public class Appearance
- public enum ConnectionStatus : Equatable
+ 	public var colors: Colors
- 	case initialized
+ 	public var images: Images
- 	case disconnected(error: ClientError? = nil)
+ 	public var fonts: Fonts
- 	case connecting
+ 	public var sounds: Sounds
- 	case connected
+ 	public init(
- 	case disconnecting
+         colors: Colors = Colors(),
- 
+         images: Images = Images(),
- public protocol Event : Sendable
+         fonts: Fonts = Fonts(),
- 
+         sounds: Sounds = Sounds()
- 
+     )
- public protocol SendableEvent : Event, ProtoModel, ReflectiveStringConvertible
+ 	public static var localizationProvider: (_ key: String, _ table: String) -> String
- 
+ public extension Appearance
- extension UserResponse
+ 	static var `default`: Appearance
- 	public var toUser: User
+ 
- 
+ extension InjectedValues
- public class Appearance
+ 	public var appearance: Appearance
          ring: Bool = false,
  	@discardableResult
  	@discardableResult
...
- 	public init(
+ 
-         colors: Colors = Colors(),
+ @available(iOS 14.0, *) public struct VideoViewOverlay : View
-         images: Images = Images(),
+ 	public init(
-         fonts: Fonts = Fonts(),
+         rootView: RootView,
-         sounds: Sounds = Sounds()
+         viewFactory: Factory = DefaultViewFactory.shared,
-     )
+         viewModel: CallViewModel
- 	public static var localizationProvider: (_ key: String, _ table: String) -> String
+     )
- 
+ 	public var body: some View
- public extension Appearance
+ 
- 	static var `default`: Appearance
+ @available(iOS 14.0, *) public struct CallContainer : View
- 
+ 	public init(
- extension InjectedValues
+         viewFactory: Factory = DefaultViewFactory.shared,
- 	public var appearance: Appearance
+         viewModel: CallViewModel
- 	public var colors: Colors
+     )
- 	public var images: Images
+ 	public var body: some View
- 	public var fonts: Fonts
+ 
- 	public var sounds: Sounds
+ public struct WaitingLocalUserView : View
- 
+ 	public init(viewModel: CallViewModel, viewFactory: Factory)
- @available(iOS 14.0, *) public struct VideoViewOverlay : View
+ 	public var body: some View
- 	public init(
+ 
-         rootView: RootView,
+ @available(iOS 14.0, *) public struct CallModifier : ViewModifier
-         viewFactory: Factory = DefaultViewFactory.shared,
+ 	@MainActor
-         viewModel: CallViewModel
+     public init(
-     )
+         viewFactory: Factory = DefaultViewFactory.shared,
- 	public var body: some View
+         viewModel: CallViewModel
- 
+     )
- @available(iOS 14.0, *) public struct CallContainer : View
+ 	public func body(content: Content) -> some View
- 	public init(
+ 
-         viewFactory: Factory = DefaultViewFactory.shared,
+ public struct CallControlsView : View
-         viewModel: CallViewModel
+ 	public init(viewModel: CallViewModel)
-     )
+ 	public var body: some View
- 	public var body: some View
+ 
- 
+ public struct VideoIconView : View
- public struct WaitingLocalUserView : View
+ 	public init(viewModel: CallViewModel, size: CGFloat = 44)
- 	public init(viewModel: CallViewModel, viewFactory: Factory)
+ 	public var body: some View
- 	public var body: some View
+ 
- 
+ public struct MicrophoneIconView : View
- @available(iOS 14.0, *) public struct CallModifier : ViewModifier
+ 	public init(viewModel: CallViewModel, size: CGFloat = 44)
- 	@MainActor
+ 	public var body: some View
-     public init(
+ 
-         viewFactory: Factory = DefaultViewFactory.shared,
+ public struct ToggleCameraIconView : View
-         viewModel: CallViewModel
+ 	public init(viewModel: CallViewModel, size: CGFloat = 44)
-     )
+ 	public var body: some View
- 	public func body(content: Content) -> some View
+ 
- 
+ public struct HangUpIconView : View
- public struct CallControlsView : View
+ 	public init(viewModel: CallViewModel, size: CGFloat = 44)
- 	public init(viewModel: CallViewModel)
+ 	public var body: some View
- 	public var body: some View
+ 
- 
+ public struct AudioOutputIconView : View
- public struct VideoIconView : View
+ 	public init(viewModel: CallViewModel, size: CGFloat = 44)
- 	public init(viewModel: CallViewModel, size: CGFloat = 44)
+ 	public var body: some View
- 	public var body: some View
+ 
- 
+ public struct SpeakerIconView : View
- public struct MicrophoneIconView : View
+ 	public init(viewModel: CallViewModel, size: CGFloat = 44)
- 	public init(viewModel: CallViewModel, size: CGFloat = 44)
+ 	public var body: some View
- 	public var body: some View
+ 
- 
+ public struct StatelessAudioOutputIconView : View
- public struct ToggleCameraIconView : View
+ 	public var call: Call?
- 	public init(viewModel: CallViewModel, size: CGFloat = 44)
+ 	public var size: CGFloat
- 	public var body: some View
+ 	public var actionHandler: ActionHandler?
- 
+ 	@MainActor
- public struct HangUpIconView : View
+     public init(
- 	public init(viewModel: CallViewModel, size: CGFloat = 44)
+         call: Call?,
- 	public var body: some View
+         size: CGFloat = 44,
- 
+         actionHandler: ActionHandler? = nil
- public struct AudioOutputIconView : View
+     )
- 	public init(viewModel: CallViewModel, size: CGFloat = 44)
+ 	public var body: some View
- 	public var body: some View
+ 
- 
+ public struct StatelessHangUpIconView : View
- public struct SpeakerIconView : View
+ 	public weak var call: Call?
- 	public init(viewModel: CallViewModel, size: CGFloat = 44)
+ 	public var size: CGFloat
- 	public var body: some View
+ 	public var actionHandler: ActionHandler?
- 
+ 	@MainActor
- public struct StatelessAudioOutputIconView : View
+     public init(
- 	public var call: Call?
+         call: Call?,
- 	public var size: CGFloat
+         size: CGFloat = 44,
- 	public var actionHandler: ActionHandler?
+         actionHandler: ActionHandler? = nil
- 	@MainActor
+     )
-     public init(
+ 	public var body: some View
-         call: Call?,
+ 
-         size: CGFloat = 44,
+ public struct StatelessMicrophoneIconView : View
-         actionHandler: ActionHandler? = nil
+ 	public var call: Call?
-     )
+ 	public var size: CGFloat
- 	public var body: some View
+ 	public var actionHandler: ActionHandler?
- 
+ 	@MainActor
- public struct StatelessHangUpIconView : View
+     public init(
- 	public weak var call: Call?
+         call: Call?,
- 	public var size: CGFloat
+         size: CGFloat = 44,
- 	public var actionHandler: ActionHandler?
+         actionHandler: ActionHandler? = nil
- 	@MainActor
+     )
-     public init(
+ 	public var body: some View
-         call: Call?,
+ 
-         size: CGFloat = 44,
+ public struct StatelessParticipantsListButton : View
-         actionHandler: ActionHandler? = nil
+ 	public weak var call: Call?
-     )
+ 	public var size: CGFloat
- 	public var body: some View
+ 	public var isActive: Binding<Bool>
- 
+ 	public var actionHandler: ActionHandler?
- public struct StatelessMicrophoneIconView : View
+ 	@MainActor
- 	public var call: Call?
+     public init(
- 	public var size: CGFloat
+         call: Call?,
- 	public var actionHandler: ActionHandler?
+         size: CGFloat = 44,
- 	@MainActor
+         isActive: Binding<Bool>,
-     public init(
+         actionHandler: ActionHandler? = nil
-         call: Call?,
+     )
-         size: CGFloat = 44,
+ 	public var body: some View
-         actionHandler: ActionHandler? = nil
+ 
-     )
+ public struct StatelessSpeakerIconView : View
- 	public var body: some View
+ 	public var call: Call?
- 
+ 	public var size: CGFloat
- public struct StatelessParticipantsListButton : View
+ 	public var actionHandler: ActionHandler?
- 	public weak var call: Call?
+ 	@MainActor
- 	public var size: CGFloat
+     public init(
- 	public var isActive: Binding<Bool>
+         call: Call?,
- 	public var actionHandler: ActionHandler?
+         size: CGFloat = 44,
- 	@MainActor
+         actionHandler: ActionHandler? = nil
-     public init(
+     )
-         call: Call?,
+ 	public var body: some View
-         size: CGFloat = 44,
+ 
-         isActive: Binding<Bool>,
+ public struct StatelessToggleCameraIconView : View
-         actionHandler: ActionHandler? = nil
+ 	public var call: Call?
-     )
+ 	public var size: CGFloat
- 	public var body: some View
+ 	public var actionHandler: ActionHandler?
- 
+ 	public init(
- public struct StatelessSpeakerIconView : View
+         call: Call?,
- 	public var call: Call?
+         size: CGFloat = 44,
- 	public var size: CGFloat
+         actionHandler: ActionHandler? = nil
- 	public var actionHandler: ActionHandler?
+     )
- 	@MainActor
+ 	public var body: some View
-     public init(
+ 
-         call: Call?,
+ public struct StatelessVideoIconView : View
-         size: CGFloat = 44,
+ 	public var call: Call?
-         actionHandler: ActionHandler? = nil
+ 	public var size: CGFloat
-     )
+ 	public var actionHandler: ActionHandler?
- 	public var body: some View
+ 	public init(
- 
+         call: Call?,
- public struct StatelessToggleCameraIconView : View
+         size: CGFloat = 44,
- 	public var call: Call?
+         actionHandler: ActionHandler? = nil
- 	public var size: CGFloat
+     )
- 	public var actionHandler: ActionHandler?
+ 	public var body: some View
- 	public init(
+ 
-         call: Call?,
+ public struct CallDurationView : View
-         size: CGFloat = 44,
+ 	@MainActor
-         actionHandler: ActionHandler? = nil
+     public init(_ viewModel: CallViewModel)
-     )
+ 	public var body: some View
- 	public var body: some View
+ 
- 
+ public struct CallParticipantImageView : View
- public struct StatelessVideoIconView : View
+ 	public init(
- 	public var call: Call?
+         viewFactory: Factory = DefaultViewFactory.shared,
- 	public var size: CGFloat
+         id: String,
- 	public var actionHandler: ActionHandler?
+         name: String,
- 	public init(
+         imageURL: URL? = nil
-         call: Call?,
+     )
-         size: CGFloat = 44,
+ 	public var body: some View
-         actionHandler: ActionHandler? = nil
+ 
-     )
+ public struct CallTopView : View
- 	public var body: some View
+ 	public init(viewModel: CallViewModel)
- 
+ 	public var body: some View
- public struct CallDurationView : View
+ 
- 	@MainActor
+ public struct SharingIndicator : View
-     public init(_ viewModel: CallViewModel)
+ 	public init(viewModel: CallViewModel, sharingPopupDismissed: Binding<Bool>)
- public struct CallParticipantImageView : View
+ public struct CallView : View
-         id: String,
+         viewModel: CallViewModel
-         name: String,
+     )
-         imageURL: URL? = nil
+ 	public var body: some View
-     )
+ 
- 	public var body: some View
+ public struct ConnectionQualityIndicator : View
- 
+ 	public init(
- public struct CallTopView : View
+         connectionQuality: ConnectionQuality,
- 	public init(viewModel: CallViewModel)
+         size: CGFloat = 28,
- 	public var body: some View
+         width: CGFloat = 3
- 
+     )
- public struct SharingIndicator : View
+ 	public var body: some View
- 	public init(viewModel: CallViewModel, sharingPopupDismissed: Binding<Bool>)
+ 
- 	public var body: some View
+ public struct CornerDraggableView : View
- 
+ 	public init(
- public struct CallView : View
+         scaleFactorX: CGFloat = 0.33,
- 	public init(
+         scaleFactorY: CGFloat = 0.33,
-         viewFactory: Factory = DefaultViewFactory.shared,
+         content: @escaping (CGRect) -> Content,
-         viewModel: CallViewModel
+         proxy: GeometryProxy,
-     )
+         onTap: @escaping () -> Void
- 	public var body: some View
+     )
- 
+ 	public var body: some View
- public struct ConnectionQualityIndicator : View
+ 
- 	public init(
+ public enum CallViewPlacement
-         connectionQuality: ConnectionQuality,
+ 	case topLeading
-         size: CGFloat = 28,
+ 	case topTrailing
-         width: CGFloat = 3
+ 	case bottomLeading
-     )
+ 	case bottomTrailing
- 	public var body: some View
+ 
- 
+ public struct ControlBadgeView : View
- public struct CornerDraggableView : View
+ 	public init(_ value: String)
- 	public init(
+ 	public var body: some View
-         scaleFactorX: CGFloat = 0.33,
+ 
-         scaleFactorY: CGFloat = 0.33,
+ public struct ModalButton : View
-         content: @escaping (CGRect) -> Content,
+ 	public init(image: Image, action: @escaping () -> Void)
-         proxy: GeometryProxy,
+ 	public var body: some View
-         onTap: @escaping () -> Void
+ 
-     )
+ public struct ParticipantsListButton : View
- 	public var body: some View
+ 	public init(
- 
+         viewModel: CallViewModel,
- public enum CallViewPlacement
+         size: CGFloat = 44
- 	case topLeading
+     )
- 	case topTrailing
+ 	public var body: some View
- 	case bottomLeading
+ 
- 	case bottomTrailing
+ public struct HorizontalParticipantsListView : View
- 
+ 	public var viewFactory: Factory
- public struct ControlBadgeView : View
+ 	public var participants: [CallParticipant]
- 	public init(_ value: String)
+ 	public var frame: CGRect
- 	public var body: some View
+ 	public var call: Call?
- 
+ 	public var innerItemSpace: CGFloat
- public struct ModalButton : View
+ 	public var showAllInfo: Bool
- 	public init(image: Image, action: @escaping () -> Void)
+ 	public init(
- 	public var body: some View
+         viewFactory: Factory = DefaultViewFactory.shared,
- 
+         participants: [CallParticipant],
- public struct ParticipantsListButton : View
+         frame: CGRect,
- 	public init(
+         call: Call?,
-         viewModel: CallViewModel,
+         innerItemSpace: CGFloat = 8,
-         size: CGFloat = 44
+         showAllInfo: Bool = false
...
- public struct HorizontalParticipantsListView : View
+ public struct SpotlightSpeakerView : View
- 	public var participants: [CallParticipant]
+ 	public var participant: CallParticipant
- 	public var frame: CGRect
+ 	public var viewIdSuffix: String
- 	public var innerItemSpace: CGFloat
+ 	public var availableFrame: CGRect
- 	public var showAllInfo: Bool
+ 	public init(
- 	public init(
+         viewFactory: Factory = DefaultViewFactory.shared,
-         viewFactory: Factory = DefaultViewFactory.shared,
+         participant: CallParticipant,
-         participants: [CallParticipant],
+         viewIdSuffix: String,
-         frame: CGRect,
+         call: Call?,
-         call: Call?,
+         availableFrame: CGRect
-         innerItemSpace: CGFloat = 8,
+     )
-         showAllInfo: Bool = false
+ 	public var body: some View
-     )
+ 
- 	public var body: some View
+ @available(iOS 14.0, *) public struct LayoutMenuView : View
- 
+ 	public init(viewModel: CallViewModel, size: CGFloat = 44)
- public struct SpotlightSpeakerView : View
+ 	public var body: some View
- 	public var viewFactory: Factory
+ 
- 	public var participant: CallParticipant
+ @available(iOS 14.0, *) public struct LocalParticipantViewModifier : ViewModifier
- 	public var viewIdSuffix: String
+ 	public init(
- 	public var call: Call?
+         localParticipant: CallParticipant,
- 	public var availableFrame: CGRect
+         call: Call?,
- 	public init(
+         callSettings: Binding<CallSettings>,
-         viewFactory: Factory = DefaultViewFactory.shared,
+         showAllInfo: Bool = false,
-         participant: CallParticipant,
+         decorations: [VideoCallParticipantDecoration] = VideoCallParticipantDecoration.allCases
-         viewIdSuffix: String,
+     )
-         call: Call?,
+ 	public func body(content: Content) -> some View
-         availableFrame: CGRect
+ 
-     )
+ @available(iOS, introduced: 13, obsoleted: 14) public struct LocalParticipantViewModifier_iOS13 : ViewModifier
- 	public var body: some View
+ 	public func body(content: Content) -> some View
- @available(iOS 14.0, *) public struct LayoutMenuView : View
+ public struct MinimizedCallView : View
- 	public init(viewModel: CallViewModel, size: CGFloat = 44)
+ 	public init(
- 	public var body: some View
+         viewFactory: Factory = DefaultViewFactory.shared,
- 
+         viewModel: CallViewModel
- @available(iOS 14.0, *) public struct LocalParticipantViewModifier : ViewModifier
+     )
- 	public init(
+ 	public var body: some View
-         localParticipant: CallParticipant,
+ 
-         call: Call?,
+ public struct ParticipantPopoverView : View
-         callSettings: Binding<CallSettings>,
+ 	public init(
-         showAllInfo: Bool = false,
+         participant: CallParticipant,
-         decorations: [VideoCallParticipantDecoration] = VideoCallParticipantDecoration.allCases
+         call: Call?,
-     )
+         popoverShown: Binding<Bool>,
- 	public func body(content: Content) -> some View
+         customView: (() -> CustomView)? = nil
- 
+     )
- @available(iOS, introduced: 13, obsoleted: 14) public struct LocalParticipantViewModifier_iOS13 : ViewModifier
+ 	public var body: some View
- 	public func body(content: Content) -> some View
+ 
- 
+ public struct CallParticipantMenuAction : Identifiable
- public struct MinimizedCallView : View
+ 	public var id: String
- 	public init(
+ 	public var title: String
-         viewFactory: Factory = DefaultViewFactory.shared,
+ 	public var requiredCapability: OwnCapability
-         viewModel: CallViewModel
+ 	public var iconName: String
-     )
+ 	public var action: (String) -> Void
- 	public var body: some View
+ 	public var confirmationPopup: ConfirmationPopup?
- 
+ 	public var isDestructive: Bool
- public struct ParticipantPopoverView : View
+ 
- 	public init(
+ public struct ConfirmationPopup
-         participant: CallParticipant,
+ 	public var title: String
-         call: Call?,
+ 	public var message: String?
-         popoverShown: Binding<Bool>,
+ 	public var buttonTitle: String
-         customView: (() -> CustomView)? = nil
+ 	public init(
-     )
+         title: String,
- 	public var body: some View
+         message: String?,
- 
+         buttonTitle: String
- public struct CallParticipantMenuAction : Identifiable
+     )
- 	public var id: String
+ 
- 	public var title: String
+ @available(iOS 14.0, *) public struct CallParticipantsInfoView : View
- 	public var requiredCapability: OwnCapability
+ 	public init(
- 	public var iconName: String
+         viewFactory: Factory = DefaultViewFactory.shared,
- 	public var action: (String) -> Void
+         callViewModel: CallViewModel
- 	public var confirmationPopup: ConfirmationPopup?
+     )
- 	public var isDestructive: Bool
+ 	public var body: some View
- public struct ConfirmationPopup
+ @available(iOS 14.0, *) public struct InviteParticipantsView : View
- 	public var title: String
+ 	public init(
- 	public var message: String?
+         viewFactory: Factory = DefaultViewFactory.shared,
- 	public var buttonTitle: String
+         inviteParticipantsShown: Binding<Bool>,
- 	public init(
+         currentParticipants: [CallParticipant],
-         title: String,
+         call: Call?
-         message: String?,
+     )
-         buttonTitle: String
+ 	public var body: some View
-     )
+ 
- 
+ public protocol UserListProvider : Sendable
- @available(iOS 14.0, *) public struct CallParticipantsInfoView : View
+ 	func loadNextUsers(pagination: Pagination) async throws -> [User]
- 	public init(
+ 
-         viewFactory: Factory = DefaultViewFactory.shared,
+ public struct Pagination : Sendable
-         callViewModel: CallViewModel
+ 	public let pageSize: Int
-     )
+ 	public let offset: Int
- 	public var body: some View
+ 
- 
+ public struct ParticipantsFullScreenLayout : View
- @available(iOS 14.0, *) public struct InviteParticipantsView : View
+ 	public init(
- 	public init(
+         viewFactory: Factory = DefaultViewFactory.shared,
-         viewFactory: Factory = DefaultViewFactory.shared,
+         participant: CallParticipant,
-         inviteParticipantsShown: Binding<Bool>,
+         call: Call?,
-         currentParticipants: [CallParticipant],
+         frame: CGRect,
-         call: Call?
+         onChangeTrackVisibility: @escaping @MainActor(CallParticipant, Bool) -> Void
...
- public protocol UserListProvider : Sendable
+ public struct ParticipantsGridLayout : View
- 	func loadNextUsers(pagination: Pagination) async throws -> [User]
+ 	public init(
- 
+         viewFactory: Factory = DefaultViewFactory.shared,
- public struct Pagination : Sendable
+         call: Call?,
- 	public let pageSize: Int
+         participants: [CallParticipant],
- 	public let offset: Int
+         availableFrame: CGRect,
- 
+         onChangeTrackVisibility: @escaping @MainActor(CallParticipant, Bool) -> Void
- public struct ParticipantsFullScreenLayout : View
+     )
- 	public init(
+ 	public var body: some View
-         viewFactory: Factory = DefaultViewFactory.shared,
+ 
-         participant: CallParticipant,
+ public struct ParticipantsSpotlightLayout : View
-         call: Call?,
+ 	public init(
-         frame: CGRect,
+         viewFactory: Factory = DefaultViewFactory.shared,
-         onChangeTrackVisibility: @escaping @MainActor(CallParticipant, Bool) -> Void
+         participant: CallParticipant,
-     )
+         call: Call?,
- 	public var body: some View
+         participants: [CallParticipant],
- 
+         frame: CGRect,
- public struct ParticipantsGridLayout : View
+         innerItemSpace: CGFloat = 8,
- 	public init(
+         onChangeTrackVisibility: @escaping @MainActor(CallParticipant, Bool) -> Void
-         viewFactory: Factory = DefaultViewFactory.shared,
+     )
-         call: Call?,
+ 	public var body: some View
-         participants: [CallParticipant],
+ 
-         availableFrame: CGRect,
+ public struct ReconnectionView : View
-         onChangeTrackVisibility: @escaping @MainActor(CallParticipant, Bool) -> Void
+ 	public init(
-     )
+         viewModel: CallViewModel,
- 	public var body: some View
+         viewFactory: Factory = DefaultViewFactory.shared
- 
+     )
- public struct ParticipantsSpotlightLayout : View
+ 	public var body: some View
- 	public init(
+ 
-         viewFactory: Factory = DefaultViewFactory.shared,
+ public struct RecordingView : View
-         participant: CallParticipant,
+ 	public init()
-         call: Call?,
+ 	public var body: some View
-         participants: [CallParticipant],
+ 
-         frame: CGRect,
+ public struct BroadcastPickerView : UIViewRepresentable
-         innerItemSpace: CGFloat = 8,
+ 	public init(preferredExtension: String, size: CGFloat = 30)
-         onChangeTrackVisibility: @escaping @MainActor(CallParticipant, Bool) -> Void
+ 	public func makeUIView(context: Context) -> some UIView
-     )
+ 	public func updateUIView(_ uiView: UIViewType, context: Context)
- 	public var body: some View
+ 
- 
+ public struct ScreenSharingView : View
- public struct ReconnectionView : View
+ 	public init(
- 	public init(
+         viewModel: CallViewModel,
-         viewModel: CallViewModel,
+         screenSharing: ScreenSharingSession,
-         viewFactory: Factory = DefaultViewFactory.shared
+         availableFrame: CGRect,
-     )
+         innerItemSpace: CGFloat = 8,
- 	public var body: some View
+         isZoomEnabled: Bool = true
- 
+     ) where Factory == DefaultViewFactory
- public struct RecordingView : View
+ 	public init(
- 	public init()
+         viewModel: CallViewModel,
- 	public var body: some View
+         screenSharing: ScreenSharingSession,
- 
+         availableFrame: CGRect,
- public struct BroadcastPickerView : UIViewRepresentable
+         innerItemSpace: CGFloat = 8,
- 	public init(preferredExtension: String, size: CGFloat = 30)
+         viewFactory: Factory,
- 	public func makeUIView(context: Context) -> some UIView
+         isZoomEnabled: Bool = true
- 	public func updateUIView(_ uiView: UIViewType, context: Context)
+     )
- 
+ 	public var body: some View
- public struct ScreenSharingView : View
+ 
- 	public init(
+ public struct ScreenshareIconView : View
-         viewModel: CallViewModel,
+ 	public init(viewModel: CallViewModel, size: CGFloat = 44)
-         screenSharing: ScreenSharingSession,
+ 	public var body: some View
-         availableFrame: CGRect,
+ 
-         innerItemSpace: CGFloat = 8,
+ @available(iOS 14.0, *) public struct BroadcastIconView : View
-         isZoomEnabled: Bool = true
+ 	public init(
-     ) where Factory == DefaultViewFactory
+         viewModel: CallViewModel,
- 	public init(
+         preferredExtension: String,
-         viewModel: CallViewModel,
+         size: CGFloat = 44
-         screenSharing: ScreenSharingSession,
+     )
-         availableFrame: CGRect,
+ 	public var body: some View
-         innerItemSpace: CGFloat = 8,
+ 
-         viewFactory: Factory,
+ public struct VideoParticipantsView : View
-         isZoomEnabled: Bool = true
+ 	public init(
-     )
+         viewFactory: Factory = DefaultViewFactory.shared,
- 	public var body: some View
+         viewModel: CallViewModel,
- 
+         availableFrame: CGRect,
- public struct ScreenshareIconView : View
+         onChangeTrackVisibility: @escaping @MainActor(CallParticipant, Bool) -> Void
- 	public init(viewModel: CallViewModel, size: CGFloat = 44)
+     )
- @available(iOS 14.0, *) public struct BroadcastIconView : View
+ public enum VideoCallParticipantDecoration : Hashable, CaseIterable
- 	public init(
+ 	case options
-         viewModel: CallViewModel,
+ 	case speaking
-         preferredExtension: String,
+ 
-         size: CGFloat = 44
+ public struct VideoCallParticipantModifier : ViewModifier
-     )
+ 	public init(
- 	public var body: some View
+         participant: CallParticipant,
- 
+         call: Call?,
- public struct VideoParticipantsView : View
+         availableFrame: CGRect,
- 	public init(
+         ratio: CGFloat,
-         viewFactory: Factory = DefaultViewFactory.shared,
+         showAllInfo: Bool,
-         viewModel: CallViewModel,
+         decorations: [VideoCallParticipantDecoration] = VideoCallParticipantDecoration.allCases
-         availableFrame: CGRect,
+     )
-         onChangeTrackVisibility: @escaping @MainActor(CallParticipant, Bool) -> Void
+ 	public func body(content: Content) -> some View
-     )
+ 
- 	public var body: some View
+ extension View
- 
+ 	@ViewBuilder
- public enum VideoCallParticipantDecoration : Hashable, CaseIterable
+     public func applyDecorationModifierIfRequired<Modifier: ViewModifier>(
- 	case options
+         _ modifier: @autoclosure () -> Modifier,
- 	case speaking
+         decoration: VideoCallParticipantDecoration,
- 
+         availableDecorations: Set<VideoCallParticipantDecoration>
- public struct VideoCallParticipantModifier : ViewModifier
+     ) -> some View
- 	public init(
+ 
-         participant: CallParticipant,
+ @MainActor public struct VideoCallParticipantOptionsModifier : ViewModifier
-         call: Call?,
+ 	public var participant: CallParticipant
-         availableFrame: CGRect,
+ 	public var call: Call?
-         ratio: CGFloat,
+ 	public init(
-         showAllInfo: Bool,
+         participant: CallParticipant,
-         decorations: [VideoCallParticipantDecoration] = VideoCallParticipantDecoration.allCases
+         call: Call?
...
- extension View
+ public struct VideoCallParticipantSpeakingModifier : ViewModifier
- 	@ViewBuilder
+ 	public var participant: CallParticipant
-     public func applyDecorationModifierIfRequired<Modifier: ViewModifier>(
+ 	public var participantCount: Int
-         _ modifier: @autoclosure () -> Modifier,
+ 	public init(
-         decoration: VideoCallParticipantDecoration,
+         participant: CallParticipant,
-         availableDecorations: Set<VideoCallParticipantDecoration>
+         participantCount: Int
-     ) -> some View
+     )
- 
+ 	public func body(content: Content) -> some View
- @MainActor public struct VideoCallParticipantOptionsModifier : ViewModifier
+ 
- 	public var participant: CallParticipant
+ public struct VideoCallParticipantView : View
- 	public var call: Call?
+ 	public init(
- 	public init(
+         viewFactory: Factory = DefaultViewFactory.shared,
-         call: Call?
+         id: String? = nil,
-     )
+         availableFrame: CGRect,
- 	public func body(content: Content) -> some View
+         contentMode: UIView.ContentMode,
- 
+         edgesIgnoringSafeArea: Edge.Set = .all,
- public struct VideoCallParticipantSpeakingModifier : ViewModifier
+         customData: [String: RawJSON],
- 	public var participant: CallParticipant
+         call: Call?
- 	public var participantCount: Int
+     )
- 	public init(
+ 	public var body: some View
-         participant: CallParticipant,
+ 
-         participantCount: Int
+ public struct ParticipantInfoView : View
-     )
+ 	public init(
- 	public func body(content: Content) -> some View
+         participant: CallParticipant,
- 
+         isPinned: Bool,
- public struct VideoCallParticipantView : View
+         maxHeight: Float = 14
- 	public init(
+     )
-         viewFactory: Factory = DefaultViewFactory.shared,
+ 	public var body: some View
-         participant: CallParticipant,
+ 
-         id: String? = nil,
+ public struct SoundIndicator : View
-         availableFrame: CGRect,
+ 	public init(participant: CallParticipant)
-         contentMode: UIView.ContentMode,
+ 	public var body: some View
-         edgesIgnoringSafeArea: Edge.Set = .all,
+ 
-         customData: [String: RawJSON],
+ public struct PopoverButton : View
-         call: Call?
+ 	public init(title: String, popoverShown: Binding<Bool>, action: @escaping () -> Void)
-     )
+ 	public var body: some View
- 	public var body: some View
+ 
- 
+ public struct LocalVideoView : View
- public struct ParticipantInfoView : View
+ 	public init(
- 	public init(
+         viewFactory: Factory = DefaultViewFactory.shared,
-         isPinned: Bool,
+         idSuffix: String = "local",
-         maxHeight: Float = 14
+         callSettings: CallSettings,
-     )
+         call: Call?,
- 	public var body: some View
+         availableFrame: CGRect
- 
+     )
- public struct SoundIndicator : View
+ 	public var body: some View
- 	public init(participant: CallParticipant)
+ 
- 	public var body: some View
+ public class VideoRenderer : RTCMTLVideoView
- 
+ 	override public init(frame: CGRect)
- public struct PopoverButton : View
+ 	override public var hash: Int
- 	public init(title: String, popoverShown: Binding<Bool>, action: @escaping () -> Void)
+ 	public func add(track: RTCVideoTrack)
- 	public var body: some View
+ 	override public func layoutSubviews()
- 
+ 	override public func willMove(toWindow newWindow: UIWindow?)
- public struct LocalVideoView : View
+ 	override public func willMove(toSuperview newSuperview: UIView?)
- 	public init(
+ 
-         viewFactory: Factory = DefaultViewFactory.shared,
+ extension VideoRenderer
-         participant: CallParticipant,
+ 	public func handleViewRendering(
-         idSuffix: String = "local",
+         for participant: CallParticipant,
-         callSettings: CallSettings,
+         onTrackSizeUpdate: @escaping (CGSize, CallParticipant) -> Void
-         call: Call?,
+     )
-         availableFrame: CGRect
+ 
-     )
+ public struct VideoRendererView : UIViewRepresentable
- 	public var body: some View
+ 	public init(
- 
+         id: String,
- public class VideoRenderer : RTCMTLVideoView
+         size: CGSize,
- 	override public init(frame: CGRect)
+         contentMode: UIView.ContentMode = .scaleAspectFill,
- 	override public var hash: Int
+         showVideo: Bool = true,
- 	public func add(track: RTCVideoTrack)
+         handleRendering: @escaping (VideoRenderer) -> Void
- 	override public func layoutSubviews()
+     )
- 	override public func willMove(toWindow newWindow: UIWindow?)
+ 	public static func dismantleUIView(
- 	override public func willMove(toSuperview newSuperview: UIView?)
+         _ uiView: VideoRenderer,
- 
+         coordinator: Coordinator
- extension VideoRenderer
+     )
- 	public func handleViewRendering(
+ 	public func makeUIView(context: Context) -> VideoRenderer
-         for participant: CallParticipant,
+ 	public func updateUIView(_ uiView: VideoRenderer, context: Context)
-         onTrackSizeUpdate: @escaping (CGSize, CallParticipant) -> Void
+ 	public func makeCoordinator() -> Coordinator
-     )
+ 
- 
+ extension View
- public struct VideoRendererView : UIViewRepresentable
+ 	@ViewBuilder
- 	public init(
+     public func onCallEnded(
-         id: String,
+         presentationValidator: @escaping (Call?) -> Bool = { _ in true },
-         size: CGSize,
+         @ViewBuilder _ content: @escaping (Call?, @escaping () -> Void) -> some View
-         contentMode: UIView.ContentMode = .scaleAspectFill,
+     ) -> some View
-         showVideo: Bool = true,
+ 
-         handleRendering: @escaping (VideoRenderer) -> Void
+ extension View
-     )
+ 	@ViewBuilder
- 	public static func dismantleUIView(
+     public func presentParticipantEventsNotification(
-         _ uiView: VideoRenderer,
+         viewModel: CallViewModel
-         coordinator: Coordinator
+     ) -> some View
-     )
+ 
- 	public func makeUIView(context: Context) -> VideoRenderer
+ extension View
- 	public func updateUIView(_ uiView: VideoRenderer, context: Context)
+ 	@ViewBuilder
- 	public func makeCoordinator() -> Coordinator
+     @MainActor
- 
+     public func presentParticipantListView<Factory: ViewFactory>(
- extension View
+         @ObservedObject viewModel: CallViewModel,
- 	@ViewBuilder
+         viewFactory: Factory = DefaultViewFactory.shared
-     public func onCallEnded(
+     ) -> some View
-         presentationValidator: @escaping (Call?) -> Bool = { _ in true },
+ 
-         @ViewBuilder _ content: @escaping (Call?, @escaping () -> Void) -> some View
+ extension View
-     ) -> some View
+ 	@ViewBuilder
- 
+     public func alignedToReadableContentGuide() -> some View
- extension View
+ 
- 	@ViewBuilder
+ public protocol SnapshotTriggering
-     public func presentParticipantEventsNotification(
+ 	var binding: Binding<Bool>
-         viewModel: CallViewModel
+ 	var publisher: AnyPublisher<Bool, Never>
-     ) -> some View
+ 	func capture()
...
-     @MainActor
+     public func snapshot(
-     public func presentParticipantListView<Factory: ViewFactory>(
+         trigger: SnapshotTriggering,
-         @ObservedObject viewModel: CallViewModel,
+         snapshotHandler: @escaping (UIImage) -> Void
-         viewFactory: Factory = DefaultViewFactory.shared
+     ) -> some View
-     ) -> some View
+ 
- 
+ @MainActor open class CallViewModel : ObservableObject
- extension View
+ 	@Published public private(set) var call: Call?
- 	@ViewBuilder
+ 	@Published public var callingState: CallingState
-     public func alignedToReadableContentGuide() -> some View
+ 	public var error: Error?
- 
+ 	@Published public var toast: Toast?
- public protocol SnapshotTriggering
+ 	@Published public var errorAlertShown
- 	var binding: Binding<Bool>
+ 	@Published public var participantsShown
- 	var publisher: AnyPublisher<Bool, Never>
+ 	@Published public var moreControlsShown
- 	func capture()
+ 	@Published public var outgoingCallMembers
- 
+ 	@Published public private(set) var callParticipants
- extension View
+ 	@Published public var participantEvent: ParticipantEvent?
- 	@ViewBuilder
+ 	@Published public internal(set) var callSettings: CallSettings
-     public func snapshot(
+ 	@Published public var isMinimized
-         trigger: SnapshotTriggering,
+ 	@Published public var localVideoPrimary
-         snapshotHandler: @escaping (UIImage) -> Void
+ 	@Published public var hideUIElements
-     ) -> some View
+ 	@Published public var blockedUsers
- 
+ 	@Published public var recordingState: RecordingState
- @MainActor open class CallViewModel : ObservableObject
+ 	@Published public private(set) var participantsLayout: ParticipantsLayout
- 	@Published public private(set) var call: Call?
+ 	@Published public var isPictureInPictureEnabled
- 	@Published public var callingState: CallingState
+ 	public var localParticipant: CallParticipant?
- 	public var error: Error?
+ 	public var noiseCancellationAudioFilter: AudioFilter?
- 	@Published public var toast: Toast?
+ 	public var participants: [CallParticipant]
- 	@Published public var errorAlertShown
+ 	public var participantAutoLeavePolicy: ParticipantAutoLeavePolicy
- 	@Published public var participantsShown
+ 	public init(
- 	@Published public var moreControlsShown
+         participantsLayout: ParticipantsLayout = .grid,
- 	@Published public var outgoingCallMembers
+         callSettings: CallSettings? = nil
- 	@Published public private(set) var callParticipants
+     )
- 	@Published public var participantEvent: ParticipantEvent?
+ 	public func toggleCameraEnabled()
- 	@Published public internal(set) var callSettings: CallSettings
+ 	public func toggleMicrophoneEnabled()
- 	@Published public var isMinimized
+ 	public func toggleCameraPosition()
- 	@Published public var localVideoPrimary
+ 	public func toggleAudioOutput()
- 	@Published public var hideUIElements
+ 	public func toggleSpeaker()
- 	@Published public var blockedUsers
+ 	public func startCall(
- 	@Published public var recordingState: RecordingState
+         callType: String,
- 	@Published public private(set) var participantsLayout: ParticipantsLayout
+         callId: String,
- 	@Published public var isPictureInPictureEnabled
+         members: [Member],
- 	public var localParticipant: CallParticipant?
+         ring: Bool = false,
- 	public var noiseCancellationAudioFilter: AudioFilter?
+         maxDuration: Int? = nil,
- 	public var participants: [CallParticipant]
+         maxParticipants: Int? = nil,
- 	public var participantAutoLeavePolicy: ParticipantAutoLeavePolicy
+         startsAt: Date? = nil,
- 	public init(
+         backstage: BackstageSettingsRequest? = nil,
-         participantsLayout: ParticipantsLayout = .grid,
+         customData: [String: RawJSON]? = nil,
-         callSettings: CallSettings? = nil
+         video: Bool? = nil
- 	public func toggleCameraEnabled()
+ 	public func joinCall(
- 	public func toggleMicrophoneEnabled()
+         callType: String,
- 	public func toggleCameraPosition()
+         callId: String,
- 	public func toggleAudioOutput()
+         customData: [String: RawJSON]? = nil
- 	public func toggleSpeaker()
+     )
- 	public func startCall(
+ 	public func enterLobby(
-         members: [Member],
+         members: [Member]
-         ring: Bool = false,
+     )
-         maxDuration: Int? = nil,
+ 	public func acceptCall(
-         maxParticipants: Int? = nil,
+         callType: String,
-         startsAt: Date? = nil,
+         callId: String,
-         backstage: BackstageSettingsRequest? = nil,
+         customData: [String: RawJSON]? = nil
-         customData: [String: RawJSON]? = nil,
+     )
-         video: Bool? = nil
+ 	public func rejectCall(
-     )
+         callType: String,
- 	public func joinCall(
+         callId: String
-         callType: String,
+     )
-         callId: String,
+ 	public func changeTrackVisibility(for participant: CallParticipant, isVisible: Bool)
-         customData: [String: RawJSON]? = nil
+ 	public func updateTrackSize(_ trackSize: CGSize, for participant: CallParticipant)
-     )
+ 	public func startScreensharing(type: ScreensharingType)
- 	public func enterLobby(
+ 	public func stopScreensharing()
-         callType: String,
+ 	public func hangUp()
-         callId: String,
+ 	public func setVideoFilter(_ videoFilter: VideoFilter?)
-         members: [Member]
+ 	public func update(participantsLayout: ParticipantsLayout)
-     )
+ 	public func setActiveCall(_ call: Call?)
- 	public func acceptCall(
+ 	public func update(participantsSortComparators: [StreamSortComparator<CallParticipant>])
-         callType: String,
+ 
-         callId: String,
+ public enum CallingState : Equatable
-         customData: [String: RawJSON]? = nil
+ 	case idle
-     )
+ 	case lobby(LobbyInfo)
- 	public func rejectCall(
+ 	case incoming(IncomingCall)
-         callType: String,
+ 	case outgoing
-         callId: String
+ 	case joining
-     )
+ 	case inCall
- 	public func changeTrackVisibility(for participant: CallParticipant, isVisible: Bool)
+ 	case reconnecting
- 	public func updateTrackSize(_ trackSize: CGSize, for participant: CallParticipant)
+ 
- 	public func startScreensharing(type: ScreensharingType)
+ public struct LobbyInfo : Equatable
- 	public func stopScreensharing()
+ 	public let callId: String
- 	public func hangUp()
+ 	public let callType: String
- 	public func setVideoFilter(_ videoFilter: VideoFilter?)
+ 	public let participants: [Member]
- 	public func update(participantsLayout: ParticipantsLayout)
+ 
- 	public func setActiveCall(_ call: Call?)
+ public enum ParticipantsLayout
- 	public func update(participantsSortComparators: [StreamSortComparator<CallParticipant>])
+ 	case grid
- 	public func update(participantsSortComparators: @escaping StreamSortComparator<CallParticipant>)
+ 	case spotlight
- 
+ 	case fullScreen
- public enum CallingState : Equatable
+ 
- 	case idle
+ public struct CallBackground : View
- 	case lobby(LobbyInfo)
+ 	public init(imageURL: URL? = nil)
- 	case incoming(IncomingCall)
+ 	public var body: some View
- 	case outgoing
+ 
- 	case joining
+ public struct CallConnectingView : View
- 	case inCall
+ 	public var outgoingCallMembers: [Member]
- 	case reconnecting
+ 	public var title: String
- 
+ 	public var callControls: CallControls
- public struct LobbyInfo : Equatable
+ 	public var callTopView: CallTopView
- 	public let callId: String
+ 	public init(
- 	public let callType: String
+         viewFactory: Factory = DefaultViewFactory.shared,
- 	public let participants: [Member]
+         outgoingCallMembers: [Member],
- 
+         title: String,
- public enum ParticipantsLayout
+         callControls: CallControls,
- 	case grid
+         callTopView: CallTopView
- 	case spotlight
+     )
- 	case fullScreen
+ 	public var body: some View
- public struct CallBackground : View
+ @available(iOS 14.0, *) public struct IncomingCallView : View
- 	public init(imageURL: URL? = nil)
+ 	public init(
- 	public var body: some View
+         viewFactory: Factory = DefaultViewFactory.shared,
- 
+         callInfo: IncomingCall,
- public struct CallConnectingView : View
+         onCallAccepted: @escaping (String) -> Void,
- 	public var outgoingCallMembers: [Member]
+         onCallRejected: @escaping (String) -> Void
- 	public var title: String
+     )
- 	public var callControls: CallControls
+ 	public var body: some View
- 	public var callTopView: CallTopView
+ 
- 	public init(
+ @MainActor public class IncomingViewModel : ObservableObject
-         viewFactory: Factory = DefaultViewFactory.shared,
+ 	public private(set) var callInfo: IncomingCall
-         outgoingCallMembers: [Member],
+ 	public init(callInfo: IncomingCall)
-         title: String,
+ 
-         callControls: CallControls,
+ public struct JoiningCallView : View
-         callTopView: CallTopView
+ 	public init(
-     )
+         viewFactory: Factory = DefaultViewFactory.shared,
- 	public var body: some View
+         callTopView: CallTopView,
- 
+         callControls: CallControls
- @available(iOS 14.0, *) public struct IncomingCallView : View
+     )
- 	public init(
+ 	public var body: some View
-         viewFactory: Factory = DefaultViewFactory.shared,
+ 
-         callInfo: IncomingCall,
+ public struct MicrophoneCheckView : View
-         onCallAccepted: @escaping (String) -> Void,
+ 	public init(
-         onCallRejected: @escaping (String) -> Void
+         audioLevels: [Float],
-     )
+         microphoneOn: Bool,
- 	public var body: some View
+         isSilent: Bool,
- 
+         isPinned: Bool,
- @MainActor public class IncomingViewModel : ObservableObject
+         maxHeight: Float = 14
- 	public private(set) var callInfo: IncomingCall
+     )
- 	public init(callInfo: IncomingCall)
+ 	public var body: some View
- public struct JoiningCallView : View
+ public struct AudioVolumeIndicator : View
-         viewFactory: Factory = DefaultViewFactory.shared,
+         audioLevels: [Float],
-         callTopView: CallTopView,
+         maxHeight: Float = 14,
-         callControls: CallControls
+         minValue: Float,
-     )
+         maxValue: Float
- 	public var body: some View
+     )
- 
+ 	public var body: some View
- public struct MicrophoneCheckView : View
+ 
- 	public init(
+ public final class MicrophoneChecker : ObservableObject
-         audioLevels: [Float],
+ 	@Published public private(set) var audioLevels: [Float]
-         microphoneOn: Bool,
+ 	public init(
-         isSilent: Bool,
+         valueLimit: Int = 3
-         isPinned: Bool,
+     )
-         maxHeight: Float = 14
+ 	public var isSilent: Bool
-     )
+ 	public func startListening(ignoreActiveCall: Bool = false) async
- 	public var body: some View
+ 	public func stopListening() async
- public struct AudioVolumeIndicator : View
+ public struct OutgoingCallView : View
-         audioLevels: [Float],
+         viewFactory: Factory = DefaultViewFactory.shared,
-         maxHeight: Float = 14,
+         outgoingCallMembers: [Member],
-         minValue: Float,
+         callTopView: CallTopView,
-         maxValue: Float
+         callControls: CallControls
...
- public final class MicrophoneChecker : ObservableObject
+ @available(iOS 14.0, *) public struct LobbyView : View
- 	@Published public private(set) var audioLevels: [Float]
+ 	public init(
- 	public init(
+         viewFactory: Factory = DefaultViewFactory.shared,
-         valueLimit: Int = 3
+         viewModel: LobbyViewModel? = nil,
-     )
+         callId: String,
- 	public var isSilent: Bool
+         callType: String,
- 	public func startListening(ignoreActiveCall: Bool = false) async
+         callSettings: Binding<CallSettings>,
- 	public func stopListening() async
+         onJoinCallTap: @escaping () -> Void,
- 
+         onCloseLobby: @escaping () -> Void
- public struct OutgoingCallView : View
+     )
- 	public init(
+ 	public var body: some View
-         viewFactory: Factory = DefaultViewFactory.shared,
+ 
-         outgoingCallMembers: [Member],
+ @MainActor public class LobbyViewModel : ObservableObject, @unchecked Sendable
-         callTopView: CallTopView,
+ 	@Published public var viewfinderImage: Image?
-         callControls: CallControls
+ 	@Published public var participants
-     )
+ 	public init(callType: String, callId: String)
- 	public var body: some View
+ 	public func startCamera(front: Bool)
- 
+ 	public func stopCamera()
- @available(iOS 14.0, *) public struct LobbyView : View
+ 	public func cleanUp()
- 	public init(
+ 
-         viewFactory: Factory = DefaultViewFactory.shared,
+ @propertyWrapper @available(iOS, introduced: 13, obsoleted: 14) public struct BackportStateObject : DynamicProperty
-         viewModel: LobbyViewModel? = nil,
+ 	public var wrappedValue: ObjectType
-         callId: String,
+ 	public var projectedValue: ObservedObject<ObjectType>.Wrapper
-         callType: String,
+ 	public init(wrappedValue thunk: @autoclosure @escaping () -> ObjectType)
-         callSettings: Binding<CallSettings>,
+ 	public mutating func update()
-         onJoinCallTap: @escaping () -> Void,
+ 
-         onCloseLobby: @escaping () -> Void
+ @propertyWrapper @available(iOS, introduced: 13, obsoleted: 14) public struct PublishedObject
-     )
+ 	public static subscript<EnclosingSelf: ObservableObject>(
- 	public var body: some View
+         _enclosingInstance observed: EnclosingSelf,
- 
+         wrapped wrappedKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Value>,
- @MainActor public class LobbyViewModel : ObservableObject, @unchecked Sendable
+         storage storageKeyPath: ReferenceWritableKeyPath<EnclosingSelf, PublishedObject>
- 	@Published public var viewfinderImage: Image?
+     ) -> Value where EnclosingSelf.ObjectWillChangePublisher == ObservableObjectPublisher
- 	@Published public var participants
+ 
- 	public init(callType: String, callId: String)
+ @available(iOS, introduced: 13, obsoleted: 14) public struct IncomingCallView_iOS13 : View
- 	public func startCamera(front: Bool)
+ 	public init(
- 	public func stopCamera()
+         viewFactory: Factory = DefaultViewFactory.shared,
- 	public func cleanUp()
+         callInfo: IncomingCall,
- 
+         onCallAccepted: @escaping (String) -> Void,
- @propertyWrapper @available(iOS, introduced: 13, obsoleted: 14) public struct BackportStateObject : DynamicProperty
+         onCallRejected: @escaping (String) -> Void
- 	public var wrappedValue: ObjectType
+     )
- 	public var projectedValue: ObservedObject<ObjectType>.Wrapper
+ 	public var body: some View
- 	public init(wrappedValue thunk: @autoclosure @escaping () -> ObjectType)
+ 
- 	public mutating func update()
+ @available(iOS, introduced: 13, obsoleted: 14) public struct LobbyView_iOS13 : View
- 
+ 	public init(
- @propertyWrapper @available(iOS, introduced: 13, obsoleted: 14) public struct PublishedObject
+         viewFactory: Factory = DefaultViewFactory.shared,
- 	public static subscript<EnclosingSelf: ObservableObject>(
+         callViewModel: CallViewModel,
-         _enclosingInstance observed: EnclosingSelf,
+         callId: String,
-         wrapped wrappedKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Value>,
+         callType: String,
-         storage storageKeyPath: ReferenceWritableKeyPath<EnclosingSelf, PublishedObject>
+         callSettings: Binding<CallSettings>,
-     ) -> Value where EnclosingSelf.ObjectWillChangePublisher == ObservableObjectPublisher
+         onJoinCallTap: @escaping () -> Void,
- 
+         onCloseLobby: @escaping () -> Void
- @available(iOS, introduced: 13, obsoleted: 14) public struct IncomingCallView_iOS13 : View
+     )
- 	public init(
+ 	public var body: some View
-         viewFactory: Factory = DefaultViewFactory.shared,
+ 
-         callInfo: IncomingCall,
+ @available(iOS, introduced: 13, obsoleted: 14) public struct CallContainer_iOS13 : View
-         onCallAccepted: @escaping (String) -> Void,
+ 	public init(
-         onCallRejected: @escaping (String) -> Void
+         viewFactory: Factory = DefaultViewFactory.shared,
-     )
+         viewModel: CallViewModel
- 	public var body: some View
+     )
- 
+ 	public var body: some View
- @available(iOS, introduced: 13, obsoleted: 14) public struct LobbyView_iOS13 : View
+ 
- 	public init(
+ public struct Colors
-         viewFactory: Factory = DefaultViewFactory.shared,
+ 	public init()
-         callViewModel: CallViewModel,
+ 	public var text
-         callId: String,
+ 	public var accentRed
-         callType: String,
+ 	public var accentGreen
-         callSettings: Binding<CallSettings>,
+ 	public var accentBlue
-         onJoinCallTap: @escaping () -> Void,
+ 	public var tintColor
-         onCloseLobby: @escaping () -> Void
+ 	public var lightGray
-     )
+ 	public var secondaryButton
- 	public var body: some View
+ 	public var hangUpIconColor
- 
+ 	public var textInverted
- @available(iOS, introduced: 13, obsoleted: 14) public struct CallContainer_iOS13 : View
+ 	public var onlineIndicatorColor
- 	public init(
+ 	public var whiteSmoke
-         viewFactory: Factory = DefaultViewFactory.shared,
+ 	public var white
-         viewModel: CallViewModel
+ 	public var background: UIColor
-     )
+ 	public var background1: UIColor
- 	public var body: some View
+ 	public var textLowEmphasis: UIColor
- 
+ 	public var callBackground: UIColor
- public struct Colors
+ 	public var participantBackground: UIColor
- 	public init()
+ 	public var lobbyBackground: Color
- 	public var text
+ 	public var lobbySecondaryBackground: Color
- 	public var accentRed
+ 	public var primaryButtonBackground: Color
- 	public var accentGreen
+ 	public var callPulsingColor
- 	public var accentBlue
+ 	public var callControlsBackground
- 	public var tintColor
+ 	public var livestreamBackground
- 	public var lightGray
+ 	public var livestreamCallControlsColor
- 	public var secondaryButton
+ 	public var participantSpeakingHighlightColor
- 	public var hangUpIconColor
+ 	public var participantInfoBackgroundColor
- 	public var textInverted
+ 	public var callDurationColor: UIColor
- 	public var onlineIndicatorColor
+ 	public var goodConnectionQualityIndicatorColor
- 	public var whiteSmoke
+ 	public var badConnectionQualityIndicatorColor
- 	public var white
+ 	public var activeSecondaryCallControl
- 	public var background: UIColor
+ 	public var inactiveCallControl
- 	public var background1: UIColor
+ 
- 	public var textLowEmphasis: UIColor
+ public struct Fonts
- 	public var callBackground: UIColor
+ 	public init()
- 	public var participantBackground: UIColor
+ 	public var caption1
- 	public var lobbyBackground: Color
+ 	public var footnoteBold
- 	public var lobbySecondaryBackground: Color
+ 	public var footnote
- 	public var primaryButtonBackground: Color
+ 	public var subheadline
- 	public var callPulsingColor
+ 	public var subheadlineBold
- 	public var callControlsBackground
+ 	public var body
- 	public var livestreamBackground
+ 	public var bodyBold
- 	public var livestreamCallControlsColor
+ 	public var bodyItalic
- 	public var participantSpeakingHighlightColor
+ 	public var headline
- 	public var participantInfoBackgroundColor
+ 	public var headlineBold
- 	public var callDurationColor: UIColor
+ 	public var title
- 	public var goodConnectionQualityIndicatorColor
+ 	public var title2
- 	public var badConnectionQualityIndicatorColor
+ 	public var title3
- 	public var activeSecondaryCallControl
+ 	public var emoji
- 	public var inactiveCallControl
+ 
- 
+ public class Images
- public struct Fonts
+ 	public init()
- 	public init()
+ 	public var videoTurnOn
- 	public var caption1
+ 	public var videoTurnOff
- 	public var footnoteBold
+ 	public var micTurnOn
- 	public var footnote
+ 	public var micTurnOff
- 	public var subheadline
+ 	public var speakerOn
- 	public var subheadlineBold
+ 	public var speakerOff
- 	public var body
+ 	public var toggleCamera
- 	public var bodyBold
+ 	public var hangup
- 	public var bodyItalic
+ 	public var acceptCall
- 	public var headline
+ 	public var participants
- 	public var headlineBold
+ 	public var xmark
- 	public var title
+ 	public var searchIcon
- 	public var title2
+ 	public var searchCloseIcon
- 	public var title3
+ 	public var recordIcon
- 	public var emoji
+ 	public var secureCallIcon
- 
+ 	public var participantsIcon
- public class Images
+ 	public var layoutSelectorIcon
- 	public init()
+ 	public var screenshareIcon
- 	public var videoTurnOn
+ 
- 	public var videoTurnOff
+ @available(iOS 14.0, *) public struct LivestreamPlayer : View
- 	public var micTurnOn
+ 	public enum JoinPolicy
- 	public var micTurnOff
+ 		case none
- 	public var speakerOn
+ 		case auto
- 	public var speakerOff
+ 	public init(
- 	public var toggleCamera
+         viewFactory: Factory = DefaultViewFactory.shared,
- 	public var hangup
+         type: String,
- 	public var acceptCall
+         id: String,
- 	public var participants
+         muted: Bool = false,
- 	public var xmark
+         showParticipantCount: Bool = true,
- 	public var searchIcon
+         joinPolicy: JoinPolicy = .auto,
- 	public var searchCloseIcon
+         showsLeaveCallButton: Bool = false,
- 	public var recordIcon
+         onFullScreenStateChange: ((Bool) -> Void)? = nil
- 	public var secureCallIcon
+     )
- 	public var participantsIcon
+ 	public var body: some View
- 	public var layoutSelectorIcon
+ 
- 	public var screenshareIcon
+ public enum CallEvent : Sendable
- 
+ 	case incoming(IncomingCall)
- @available(iOS 14.0, *) public struct LivestreamPlayer : View
+ 	case accepted(CallEventInfo)
- 	public enum JoinPolicy
+ 	case rejected(CallEventInfo)
- 		case none
+ 	case ended(CallEventInfo)
- 		case auto
+ 	case userBlocked(CallEventInfo)
- 	public init(
+ 	case userUnblocked(CallEventInfo)
-         viewFactory: Factory = DefaultViewFactory.shared,
+ 	case sessionStarted(CallSessionResponse)
-         type: String,
+ 
-         id: String,
+ public enum CallEventAction : Sendable
-         muted: Bool = false,
+ 	case accept
-         showParticipantCount: Bool = true,
+ 	case reject
-         joinPolicy: JoinPolicy = .auto,
+ 	case cancel
-         showsLeaveCallButton: Bool = false,
+ 	case end
-         onFullScreenStateChange: ((Bool) -> Void)? = nil
+ 	case block
-     )
+ 	case unblock
- 	public var body: some View
+ 
- 
+ public struct CallEventInfo : Event, Sendable
- public enum CallEvent : Sendable
+ 	public let callCid: String
- 	case incoming(IncomingCall)
+ 	public let user: User?
- 	case accepted(CallEventInfo)
+ 	public let action: CallEventAction
- 	case rejected(CallEventInfo)
+ 	public var callId: String
- 	case ended(CallEventInfo)
+ 	public var type: String
- 	case userBlocked(CallEventInfo)
+ 
- 	case userUnblocked(CallEventInfo)
+ public class CallEventsHandler
- 	case sessionStarted(CallSessionResponse)
+ 	public init()
- 
+ 	public func checkForCallEvents(from event: VideoEvent) -> CallEvent?
- public enum CallEventAction : Sendable
+ 	public func checkForParticipantEvents(from event: VideoEvent) -> ParticipantEvent?
- 	case accept
+ 
- 	case reject
+ public struct ParticipantEvent : Sendable
- 	case cancel
+ 	public let id: String
- 	case end
+ 	public let action: ParticipantAction
- 	case block
+ 	public let user: String
- 	case unblock
+ 	public let imageURL: URL?
- public struct CallEventInfo : Event, Sendable
+ public enum ParticipantAction : Sendable
- 	public let callCid: String
+ 	case join
- 	public let user: User?
+ 	case leave
- 	public let action: CallEventAction
+ 	public var display: String
- 	public var callId: String
+ 
- 	public var type: String
+ public struct IncomingCall : Identifiable, Sendable, Equatable
- 
+ 	public static func == (lhs: IncomingCall, rhs: IncomingCall) -> Bool
- public class CallEventsHandler
+ 	public let id: String
- 	public init()
+ 	public let caller: User
- 	public func checkForCallEvents(from event: VideoEvent) -> CallEvent?
+ 	public let type: String
- 	public func checkForParticipantEvents(from event: VideoEvent) -> ParticipantEvent?
+ 	public let members: [Member]
- 
+ 	public let timeout: TimeInterval
- public struct ParticipantEvent : Sendable
+ 	public let video: Bool
- 	public let id: String
+ 	public init(
- 	public let action: ParticipantAction
+         id: String,
- 	public let user: String
+         caller: User,
- 	public let imageURL: URL?
+         type: String,
- 
+         members: [Member],
- public enum ParticipantAction : Sendable
+         timeout: TimeInterval,
- 	case join
+         video: Bool = false
- 	case leave
+     )
- 	public var display: String
+ 
- 
+ public struct Toast : Equatable
- public struct IncomingCall : Identifiable, Sendable, Equatable
+ 	public var style: ToastStyle
- 	public static func == (lhs: IncomingCall, rhs: IncomingCall) -> Bool
+ 	public var message: String
- 	public let id: String
+ 	public var placement: ToastPlacement
- 	public let caller: User
+ 	public var duration: Double
- 	public let type: String
+ 	public init(
- 	public let members: [Member]
+         style: ToastStyle,
- 	public let timeout: TimeInterval
+         message: String,
- 	public let video: Bool
+         placement: ToastPlacement = .top,
- 	public init(
+         duration: Double = 2.5
-         id: String,
+     )
-         caller: User,
+ 
-         type: String,
+ public enum ToastPlacement
-         members: [Member],
+ 	case top
-         timeout: TimeInterval,
+ 	case bottom
-         video: Bool = false
+ 
-     )
+ public indirect enum ToastStyle : Equatable
- 
+ 	case error
- public struct Toast : Equatable
+ 	case warning
- 	public var style: ToastStyle
+ 	case success
- 	public var message: String
+ 	case info
- 	public var placement: ToastPlacement
+ 	case custom(baseStyle: ToastStyle, icon: AnyView)
- 	public var duration: Double
+ 	public static func == (
- 	public init(
+         lhs: ToastStyle,
-         style: ToastStyle,
+         rhs: ToastStyle
-         message: String,
+     ) -> Bool
-         placement: ToastPlacement = .top,
+ 
-         duration: Double = 2.5
+ public class Sounds
-     )
+ 	public var bundle: Bundle
- 
+ 	public var outgoingCallSound
- public enum ToastPlacement
+ 	public var incomingCallSound
- 	case top
+ 	public init()
- 	case bottom
+ 
- 
+ public class StreamVideoUI
- public indirect enum ToastStyle : Equatable
+ 	public convenience init(
- 	case error
+         apiKey: String,
- 	case warning
+         user: User,
- 	case success
+         token: UserToken,
- 	case info
+         videoConfig: VideoConfig = VideoConfig(),
- 	case custom(baseStyle: ToastStyle, icon: AnyView)
+         tokenProvider: @escaping UserTokenProvider,
- 	public static func == (
+         appearance: Appearance = Appearance(),
-         lhs: ToastStyle,
+         utils: Utils = UtilsKey.currentValue
-         rhs: ToastStyle
+     )
-     ) -> Bool
+ 	public init(
- 
+         streamVideo: StreamVideo,
- public class Sounds
+         appearance: Appearance = Appearance(),
- 	public var bundle: Bundle
+         utils: Utils = UtilsKey.currentValue
- 	public var outgoingCallSound
+     )
- 	public var incomingCallSound
+ 	public func connect() async throws
- 	public init()
+ 
- 
+ public class Utils
- public class StreamVideoUI
+ 	public var userListProvider: UserListProvider?
- 	public convenience init(
+ 	public var callSoundsPlayer: CallSoundsPlayer
-         apiKey: String,
+ 	public init(
-         user: User,
+         userListProvider: UserListProvider? = nil,
-         token: UserToken,
+         callSoundsPlayer: CallSoundsPlayer = .init()
-         videoConfig: VideoConfig = VideoConfig(),
+     )
-         tokenProvider: @escaping UserTokenProvider,
+ 
-         appearance: Appearance = Appearance(),
+ public enum UtilsKey : InjectionKey
-         utils: Utils = UtilsKey.currentValue
+ 	public static var currentValue: Utils
-     )
+ 
- 	public init(
+ extension InjectedValues
-         streamVideo: StreamVideo,
+ 	public var utils: Utils
-         appearance: Appearance = Appearance(),
+ 
-         utils: Utils = UtilsKey.currentValue
+ public struct StreamLazyImage : View
-     )
+ 	public var imageURL: URL?
- 	public func connect() async throws
+ 	public var contentMode: ContentMode
- 
+ 	public var placeholder: () -> Placeholder
- public class Utils
+ 	public init(
- 	public var userListProvider: UserListProvider?
+         imageURL: URL?,
- 	public var callSoundsPlayer: CallSoundsPlayer
+         contentMode: ContentMode = .fill,
- 	public init(
+         placeholder: @escaping () -> Placeholder
-         userListProvider: UserListProvider? = nil,
+     )
-         callSoundsPlayer: CallSoundsPlayer = .init()
+ 	public var body: some View
-     )
+ 
- 
+ @available(iOS, deprecated: 14.0) @available(macOS, deprecated: 11.0) @available(tvOS, deprecated: 14.0) @available(watchOS, deprecated: 7.0) public extension View
- public enum UtilsKey : InjectionKey
+ 	@ViewBuilder
- 	public static var currentValue: Utils
+     @_disfavoredOverload
- 
+     func onChange<Value: Equatable>(
- extension InjectedValues
+         of value: Value,
- 	public var utils: Utils
+         perform action: @escaping (Value) -> Void
- 
+     ) -> some View
- public struct StreamLazyImage : View
+ 
- 	public var imageURL: URL?
+ open class CallSoundsPlayer
- 	public var contentMode: ContentMode
+ 	public init()
- 	public var placeholder: () -> Placeholder
+ 	open func playIncomingCallSound()
- 	public init(
+ 	open func playOutgoingCallSound()
-         imageURL: URL?,
+ 	open func stopOngoingSound()
-         contentMode: ContentMode = .fill,
+ 
-         placeholder: @escaping () -> Placeholder
+ extension View
-     )
+ 	public func cornerRadius(
- 	public var body: some View
+         _ radius: CGFloat,
- 
+         corners: UIRectCorner,
- @available(iOS, deprecated: 14.0) @available(macOS, deprecated: 11.0) @available(tvOS, deprecated: 14.0) @available(watchOS, deprecated: 7.0) public extension View
+         backgroundColor: Color = .clear,
- 	@ViewBuilder
+         extendToSafeArea: Bool = false
-     @_disfavoredOverload
+     ) -> some View
-     func onChange<Value: Equatable>(
+ 
-         of value: Value,
+ public struct TopLeftView : View
-         perform action: @escaping (Value) -> Void
+ 	public init(content: @escaping () -> Content)
-     ) -> some View
+ 	public var body: some View
- open class CallSoundsPlayer
+ public struct TopRightView : View
- 	public init()
+ 	public init(content: @escaping () -> Content)
- 	open func playIncomingCallSound()
+ 	public var body: some View
- 	open func playOutgoingCallSound()
+ 
- 	open func stopOngoingSound()
+ public struct BottomRightView : View
- 
+ 	public init(content: @escaping () -> Content)
- extension View
+ 	public var body: some View
- 	public func cornerRadius(
+ 
-         _ radius: CGFloat,
+ public struct BottomView : View
-         corners: UIRectCorner,
+ 	public init(content: @escaping () -> Content)
-         backgroundColor: Color = .clear,
+ 	public var body: some View
-         extendToSafeArea: Bool = false
+ 
-     ) -> some View
+ extension RTCCVPixelBuffer
- 
+ 	public func bufferSizeForCroppingAndScaling(to size: CGSize) -> Int
- public struct TopLeftView : View
+ 
- 	public init(content: @escaping () -> Content)
+ extension View
- 	public var body: some View
+ 	@ViewBuilder
- 
+     public func onReceive<P>(
- public struct TopRightView : View
+         _ publisher: P?,
- 	public init(content: @escaping () -> Content)
+         perform action: @escaping (P.Output) -> Void
- 	public var body: some View
+     ) -> some View where P: Publisher, P.Failure == Never
- public struct BottomRightView : View
+ public class Formatters
- 	public init(content: @escaping () -> Content)
+ 	public var mediaDuration: MediaDurationFormatter
- 	public var body: some View
+ 
- 
+ extension InjectedValues
- public struct BottomView : View
+ 	public var formatters: Formatters
- 	public init(content: @escaping () -> Content)
+ 
- 	public var body: some View
+ public protocol MediaDurationFormatter
- 
+ 	func format(_ time: TimeInterval) -> String?
- extension RTCCVPixelBuffer
+ 
- 	public func bufferSizeForCroppingAndScaling(to size: CGSize) -> Int
+ open class StreamMediaDurationFormatter : MediaDurationFormatter
- 
+ 	public var withHoursDateComponentsFormatter: DateComponentsFormatter
- extension View
+ 	public var withoutHoursDateComponentsFormatter: DateComponentsFormatter
- 	@ViewBuilder
+ 	public init()
-     public func onReceive<P>(
+ 	open func format(_ time: TimeInterval) -> String?
-         _ publisher: P?,
+ 
-         perform action: @escaping (P.Output) -> Void
+ public struct DragHandleView : View
-     ) -> some View where P: Publisher, P.Failure == Never
+ 	public init()
- 
+ 	public var body: some View
- public class Formatters
+ 
- 	public var mediaDuration: MediaDurationFormatter
+ extension View
- 
+ 	@ViewBuilder
- extension InjectedValues
+     public func halfSheet<Content>(
- 	public var formatters: Formatters
+         isPresented: Binding<Bool>,
- 
+         onDismiss: (() -> Void)? = nil,
- public protocol MediaDurationFormatter
+         @ViewBuilder content: @escaping () -> Content
- 	func format(_ time: TimeInterval) -> String?
+     ) -> some View where Content: View
- open class StreamMediaDurationFormatter : MediaDurationFormatter
+ public struct CallIconView : View
- 	public var withHoursDateComponentsFormatter: DateComponentsFormatter
+ 	public init(icon: Image, size: CGFloat = 64, iconStyle: CallIconStyle = .primary)
- 	public var withoutHoursDateComponentsFormatter: DateComponentsFormatter
+ 	public var body: some View
- 	public init()
+ 
- 	open func format(_ time: TimeInterval) -> String?
+ public struct CallIconStyle
- 
+ 	public let backgroundColor: Color
- public struct DragHandleView : View
+ 	public let foregroundColor: Color
- 	public init()
+ 	public let opacity: CGFloat
- 	public var body: some View
+ 
- 
+ extension CallIconStyle
- extension View
+ 	public static let primary
- 	@ViewBuilder
+ 	public static let secondary
-     public func halfSheet<Content>(
+ 	public static let secondaryActive
-         isPresented: Binding<Bool>,
+ 	public static let transparent
-         onDismiss: (() -> Void)? = nil,
+ 	public static let disabled
-         @ViewBuilder content: @escaping () -> Content
+ 	public static let destructive
-     ) -> some View where Content: View
+ 
- 
+ public struct OnlineIndicatorView : View
- public struct CallIconView : View
+ 	public var body: some View
- 	public init(icon: Image, size: CGFloat = 64, iconStyle: CallIconStyle = .primary)
+ 
- 	public var body: some View
+ extension Image
- 
+ 	public func customizable() -> some View
- public struct CallIconStyle
+ 
- 	public let backgroundColor: Color
+ public protocol KeyboardReadable
- 	public let foregroundColor: Color
+ 	var keyboardWillChangePublisher: AnyPublisher<Bool, Never>
- 	public let opacity: CGFloat
+ 	var keyboardDidChangePublisher: AnyPublisher<Bool, Never>
- 
+ 	var keyboardHeight: AnyPublisher<CGFloat, Never>
- extension CallIconStyle
+ 
- 	public static let primary
+ extension KeyboardReadable
- 	public static let secondary
+ 	public var keyboardWillChangePublisher: AnyPublisher<Bool, Never>
- 	public static let secondaryActive
+ 	public var keyboardDidChangePublisher: AnyPublisher<Bool, Never>
- 	public static let transparent
+ 	public var keyboardHeight: AnyPublisher<CGFloat, Never>
- 	public static let disabled
+ 
- 	public static let destructive
+ public struct HideKeyboardOnTapGesture : ViewModifier
- 
+ 	public init(shouldAdd: Bool, onTapped: (() -> Void)? = nil)
- public struct OnlineIndicatorView : View
+ 	public func body(content: Content) -> some View
- 	public var body: some View
+ 
- 
+ extension View
- extension Image
+ 	public func streamAccessibility(value: String) -> some View
- 	public func customizable() -> some View
+ 
- 
+ public enum BackgroundType
- public protocol KeyboardReadable
+ 	case circle
- 	var keyboardWillChangePublisher: AnyPublisher<Bool, Never>
+ 	case rectangle
- 	var keyboardDidChangePublisher: AnyPublisher<Bool, Never>
+ 	case none
- 	var keyboardHeight: AnyPublisher<CGFloat, Never>
+ 
- 
+ extension Image
- extension KeyboardReadable
+ 	public func applyCallButtonStyle(
- 	public var keyboardWillChangePublisher: AnyPublisher<Bool, Never>
+         color: Color,
- 	public var keyboardDidChangePublisher: AnyPublisher<Bool, Never>
+         backgroundType: BackgroundType = .circle,
- 	public var keyboardHeight: AnyPublisher<CGFloat, Never>
+         size: CGFloat = 64
- 
+     ) -> some View
- public struct HideKeyboardOnTapGesture : ViewModifier
+ 	@ViewBuilder
- 	public init(shouldAdd: Bool, onTapped: (() -> Void)? = nil)
+     func background(for type: BackgroundType) -> some View
- 	public func body(content: Content) -> some View
+ 
- 
+ extension View
- extension View
+ 	public func adjustVideoFrame(to width: CGFloat, ratio: CGFloat = 0.5) -> some View
- 	public func streamAccessibility(value: String) -> some View
+ 
- 
+ extension View
- public enum BackgroundType
+ 	@ViewBuilder
- 	case circle
+     public func enablePictureInPicture(_ isActive: Bool) -> some View
- 	case rectangle
+ 
- 	case none
+ public struct ToastView : View
- 
+ 	public init(
- extension Image
+         style: ToastStyle,
- 	public func applyCallButtonStyle(
+         message: String,
-         color: Color,
+         onCancelTapped: @escaping (() -> Void)
-         backgroundType: BackgroundType = .circle,
+     )
-         size: CGFloat = 64
+ 	public var body: some View
-     ) -> some View
+ 
- 	@ViewBuilder
+ public struct ToastModifier : ViewModifier
-     func background(for type: BackgroundType) -> some View
+ 	public init(toast: Binding<Toast?>)
- 
+ 	public func body(content: Content) -> some View
- extension View
+ 
- 	public func adjustVideoFrame(to width: CGFloat, ratio: CGFloat = 0.5) -> some View
+ extension View
- 
+ 	public func toastView(toast: Binding<Toast?>) -> some View
- extension View
+ 
- 	@ViewBuilder
+ public struct UserAvatar : View
-     public func enablePictureInPicture(_ isActive: Bool) -> some View
+ 	public var imageURL: URL?
- 
+ 	public var size: CGFloat
- public struct ToastView : View
+ 	public var failbackProvider: FailbackProvider
- 	public init(
+ 	public init(imageURL: URL?, size: CGFloat, failbackProvider: (() -> Failback)?)
-         style: ToastStyle,
+ 	public var body: some View
-         message: String,
+ 
-         onCancelTapped: @escaping (() -> Void)
+ public struct UserAvatarViewOptions
-     )
+ 	public var size: CGFloat
- 	public var body: some View
+ 	public var failbackProvider: (() -> AnyView)?
- 
+ 	public init(
- public struct ToastModifier : ViewModifier
+         size: CGFloat,
- 	public init(toast: Binding<Toast?>)
+         failbackProvider: (() -> AnyView)? = nil
- 	public func body(content: Content) -> some View
+     )
- extension View
+ extension Alert
- 	public func toastView(toast: Binding<Toast?>) -> some View
+ 	public static var defaultErrorAlert: Alert
- public struct UserAvatar : View
+ @MainActor public protocol ViewFactory : AnyObject
- 	public var imageURL: URL?
+ 	func makeCallControlsView(viewModel: CallViewModel) -> CallControlsViewType
- 	public var size: CGFloat
+ 	func makeOutgoingCallView(viewModel: CallViewModel) -> OutgoingCallViewType
- 	public var failbackProvider: FailbackProvider
+ 	func makeJoiningCallView(viewModel: CallViewModel) -> JoiningCallViewType
- 	public init(imageURL: URL?, size: CGFloat, failbackProvider: (() -> Failback)?)
+ 	func makeIncomingCallView(viewModel: CallViewModel, callInfo: IncomingCall) -> IncomingCallViewType
- 	public var body: some View
+ 	func makeWaitingLocalUserView(viewModel: CallViewModel) -> WaitingLocalUserViewType
- 
+ 	func makeVideoParticipantsView(
- public struct UserAvatarViewOptions
+         viewModel: CallViewModel,
- 	public var size: CGFloat
+         availableFrame: CGRect,
- 	public var failbackProvider: (() -> AnyView)?
+         onChangeTrackVisibility: @escaping @MainActor(CallParticipant, Bool) -> Void
- 	public init(
+     ) -> ParticipantsViewType
-         size: CGFloat,
+ 	func makeVideoParticipantView(
-         failbackProvider: (() -> AnyView)? = nil
+         participant: CallParticipant,
-     )
+         id: String,
- 
+         availableFrame: CGRect,
- extension Alert
+         contentMode: UIView.ContentMode,
- 	public static var defaultErrorAlert: Alert
+         customData: [String: RawJSON],
- 
+         call: Call?
- @MainActor public protocol ViewFactory : AnyObject
+     ) -> ParticipantViewType
- 	func makeCallControlsView(viewModel: CallViewModel) -> CallControlsViewType
+ 	func makeVideoCallParticipantModifier(
- 	func makeOutgoingCallView(viewModel: CallViewModel) -> OutgoingCallViewType
+         participant: CallParticipant,
- 	func makeJoiningCallView(viewModel: CallViewModel) -> JoiningCallViewType
+         call: Call?,
- 	func makeIncomingCallView(viewModel: CallViewModel, callInfo: IncomingCall) -> IncomingCallViewType
+         availableFrame: CGRect,
- 	func makeWaitingLocalUserView(viewModel: CallViewModel) -> WaitingLocalUserViewType
+         ratio: CGFloat,
- 	func makeVideoParticipantsView(
+         showAllInfo: Bool
-         viewModel: CallViewModel,
+     ) -> ParticipantViewModifierType
-         availableFrame: CGRect,
+ 	func makeCallView(viewModel: CallViewModel) -> CallViewType
-         onChangeTrackVisibility: @escaping @MainActor(CallParticipant, Bool) -> Void
+ 	func makeMinimizedCallView(viewModel: CallViewModel) -> MinimizedCallViewType
-     ) -> ParticipantsViewType
+ 	func makeCallTopView(viewModel: CallViewModel) -> CallTopViewType
- 	func makeVideoParticipantView(
+ 	func makeParticipantsListView(
-         participant: CallParticipant,
+         viewModel: CallViewModel
-         id: String,
+     ) -> CallParticipantsListViewType
-         availableFrame: CGRect,
+ 	func makeScreenSharingView(
-         contentMode: UIView.ContentMode,
+         viewModel: CallViewModel,
-         customData: [String: RawJSON],
+         screensharingSession: ScreenSharingSession,
-         call: Call?
+         availableFrame: CGRect
-     ) -> ParticipantViewType
+     ) -> ScreenSharingViewType
- 	func makeVideoCallParticipantModifier(
+ 	func makeLobbyView(
-         participant: CallParticipant,
+         viewModel: CallViewModel,
-         call: Call?,
+         lobbyInfo: LobbyInfo,
-         availableFrame: CGRect,
+         callSettings: Binding<CallSettings>
-         ratio: CGFloat,
+     ) -> LobbyViewType
-         showAllInfo: Bool
+ 	func makeReconnectionView(viewModel: CallViewModel) -> ReconnectionViewType
-     ) -> ParticipantViewModifierType
+ 	func makeLocalParticipantViewModifier(
- 	func makeCallView(viewModel: CallViewModel) -> CallViewType
+         localParticipant: CallParticipant,
- 	func makeMinimizedCallView(viewModel: CallViewModel) -> MinimizedCallViewType
+         callSettings: Binding<CallSettings>,
- 	func makeCallTopView(viewModel: CallViewModel) -> CallTopViewType
+         call: Call?
- 	func makeParticipantsListView(
+     ) -> LocalParticipantViewModifierType
-         viewModel: CallViewModel
+ 	func makeUserAvatar(
-     ) -> CallParticipantsListViewType
+         _ user: User,
- 	func makeScreenSharingView(
+         with options: UserAvatarViewOptions
-         viewModel: CallViewModel,
+     ) -> UserAvatarViewType
-         screensharingSession: ScreenSharingSession,
+ 
-         availableFrame: CGRect
+ extension ViewFactory
-     ) -> ScreenSharingViewType
+ 	public func makeCallControlsView(viewModel: CallViewModel) -> some View
- 	func makeLobbyView(
+ 	public func makeOutgoingCallView(viewModel: CallViewModel) -> some View
-         viewModel: CallViewModel,
+ 	public func makeJoiningCallView(viewModel: CallViewModel) -> some View
-         lobbyInfo: LobbyInfo,
+ 	public func makeIncomingCallView(viewModel: CallViewModel, callInfo: IncomingCall) -> some View
-         callSettings: Binding<CallSettings>
+ 	public func makeWaitingLocalUserView(viewModel: CallViewModel) -> some View
-     ) -> LobbyViewType
+ 	public func makeVideoParticipantsView(
- 	func makeReconnectionView(viewModel: CallViewModel) -> ReconnectionViewType
+         viewModel: CallViewModel,
- 	func makeLocalParticipantViewModifier(
+         availableFrame: CGRect,
-         localParticipant: CallParticipant,
+         onChangeTrackVisibility: @escaping @MainActor(CallParticipant, Bool) -> Void
-         callSettings: Binding<CallSettings>,
+     ) -> some View
-         call: Call?
+ 	public func makeVideoParticipantView(
-     ) -> LocalParticipantViewModifierType
+         participant: CallParticipant,
- 	func makeUserAvatar(
+         id: String,
-         _ user: User,
+         availableFrame: CGRect,
-         with options: UserAvatarViewOptions
+         contentMode: UIView.ContentMode,
-     ) -> UserAvatarViewType
+         customData: [String: RawJSON],
- 
+         call: Call?
- extension ViewFactory
+     ) -> some View
- 	public func makeCallControlsView(viewModel: CallViewModel) -> some View
+ 	public func makeVideoCallParticipantModifier(
- 	public func makeOutgoingCallView(viewModel: CallViewModel) -> some View
+         participant: CallParticipant,
- 	public func makeJoiningCallView(viewModel: CallViewModel) -> some View
+         call: Call?,
- 	public func makeIncomingCallView(viewModel: CallViewModel, callInfo: IncomingCall) -> some View
+         availableFrame: CGRect,
- 	public func makeWaitingLocalUserView(viewModel: CallViewModel) -> some View
+         ratio: CGFloat,
- 	public func makeVideoParticipantsView(
+         showAllInfo: Bool
-         viewModel: CallViewModel,
+     ) -> some ViewModifier
-         availableFrame: CGRect,
+ 	public func makeCallView(viewModel: CallViewModel) -> some View
-         onChangeTrackVisibility: @escaping @MainActor(CallParticipant, Bool) -> Void
+ 	public func makeMinimizedCallView(viewModel: CallViewModel) -> some View
-     ) -> some View
+ 	public func makeCallTopView(viewModel: CallViewModel) -> some View
- 	public func makeVideoParticipantView(
+ 	public func makeParticipantsListView(
-         participant: CallParticipant,
+         viewModel: CallViewModel
-         id: String,
+     ) -> some View
-         availableFrame: CGRect,
+ 	public func makeScreenSharingView(
-         contentMode: UIView.ContentMode,
+         viewModel: CallViewModel,
-         customData: [String: RawJSON],
+         screensharingSession: ScreenSharingSession,
-         call: Call?
+         availableFrame: CGRect
- 	public func makeVideoCallParticipantModifier(
+ 	public func makeLobbyView(
-         participant: CallParticipant,
+         viewModel: CallViewModel,
-         call: Call?,
+         lobbyInfo: LobbyInfo,
-         availableFrame: CGRect,
+         callSettings: Binding<CallSettings>
-         ratio: CGFloat,
+     ) -> some View
-         showAllInfo: Bool
+ 	public func makeReconnectionView(viewModel: CallViewModel) -> some View
-     ) -> some ViewModifier
+ 	public func makeLocalParticipantViewModifier(
- 	public func makeCallView(viewModel: CallViewModel) -> some View
+         localParticipant: CallParticipant,
- 	public func makeMinimizedCallView(viewModel: CallViewModel) -> some View
+         callSettings: Binding<CallSettings>,
- 	public func makeCallTopView(viewModel: CallViewModel) -> some View
+         call: Call?
- 	public func makeParticipantsListView(
+     ) -> some ViewModifier
-         viewModel: CallViewModel
+ 	public func makeUserAvatar(
-     ) -> some View
+         _ user: User,
- 	public func makeScreenSharingView(
+         with options: UserAvatarViewOptions
-         viewModel: CallViewModel,
+     ) -> some View
-         screensharingSession: ScreenSharingSession,
+ 
-         availableFrame: CGRect
+ public final class DefaultViewFactory : ViewFactory, @unchecked Sendable
-     ) -> some View
+ 	public nonisolated static let shared
- 	public func makeLobbyView(
+ 
-         viewModel: CallViewModel,
+ @MainActor open class CallViewController : UIViewController
-         lobbyInfo: LobbyInfo,
+ 	public private(set) var viewModel: CallViewModel
-         callSettings: Binding<CallSettings>
+ 	public static func make(with viewModel: CallViewModel? = nil) -> CallViewController
-     ) -> some View
+ 	public convenience init()
- 	public func makeReconnectionView(viewModel: CallViewModel) -> some View
+ 	public init(viewModel: CallViewModel)
- 	public func makeLocalParticipantViewModifier(
+ 	@available(*, unavailable)
-         localParticipant: CallParticipant,
+     public required init?(coder: NSCoder)
-         callSettings: Binding<CallSettings>,
+ 	override open func viewDidLoad()
-         call: Call?
+ 	open func setupVideoView()
-     ) -> some ViewModifier
+ 	open func makeVideoView<Factory: ViewFactory>(with viewFactory: Factory) -> UIView
- 	public func makeUserAvatar(
+ 	public func startCall(callType: String, callId: String, members: [Member], ring: Bool = false)
-         _ user: User,
+ 
-         with options: UserAvatarViewOptions
+ extension UIView
-     ) -> some View
+ 	public func embed(_ subview: UIView, insets: NSDirectionalEdgeInsets = .zero)
- 
+ 	public func pinItem(anchors: [LayoutAnchorName] = [.top, .leading, .bottom, .trailing], to view: UIView)
- public final class DefaultViewFactory : ViewFactory, @unchecked Sendable
+ 	public func pinItem(anchors: [LayoutAnchorName] = [.top, .leading, .bottom, .trailing], to layoutGuide: UILayoutGuide)
- 	public nonisolated static let shared
+ 	public func pinItem(anchors: [LayoutAnchorName] = [.width, .height], to constant: CGFloat)
- 
+ 	public var withoutAutoresizingMaskConstraints: Self
- @MainActor open class CallViewController : UIViewController
+ 	func withAccessibilityIdentifier(identifier: String) -> Self
- 	public private(set) var viewModel: CallViewModel
+ 	var isVisible: Bool
- 	public static func make(with viewModel: CallViewModel? = nil) -> CallViewController
+ 	func setAnimatedly(hidden: Bool)
- 	public convenience init()
+ 	static func spacer(axis: NSLayoutConstraint.Axis) -> UIView
- 	public init(viewModel: CallViewModel)
+ 
- 	@available(*, unavailable)
+ public enum LayoutAnchorName
-     public required init?(coder: NSCoder)
+ 	case bottom
- 	override open func viewDidLoad()
+ 	case centerX
- 	open func setupVideoView()
+ 	case centerY
- 	open func makeVideoView<Factory: ViewFactory>(with viewFactory: Factory) -> UIView
+ 	case firstBaseline
- 	public func startCall(callType: String, callId: String, members: [Member], ring: Bool = false)
+ 	case height
- 
+ 	case lastBaseline
- extension UIView
+ 	case leading
- 	public func embed(_ subview: UIView, insets: NSDirectionalEdgeInsets = .zero)
+ 	case left
- 	public func pinItem(anchors: [LayoutAnchorName] = [.top, .leading, .bottom, .trailing], to view: UIView)
+ 	case right
- 	public func pinItem(anchors: [LayoutAnchorName] = [.top, .leading, .bottom, .trailing], to layoutGuide: UILayoutGuide)
+ 	case top
- 	public func pinItem(anchors: [LayoutAnchorName] = [.width, .height], to constant: CGFloat)
+ 	case trailing
- 	public var withoutAutoresizingMaskConstraints: Self
+ 	case width
- 	func withAccessibilityIdentifier(identifier: String) -> Self
+ === Sources Public API - End === 
- 	var isVisible: Bool
- 	func setAnimatedly(hidden: Bool)
- 	static func spacer(axis: NSLayoutConstraint.Axis) -> UIView
- 
- public enum LayoutAnchorName
- 	case bottom
- 	case centerX
- 	case centerY
- 	case firstBaseline
- 	case height
- 	case lastBaseline
- 	case leading
- 	case left
- 	case right
- 	case top
- 	case trailing
- 	case width
- === Sources Public API - End === 