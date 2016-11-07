class PetsController < ApplicationController
  def index
    pets = Pet.select("id", "age", "human", "name")
    render :json => pets, :status => :ok
    #OR
    # pets=Pet.all
    # render :json => pets.as_json(:only => [:id, :name, :human, :age]), :status => :ok
  end

  def show
  	pet=Pet.find_by(id: params[:id])
  	if pet 
  		render :json => pet.as_json(:only => [:id, :name, :human, :age]), :status => :ok
  	else
  		render :json => [], :status => :no_content
  	end 
  end

  def search
  	found_pets=Pet.where(name: params[:query].capitalize)
  	unless found_pets.empty? 
  		render :json => found_pets.as_json(:only => [:id, :name, :human, :age]), :status => :ok
  	else
  		render :json => [], :status => :no_content
  	end 
  end
end
