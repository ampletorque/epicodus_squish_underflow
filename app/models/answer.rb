class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates :description, :presence => true
  validates :title, :presence => true



end
