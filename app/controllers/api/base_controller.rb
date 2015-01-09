class Api::BaseController < ActionController::Base
  def default_serializer_options
    { root: false }
  end

  # https://github.com/rails-api/active_model_serializers/issues/641#issuecomment-68196151
  def _render_with_renderer_json(json, options)
    serializer = build_json_serializer(json, options)

    if serializer
      super(serializer, options)
    else
      super(json, options)
    end
  end
end