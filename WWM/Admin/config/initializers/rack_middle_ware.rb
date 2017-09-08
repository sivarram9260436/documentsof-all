NewKreatioCMS::Application.config.middleware.insert_after(Rack::Lock,SetCookieCleaner)
NewKreatioCMS::Application.config.middleware.insert_after(Rack::Lock,MaxRequestPerWorker, 5)
