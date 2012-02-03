class TechniquesController < ApplicationController
  before_filter :authenticate_user!

  def create
    technique = Technique.new(params[:technique])
    if technique.save
      render_katas_edit(technique.kata)
    else
      render_katas_edit(Kata.find(params[:technique][:kata_id]), technique)
    end
  end


  def update
    technique = Technique.find(params[:id])
    flash[:success] = "Technique updated." if technique.update_attributes(params[:technique])
    render_katas_edit(technique.kata)
  end
  
  def destroy
    technique = Technique.find(params[:id])
    kata = technique.kata
    technique.destroy
    flash[:success] = "Technique deleted."
    render_katas_edit(kata)
  end
  
  
private    
  def render_katas_edit(kata, technique = Technique.new(:kata_id => kata.id))
    @kata = kata
    @new_technique = technique
    render "katas/edit"
  end
end
