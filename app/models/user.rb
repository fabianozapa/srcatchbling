class User < ApplicationRecord


  # Macros: Extends and Includes ---------------------------------------------------------------------------------------
  extend Enumerize
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  enumerize :role, scope: true, in: {
    admin:    :admin,
    feeder:   :feeder,
    consumer: :consumer,
    blocked:  :blocked
  }, consumer: :consumer
  # --------------------------------------------------------------------------------------------------------------------


  # Macros: Relations --------------------------------------------------------------------------------------------------
  has_many :worked_times
  # --------------------------------------------------------------------------------------------------------------------


  # Macros: Validations ------------------------------------------------------------------------------------------------
  validates_presence_of :name, :email
  validates_presence_of :password, on: :create
  validates_uniqueness_of :email
  # --------------------------------------------------------------------------------------------------------------------


  # Macros: Scopes -----------------------------------------------------------------------------------------------------
  scope :admins,      -> { where( role: [:admin                      ] ) }
  scope :not_admins,  -> { where( role: [:intern, :blocked, nil, ''  ] ) }
  scope :interns,     -> { where( role: [:intern                     ] ) }
  scope :not_interns, -> { where( role: [:admin,  :blocked, nil, ''  ] ) }
  scope :blocked,     -> { where( role: [:blocked                    ] ) }
  scope :not_blocked, -> { where( role: [:admin,  :intern,  nil, ''  ] ) }
  scope :pending,     -> { where( role: [nil, ''                     ] ) }
  scope :not_pending, -> { where( role: [:admin,  :intern, :blocked  ] ) }
  # --------------------------------------------------------------------------------------------------------------------


  # Public Instance Methods --------------------------------------------------------------------------------------------
  def account_active?
    not(self.blocked?)
  end

  def active_for_authentication?
    super && account_active?
  end

  def inactive_message
    account_active? ? super : :locked
  end

  def admin?
    self.role.admin? rescue false
  end

  def feeder?
    self.role.feeder? rescue false
  end

  def consumer?
    self.role.consumer? rescue false
  end

  def pending?
    self.role.pending? rescue false
  end

  def blocked?
    self.role.blocked? rescue false
  end
  # --------------------------------------------------------------------------------------------------------------------


end
