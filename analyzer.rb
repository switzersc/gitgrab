require "octokit"
require "active_support/core_ext/integer"
require "active_support/core_ext/time"
require "active_support/core_ext/date"
require "dotenv"

Dotenv.load

class Analyzer
  attr_reader :client

  def initialize
    @client = Octokit::Client.new(login: ENV["GITHUB_LOGIN"], password: ENV["GITHUB_PASSWORD"])
    @client.auto_paginate = true
  end

  def get_the_numbers(org)
    github_org = client.org(org)
    repos = client.repos org, sort: "updated", direction: "asc"
    count = repos.count

    numbers = {
        org_created: github_org.created_at,
        org_updated: github_org.updated_at,
        total_repos: count,
        updated_within_two_years: updated_within(repos, 24).count,
        updated_within_six_months: updated_within(repos, 6).count,
        pushed_within_two_years: pushed_within(repos, 24).count,
        pushed_within_six_months: pushed_within(repos, 6).count,
        not_pushed_in_two_years: (count - updated_within(repos, 24).count),
        percentage_actively_updated: (updated_within(repos, 24).count / count),
        percentage_actively_pushed: (updated_within(repos, 24).count / count),
        number_never_pushed: no_push(repos).count,
        number_without_license: repos_without_license(repos).count,
        number_with_license: repos_with_license(repos).count,
        percentage_without_license: (repos_without_license(repos).count / count),
        license_types: license_types(repos),
        longest_activity_repo: longest_activity_repo(repos).name,
        longest_activity_life_weeks: seconds_into_weeks(longest_activity_life(repos)),
        longest_activity_life_years: seconds_into_years(longest_activity_life(repos)),
        shortest_activity_repo: shortest_activity_repo(repos).name,
        shortest_activity_life_weeks: seconds_into_weeks(shortest_activity_life(repos)),
        shortest_activity_life_years: seconds_into_years(shortest_activity_life(repos)),
        number_activity_life_over_five_years: number_activity_life_over(repos, 5),
        number_activity_life_over_two_years: number_activity_life_over(repos, 2),
        number_activity_life_over_one_year: number_activity_life_over(repos, 1),
        number_activity_life_less_than_two_years: number_activity_life_under(repos, 2),
        number_activity_life_less_than_one_year: number_activity_life_under(repos, 1),
    }
    p numbers
  end

  def no_push(repos)
    repos.select { |r| r.pushed_at.nil?}
  end

  def updated_within(repos, months)
    repos.select { |r| r.updated_at >= months.months.ago }
  end

  # Find repos pushed within given number of years.
  # Must remove repos with no pushes.
  def pushed_within(repos, months)
    (repos - no_push(repos)).select { |r| r.pushed_at >= months.months.ago }
  end

  def repos_without_license(repos)
    repos.select{|r| r.license.nil? }
  end

  def repos_with_license(repos)
    repos.select{|r| !! r.license }
  end

  def license_types(repos)
    repos_with_license(repos).map{|r| [r.license.key, r.license.name]}.uniq
  end

  def longest_activity_repo(repos)
    repos.max do |a, b|
      activity_life(a) <=> activity_life(b)
    end
  end

  def longest_activity_life(repos)
    activity_life longest_activity_repo(repos)
  end

  def shortest_activity_repo(repos)
    repos.min do |a, b|
      activity_life(a) <=> activity_life(b)
    end
  end

  def shortest_activity_life(repos)
    activity_life shortest_activity_repo(repos)
  end

  def activity_life(repo)
    repo.updated_at - repo.created_at
  end

  def seconds_into_weeks(seconds)
    seconds / 60 / 60 / 24 / 7
  end

  def seconds_into_years(seconds)
    seconds_into_weeks(seconds) / 52
  end

  def number_activity_life_over(repos, years)
    repos.select do |r|
      seconds_into_years(activity_life(r)) > years
    end.count
  end

  def number_activity_life_under(repos, years)
    repos.select do |r|
      seconds_into_years(activity_life(r)) < years
    end.count
  end
end


# 682 repos owned by CodeForAmerica org

# 450 haven't been updated in 2 years (not commits but repo information)

# 2 have never been pushed to
# 576 haven't been pushed to in 2 years (commits)

# only 255 have a license. of those, these are the types of licenses:  [["mit", "MIT License"], ["other", "Other"], ["gpl-2.0", "GNU General Public License v2.0"], ["bsd-3-clause", "BSD 3-Clause \"New\" or \"Revised\" License"], ["apache-2.0", "Apache License 2.0"], ["gpl-3.0", "GNU General Public License v3.0"], ["bsd-2-clause", "BSD 2-Clause \"Simplified\" License"], ["isc", "ISC License"], ["unlicense", "The Unlicense"], ["cc0-1.0", "Creative Commons Zero v1.0 Universal"]]

