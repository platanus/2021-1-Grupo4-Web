class Menu < ApplicationRecord
  belongs_to :user
  has_many :recipes
end

# == Schema Information
#
# Table name: menus
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
