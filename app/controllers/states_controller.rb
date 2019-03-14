class StatesController < ApplicationController
  def index
    puts "********************************************"
   @states = CS.states(params[:country])
  end
end
