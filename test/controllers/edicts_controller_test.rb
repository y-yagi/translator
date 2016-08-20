require 'test_helper'

class EdictsControllerTest < ActionDispatch::IntegrationTest
  test 'search exist word' do
    get edicts_url, params: { word: 'calendula' }
    assert_response :success
    assert_equal [{"japanese"=>"金盞花", "japanese_yomi"=>"きんせんか"}], response.parsed_body
  end

  test 'search non exist word' do
    get edicts_url, params: { word: 'summ' }
    assert_response :success
    assert_equal [], response.parsed_body
  end
end
