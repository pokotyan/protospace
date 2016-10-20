FactoryGirl.define do

  factory :image, class: Image do
    #第一引数はアップロードするファイルの場所、第二引数はcontent_type
    image{ Rack::Test::UploadedFile.new Rails.root.join('spec/fixtures/img/sample.jpg'), 'image/jpg' }

    factory :main_image do
      status "main"
    end

    factory :sub_image do
      status "sub"
    end

    factory :wrong_content do
      image{ Rack::Test::UploadedFile.new Rails.root.join('spec/fixtures/txt/sample.txt'), 'text/plain' }
    end

  end

end
