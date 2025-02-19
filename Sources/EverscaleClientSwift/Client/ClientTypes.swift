public enum TSDKClientErrorCode: Int, Codable {
    case NotImplemented = 1
    case InvalidHex = 2
    case InvalidBase64 = 3
    case InvalidAddress = 4
    case CallbackParamsCantBeConvertedToJson = 5
    case WebsocketConnectError = 6
    case WebsocketReceiveError = 7
    case WebsocketSendError = 8
    case HttpClientCreateError = 9
    case HttpRequestCreateError = 10
    case HttpRequestSendError = 11
    case HttpRequestParseError = 12
    case CallbackNotRegistered = 13
    case NetModuleNotInit = 14
    case InvalidConfig = 15
    case CannotCreateRuntime = 16
    case InvalidContextHandle = 17
    case CannotSerializeResult = 18
    case CannotSerializeError = 19
    case CannotConvertJsValueToJson = 20
    case CannotReceiveSpawnedResult = 21
    case SetTimerError = 22
    case InvalidParams = 23
    case ContractsAddressConversionFailed = 24
    case UnknownFunction = 25
    case AppRequestError = 26
    case NoSuchRequest = 27
    case CanNotSendRequestResult = 28
    case CanNotReceiveRequestResult = 29
    case CanNotParseRequestResult = 30
    case UnexpectedCallbackResponse = 31
    case CanNotParseNumber = 32
    case InternalError = 33
    case InvalidHandle = 34
    case LocalStorageError = 35
}

public enum TSDKAppRequestResultEnumTypes: String, Codable {
    case Error = "Error"
    case Ok = "Ok"
}

public struct TSDKClientError: Codable, Error {
    public var code: UInt32
    public var message: String
    public var data: AnyValue = [:].toAnyValue()

    public init(code: UInt32, message: String, data: AnyValue = [:].toAnyValue()) {
        self.code = code
        self.message = message
        self.data = data
    }
}

public struct TSDKClientConfig: Codable {
    public var network: TSDKNetworkConfig?
    public var crypto: TSDKCryptoConfig?
    public var abi: TSDKAbiConfig?
    public var boc: TSDKBocConfig?
    public var proofs: TSDKProofsConfig?
    /// For file based storage is a folder name where SDK will store its data. For browser based is a browser async storage key prefix. Default (recommended) value is "~/.tonclient" for native environments and ".tonclient" for web-browser.
    public var local_storage_path: String?

    public init(network: TSDKNetworkConfig? = nil, crypto: TSDKCryptoConfig? = nil, abi: TSDKAbiConfig? = nil, boc: TSDKBocConfig? = nil, proofs: TSDKProofsConfig? = nil, local_storage_path: String? = nil) {
        self.network = network
        self.crypto = crypto
        self.abi = abi
        self.boc = boc
        self.proofs = proofs
        self.local_storage_path = local_storage_path
    }
}

public struct TSDKNetworkConfig: Codable {
    /// DApp Server public address. For instance, for `net.ton.dev/graphql` GraphQL endpoint the server address will be net.ton.dev
    public var server_address: String?
    /// List of DApp Server addresses.
    /// Any correct URL format can be specified, including IP addresses This parameter is prevailing over `server_address`.
    public var endpoints: [String]?
    /// Deprecated.
    /// You must use `network.max_reconnect_timeout` that allows to specify maximum network resolving timeout.
    public var network_retries_count: Int8?
    /// Maximum time for sequential reconnections.
    /// Must be specified in milliseconds. Default is 120000 (2 min).
    public var max_reconnect_timeout: UInt32?
    /// Deprecated
    public var reconnect_timeout: UInt32?
    /// The number of automatic message processing retries that SDK performs in case of `Message Expired (507)` error - but only for those messages which local emulation was successful or failed with replay protection error.
    /// Default is 5.
    public var message_retries_count: Int8?
    /// Timeout that is used to process message delivery for the contracts which ABI does not include "expire" header. If the message is not delivered within the specified timeout the appropriate error occurs.
    /// Must be specified in milliseconds. Default is 40000 (40 sec).
    public var message_processing_timeout: UInt32?
    /// Maximum timeout that is used for query response.
    /// Must be specified in milliseconds. Default is 40000 (40 sec).
    public var wait_for_timeout: UInt32?
    /// Maximum time difference between server and client.
    /// If client's device time is out of sync and difference is more than the threshold then error will occur. Also an error will occur if the specified threshold is more than`message_processing_timeout/2`.
    /// Must be specified in milliseconds. Default is 15000 (15 sec).
    public var out_of_sync_threshold: UInt32?
    /// Maximum number of randomly chosen endpoints the library uses to broadcast a message.
    /// Default is 2.
    public var sending_endpoint_count: UInt8?
    /// Frequency of sync latency detection.
    /// Library periodically checks the current endpoint for blockchain data syncronization latency.
    /// If the latency (time-lag) is less then `NetworkConfig.max_latency`then library selects another endpoint.
    /// Must be specified in milliseconds. Default is 60000 (1 min).
    public var latency_detection_interval: UInt32?
    /// Maximum value for the endpoint's blockchain data syncronization latency (time-lag). Library periodically checks the current endpoint for blockchain data synchronization latency. If the latency (time-lag) is less then `NetworkConfig.max_latency` then library selects another endpoint.
    /// Must be specified in milliseconds. Default is 60000 (1 min).
    public var max_latency: UInt32?
    /// Default timeout for http requests.
    /// Is is used when no timeout specified for the request to limit the answer waiting time. If no answer received during the timeout requests ends witherror.
    /// Must be specified in milliseconds. Default is 60000 (1 min).
    public var query_timeout: UInt32?
    /// Access key to GraphQL API.
    /// At the moment is not used in production.
    public var access_key: String?

