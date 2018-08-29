module PaypalConcern
  extend ActiveSupport::Concern

  require 'paypal-sdk-rest'
  require 'securerandom'
  include PayPal::SDK::REST
  include PayPal::SDK::Core::Logging

  def pay_paypal(admin_id, homework_id, proposal_id)

    @homework = Homework.find(homework_id)
    @proposal = Proposal.find(proposal_id)

    # Build Payment object
    @payment = Payment.new({
      :intent =>  "sale",
      :payer =>  {
        :payment_method =>  "paypal" },
      :redirect_urls => {
        :return_url => "http://localhost:3000/" +  create_classroom_paypal_path(admin_id: admin_id, homework_id: homework_id, proposal_id: proposal_id),
        :cancel_url => "http://localhost:3000/" },
      :transactions =>  [{
        :item_list => {
          :items => [{
            :name => @homework.name,
            :sku => @homework.name,
            :price => @proposal.cost.to_s,
            :currency => "MXN",
            :quantity => 1 }]},
        :amount =>  {
          :total =>  @proposal.cost.to_s,
          :currency =>  "MXN" },
        :description =>  @homework.name }]})

    if @payment.create
      @redirect_url = @payment.links.find{|v| v.rel == "approval_url" }.href
      logger.info "Payment[#{@payment.id}]"
      puts @payment.id
      puts @payment.id
      puts "--------"
      logger.info "Redirect: #{@redirect_url}"
      return @redirect_url
    else
      logger.error @payment.error.inspect
    end

  end


  def payout_paypal(homework, proposal)

    include PayPal::SDK::REST
    include PayPal::SDK::Core::Logging

    price = proposal.cost - (0.15 * proposal.cost)

    @payout = Payout.new(
      {
        :sender_batch_header => {
          :sender_batch_id => SecureRandom.hex(8),
          :email_subject => 'Pago por la tarea',
        },
        :items => [
          {
            :recipient_type => 'EMAIL',
            :amount => {
              :value => "7.0", #price.to_s
              :currency => 'MXN'
            },
            :note => 'Pago por la tarea',
            :sender_item_id => "MEX3Y5PSDGZ3E", #aqui el id de la cuenta
            :receiver => "arturo.bravora@udlap.mx", #proposal.admin.email
          }
        ]
      }
    )

    begin
      @payout_batch = @payout.create(false)
      #logger.info "Created Payout with [#{@payout_batch.batch_header.payout_batch_id}]"
      return true
    rescue Exception => e
      puts e
      return false
    end

    #SANDBOX
    #8EKK43ENJJYS2
    #LIVE
    #Q7ZMGQ75YEWRG

  end

end
