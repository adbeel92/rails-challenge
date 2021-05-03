# frozen_string_literal: true

module Links
  module Operations
    class ShortUrlBuilder
      class << self
        def encode_link_url(link)
          Base62.encode("#{link.created_at.to_i}#{link.id}".to_i)
        end

        def decode_link_url(text_encoded)
          decoded_id = Base62.decode(text_encoded).to_s
          created_at = decoded_id[0..9]

          Link.find_by!(
            id: decoded_id.remove(created_at),
            created_at: Time.at(created_at.to_i)
          )
        end
      end
    end
  end
end
