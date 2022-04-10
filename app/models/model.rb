class Model < ApplicationRecord
  def self.register_model(model_data, model_id)
    model = Model.new(model_data)
    model.id = model_id
    model.save ? true : false
  end

  def self.update_model_data(data_info, model_id)
    model = Model.find(model_id)
    model.update(data_info) ? true : false
  end
end
