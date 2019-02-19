class OrgAnalyzer
  attr_reader :client, :repos, :org, :org_name, :info, :count, :substantive_repos

  def initialize(client, org_name)
    @client = client
    @org_name = org_name
    @org = client.org(org_name)
    @repos = client.repos org_name, sort: "updated", direction: "asc"
    @count = repos.count
  rescue Octokit::NotFound
    @count = 0
    @info = nil
  end

  def info
    return nil unless count > 0

    @info = {
      org_name: org_name,
      org_created: org.created_at,
      org_updated: org.updated_at,
      total_repos: count,
      substantive_repos: substantive_repos.count,
      nonsubstantive_repos: number_of_nonsubstantive_repos,
      never_pushed: no_push.count,
      updated_within_two_years: updated_within(24).count,
      percentage_updated_two_years: percentage(updated_within(24).count, count),
      subst_updated_within_two_years: updated_within(24, substantive_repos).count,
      subst_percentage_updated_two_years: percentage(updated_within(24, substantive_repos).count, count),
      updated_within_six_months: updated_within(6).count,
      percentage_updated_six_months: percentage(updated_within(6).count, count),
      subst_updated_within_six_months: updated_within(6, substantive_repos).count,
      subst_percentage_updated_six_months: percentage(updated_within(6, substantive_repos).count, count),
      pushed_within_two_years: pushed_within(24).count,
      percentage_pushed_two_years: percentage(pushed_within(24).count, count),
      subst_pushed_within_two_years: pushed_within(24, substantive_repos).count,
      subst_percentage_pushed_two_years: percentage(pushed_within(24, substantive_repos).count, count),
      pushed_within_six_months: pushed_within(6).count,
      not_pushed_in_two_years: (count - updated_within(24).count),
      subst_pushed_within_six_months: pushed_within(6, substantive_repos).count,
      subst_not_pushed_in_two_years: (count - updated_within(24, substantive_repos).count),
      number_without_license: repos_without_license.count,
      number_with_license: repos_with_license.count,
      percentage_without_license: percentage(repos_without_license.count, count),
      subst_number_without_license: repos_without_license(substantive_repos).count,
      subst_number_with_license: repos_with_license(substantive_repos).count,
      subst_percentage_without_license: percentage(repos_without_license(substantive_repos).count, count),
      license_types: license_types,
      subst_license_types: license_types(substantive_repos),
      longest_activity_repo: longest_activity_repo.name,
      longest_activity_life_weeks: seconds_into_weeks(longest_activity_life),
      longest_activity_life_years: seconds_into_years(longest_activity_life),
      subst_longest_activity_repo: longest_activity_repo(substantive_repos).name,
      subst_longest_activity_life_weeks: seconds_into_weeks(longest_activity_life(substantive_repos)),
      subst_longest_activity_life_years: seconds_into_years(longest_activity_life(substantive_repos)),
      shortest_activity_repo: shortest_activity_repo.name,
      shortest_activity_life_weeks: seconds_into_weeks(shortest_activity_life),
      shortest_activity_life_years: seconds_into_years(shortest_activity_life),
      subst_shortest_activity_repo: shortest_activity_repo(substantive_repos).name,
      subst_shortest_activity_life_weeks: seconds_into_weeks(shortest_activity_life(substantive_repos)),
      subst_shortest_activity_life_years: seconds_into_years(shortest_activity_life(substantive_repos)),
      number_activity_life_over_five_years: number_activity_life_over(5),
      percentage_activity_life_over_five_years: percentage(number_activity_life_over(5), count),
      number_activity_life_over_two_years: number_activity_life_over(2),
      percentage_activity_life_over_two_years: percentage(number_activity_life_over(2), count),
      number_activity_life_over_one_year: number_activity_life_over(1),
      percentage_activity_life_over_one_year: percentage(number_activity_life_over(1), count),
      number_activity_life_less_than_two_years: number_activity_life_under(2),
      percentage_activity_life_less_five_years: percentage(number_activity_life_under(2), count),
      number_activity_life_less_than_one_year: number_activity_life_under(1),
      percentage_activity_life_under_five_years: percentage(number_activity_life_under(5), count),
    }
  end

  def no_push
    repos.select { |r| r.pushed_at.nil?}
  end

  def updated_within(months, collection=repos)
    collection.select { |r| r.updated_at >= months.months.ago }
  end

  # Find repos pushed within given number of years.
  # Must remove repos with no pushes.
  def pushed_within(months, collection=repos)
    (collection - no_push).select { |r| r.pushed_at >= months.months.ago }
  end

  def repos_without_license(collection=repos)
    collection.select{|r| r.license.nil? }
  end

  def repos_with_license(collection=repos)
    collection.select{|r| !! r.license }
  end

  def license_types(collection=repos)
    repos_with_license(collection).map{|r| [r.license.key, r.license.name]}.uniq
  end

  def longest_activity_repo(collection=repos)
    collection.max do |a, b|
      activity_life(a) <=> activity_life(b)
    end
  end

  def longest_activity_life(collection=repos)
    activity_life longest_activity_repo(collection)
  end

  def shortest_activity_repo(collection=repos)
    collection.min do |a, b|
      activity_life(a) <=> activity_life(b)
    end
  end

  def shortest_activity_life(collection=repos)
    activity_life shortest_activity_repo(collection)
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

  def number_activity_life_over(years)
    repos.select do |r|
      seconds_into_years(activity_life(r)) > years
    end.count
  end

  def number_activity_life_under(years)
    repos.select do |r|
      seconds_into_years(activity_life(r)) < years
    end.count
  end

  def percentage(num, denom)
    ((num.to_f / denom.to_f) * 100.0).round(2)
  end

  def commits(repo)
    client.commits repo.full_name
  rescue Octokit::Conflict
    []
  end

  # repos_with_more_than_one_commit
  def substantive_repos
    @substantive_repos ||= repos.each_with_object([]) do |repo, array|
      if commits(repo).count > 1
        array << repo
      end
    end
  end

  def number_of_nonsubstantive_repos
    count - substantive_repos.count
  end
end