require "test_helper"

class TaxJurisdictionPostalCodesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tax_jurisdiction_postal_codes_index_url
    assert_response :success
  end
end
