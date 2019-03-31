ActiveAdmin.register Work do
  permit_params :title, :summary, :year, :runtime, :country, :type, :image, :link

  form do |f|
    f.inputs do
      f.input :title
      f.input :summary
      f.input :year
      f.input :runtime
      f.input :country, as: :string
      f.input :type
      f.input :image, as: :string
      f.input :link
    end
    f.actions
  end

  controller do
    def create
      work = Work.new(permitted_params[:work])

      hash = ImdbService.new
      escaped_title = URI.escape(work.title)
      work.image = hash.get_image_by_title(escaped_title, work.year)
      # work.image = hash.fetch_values("Year", "Runtime", "Country", "Poster", "Type").get_image_by_title(escaped_title, work.year)

      if work.save
        redirect_to admin_work_url(id: work.id)
      else
        render :new
      end
    end

    def update
      work = Work.find(params[:id])

      # フォームの入力値を使う
      title = permitted_params[:work][:title]
      year = permitted_params[:work][:year]

      hash = ImdbService.new
      escaped_title = URI.escape(title)
      update_image = hash.get_image_by_title(escaped_title, year)

      # フォームの入力値で１度更新する
      work.update(permitted_params[:work])
      # 画像だけAPIでもう一度更新する
      if work.update(image: update_image)
        redirect_to admin_work_url(id: work.id)
      else
        render :edit
      end
    end
  end
end
