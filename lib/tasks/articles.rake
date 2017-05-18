namespace :incyde do
  namespace :articles do

    desc 'Update nil published_at with created_at'
    task update_published_at: :environment do

      Article.where(published_at: nil).each do |article|
        article.update(published_at: article.created_at)
      end

    end

    desc 'Update nil category_id with "Incyde" ArticleCategory'
    task update_category_id: :environment do

      Article.where(category_id: nil).update_all(category_id: ArticleCategory.find_by_code('incyde').try(:id))

    end

    desc 'Import from http://incyde.org/rss You can import the N recent with param N=10 default is 5'
    task import: :environment do

      # Número de noticias a importar (cogiendo las N más recientes)
      number_to_import = (ENV['N'] || 5).to_i

      Feedjira::Feed.add_common_feed_entry_element("image", as: :image_url)
      feed = Feedjira::Feed.fetch_and_parse('http://incyde.org/rss')
      author = Admin.find_by(email: 'arodriguez@incydecamaras.es') || Admin.last
      entries = feed.entries.first(number_to_import)

      logger = Logger.new("log/import_articles.log")
      logger.info "Comenzando la importación: #{start_at = Time.now}"

      category_id = ArticleCategory.find_by_code('incyde').try(:id)

      entries.each do |entry|
        begin
          logger.info "Importando: #{entry.id}"
          text = entry.summary

          Article.create(
              category_id: category_id,
              author: author,
              title: entry.title,
              description: ActionView::Base.full_sanitizer.sanitize(text.try(:truncate, 500, separator: /\s/)),
              body: text,
              public: true,
              published_at: entry.published,
              image_url:  entry.image_url.try(:strip),
              imported_url: entry.url
          )
        rescue Exception => exception
          logger.info Time.now
          logger.info "Error importando la noticia #{entry.try(:url)}"
          logger.info "Excepcion #{exception.inspect}"
          logger.info "\n\n\n\n"
        end
      end

      logger.info "Fin de la importación: #{Time.now}; Duración: #{Time.now - start_at}s"

    end

  end
end
