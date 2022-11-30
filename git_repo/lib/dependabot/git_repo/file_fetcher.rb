# frozen_string_literal: true

require "parseconfig"
require "dependabot/file_fetchers"
require "dependabot/file_fetchers/base"
require "dependabot/shared_helpers"

module Dependabot
  module GitRepo
    class FileFetcher < Dependabot::FileFetchers::Base
      def self.required_files_in?(filenames)
        return true if filenames.any? { |name| name.end_with?(".conf") }

        return true if filenames.include?("default")
        
        return true if filenames.include?("git-repo")
      end

      def self.required_files_message
        "Repo must contain a default.txt or files must be under a git-repo directory."
      end

    end
  end
end

Dependabot::FileFetchers.
  register("repo", Dependabot::GitRepo::FileFetcher)
