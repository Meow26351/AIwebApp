class MyWorker
  include Sidekiq::Worker
  def perform
    puts 'hello world!'
  end
end