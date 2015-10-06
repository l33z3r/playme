class Material < ActiveRecord::Base
  belongs_to :song
  belongs_to :user

  before_save :check_for_youtube
  def check_for_youtube
    self.url = youtube_embedded_url(url) if url.include? 'youtube'
  end

  def youtube_embedded_url(youtube_url)
    if youtube_url[/youtu\.be\/([^\?]*)/]
      youtube_id = $1
    else
      # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
      youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
      youtube_id = $5
    end

    "http://www.youtube.com/embed/#{ youtube_id }"
  end
end
