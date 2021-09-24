# frozen_string_literal: true

class StripeService
  def initialize(params)
    @card = params[:card]
    @amount = params[:amount].to_i
    @email = params[:email]
  end

  def create_charge
    customer = Stripe::Customer.create(
      email: @email,
      source: @card
    )

    Stripe::Charge.create({
                            customer: customer.id,
                            amount: @amount,
                            description: 'Rails Stripe customer',
                            currency: 'usd'
                          })
  end
end
