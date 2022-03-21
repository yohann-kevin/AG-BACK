class ModelNetwork < ApplicationRecord
  def self.register_model_network(data_network, model_id)
    model_network = ModelNetwork.create(data_network)
    model_network.model_uuid = model_id
    model_network.save ? true : false
  end
end
