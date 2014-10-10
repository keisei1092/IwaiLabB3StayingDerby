require 'sinatra'
require 'data_mapper'
require 'slim'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

class Task
  include DataMapper::Resource
  property :id,		Serial
  property :name,	String, :required => true
  peroperty :completed_at, DateTime
end

DataMapper.finalize

get '/' do
  slim :index
end

post '/' do
  @task = params[:task]
  slim :task
end

get '/:task' do
  @task = params[:task].split('-').join(' ').capitalize
  slim :task
end

__END__

@@layout
doctype html
html
  head
    meta charset="utf-8"
    title Just Do It
    link rel="stylesheet" media="screen, projection" href="/styles.css"
    /[if lt IE 9]
      script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"
  body
    h1 Just Do It
    == yield
