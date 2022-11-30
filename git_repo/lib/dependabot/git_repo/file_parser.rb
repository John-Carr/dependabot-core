# frozen_string_literal: true

require "parseconfig"
require "dependabot/dependency"
require "dependabot/file_parsers"
require "dependabot/file_parsers/base"
require "dependabot/shared_helpers"

module Dependabot
  module GitRepo
    class FileParser < Dependabot::FileParsers::Base
      def parse
        Dependabot::SharedHelpers.in_a_temporary_directory do
          File.write(".gitmodules", gitmodules_file.content)

          ParseConfig.new(".gitmodules").params.map do |_, params|
            raise DependencyFileNotParseable, gitmodules_file.path if params.fetch("path").end_with?("/")

            Dependency.new(
              name: params.fetch("path"),
              version: submodule_sha(params.fetch("path")),
              package_manager: "git_repo",
              requirements: [{
                requirement: nil,
                file: "default.conf",
                source: {
                  type: "git",
                  url: absolute_url(params["url"]),
                  branch: params["branch"],
                  ref: params["branch"]
                },
                groups: []
              }]
            )
          end
        end
      end
    end
 end
end
