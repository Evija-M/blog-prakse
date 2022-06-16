# frozen_string_literal: true

Resque.inline = true if Rails.env.dev? || Rails.env.test?
