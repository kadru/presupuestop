# frozen_string_literal: true

namespace :ci do
  desc "Setup db for CI environment"
  task setup_db: %i[environment db:create db:schema:load]
end
