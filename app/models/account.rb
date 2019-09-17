class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :document, presence: true

  has_one :enrollment
  has_one :unit, through: :enrollment

  has_one :profile
  has_many :schedules

  has_many :customers, through: :customer_appointments

  def personal?
    is_a? Personal
  end

  def profile?
    !profile.nil?
  end

  def banished?
    response = EspertoAcademy.client.get do |req|
      req.url 'clients/consult_cpf?cpf=12345678909'
    end
    response.body[:status] == 'banished'
  end

end
