# == Schema Information
#
# Table name: ingredients
#
#  id          :bigint(8)        not null, primary key
#  provider_id :integer
#  user_id     :integer
#  name        :string
#  SKU         :string
#  price       :integer
#  currency    :string
#  quantity    :integer
#  measure     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
module IngredientsHelper
end
