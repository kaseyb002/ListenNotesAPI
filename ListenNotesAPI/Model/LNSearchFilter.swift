import Foundation

public struct LNSearchFilter {
    
    /// Default is `.relevance`
    var sortBy: SortBy = .relevance
    var searchInFields: Set<Field> = [.everything]
    var minMinuteLength: Int?
    var maxMinuteLength: Int?
    var publishedAfter: Date?
    var publishedBefore: Date?
    /// Default is `.off`
    var safeMode: SafeMode = .off
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
