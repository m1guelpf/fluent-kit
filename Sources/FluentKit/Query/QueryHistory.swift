import NIOConcurrencyHelpers

/// Holds the history of queries for a database
public final class QueryHistory: Sendable {
    /// The queries that were executed over a period of time
    public var queries: [DatabaseQuery] {
        get {
            self._queries.withLockedValue { $0 }
        }
        set {
            self._queries.withLockedValue { $0 = newValue }
        }
    }
    
    private let _queries: NIOLockedValueBox<[DatabaseQuery]>

    /// Create a new `QueryHistory` with no existing history
    public init() {
        self._queries = .init([])
    }

    func add(_ query: DatabaseQuery) {
        self._queries.withLockedValue {
            $0.append(query)
        }
    }
}
