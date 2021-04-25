# frozen_string_literal: true

module Components
  module Parameters
    def dparams
      return {} unless route_setting(:declared_params)

      @dparams ||= declared(params, include_missing: false)
    end
  end
end
