class User

  include ActiveModel::Validations
  include ActiveModel::AttributeAssignment
  include ActiveModel::SecurePassword

  attr_accessor :username, :password_digest

  has_secure_password

  validates :username, presence: true

  def self.stub( params = {} )
    if params[ :username ] == 'incre'
      user = User.new
      user.assign_attributes( username: 'incre', password: 'mental' )

      user
    end
  end

end
