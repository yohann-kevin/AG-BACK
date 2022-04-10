class ModelNetwork < ApplicationRecord
  def self.register_model_network(data_network, model_id)
    model_network = ModelNetwork.create(data_network)
    model_network.model_uuid = model_id
    model_network.save ? true : false
  end

  def self.update_model_network(data_info, model_id)
    model_network = ModelNetwork.find_by(model_uuid: model_id)
    model_network.update(data_info) ? true : false
  end
end
