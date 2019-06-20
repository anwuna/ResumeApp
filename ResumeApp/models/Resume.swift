struct Resume : Codable {
	var name = ""
	var summary = [String]()
    var skills = [String]()
    var workExperience = [WorkExperience]()
	var education = ""

	enum CodingKeys: String, CodingKey {

		case name = "name"
		case summary = "summary"
		case skills = "skills"
		case workExperience = "work_experience"
		case education = "education"
	}

    init() {}
    
    init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decode(String.self, forKey: .name)
		summary = try values.decode([String].self, forKey: .summary)
		skills = try values.decode([String].self, forKey: .skills)
		workExperience = try values.decode([WorkExperience].self, forKey: .workExperience)
		education = try values.decode(String.self, forKey: .education)
	}

}
