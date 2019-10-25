import Foundation

public struct LNSearchFilter {
    
    var sortBy: SortBy = .relevance
    var searchInFields: Set<Field> = [.everything]
    var minMinuteLength: Int?
    var maxMinuteLength: Int?
    var publishedAfter: Date?
    var publishedBefore: Date?
    var safeMode: SafeMode = .off
    var language: String?
    var genreIds = [Int]()
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
