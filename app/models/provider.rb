class Provider < ApplicationRecord
  has_many :ingredients, dependent: :destroy
  belongs_to :user
end

# == Schema Information
#
# Table name: providers
#
#  id               :bigint(8)        not null, primary key
#  name             :string
#  address          :string
#  country          :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  email            :string
#  webpage_url      :string
#  delivery_days    :integer
#  minimum_purchase :integer
#  phone            :string
#  user_id          :bigint(8)
#
# Indexes
#
#  index_providers_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
