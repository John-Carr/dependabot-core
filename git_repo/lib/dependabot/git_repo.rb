# frozen_string_literal: true

# These all need to be required so the various classes can be registered in a
# lookup table of package manager names to concrete classes.
require "dependabot/git_repo/file_fetcher"
require "dependabot/git_repo/file_parser"
require "dependabot/git_repo/update_checker"
require "dependabot/git_repo/file_updater"
require "dependabot/git_repo/metadata_finder"
require "dependabot/git_repo/requirement"
require "dependabot/git_repo/version"

require "dependabot/pull_request_creator/labeler"
Dependabot::PullRequestCreator::Labeler.
  register_label_details("repo", name: "repo", colour: "000000")

require "dependabot/dependency"
Dependabot::Dependency.
  register_production_check("repo", ->(_) { true })
