class ModelInfo < ApplicationRecord
  def self.register_model_info(data_info, model_id)
    model_info = ModelInfo.new(data_info)
    model_info.model_uuid = model_id
    model_info.save ? true : false
  end

  def self.update_model_info(data_info, model_id)
    model_info = ModelInfo.find_by(model_uuid: model_id)
    model_info.update(data_info) ? true : false
  end
end
