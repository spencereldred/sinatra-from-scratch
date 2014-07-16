require "sinatra"
require "active_record"
require "./lib/database_connection"
require "rack-flash"

class App < Sinatra::Application
  enable :sessions
  use Rack::Flash

  def initialize
    super
    @database_connection = DatabaseConnection.establish(ENV["RACK_ENV"])
  end

  get "/" do
    all_emails = @database_connection.sql("SELECT * FROM emails")

    erb :home, locals: {all_emails: all_emails}
  end

  post "/email" do
    email = params[:email]
    @database_connection.sql("INSERT INTO emails (address) VALUES ('#{email}')")

    redirect "/"
  end

end