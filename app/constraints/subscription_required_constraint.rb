class SubscriptionRequiredConstraint
    def matches?(request)
      user = request.env['warden'].user
      user.present? && user.subscription_active?
    end
  end