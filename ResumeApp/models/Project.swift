struct Project : Codable, Equatable {
	let name = ""
	let description = ""
    
    static func == (lhs: Project, rhs: Project) -> Bool {
        return lhs.name == rhs.name &&
                lhs.description == rhs.description
    
    }
}
