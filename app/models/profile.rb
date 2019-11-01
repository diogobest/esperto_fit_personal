class Profile < ApplicationRecord
  GENDERS = [:female, :male]
  enum gender: GENDERS

  belongs_to :account

  validates :first_name, :last_name, :address, :date_of_birth,
            :contact, :gender, :nickname, :payment_method,
            presence: true

  def owner?(account)
    self.account == account
  end 
end
