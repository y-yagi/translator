class EdictsController < ApplicationController
  def index
    edicts = Edict.limit(10)
    render json: edicts
  end

  def show
    edict = Edict.find(params[:id])
    render json: edict
  end
end
