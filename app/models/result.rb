class Result
  def initialize(bill)
    @bill = bill
  end

  def calculate
    people_to_be_paid = absolute_balance_per_person.select {|_, x| x < 0}

    movements = @bill.data.map do |x|
      [x["name"], []]
    end.to_h

    absolute_balance_per_person.each do |person, absolute_balance|
      next unless absolute_balance > 0

      people_to_be_paid.each do |name, pending_to_pay|
        break if absolute_balance <= 0

        if absolute_balance >= pending_to_pay.abs
          movements[person] << [name, pending_to_pay.abs]
          people_to_be_paid[name] = 0
          absolute_balance -= pending_to_pay.abs
        else
          movements[person] << [name, absolute_balance]
          people_to_be_paid[name] += absolute_balance
          absolute_balance = 0
        end
      end
    end

    movements
  end

  def total_paid
    @bill.data.sum {|x| x["paid"]}
  end

  def total_persons
    @bill.data.sum {|x| x["pays_for_people"]}
  end

  def amount_per_person
    total_paid / total_persons.to_f
  end

  def absolute_balance_per_person
    @bill.data.map do |x|
      [x["name"], (amount_per_person * x["pays_for_people"]) - x["paid"]]
    end.to_h
  end
end