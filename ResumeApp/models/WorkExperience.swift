struct WorkExperience : Codable, Equatable {
	var companyName = ""
	var date = ""
	var position = ""
    var toolsUsed = [String]()
	var summary = [String]()
	var project = [Project]()
	var additionalNotes = ""

    init() {}
    
	enum CodingKeys: String, CodingKey {
		case companyName = "company_name"
		case date = "date"
		case position = "position"
		case toolsUsed = "tools_used"
		case summary = "summary"
		case project = "project"
		case additionalNotes = "additional_notes"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		companyName = try values.decode(String.self, forKey: .companyName)
		date = try values.decode(String.self, forKey: .date)
		position = try values.decode(String.self, forKey: .position)
		toolsUsed = try values.decode([String].self, forKey: .toolsUsed)
		summary = try values.decode([String].self, forKey: .summary)
        project = try values.decodeIfPresent([Project].self, forKey: .project) ?? []
		additionalNotes = try values.decodeIfPresent(String.self, forKey: .additionalNotes) ?? ""
	}
    
    static func == (lhs: WorkExperience, rhs: WorkExperience) -> Bool {
        return lhs.companyName == rhs.companyName &&
                lhs.date == rhs.date &&
                lhs.position == rhs.position &&
                lhs.toolsUsed == rhs.toolsUsed &&
                lhs.summary == rhs.summary &&
                lhs.project == rhs.project &&
                lhs.additionalNotes == rhs.additionalNotes
    }
    

}
