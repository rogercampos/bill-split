class BillsController < ApplicationController
  def show
    @bill = load_bill || Bill.new(data: [])
  end

  def create
    @bill = load_or_create_bill

    data = params[:persons].map do |person|
      next if person[:name].to_s.strip.blank?

      {
        name: person[:name].to_s.strip,
        paid: person[:paid].to_f,
        pays_for_people: person[:pays_for_people].to_i
      }
    end.compact

    if data.map { _1[:name] }.uniq.length != data.length
      head :bad_request
      return
    end

    @bill.update!(data: data)

    if rand(10) == 0
      Bill.where("updated_at < ?", 1.month.ago).destroy_all
    end
  end

  def remove_person
  end

  def add_person
  end

  def shared
    @bill = Bill.find_by!(public_token: params[:id])
  end

  def discard
    load_bill&.destroy
    session[:current_bill_id] = nil
    redirect_to root_path
  end

  private

  def load_bill
    return @bill if defined?(@bill)

    @bill = Bill.find_by(id: session[:current_bill_id]) if session[:current_bill_id].present?
  end

  def load_or_create_bill
    return @bill if defined?(@bill)

    @bill = load_bill

    if @bill.nil?
      @bill = Bill.create!
      session[:current_bill_id] = @bill.id
    end

    @bill
  end
end
