require "octokit"
require "active_support/core_ext/integer"
require "active_support/core_ext/time"
require "active_support/core_ext/date"
require "dotenv"
require "csv"
require_relative "./org_analyzer"

Dotenv.load

class GithubRepoAnalyzer
  attr_reader :client, :org_names, :output_path

  def initialize(org_names: [], output_path: "github_data.csv")
    @client = Octokit::Client.new(login: ENV["GITHUB_LOGIN"], password: ENV["GITHUB_PASSWORD"])
    @client.auto_paginate = true
    @org_names = org_names
    @output_path = output_path
  end

  def get_the_numbers
    data = org_names.each_with_object([]) do |org_name, result|
      info = OrgAnalyzer.new(client, org_name).info
      result << info if info
    end

    write_to_csv(data)
  end

  private

  def write_to_csv(data)
    CSV.open(output_path, 'wb') do |csv|
      headers = data.first.keys
      csv << headers
      data.each do |row|
        csv << CSV::Row.new(row.keys, row.values).values_at(*headers)
      end
    end
  end
end


# 682 repos owned by CodeForAmerica org

# 450 haven't been updated in 2 years (not commits but repo information)

# 2 have never been pushed to
# 576 haven't been pushed to in 2 years (commits)

# only 255 have a license. of those, these are the types of licenses:  [["mit", "MIT License"], ["other", "Other"], ["gpl-2.0", "GNU General Public License v2.0"], ["bsd-3-clause", "BSD 3-Clause \"New\" or \"Revised\" License"], ["apache-2.0", "Apache License 2.0"], ["gpl-3.0", "GNU General Public License v3.0"], ["bsd-2-clause", "BSD 2-Clause \"Simplified\" License"], ["isc", "ISC License"], ["unlicense", "The Unlicense"], ["cc0-1.0", "Creative Commons Zero v1.0 Universal"]]

