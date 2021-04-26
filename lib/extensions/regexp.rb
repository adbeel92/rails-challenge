# frozen_string_literal: true

class Regexp
  ALPHANUMERIC = /\A[a-zA-ZáéíóúÁÉÍÓÚñÑäëïöüÄËÏÖÜ0-9]*\z/.freeze
  NUMERIC = /\A[0-9]*\z/.freeze
  EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  NAME = /(?!.\s$)(?!^\s.)\A([a-zA-ZáéíóúÁÉÍÓÚñÑäëïöüÄËÏÖÜ0-9\-'\s]*)\z/u.freeze
end
