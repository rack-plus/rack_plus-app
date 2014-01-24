module RackPlus
  class App
    def initialize(options={})
      @router         = options[:router]         || Proc.new { nil }
      @fallback_route = options[:fallback_route] || Proc.new { [404, {}, ["404. No route found!"]] }
      @error_handler  = options[:error_handler]  || Proc.new { [500, {}, ["500. Internal Server Error!"]] }
    end

    def call(environment)
      route = @router.call(environment) || @fallback_route
      route.call(environment)
    rescue StandardError => ex
      environment["rack_plus.error"] = ex
      @error_handler.call(environment)
    end
  end
end

