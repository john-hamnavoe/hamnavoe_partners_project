class TaxJurisdictionPostalCodesController < ApplicationController
  def index
    @tax_jurisdiction_postal_codes = TaxJurisdictionPostalCode.all
  end
end
