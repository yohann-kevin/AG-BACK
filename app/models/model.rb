class Model < ApplicationRecord
  def self.register_model(model_data, model_id)
    model = Model.new(model_data)
    model.id = model_id
    model.save ? true : false
  end
end
