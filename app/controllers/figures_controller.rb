

class FiguresController < ApplicationController

	get '/figures' do
		@figures = Figure.all
		erb :'figures/index'
	end

	get '/figures/new' do 
		erb :'figures/new'
	end

	post '/figures' do 
		@figure = Figure.create(params[:figure])
		#binding.pry
		if !params[:title][:name].empty?
			@figure.titles << Title.create(name: params[:title][:name])
		end
		if !params[:landmark][:name].empty?
			@figure.landmarks << Landmark.create(name: params[:landmark][:name])
		end
		@figure.save
		redirect '/figures'
	end

	get '/figures/:id' do
		@figure = Figure.find(params[:id])
		erb :'figures/show'
	end

	get '/figures/:id/edit' do # EDIT
		#binding.pry
		@figure = Figure.find(params[:id])
		erb :"figures/edit"
	end

	patch '/figures/:id' do 

		@figure = Figure.find(params[:id])
		@figure.update(params[:figure])
		if !params[:figure][:name].empty?
			@figure.name = params[:figure][:name]
		end
		if !params[:title][:name].empty?
			@figure.titles << Title.create(name: params[:title][:name])
		end
		if !params[:landmark][:name].empty?
			@figure.landmarks << Landmark.create(name: params[:landmark][:name])
		end
		@figure.save

		erb :'figures/show'
	end

	
end

# '/figures/:id vs /figures/#{@figure.id} vs /figures/<%=@figure.id%>'