    public init(server_address: String? = nil, endpoints: [String]? = nil, network_retries_count: Int8? = nil, max_reconnect_timeout: UInt32? = nil, reconnect_timeout: UInt32? = nil, message_retries_count: Int8? = nil, message_processing_timeout: UInt32? = nil, wait_for_timeout: UInt32? = nil, out_of_sync_threshold: UInt32? = nil, sending_endpoint_count: UInt8? = nil, latency_detection_interval: UInt32? = nil, max_latency: UInt32? = nil, query_timeout: UInt32? = nil, access_key: String? = nil) {
        self.server_address = server_address
        self.endpoints = endpoints
        self.network_retries_count = network_retries_count
        self.max_reconnect_timeout = max_reconnect_timeout
        self.reconnect_timeout = reconnect_timeout
        self.message_retries_count = message_retries_count
        self.message_processing_timeout = message_processing_timeout
        self.wait_for_timeout = wait_for_timeout
        self.out_of_sync_threshold = out_of_sync_threshold
        self.sending_endpoint_count = sending_endpoint_count
        self.latency_detection_interval = latency_detection_interval
        self.max_latency = max_latency
        self.query_timeout = query_timeout
        self.access_key = access_key
    }
}

public struct TSDKCryptoConfig: Codable {
    /// Mnemonic dictionary that will be used by default in crypto functions. If not specified, 1 dictionary will be used.
    public var mnemonic_dictionary: UInt8?
    /// Mnemonic word count that will be used by default in crypto functions. If not specified the default value will be 12.
    public var mnemonic_word_count: UInt8?
    /// Derivation path that will be used by default in crypto functions. If not specified `m/44'/396'/0'/0/0` will be used.
    public var hdkey_derivation_path: String?

    public init(mnemonic_dictionary: UInt8? = nil, mnemonic_word_count: UInt8? = nil, hdkey_derivation_path: String? = nil) {
        self.mnemonic_dictionary = mnemonic_dictionary
        self.mnemonic_word_count = mnemonic_word_count
        self.hdkey_derivation_path = hdkey_derivation_path
    }
}

public struct TSDKAbiConfig: Codable {
    /// Workchain id that is used by default in DeploySet
    public var workchain: Int32?
    /// Message lifetime for contracts which ABI includes "expire" header. The default value is 40 sec.
    public var message_expiration_timeout: UInt32?
    /// Factor that increases the expiration timeout for each retry The default value is 1.5
    public var message_expiration_timeout_grow_factor: Float32?

    public init(workchain: Int32? = nil, message_expiration_timeout: UInt32? = nil, message_expiration_timeout_grow_factor: Float32? = nil) {
        self.workchain = workchain
        self.message_expiration_timeout = message_expiration_timeout
        self.message_expiration_timeout_grow_factor = message_expiration_timeout_grow_factor
    }
}

public struct TSDKBocConfig: Codable {
    /// Maximum BOC cache size in kilobytes.
    /// Default is 10 MB
    public var cache_max_size: UInt32?

    public init(cache_max_size: UInt32? = nil) {
        self.cache_max_size = cache_max_size
    }
}

public struct TSDKProofsConfig: Codable {
    /// Cache proofs in the local storage.
    /// Default is `true`. If this value is set to `true`, downloaded proofs and master-chain BOCs are saved into thepersistent local storage (e.g. file system for native environments or browser's IndexedDBfor the web); otherwise all the data is cached only in memory in current client's contextand will be lost after destruction of the client.
    public var cache_in_local_storage: Bool?

    public init(cache_in_local_storage: Bool? = nil) {
        self.cache_in_local_storage = cache_in_local_storage
    }
}

public struct TSDKBuildInfoDependency: Codable {
    /// Dependency name.
    /// Usually it is a crate name.
    public var name: String
    /// Git commit hash of the related repository.
    public var git_commit: String

    public init(name: String, git_commit: String) {
        self.name = name
        self.git_commit = git_commit
    }
}

public struct TSDKParamsOfAppRequest: Codable {
    /// Request ID.
    /// Should be used in `resolve_app_request` call
    public var app_request_id: UInt32
    /// Request describing data
    public var request_data: AnyValue

    public init(app_request_id: UInt32, request_data: AnyValue) {
        self.app_request_id = app_request_id
        self.request_data = request_data
    }
}

public struct TSDKAppRequestResult: Codable {
    public var type: TSDKAppRequestResultEnumTypes
    /// Error description
    public var text: String?
    /// Request processing result
    public var result: AnyValue?

    public init(type: TSDKAppRequestResultEnumTypes, text: String? = nil, result: AnyValue? = nil) {
        self.type = type
        self.text = text
        self.result = result
    }
}

public struct TSDKResultOfGetApiReference: Codable {
    public var api: AnyValue

    public init(api: AnyValue) {
        self.api = api
    }
}

public struct TSDKResultOfVersion: Codable {
    /// Core Library version
    public var version: String

    public init(version: String) {
        self.version = version
    }
}

public struct TSDKResultOfBuildInfo: Codable {
    /// Build number assigned to this build by the CI.
    public var build_number: UInt32
    /// Fingerprint of the most important dependencies.
    public var dependencies: [TSDKBuildInfoDependency]

    public init(build_number: UInt32, dependencies: [TSDKBuildInfoDependency]) {
        self.build_number = build_number
        self.dependencies = dependencies
    }
}

public struct TSDKParamsOfResolveAppRequest: Codable {
    /// Request ID received from SDK
    public var app_request_id: UInt32
    /// Result of request processing
    public var result: TSDKAppRequestResult

    public init(app_request_id: UInt32, result: TSDKAppRequestResult) {
        self.app_request_id = app_request_id
        self.result = result
    }
}

