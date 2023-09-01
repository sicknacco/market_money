class Vendor < ApplicationRecord
  has_many :market_vendors
  has_many :markets, through: :market_vendors

  validates :name,
            :description,
            :contact_name,
            :contact_phone,
            presence: true
  validates :credit_accepted, inclusion: [true, false]

  def states_sold_in
    markets.distinct.pluck(:state)
  end
end