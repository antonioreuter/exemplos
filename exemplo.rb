class ShipmentActionItem < ActiveRecord::Base
end

class ShipmentAction < ActiveRecord::Base

  attr_accessor :type, :status, :reason, :contact_type :created_at

  has_many :items, dependent: :destroy, class_name: "ShipmentActionItem"
  accepts_nested_attributes_for :items

  



end


class CancelShipmentAction < ShipmentAction


  def build_json
    #implementacao para gerar o json
  end

end


class ExchangeShipmentAction < ShipmentAction

  attr_accessor :post_type, :financial_expense, :delivery_expense,
                :max_post_at, :realized_post_at, :promissed_collect_at,
                :tracking_code, :invoice_number

  def build_json
    #implementacao para gerar o json
  end
end


class ShipmentActionService

  def build_by_type (type, shipment_id)
    #cria um shipment action com base no tipo e no codigo da entrega
  end

  def build_by_hash(shipment_action_params)
    #cria um shipment action com base nos parametros
  end

  def find(id)
    #recupera do banco o shipment action correspondente
  end

  def save (shipment_action)
    shipment_action.save
  end

  def exclude
    shipment_action.delete
  end

  def execute(id)
    shipment_action = find(id)
    json = shipment_action.build_json
    #envia um post para um servico
  end

end


class ShipmentActionController < ApplicationController

  def initialize(service = ShipmentActionService.new)
    @shipment_action_service ||= service
  end

  def new
    shipment_action = @shipment_action_service.build_by_type(params[:type], params[:shipment_id])
    #redireciona para a tela de cadastro
  end

  def confirm
    shipment_action = @shipment_action_service.build_by_hash(params[:shipment_action])
    @shipment_action_service.save(shipment_action)
    #redireciona para a pagina de confirmacao
  end

  def edit
    shipment_action = @shipment_action_service.find(params[:id])
    #redireciona para a tela de cadastro
  end

  def execute
    @shipment_action_service.execute(params[:id])
    #redireciona para a tela de pedidos
  end

end
