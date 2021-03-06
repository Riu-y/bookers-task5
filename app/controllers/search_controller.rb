class SearchController < ApplicationController
	def index
		@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
		@user = current_user
		@model = params["search"]["model"]
		@content = params["search"]["content"]
		@how = params["search"]["how"]
		@datas = search_for(@how, @model, @content)
    #binding.pry
	end

  private
  def match(model, content)
  	if model == 'user'
  		User.where(name: content)
  	elsif model == 'book'
  		Book.where(title: content)
  	end
  end

  def forward(model,  content)
  	if model == 'user'
  		User.where("name LIKE ?", "#{content}%")
  	elsif model == 'book'
  		Book.where("title LIKE ?", "#{content}%")
  	end
  end

  def backward(model, content)
  	if model == 'user'
  		User.where("name LIKE ?", "%#{content}")
  	elsif model == 'book'   
  		Book.where("title LIKE? ", "%#{content}")
  	end   
  end

  def partical(model, content)
  	if model == 'user'
  		User.where("name LIKE ?", "%#{content}%")
  	elsif model == 'book'   
  		Book.where("title LIKE ?", "%#{content}%")
  	end
  end

  def search_for(how, model, content)
  	case how
  	when 'match' 
  		match(model, content)
  	when 'forward'
  		forward(model, content)
  	when 'backward'
  		backward(model, content)
  	when 'partical'
  		partical(model, content)
  	end
  end
end
