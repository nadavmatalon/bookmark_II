require "sinatra"
require "data_mapper"
require "./lib/link"
require "./lib/tag"
require "./lib/user"

env = ENV["RACK_ENV"] || "development"
DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")
DataMapper.finalize
DataMapper.auto_upgrade!

set :views, Proc.new {File.join(root, '..', "views")}
set :public_folder, Proc.new {File.join(root, '..', "public")}

enable :sessions


get '/' do
	@links = Link.all
  erb :index
end

post '/links' do
	url = params["url"]
	title = params["title"]
	Link.create(:url => url, :title => title)
	redirect to('/')
end

