import Foundation

public struct LNSearchFilter {
    
    /// Default is `.relevance`
    var sortBy: SortBy = .relevance
    /// Default is `[.everything]`
    var searchInFields: Set<Field> = [.everything]
    /// This must be `< maxMinuteLength` or `maxMinuteLength == nil`
    var minMinuteLength: Int?
    /// This must be `> minMinuteLength` or `minMinuteLength == nil`
    var maxMinuteLength: Int?
    /// This must be `< publishedBefore` or `publishedBefore == nil`
    var publishedAfter: Date?
    /// This must be `> publishedAfter` or `publishedAfter == nil`
    var publishedBefore: Date?
    /// Default is `.off`
    var safeMode: SafeMode = .off
    /// Restrict scope to a specific language. See `getLanguages()` for full list.
    var language: String?
    /// Restrict scope to specific genres
    var genreIds = [Int]()
    /// Restrict scope to a specific podcast
    var podcastId: String?
    
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
