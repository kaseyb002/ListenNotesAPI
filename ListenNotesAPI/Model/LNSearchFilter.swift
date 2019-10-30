import Foundation

public struct LNSearchFilter {
    
    /// Default is `.relevance`
    public var sortBy: SortBy = .relevance
    /// Default is `[.everything]`
    public var searchInFields: Set<Field> = [.everything]
    /// This must be `< maxMinuteLength` or `maxMinuteLength == nil`
    public var minMinuteLength: Int?
    /// This must be `> minMinuteLength` or `minMinuteLength == nil`
    public var maxMinuteLength: Int?
    /// This must be `< publishedBefore` or `publishedBefore == nil`
    public var publishedAfter: Date?
    /// This must be `> publishedAfter` or `publishedAfter == nil`
    public var publishedBefore: Date?
    /// Default is `.off`
    public var safeMode: SafeMode = .off
    /// Restrict scope to a specific language. See `getLanguages()` for full list.
    public var language: String?
    /// Restrict scope to specific genres
    public var genreIds = [Int]()
    /// Restrict scope to a specific podcast
    public var podcastId: String?
    
    public enum Field: String, CaseIterable {
        case everything
        case title
        case description
        case author
        case audio
    }
    
    public enum SortBy: Int {
        case relevance, mostRecent
    }
    
    public enum SafeMode: Int {
        case off, filterExplicit
    }
}
