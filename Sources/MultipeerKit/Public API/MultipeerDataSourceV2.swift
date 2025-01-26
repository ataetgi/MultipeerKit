import Foundation

@available(tvOS 17.0, *)
@available(OSX 15.0, *)
@available(iOS 17.0, *)
@Observable
public final class MultipeerDataSourceV2 {

    /// The underlying Multipeer transceiver.
    public let transceiver: MultipeerTransceiver

    /// Peers currently available for invitation, connection and data transmission.
    /// Marked `public private(set)` so external callers can read but not mutate directly.
    public private(set) var availablePeers: [Peer] = []

    public init(transceiver: MultipeerTransceiver) {
        self.transceiver = transceiver

        // Observe changes in available peers from the transceiver
        transceiver.availablePeersDidChange = { [weak self] peers in
            self?.availablePeers = peers
        }

        // Initialize with the current known peers
        self.availablePeers = transceiver.availablePeers
    }

}
