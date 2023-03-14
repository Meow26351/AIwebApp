
class HomeController < ApplicationController

  def show_agent
    agent = Agent.find(params[:id])
    @show_agents_tasks = agent.tasks
  end
  def agents_work
    @agents = Agent.all
  end

  def analysis
    xy_values = [
      { x: 10, y: 7 },
      { x: 20, y: 8 },
      { x: 30, y: 8 },
      { x: 40, y: 9 },
      { x: 50, y: 9 },
      { x: 60, y: 9 },
      { x: 70, y: 10 },
      { x: 80, y: 11 },
      { x: 90, y: 14 },
      { x: 100, y: 14 },
      { x: 110, y: 15 },
      { x: 120, y: 9 }
    ]
    gon.my_data = DateTime.now.month
    gon.other_data = "bitches"
    gon.chart = xy_values
  end
  def index
  end
  def create
  end

  def profile
  end
end