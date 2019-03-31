class TimelinesController < ApplicationController
  def index
    @works = Work.order('created_at DESC').page(params[:page]).per(50)
  end

  def search
    @works = Work.search(params[:keyword]).order('created_at DESC').page(params[:page]).per(10)
    @works_count = @works.count
  end
end
