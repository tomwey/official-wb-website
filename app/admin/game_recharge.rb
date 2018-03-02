ActiveAdmin.register GameRecharge do
  menu parent: 'game', priority: 8, label: '游戏充值'
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :game_id, :uid, :money_val, :diamond, :recharge_desc
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
index do
  selectable_column
  column :uid
  column :money, sortable: true do |o|
    o.money_val
  end
  column :diamond
  column :recharge_desc, sortable: false
  column :recharge_man, sortable: false
  column :recharged_at
  column 'at', :created_at
  
  actions defaults: false do |o|
    item "查看", [:admin, o]
    
    if o.recharged_at.blank?
      item "充值到服务器", recharge_admin_game_recharge_path(o), method: :put, data: { confirm: '您确定吗？' }
    end
    item "编辑", edit_admin_game_recharge_path(o)
    
  end
  
end

member_action :recharge, method: :put do
  msg = resource.recharge! # ? '已上架' : '余额不足,上架失败'
  if msg == '充值成功'
    redirect_to collection_path, notice: '充值成功'
  else
    redirect_to collection_path, alert: msg
  end
end

before_create do |o|
  o.recharge_man = current_admin_user.email
  o.game_id = 0
end

form do |f|
  f.semantic_errors
  f.inputs '基本信息' do
    f.input :uid
    f.input :game_id, as: :select, collection: Game.all.map { |g| [g.name, g.id] }
    f.input :money_val, as: :number, label: '充值金额', placeholder: '单位为元'
    f.input :diamond
    f.input :recharge_desc
  end
  
  actions
  
end


end
