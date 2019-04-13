# == Schema Information
#
# Table name: albums
#
#  id         :bigint(8)        not null, primary key
#  band_id    :integer          not null
#  title      :string           not null
#  year       :integer          not null
#  live       :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Album < ApplicationRecord

    belongs_to :band,
    foreign_key: :band_id,
    class_name: :Band

    has_many :tracks,
    foreign_key: :album_id,
    class_name: :Track,
    dependent: :destroy

    validates :title, :year, :band_id, presence: true
    validates :live, inclusion: {in: [true,false] }
    
    

end
