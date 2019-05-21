import Vapor
import FluentSQLite


// Simple article model
final class Article: Codable {
    
    var id: UUID?
    var content: String
    
    init(content: String) {
        self.content = content
    }
    
}

extension Article: Content {}
extension Article: SQLiteUUIDModel {}
extension Article: Migration {}


