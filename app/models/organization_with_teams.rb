class OrganizationWithTeams < Organization
  attr_accessor :teams

  def owner?
    teams.any?(&:owners?)
  end
end
