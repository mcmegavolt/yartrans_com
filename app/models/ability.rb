class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user
 
    # if user.role? :super_admin
    #   can :manage, :all
    # elsif user.role? :product_admin
    #   can :manage, [Product, Asset, Issue]
    # elsif user.role? :product_team
    #   can :read, [Product, Asset]
    #   # manage products, assets he owns
    #   can :manage, Product do |product|
    #     product.try(:owner) == user
    #   end
    #   can :manage, Asset do |asset|
    #     asset.assetable.try(:owner) == user
    #   end
    # end

    if user.role? :admin ######### ADMIN ##############
      can :log, :admin_panel
      can :manage, :all

    elsif user.role? :director ###### DIRECTOR ########
      can :log, :admin_panel
      can :edit, [Article::Page, Article::Category]
      can [:edit, :destroy], User do |user|
        (user.role? :client) || (user.role? :manager)
      end
      can [:read, :create] , User
      can :read, Role, :name => ['Manager', 'Client']

    elsif user.role? :manager ####### MANAGER #########
      can :log, :admin_panel
      can [:edit, :destroy, :create], User do |user|
        user.role? :client
      end
      can [:read, :create], User
      can :read, Role, :name => 'Client'

    elsif user.role? :client ####### CLIENT ###########

    else ####### GUEST ################################

    end

  end
end
