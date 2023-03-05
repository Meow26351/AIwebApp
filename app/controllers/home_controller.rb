
class HomeController < ApplicationController

  def show_agent
    agent = Agent.find(params[:id])
    @show_agents_tasks = agent.tasks
  end
  def agents_work
    @agents = Agent.all
  end

  def analysis
  end
  def index
  end
  def create
  end

  def profile
  end
end