# frozen_string_literal: true

Dir["#{Rails.root}/lib/extensions/**/*.rb"].sort.each { |file| require file }
