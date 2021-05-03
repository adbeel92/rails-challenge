# frozen_string_literal: true

Dir["#{Rails.root}/lib/extensions/**/*.rb"].sort.each { |file| require file }
Dir["#{Rails.root}/lib/base_62/**/*.rb"].sort.each { |file| require file }
