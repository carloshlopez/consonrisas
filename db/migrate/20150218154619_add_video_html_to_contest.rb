class AddVideoHtmlToContest < ActiveRecord::Migration
  def change
    add_column :contests, :video_html, :string
  end
end