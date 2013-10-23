module TokyoApi
  class Base < Vertebrae::Model
    def normalized_base_path
      "#{base_path}/"
    end
  end
end