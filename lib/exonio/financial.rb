module Exonio
  module Financial
    # Calculates the future value of an annuity investment based on
    # constant-amount periodic payments and a constant interest rate.
    #
    # @param rate [Float] The interest rate as decimal (not per cent) per period
    # @param nper [Integer] The number of compounding periods
    # @param pmt [Float] The number of payments to be made
    # @param pv [Float] The present value
    # @param end_or_begining [Integer] Whether payments are due at the end (0) or
    #   beggining (1) of each period
    #
    # @return [Float]
    #
    # @example
    #   Exonio.fv(0.05 / 12, 12 * 10, -100, -100) # ==> 15692.928894335748
    #
    def fv(rate, nper, pmt, pv, end_or_beginning = 0)
      temp = (1 + rate) ** nper
      fact = (1 + rate* end_or_beginning) * (temp - 1) / rate

      -(pv * temp + pmt * fact)
    end

    # Calculates the payment on interest for an investment based on
    # constant-amount periodic payments and a constant interest rate.
    #
    # @param rate [Float] The interest rate as decimal (not per cent) per period
    # @param per [Integer] The amortization period, in terms of number of periods
    # @param nper [Integer] The number of payments to be made
    # @param pv [Float] The present value
    # @param fv [Float] The future value remaining after the final payment has been made
    # @param end_or_begining [Integer] Whether payments are due at the end (0) or
    #   beggining (1) of each period
    #
    # @return [Float]
    #
    # @example
    #   Exonio.ipmt(0.075 / 12, 8, 12 * 2, 5000) # ==> -22.612926783996798
    #
    def ipmt(rate, per, nper, pv, fv = 0, end_or_beginning = 0)
      pmt = self.pmt(rate, nper, pv, fv, end_or_beginning)
      fv = self.fv(rate, (per - 1), pmt, pv, end_or_beginning) * rate
      temp = end_or_beginning == 1 ? fv / (1 + rate) : fv

      (per == 1 && end_or_beginning == 1) ? 0.0 : temp
    end

    # Calculates the number of payment periods for an investment based on
    # constant-amount periodic payments and a constant interest rate.
    #
    # @param rate [Float] The interest rate as decimal (not per cent) per period
    # @param pmt [Float] The number of payments to be made
    # @param pv [Float] The present value
    # @param fv [Float] The future value remaining after the final payment has been made
    # @param end_or_begining [Integer] Whether payments are due at the end (0) or
    #   beggining (1) of each period
    #
    # @return [Float]
    #
    # @example
    #   Exonio.nper(0.07 / 12, -150, 8000) # ==> 64.07334877066185
    #
    def nper(rate, pmt, pv, fv = 0, end_or_beginning = 0)
      z = pmt * (1 + rate * end_or_beginning) / rate
      temp = Math.log((-fv + z) / (pv + z))

      temp / Math.log(1 + rate)
    end

    # Calculates the periodic payment for an annuity investment based on
    # constant-amount periodic payments and a constant interest rate.
    #
    # @param rate [Float] The interest rate as decimal (not per cent) per period
    # @param nper [Integer] The number of payments to be made (number of periods)
    # @param pv [Float] The present value of the annuity
    # @param fv [Float] The future value remaining after the final payment has been made
    # @param end_or_begining [Integer] Whether payments are due at the end (0) or
    #   beggining (1) of each period
    #
    # @return [Float]
    #
    # @example
    #   Exonio.pmt(0.075/12, 12*15, 200_000) # ==> -1854.0247200054619
    #
    def pmt(rate, nper, pv, fv = 0, end_or_beginning = 0)
      temp = (1 + rate) ** nper
      fact = (1 + rate * end_or_beginning) * (temp - 1) / rate

      -(fv + pv * temp) / fact
    end

    # Calculates the present value of an annuity investment based on
    # constant-amount periodic payments and a constant interest rate.
    #
    # @param rate [Float] The interest rate as decimal (not per cent) per period
    # @param nper [Integer] The number of payments to be made (number of periods)
    # @param pmt [Float] The amount per period to be paid
    # @param fv [Float] The future value remaining after the final payment has been made
    # @param end_or_begining [Integer] Whether payments are due at the end (0) or
    #   beggining (1) of each period
    #
    # @return [Float]
    #
    # @example
    #   Exonio.pv(0.05/12, 12*10, -100, 20_000) # ==> -2715.0857731569663
    #
    def pv(rate, nper, pmt, fv = 0, end_or_beginning = 0)
      temp = (1 + rate) ** nper
      fact = (1 + rate * end_or_beginning) * (temp - 1) / rate

      -(fv + pmt * fact) / temp
    end
  end
end
