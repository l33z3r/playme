class Material < ActiveRecord::Base
  belongs_to :song, dependent: :destroy
  belongs_to :user
end
