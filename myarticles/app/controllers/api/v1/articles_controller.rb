module Api
	module V1
		class ArticlesController < ApplicationController

			def index
			articles = Article.order('created_at DESC');
			render json: {status: 'Success', message:'Loaded Articles', data:articles}, status: :OK
			end

			def show
				article = Article.find(params[:id])
				render json: {status: 'Success', message:'Loaded Article', data:article}, status: :OK
			end
	
			def create
				article  = Article.new(article_params)
		
			if article.save
				render json: {status: 'Success', message:'Saved Article', data:article}, status: :OK
			else 
				render json: {status: 'Error', message:'Article Not Saved', data:article.errors}, status: :unprocessable_entity
			end
			end

			def destroy
				article = Article.find(params[:id])
				article.destroy
				render json: {status: 'Success', message:'Article Deleted', data:article}, status: :OK
			end

			def update
				article = Article.find(params[:id])
				if article.update_attributes(article_params)
					render json: {status: 'Success', message:'Updated Article', data:article}, status: :OK

				else
					render json: {status: 'Error', message:'Article Not Updated', data:article.errors}, status: :unprocessable_entity
				end
			end

			private
			def article_params
				params.require(article).permit(:title, :body)
			end
		end
	end
end
 