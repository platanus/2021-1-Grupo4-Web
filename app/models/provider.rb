class Provider < ApplicationRecord
    has_many :ingredients, dependent: :destroy
end

# == Schema Information
#
# Table name: providers
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  address    :string
#  country    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
