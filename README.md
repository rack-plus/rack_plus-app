Rack+ App
=========

Rack+ App is a minimal base class for Rack apps. It is part of the Rack+
framework.


Specification
-------------
A Rack+ App is a Ruby class whose constructor (i.e. `new` method) takes either
no arguments, or a hash of options, and returns a valid Rack Application whose
call method has the following behavior:

If a `:router` option was provided to the constructor, the Application must call
the provided router with the environment. If no `:router` option is provided,
the app must provide a default. If the router returns a route when called, the
app must call the route with the environment. If the router returns nil, the app
must call the fallback route (see below).

If a `:fallback_route` option was provided to the constructor, and the
application's router returns nil (see above), the Application must call the
provided fallback route with the environment and return its response. If no
fallback route is provided, the app must provide a default.

If, at any point durring the routing or processing of the Rack request, an
uncaught StandardError (or any subclass of StandardError) is raised, the
Application must catch the execption and set `rack_plus.error` on the Rack
Request to the caught execption. If an `:error_handler` option was provided to
the constructor, the Application must call the provided error handler with the
environment and return its response. If no error handler is provided, the app
may provide a default error handler. If the app does not provide a default error
handler, it must re-raise the unhandled execption instead.
