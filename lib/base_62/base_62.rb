# frozen_string_literal: true

module Base62
  ALLOWED_CHARS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze
  BASE = ALLOWED_CHARS.size

  class << self
    def encode(number_in_base_ten)
      result = []
      while number_in_base_ten.positive?
        result << ALLOWED_CHARS[number_in_base_ten % BASE]
        number_in_base_ten /= BASE
      end
      result.reverse.join
    end

    def decode(text_in_base_sixty_two)
      text_size = text_in_base_sixty_two.size
      number = 0
      text_in_base_sixty_two.chars.each_with_index do |char, index|
        power = text_size - (index + 1)
        number += ALLOWED_CHARS.index(char) * (BASE**power)
      end
      number
    end
  end
end
