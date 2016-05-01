class EdictsController < ApplicationController
  def index
    edicts = []
    edicts = Edict.search(params[:word]) if params[:word].present?
    render json: edicts
  end

  def show
    edict = Edict.find(params[:id])
    render json: edict
  end
end
