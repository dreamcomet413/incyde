module ApplicationHelper

  def embed_from_youtube_url(youtube_url)
    youtube_id = youtube_url.split("=").last
    content_tag(:iframe, nil, src: "//www.youtube.com/embed/#{youtube_id}")
  end

  def url_with_protocol(url)
    /^http/.match(url) ? url : "http://#{url}"
  end

  def print_data_for_detail(data)
    if !!data == data
      data ? "Si" : "No"
    elsif data =~ URI::regexp
      link_to(data, data, target: '_blank')
    else
      data
    end
  end

  def body_class
    "ct-#{controller_path.gsub("/", "-")} ac-#{action_name}"
  end

  def nessmeeting_url(email)
    # "http://www.nessmeeting.com/testParametros.aspx?param=#{NessmeetingEncryptor.new.encriptar_cadena(email)}"
    "http://fundacionincyde.nessmeeting.com/acceso.aspx?param=#{NessmeetingEncryptor.new.get_token(email)}"
  end

  def change_to_locale
    I18n.locale == :es ? 'en' : 'es'
  end

end
